<% pagehead(menu.switch_mac) %>

<style tyle='text/css'>
#bs-grid {
	text-align: center;
	width: 600px;	
}
#bs-grid .co1 {
	width: 100px;
}
#bs-grid .co2 {
	width: 100px;
}
#bs-grid .co3 {
	width: 100px;
}
#bs-grid .co4 {
	width: 100px;
}

</style>

<script type='text/javascript'>

<% ih_sysinfo(); %>
<% ih_user_info(); %>

/*
var port_config=[['1','1','1',1,3,2,1,0,0,0,0,0,0,1,0,0,0,'abc1,23'],['1','1','2',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],['1','1','3',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],['1','1','4',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],['1','1','5',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],['1','1','6',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],['1','1','7',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],['1','1','8',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],['2','1','1',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],['2','1','2',1,3,2,1,0,0,0,0,0,0,1,0,0,0,'']];
var vlan_config=[[1,0,0,'VLAN0001',untagged=[[1,1,1],[1,1,3],[1,1,5],[1,1,7],[2,1,1]],tagged=[]],
					[2,0,0,'VLAN0002',untagged=[[1,1,2],[1,1,4],[1,1,6],[1,1,8],[2,1,2]],tagged=[]],
					[6,0,0,'VLAN0006',untagged=[],tagged=[]]];
var fdb_config=[300,['0000.0000.0003',1,2,[[1,1,3]]],['0000.0000.0002',2,2,[[1,1,2]]]];
var fdb_config=[300,['0000.0000.0003',1,2,[[1,1,3]]],['0000.0000.0002',2,2,[[1,1,2]]]];
*/
<% web_exec('show running-config fdb') %>
<% web_exec('show running-config vlan') %>
<% web_exec('show running-config interface') %>

<% web_exec('show running-config port-channel') %>

var port_cmd_list = [];
var fdb_config_old = [];
var vlan_id = [];
var vlan_id_one = [];
var priority_options = [[0,'0'],[1,'1'],[2,'2'],[3,'3'],[4,'4'],[5,'5'],[6,'6'],[7,'7']];
var port_title_list = [];
var switch_interface = [];

var vlan_interface = [];
var now_vlan_if_options = [];
var now_vlan_if_cmd = [];
var old_vlan_selected;

var port_id  = [];
var ageTimeIndex = 0;
var ageLinkLossIndex = 1;
var staMacIndex = ageLinkLossIndex + 1;
var drop_option =[0 , "Drop"];

function portIsTrunkMem(port_id)
{
	for (var i = 1; i < trunk_config.length; i++){
		for (var j = 0; j < trunk_config[i][1].length; j++){
			if ((port_id[0] == trunk_config[i][1][j][0])
				&& (port_id[1] == trunk_config[i][1][j][1])
				&& (port_id[2] == trunk_config[i][1][j][2]))
				return true;
		}
	}

	return false;
}

/*non-trunk port*/
for(var i=0;i<port_config.length;++i){
	if (portIsTrunkMem(port_config[i])) continue;
	if(port_config[i][0] == 1){
		port_title_list.push("FE"+ port_config[i][1] + "/" + port_config[i][2]);
		port_cmd_list.push("fastethernet "+ port_config[i][1] + "/" + port_config[i][2]);
	}else if(port_config[i][0] == 2){
		port_title_list.push("GE"+ port_config[i][1] + "/" + port_config[i][2]);
		port_cmd_list.push("gigabitethernet "+ port_config[i][1] + "/" + port_config[i][2]);
	}
	port_id.push([port_config[i][0], port_config[i][1], port_config[i][2]]);
	//switch_interface.push([i, port_title_list[i]]);	
}

/*trunk 'port'*/
for (var i = 1; i < trunk_config.length; i++){
	port_title_list.push("T"+ trunk_config[i][0]);
	port_cmd_list.push("channel-group "+ trunk_config[i][0]);
	port_id.push([0, 0, trunk_config[i][0]]);
}
drop_option[0]=port_id.length;
for (var i = 0; i < port_title_list.length; i++){
	switch_interface.push([i, port_title_list[i]]);	
}
port_cmd_list.push("drop");


