<% pagehead(menu.switch_raps_node) %>

<style type='text/css'>
#raps_grid {
	width: 400px;
}
#raps_grid .co1 {
	width: 80px;
	text-align: center;
}
#raps_grid .co2 {
	width: 80px;
	text-align: center;
}
#raps_grid .co3 {
	width: 80px;
	text-align: center;	
}

</style>

<script type='text/javascript'>

<% ih_sysinfo() %>
<% ih_user_info(); %>

<% web_exec('show running-config inring') %>
<% web_exec('show running-config interface') %>

var port_config=[['1','1','1',1,3,2,1,0,0,0,0,0,0,1,0,0,0,'abc1,23'],['1','1','2',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],['1','1','3',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],['1','1','4',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],['1','1','5',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],['1','1','6',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],['1','1','7',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],['1','1','8',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],['2','1','1',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],['2','1','2',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],['2','1','3',1,3,2,1,0,0,0,0,0,0,1,0,0,0,'']];
var cfm_config=[1, [[1,1,2], 8, 1]];

var port_title_list = [];
var switch_interface = [];
var tmp_old_config = [];

for(var i=0;i<port_config.length;++i){

	if(port_config[i][0] == 1){
		port_title_list.push("FE"+ port_config[i][1] + "/" + port_config[i][2]);
	}else if(port_config[i][0] == 2){
		port_title_list.push("GE"+ port_config[i][1] + "/" + port_config[i][2]);
	}
	switch_interface.push([i, port_title_list[i]]);
	
}


var instance = new webGrid();

instance.exist = function(f, v)
{
	var data = this.getAllData();
	for (var i = 0; i < data.length; ++i) {
		if (data[i][f] == v) return true;
	}
	return false;
}

instance.existName = function(name)
{
	return this.exist(0, name);
}


instance.dataToView = function(data) {
	
	return [port_title_list[data[0]],data[1],['Disable','Enable'][data[2]]];
}

instance.fieldValuesToData = function(row) {
	var f = fields.getAll(row);
	return [f[0].value, f[1].value, f[2].value];
}

instance.verifyFields = function(row, quiet) {
	var f = fields.getAll(row);
	var s;
	
	if (this.existName(f[0].value)) {
		ferror.set(f[0], errmsg.bad_id, quiet);
		return 0;
	}else{
		ferror.clear(f[0], errmsg.bad_id, quiet);
	}


	return 1;
}

instance.resetNewEditor = function() {
	var f = fields.getAll(this.newEditor);
	f[0].value = '';
	f[1].value = '';
	f[2].value = '';
					
	ferror.clearAll(fields.getAll(this.newEditor));
}

instance.setup = function() {


	this.init('raps_grid', 'move', 80, [
		{ type: 'select', options: switch_interface},
		{ type: 'text'},
		{ type: 'select', options: [[0,'Disable'],[1,'Enable']]}
		]);
	this.headerSet([port.port,ui.vlan_id,raps.mep_enable]);

	for(var i = 1;i < cfm_config.length;++i){
		tmp_old_config[i-1] = [];
		//port id
		for(var j=0;j<port_config.length;){
			if((port_config[j][0] == cfm_config[i][0][0])&&(port_config[j][1] == cfm_config[i][0][1])&&(port_config[j][2] == cfm_config[i][0][2])){
				tmp_old_config[i-1][0] = j;
				break;
			}else{
				j++;
				if(j == port_config.length)
					alert("Port Error!");
			}
		}
		//vlan id
		tmp_old_config[i-1][1] = cfm_config[i][1].toString();
		//mep enable
		tmp_old_config[i-1][2] = cfm_config[i][2].toString();
		
		instance.insertData(-1,tmp_old_config[i-1]);
	}

	instance.showNewEditor();
}

