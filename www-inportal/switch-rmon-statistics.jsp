<% pagehead(menu.switch_rmon_statistics) %>

<style type='text/css'>
#stats_rmon_grid {
	width: 310px;
}
#stats_rmon_grid .co1 {
	width: 80px;
	text-align: center;
}
#stats_rmon_grid .co2 {
	width: 80px;
	text-align: center;
}
#stats_rmon_grid .co3 {
	width: 150px;
	text-align: center;	
}

</style>

<script type='text/javascript'>

<% ih_sysinfo() %>
<% ih_user_info() %>

<% web_exec('show rmon statistics') %>
<% web_exec('show running-config interface') %>

//var port_config=[['1','1','1',1,3,2,1,0,0,0,0,0,0,1,0,0,0,'abc1,23'],['1','1','2',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],['1','1','3',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],['1','1','4',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],['1','1','5',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],['1','1','6',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],['1','1','7',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],['1','1','8',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],['2','1','1',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],['2','1','2',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],['2','1','3',1,3,2,1,0,0,0,0,0,0,1,0,0,0,'']];

//var statsCtrl_config =[[1,[1,1,1],	'abc']];

<% web_exec('show rmon alarms') %>


var rmon_statistics_oid_vector = ['1','3','6','1','2','1','16','1','1','1'];
var tmp_old_config = [];
var switch_interface = [];
var port_title_list = [];
var port_cmd_list = [];

for(var i=0;i<port_config.length;++i){

	if(port_config[i][0] == 1){
		port_title_list.push("FE"+ port_config[i][1] + "/" + port_config[i][2]);
		port_cmd_list.push("fastethernet "+ port_config[i][1] + "/" + port_config[i][2]);
	}else if(port_config[i][0] == 2){
		port_title_list.push("GE"+ port_config[i][1] + "/" + port_config[i][2]);
		port_cmd_list.push("gigabitethernet "+ port_config[i][1] + "/" + port_config[i][2]);
	}
	switch_interface.push([i, port_title_list[i]]);
}

function getAlarmIndex(oid)
{
	var oid_vector = [];

	oid_vector = oid.split('.');

	return (parseInt(oid_vector[rmon_statistics_oid_vector.length + 1], 10));
}

var stats_rmon = new webGrid();

stats_rmon.verifyDelete = function(data) {
	for (var i = 0; i < alarm_config.length; i++){
		if (data[0] == getAlarmIndex(alarm_config[i][1])){
			show_alert(errmsg.using_stcs);
			return false;
		}
	}
	return true;
}

stats_rmon.exist = function(f, v)
{
	var data = this.getAllData();
	for (var i = 0; i < data.length; ++i) {
		if (data[i][f] == v) return true;
	}
	return false;
}

stats_rmon.existName = function(name)
{
	return this.exist(0, name);
}

stats_rmon.existPort = function(Port)
{
	return this.exist(1, Port);
}


stats_rmon.dataToView = function(data) {
	
	return [data[0], port_title_list[data[1]], data[2]];
}

stats_rmon.fieldValuesToData = function(row) {
	var f = fields.getAll(row);
	return [f[0].value, f[1].value, f[2].value];
}

stats_rmon.onDataChanged = function() {
	verifyFields(null, 1);
}

stats_rmon.verifyFields = function(row, quiet) {

	var f = fields.getAll(row);
	var s;

	ferror.clearAll(f);
	/*
	if(stats_rmon.getAllData().length >= 10){
		show_alert(errmsg.no_more);
		stats_rmon.resetNewEditor();
		return 0;
	}
	*/
		
	//index
	if (!v_f_number(f[0], quiet, false, 1, 65535)) return 0;
	if (this.existName(f[0].value)) {
		ferror.set(f[0], errmsg.bad_id, quiet);
		return 0;
	}else{
		ferror.clear(f[0]);
	}

	//port
	if (stats_rmon.existPort(f[1].value)) {
		ferror.set(f[1], errmsg.ex_port, quiet);
		return 0;
	}else{
		ferror.clear(f[1]);
	}

	//owner
	//owner string
	if(!v_f_text(f[2], quiet, 0, 32)) return 0;
	
	return 1;

}

stats_rmon.resetNewEditor = function() {
	var f = fields.getAll(this.newEditor);
//	f[0].value = '';
	f[1].selected = '';
	f[2].value = 'Monitor';
			
	ferror.clearAll(fields.getAll(this.newEditor));
}