function port_mem_type_in_vlan(port_index, vlan_conf)
{
	var port_name;
	if (port_index >= port_id.length)
		return 0;
	port_name = port_id[port_index];
	
	/*untagged*/
	for (var i = 0; i < vlan_conf[4].length; i++){
		if ((port_name[0] == vlan_conf[4][i][0])
			&& (port_name[1] == vlan_conf[4][i][1])
			&& (port_name[2] == vlan_conf[4][i][2])){
			return 1;
		}
	}
	/*tagged*/
	for (var i = 0; i < vlan_conf[5].length; i++){
		if ((port_name[0] == vlan_conf[5][i][0])
			&& (port_name[1] == vlan_conf[5][i][1])
			&& (port_name[2] == vlan_conf[5][i][2])){
			return 2;
		}
	}

	return 0;
}

for(var i = 0;i < vlan_config.length;i++){
	vlan_id.push([i,vlan_config[i][0]]);
	vlan_id_one.push(vlan_config[i][0].toString());

	var my_vid = vlan_config[i][0];
	var my_vlan_if = [];
	var my_vlan_if_cmd = [];
	var index = 0;

	for(index = 0; index < port_id.length; index++){
		if (port_mem_type_in_vlan(index, vlan_config[i]) > 0){
			my_vlan_if.push(switch_interface[index]);
			my_vlan_if_cmd.push(port_cmd_list[index]);
		}
	}

/*	
	//untagged
	for (var j = 0; j < vlan_config[i][4].length; j++, index++){
		if(vlan_config[i][4][j][0] == 1){
			my_vlan_if.push([index , "FE"+ vlan_config[i][4][j][1] + "/" + vlan_config[i][4][j][2]]);
			my_vlan_if_cmd.push("fastethernet " + vlan_config[i][4][j][1] + "/" + vlan_config[i][4][j][2]);
		}else if(vlan_config[i][4][j][0] == 2){
			my_vlan_if.push([index , "GE"+ vlan_config[i][4][j][1] + "/" + vlan_config[i][4][j][2]]);
			my_vlan_if_cmd.push("gigabitethernet "+ vlan_config[i][4][j][1] + "/" + vlan_config[i][4][j][2]);
		}else if((vlan_config[i][4][j][0] == 0)
				&& (vlan_config[i][4][j][1] == 0)){
			my_vlan_if.push([index , "T"+  vlan_config[i][4][j][2]]);
			my_vlan_if_cmd.push("channel-group "+ vlan_config[i][4][j][2]);
		}
	}
	//tagged
	for (var j = 0; j < vlan_config[i][5].length; j++, index++){
		if(vlan_config[i][5][j][0] == 1){
			my_vlan_if.push([index , "FE"+ vlan_config[i][5][j][1] + "/" + vlan_config[i][5][j][2]]);
			my_vlan_if_cmd.push("fastethernet "+ vlan_config[i][5][j][1] + "/" + vlan_config[i][5][j][2]);
		}else if(vlan_config[i][5][j][0] == 2){
			my_vlan_if.push([index , "GE"+ vlan_config[i][5][j][1] + "/" + vlan_config[i][5][j][2]]);
			my_vlan_if_cmd.push("gigabitethernet "+ vlan_config[i][5][j][1] + "/" + vlan_config[i][5][j][2]);
		}else if((vlan_config[i][5][j][0] == 0) 
				&& (vlan_config[i][5][j][1] == 0)){
			my_vlan_if.push([index , "T"+  vlan_config[i][5][j][2]]);
			my_vlan_if_cmd.push("channel-group "+ vlan_config[i][5][j][2]);
		}
	}
*/	
	my_vlan_if.push(drop_option);
	my_vlan_if_cmd.push("drop");
	vlan_interface.push([my_vid, my_vlan_if, my_vlan_if_cmd]);	
}

var mac_static = new webGrid();