function verifyFields(focused, quiet)
{

	var cmd = "";
	var fom = E('_fom');
	  
	E('save-button').disabled = true;	

	var data = instance.getAllData();
	var tmp_config = qos_interface_config.split(';');

	//check if add or change
	for(var i = 0;i < data.length;++i){
		var interface_view_flag = 0;
		var tmp_data = data[i];
		for(var j = 0;j < tmp_config.length;){
			var tmp_config_old = tmp_config[j].split(',');
			if(tmp_data[0] == tmp_config_old[0]){
				//check change
				if(['','cos','dscp'][tmp_data[1]] != tmp_config_old[1]){
					if(interface_view_flag == 0){
						cmd += "!" + "\n";//back to config view
						cmd += "interface fastethernet " + tmp_data[0] + "\n";
						interface_view_flag = 1;
					}
					if(tmp_data[1] == 0){
						cmd += "no qos trust" + "\n";
					}else{
						cmd += "qos trust " + ['','cos','dscp'][tmp_data[1]] + "\n";
					}
				}

				if(['','default','override'][tmp_data[2]] != tmp_config_old[2]){
					if(interface_view_flag == 0){
						cmd += "!" + "\n";//back to config view
						cmd += "interface fastethernet " + tmp_data[0] + "\n";
						interface_view_flag = 1;
					}
					if(tmp_data[2] == 0){
						if(tmp_config_old[2] == 'default')
							cmd += "no qos cos " + tmp_config_old[3] + "\n";
						else
							cmd += "no qos cos override" + "\n";
					}else if(tmp_data[2] == 1){
						cmd += "qos cos " + tmp_data[3] + "\n";
					}else if(tmp_data[2] == 2){
						cmd += "qos cos override" + "\n";
					}
				}else{
					if(tmp_data[2] == 1){
						if(tmp_data[3] != tmp_config_old[3]){
							if(interface_view_flag == 0){
								cmd += "!" + "\n";//back to config view
								cmd += "interface fastethernet " + tmp_data[0] + "\n";
								interface_view_flag = 1;
							}
							cmd += "qos cos " + tmp_data[3] + "\n";
						}
					}
				}
				
				break;
			}else{
				j++;
				if(j == tmp_config.length){//one add
					cmd += "!" + "\n";//back to config view
					cmd += "interface fastethernet " + tmp_data[0] + "\n";
					
					if(tmp_data[1] != 0){
						cmd += "qos trust " + ['','cos','dscp'][tmp_data[1]] + "\n";
					}

					if(tmp_data[2] == 1){
						cmd += "qos cos " + tmp_data[3] + "\n";
					}else if(tmp_data[2] == 2){
						cmd += "qos cos override" + "\n";
					}	
				}
			}
		}
	}
	//check delete 
	for(var i = 0;i < tmp_config.length;++i){
		var tmp_config_old = tmp_config[i].split(',');
		for(var j = 0;j < data.length;){
			var tmp_data = data[j];
			if(tmp_config_old[0] == tmp_data[0]){
				break;
			}else{
				j++;
				if(j == data.length){
					cmd += "!" + "\n";//back to config view
					cmd += "interface fastethernet " + tmp_config_old[0] + "\n";
					cmd += "no qos trust" + "\n";
					if(tmp_config_old[2] == 'default'){
						cmd += "no qos cos " + tmp_config_old[3] + "\n";
					}else if(tmp_config_old[2] == 'override'){
						cmd += "no qos cos override" + "\n";
					}
				}
			}
		}
	}
	

	//alert(cmd);
	if (user_info.priv < admin_priv) {
		elem.display('save-button', false);
	}else{
		elem.display('save-button', true);
		fom._web_cmd.value = cmd;
		E('save-button').disabled = (cmd=="");	
	}


	return 1;
}

function save()
{
	if (!verifyFields(null, false)) return;	
	//alert(E('_fom')._web_cmd.value);
	if((E('_fom')._web_cmd.value != '')&&(cookie.get('autosave') == 1)){
		E('_fom')._web_cmd.value += "!"+"\n"+"copy running-config startup-config"+"\n";	
	}
	form.submit('_fom', 1);
}

function init()
{
	if((cookie.get('autosave')) == null){
		cookie.set('autosave', 1);
	}
	//instance.recolor();
	//instance.resetNewEditor();
}
</script>
</head>
<body onload='init()'>
<form id='_fom' method='post' action='apply.cgi'>
<input type='hidden' name='_web_cmd' value=''>

<div class='section'>
<script type='text/javascript'>

createFieldTable('', [
	{ title: ui.enable + ' Y.1731', name: 'f_1731_enable', type: 'checkbox', value: cfm_config[0]}
]);
</script>
</div>

<div class='section-title' id='_instance_list'>
<script type='text/javascript'>
	GetText(raps.instance_list);
</script>
</div>
	<table class='web-grid' cellspacing=1 id='raps_grid'></table>


<script type='text/javascript'>
init();
if(cookie.get('autosave') == 1)
	ui.aply=ui.aply_save;
genStdFooter("");
</script><script type='text/javascript'>instance.setup();</script>
</form>
</body>
</html>