stats_rmon.setup = function() {

	this.init('stats_rmon_grid', 'move', 20, [
		{ type: 'text' }, 
		{ type: 'select', options: switch_interface },
		{ type: 'text' }
		]);
	this.headerSet([rmon.index, port.port, rmon.owner_string]);

	for (var i = 0; i < statsCtrl_config.length; i++) {
		tmp_old_config[i] = [];

		//index
		tmp_old_config[i][0] = statsCtrl_config[i][0].toString();

		//port
		for(var j=0;j<port_config.length;){
			if((port_config[j][0] == statsCtrl_config[i][1][0])&&(port_config[j][1] == statsCtrl_config[i][1][1])&&(port_config[j][2] == statsCtrl_config[i][1][2])){
				tmp_old_config[i][1]  = j.toString();
				break;
			}else{
				j++;
				if(j == port_config.length)
					alert("Port Error!");
			}
		}

		//owner
		tmp_old_config[i][2] = statsCtrl_config[i][2].toString();				

		stats_rmon.insertData(-1,tmp_old_config[i]);				
	}

	this.showNewEditor();
	this.resetNewEditor();
}


function isDigit(str)
{ 
  var reg = /^\d*$/; 

  return reg.test(str); 
}

function createStats(tmp_data)
{
	var cmd = '';
	
	cmd += "!" + "\n";
	cmd += "interface " + port_cmd_list[tmp_data[1]]+ "\n";

	cmd += "rmon collection stats " + tmp_data[0] + ((tmp_data[2] != '')?(" owner " + tmp_data[2] ):(" "))+ "\n";

	return cmd;
}

function deleteStats(tmp_data)
{
	var cmd = '';
	cmd += "!" + "\n";
	cmd += "interface " + port_cmd_list[tmp_data[1]]+ "\n";

	cmd += "no rmon collection  stats " + tmp_data[0] + "\n";

	return cmd;
}



function verifyFields(focused, quiet)
{
	
	var cmd = "";
	var fom = E('_fom');
	var data_found = 0;
	var data_changed = 0;
	  
	E('save-button').disabled = true;	

	var tmp_data = stats_rmon.getAllData();
	if (stats_rmon.isEditing()) return;	

	//delete
	for(var i=0;i<tmp_old_config.length;++i){
		data_found = 0;
		data_changed = 0;
		for(var j=0;j<tmp_data.length; j++){
			if(tmp_old_config[i][0] == tmp_data[j][0]){
				data_found = 1;
				if (tmp_old_config[i][1] != tmp_data[j][1])
					data_changed = 1;
				break;
			}
		}
		if (!data_found || data_changed)
			cmd += deleteStats(tmp_old_config[i]);
	}	

	
	//check if add or change
	for(var i=0;i<tmp_data.length;++i){
		data_found = 0;
		data_changed = 0;
		for(var j=0;j<tmp_old_config.length; j++){
			if(tmp_old_config[j][0] == tmp_data[i][0]){
				data_found = 1;
				if (tmp_old_config[j][1] != tmp_data[i][1]
					|| tmp_old_config[j][2] != tmp_data[i][2])
					data_changed = 1;
				break;
			}
		}

		if (!data_found || data_changed)
			cmd += createStats(tmp_data[i]);
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
	if (cookie.get('debugcmd') == 1)
		alert(E('_fom')._web_cmd.value);
	if((E('_fom')._web_cmd.value != '')&&(cookie.get('autosave') == 1)){
		E('_fom')._web_cmd.value += "!"+"\n"+"copy running-config startup-config"+"\n";	
	}
	form.submit('_fom', 1);
}

function earlyInit()
{
	stats_rmon.setup();
	verifyFields(null, 1);
}

function init()
{
	if((cookie.get('autosave')) == null){
		cookie.set('autosave', 1);
	}
}

</script>
</head>
<body onload='init()'>
<form id='_fom' method='post' action='apply.cgi'>
<input type='hidden' name='_web_cmd' value=''>



<div class='section'>
	<table class='web-grid' cellspacing=1 id='stats_rmon_grid'></table>
	<script type='text/javascript'>stats_rmon.setup();</script>

</div>

<script type='text/javascript'>
init();
if(cookie.get('autosave') == 1)
	ui.aply=ui.aply_save;
genStdFooter("");
</script>
<script type='text/javascript'>verifyFields(null, 1);</script>
</form>

</body>
</html>