function check_mac(row, quiet)
{
	var f = fields.getAll(row);
		
	
	if((f[0].value == '') || (f[0].value == '0000.0000.0000')){
		//ferror.set(f[0], errmsg.mac, quiet);
		return 0;
	}else{
		var tmp_old = f[0].value;
		var tmp_1 = f[0].value.split('.');
		var tmp_2 = f[0].value.split(':');
		
		if((tmp_1.length == 3) && (f[0].value.length == 14)){
			var tmp_mac = [];
			var idex = 0;
			for(var i = 0;i < tmp_1.length;++i){
				if(tmp_1[i].length == 4){
					tmp_mac[idex++] = tmp_1[i].substring(0,2);
					tmp_mac[idex++] = tmp_1[i].substring(2,4);	
				}else{
					//ferror.set(f[0], errmsg.mac, quiet);
					return 0;
				}
								
			}
			f[0].value = tmp_mac.join(':');
			if (!v_mac(f[0], quiet)) {
				f[0].value = tmp_old;
				return 0;
			}

			f[0].value = tmp_old;
			return 1;
		}else if((tmp_2.length == 6) && (f[0].value.length == 17)){
			if (!v_mac(f[0], quiet)) {
				f[0].value = tmp_old;
				return 0;
			}else{
				for(var j = 0;j < tmp_2.length;j++){
					if(tmp_2[j].length != 2){
						//ferror.set(f[0], errmsg.mac, quiet);
						return 0;
					}
				}
			}
			var tmp_value = tmp_2.join('');
			var tmp_3 = [];

			tmp_3[0] = tmp_value.substring(0,4); 
			tmp_3[1] = tmp_value.substring(4,8); 
			tmp_3[2] = tmp_value.substring(8,12); 
			f[0].value = tmp_3.join('.');
			return 1;
		
		}else{
			//ferror.set(f[0], errmsg.mac, quiet);
			return 0;
		}
		
	}

}

function get_vlan_if_option(vlan_id)
{
	for (var i = 0; i < vlan_interface.length; i++){
		if (vlan_interface[i][0] == vlan_id){
			now_vlan_if_options =vlan_interface[i][1];	
			now_vlan_if_cmd = vlan_interface[i][2];
		}
	}
}

function get_vlan_if_to_view(vlan_id)
{
	for (var i = 0; i < vlan_interface.length; i++){
		if (vlan_interface[i][0] == vlan_id){
			return vlan_interface[i][1];
		}
	}
}



mac_static.onDataChanged = function()
{
	verifyFields();
	mac_static.resetNewEditor();
}

mac_static.exist = function(f, v)
{
	var data = this.getAllData();
	for (var i = 0; i < data.length; ++i) {
		if (data[i][f] == v) return true;
	}
	return false;
}

mac_static.existName = function(name)
{
	return this.exist(0, name);
}

mac_static.existMac = function(mac, vid)
{
	var data = this.getAllData();
	for (var i = 0; i < data.length; ++i) {
		if ((data[i][0] == mac)
			&& (data[i][1] == vid)) return true;
	}
	return false;
}

mac_static.dataToView = function(data) 
{
	var tmp_vlan_if_to_view_list = [];
	var tmp_if = '';

	//alert('dataToView data[2]='+data[2]);
	tmp_vlan_if_to_view_list = get_vlan_if_to_view(vlan_config[data[1]][0]);
	for (var i = 0; i < tmp_vlan_if_to_view_list.length; i++){
		//alert(tmp_vlan_if_to_view_list[i][0]);
		if (data[2] == tmp_vlan_if_to_view_list[i][0]){
		//	alert('dataToView data[2]='+data[2]);
			tmp_if = tmp_vlan_if_to_view_list[i][1];
			break;
		}
	}
//	return [data[0], vlan_id_one[data[1]], tmp_vlan_if_to_view_list[data[2]][1], data[3]];
	return [data[0], vlan_id_one[data[1]], tmp_if, data[3]];
}

mac_static.fieldValuesToData = function(row) {
	var f = fields.getAll(row);
		
	return [f[0].value,f[1].value,f[2].value,f[3].value];

}

function updateVlanIfOptions (Options)
{

//	alert(document.getElementsByName("vlan_if_options")[0].length);
	var old_options = document.getElementsByName("vlan_if_options")[0];
	
	while(old_options.options.length>0){
		old_options.remove(0);
	}

	for(var j=0;j<Options.length;j++){
      var item = new Option(Options[j][1],Options[j][0]);
	  old_options.options.add(item);
	}
//	alert(document.getElementsByName("vlan_if_options")[0].length);
}




	
mac_static.verifyFields = function(row, quiet)
{
	var f = fields.getAll(row);
	
	if(!check_mac(row, quiet)){
		ferror.set(f[0], errmsg.mac, quiet);
		return 0;
	}else{
		ferror.clear(f[0], errmsg.mac, quiet);
	}

	if (this.existMac(f[0].value, f[1].value)) {
		ferror.set(f[0], errmsg.bad_mac, quiet);
		ferror.set(f[1], errmsg.bad_mac, true);
		return 0;
	}else{
		ferror.clear(f[0]);
		ferror.clear(f[1]);
	}
	
	
	//update port options
//	if (old_vlan_selected != vlan_config[f[1].value][0]){
		var tmp_if_option = f[2].value;
//	alert(tmp_if_option);
//	alert(port_id.length);

		get_vlan_if_option(vlan_config[f[1].value][0]);
		//mac_static.safeUpdateRowEditorField(row, 2, now_vlan_if_options);
		updateVlanIfOptions (now_vlan_if_options);
		//alert('1...'+tmp_if_option);
		if (port_mem_type_in_vlan(tmp_if_option, vlan_config[f[1].value]) > 0
			|| tmp_if_option ==  port_id.length){
			f[2].value = tmp_if_option;
		//	alert('2...'+f[2].value);
		}else{
			f[2].value = now_vlan_if_options[0][0];
		//	alert('3...'+f[2].value);
		}
		//alert('4...'+f[2].value);
			

		old_vlan_selected = vlan_config[f[1].value][0];
		if (now_vlan_if_options.length == 0){
			ferror.set(f[2], errmsg.empty_vlan_if_op, false);
			return 0;
		}else{
			ferror.clear(f[2], errmsg.empty_vlan_if_op, false);
		}
//	}

	return 1;
}

mac_static.resetNewEditor = function() {
	var f = fields.getAll(this.newEditor);

	f[0].value = '0000.0000.0001';
	f[1].selected = 0;
	f[2].selected = 0;
	f[3].selected = 0;
	
	ferror.clearAll(fields.getAll(this.newEditor));

}


mac_static.setup = function()
{
	old_vlan_selected = 1;
	get_vlan_if_option(old_vlan_selected);

	this.init('bs-grid', ['sort', 'move'], 128,[
		{ type: 'text', maxlen: 17 }, 
		{ type: 'select', options: vlan_id },
		{ type: 'select', options: now_vlan_if_options, attrib: 'name=vlan_if_options'},
		{ type: 'select', options: priority_options }
	]);

	this.headerSet([mac.mac_address, ui.vlan_id,port.port,ui.priority]);

	for(var i = 0;i < (fdb_config.length - staMacIndex);++i){
		var tmp_vlan_config = [];
		fdb_config_old.push([]);
		 fdb_config_old[i] = [];
		//mac address
		fdb_config_old[i][0] = fdb_config[i+staMacIndex][0].toString();

		//vlan id
		for(var n = 0;n < vlan_id_one.length;n++){
			if(vlan_id_one[n] == fdb_config[i+staMacIndex][1]){
				fdb_config_old[i][1] = n;
				break;
			}
		}
		for(var j = 0;j < vlan_config.length;j++){
			if (vlan_config[j][0] == fdb_config[i+staMacIndex][1])
				tmp_vlan_config = vlan_config[j];
		}

		//port
		get_vlan_if_option(fdb_config[i+staMacIndex][1]);
		fdb_config_old[i][2] = port_id.length;//now_vlan_if_options.length - 1;//index to 'Drop'
		if (fdb_config[i+staMacIndex][3].length != 0){
			for(var index = 0; index < port_id.length; index++){
				if ((fdb_config[i+staMacIndex][3][0][0] == port_id[index][0])
					&&(fdb_config[i+staMacIndex][3][0][1] == port_id[index][1])
					&&(fdb_config[i+staMacIndex][3][0][2] == port_id[index][2])){
					fdb_config_old[i][2] = index;
					break;
				}
			}
		}

		//priority
		fdb_config_old[i][3] = fdb_config[i+staMacIndex][2].toString();
		
		mac_static.insertData(-1,fdb_config_old[i]);	
	}	
	
	mac_static.showNewEditor();
	mac_static.resetNewEditor();
}


function verifyFields(focused, quiet)
{
	var ok = 1;

	var cmd = "";
	var fom = E('_fom');
	var view_flag = 1;

	E('save-button').disabled = true; 
	
	if (mac_static.isEditing()) return;
		
	//check static mac address table
	var tmp_data = mac_static.getAllData();
	//check add  or change address
	for(var i = 0;i < tmp_data.length;++i){
		var line_found = 0;
		get_vlan_if_option(vlan_id_one[tmp_data[i][1]] );
		if(fdb_config_old.length ==0){
			if (view_flag){
				cmd += "!" + "\n";
				view_flag = 0;
			}
			cmd += "mac address-table static " + tmp_data[i][0] + " vlan " + vlan_id_one[tmp_data[i][1]] 
				+ ((port_cmd_list[tmp_data[i][2]][0]=='c' 
						|| port_cmd_list[tmp_data[i][2]][0]=='d')?(" "):(" interface " ))
				+ port_cmd_list[tmp_data[i][2]] 
				+ ((port_cmd_list[tmp_data[i][2]][0]=='d')?(""):(" priority " + tmp_data[i][3])) + "\n";
			continue;
		}
		
		for(var j = 0;j < fdb_config_old.length;j++){
			if((tmp_data[i][0] == fdb_config_old[j][0])
				&&(tmp_data[i][1] == fdb_config_old[j][1])){
				line_found = 1;
				
				//check change
				if ((tmp_data[i][2] != fdb_config_old[j][2])
					||(tmp_data[i][3] != fdb_config_old[j][3])){
					if (view_flag){
						cmd += "!" + "\n";
						view_flag = 0;
					}		

					if ((tmp_data[i][2] != fdb_config_old[j][2])
							&& ((port_cmd_list[tmp_data[i][2]][0]=='d')
								|| (port_cmd_list[fdb_config_old[j][2]][0]=='d'))){
						cmd += "no mac address-table static " + fdb_config_old[i][0] + " vlan " 
							+ vlan_id_one[fdb_config_old[i][1]] + "\n";
					}
					cmd += "mac address-table static " + tmp_data[i][0] + " vlan " + vlan_id_one[tmp_data[i][1]] 
						+ ((port_cmd_list[tmp_data[i][2]][0]=='c' 
								|| port_cmd_list[tmp_data[i][2]][0]=='d')?(" "):(" interface " ))
						+ port_cmd_list[tmp_data[i][2]] 
						+ ((port_cmd_list[tmp_data[i][2]][0]=='d')?(""):(" priority " + tmp_data[i][3])) + "\n";
				}				
				break;
			}
		}

		if(!line_found){//new line
			if (view_flag){
				cmd += "!" + "\n";
				view_flag = 0;
			}	
			cmd += "mac address-table static " + tmp_data[i][0] + " vlan " + vlan_id_one[tmp_data[i][1]] 
				+ ((port_cmd_list[tmp_data[i][2]][0]=='c' 
						|| port_cmd_list[tmp_data[i][2]][0]=='d')?(" "):(" interface " ))
				+ port_cmd_list[tmp_data[i][2]] 
				+ ((port_cmd_list[tmp_data[i][2]][0]=='d')?(""):(" priority " + tmp_data[i][3])) + "\n";
		}
	}

	//check delete mac address
	for(var i =0;i<fdb_config_old.length;++i){
		var line_found = 0;
		if(tmp_data.length ==0){
			if (view_flag){
				cmd += "!" + "\n";
				view_flag = 0;
			}	
			cmd += "no mac address-table static " + fdb_config_old[i][0] + " vlan " + vlan_id_one[fdb_config_old[i][1]] + "\n";
			continue;
		}
		for(var j=0;j<tmp_data.length;j++){
			if((fdb_config_old[i][0] == tmp_data[j][0])
				&&(fdb_config_old[i][1] == tmp_data[j][1])){
				line_found = 1;
				break;
			}
		}

		if (!line_found){
			if (view_flag){
				cmd += "!" + "\n";
				view_flag = 0;
			}
			cmd += "no mac address-table static " + fdb_config_old[i][0] + " vlan " + vlan_id_one[fdb_config_old[i][1]] + "\n";
		}
	}	

		//alert(cmd);
	if (user_info.priv < admin_priv) {
		elem.display('save-button', 'cancel-button', false);
	}else{
		elem.display('save-button', 'cancel-button', true);
		fom._web_cmd.value = cmd;
		E('save-button').disabled = (cmd=="");	
	}

	
	return ok;	
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

function init()
{
	if((cookie.get('autosave')) == null){
		cookie.set('autosave', 1);
	}
	//mac_static.recolor();
	//mac_static.resetNewEditor();
}

function earlyInit()
{
	mac_static.setup();
	verifyFields(null, 1);
}
</script>
</head>
<body onload='init()'>
<form id='_fom' method='post' action='apply.cgi'>
<input type='hidden' name='_web_cmd' value=''>


<div class='section-title'>
<script type='text/javascript'>
	GetText(mac.static_mac_table);
</script>
</div>
<div class='section'>
	<table class='web-grid' cellspacing=1 id='bs-grid'></table>
	<script type='text/javascript'>mac_static.setup();</script>	
</div>

<script type='text/javascript'>
init();
if(cookie.get('autosave') == 1)
	ui.aply=ui.aply_save;
genStdFooter("");
</script>
</form>
<script type='text/javascript'>verifyFields(null, 1);</script>
</body>
</html>
