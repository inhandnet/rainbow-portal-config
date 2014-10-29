<% pagehead(menu.switch_dynamic_mac) %>

<style tyle='text/css'>
#bs-grid {
	width: 500px;	
}


</style>

<script type='text/javascript'>

<% ih_sysinfo() %>
<% ih_user_info(); %>
<% web_exec('show running-config fdb') %>
<% web_exec('show running-config interface') %>
<% web_exec('show mac address-table dynamic') %>
<% web_exec('show mac address-table count dynamic') %>
//dynFdbCnt= 50;
//var port_config=[['1','1','1',1,3,2,1,0,0,0,0,0,0,1,0,0,0,'abc1,23'],['1','1','2',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],['1','1','3',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],['1','1','4',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],['1','1','5',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],['1','1','6',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],['1','1','7',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],['1','1','8',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],['2','1','1',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],['2','1','2',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],['2','1','3',1,3,2,1,0,0,0,0,0,0,1,0,0,0,'']];
//var dynamic_fdb=[['000b.beb2.51e1',1,0,[[1,1,4]]],['000c.29dd.2df0',1,0,[[-1,-1,1]]],['0010.8565.3699',1,0,[[1,1,4]]],['001d.925c.d92e',1,0,[[1,1,4]]],['001e.37d2.69c0',1,0,[[1,1,4]]],['0022.681d.5113',1,0,[[1,1,4]]],['0022.fa4c.7e3e',1,0,[[1,1,4]]],['0022.fab3.2b14',1,0,[[1,1,4]]],['0023.8bb2.db6a',1,0,[[1,1,4]]],['0026.553a.58e5',1,0,[[1,1,4]]],['0026.553a.6730',1,0,[[1,1,2]]],['0026.9ee4.b8d4',1,0,[[1,1,4]]],['0026.9ee4.b8f2',1,0,[[1,1,4]]],['c417.fe0d.13c7',1,0,[[1,1,4]]],['c80a.a9af.57e5',1,0,[[1,1,4]]]];
//var fdb_config=[300,['0000.0000.0003',1,2,[[1,1,3]]],['0000.0000.0002',1,2,[[1,1,2]]]];

var clear_type = ['','port','vlan','all'];

var switch_interface = [];
var port_title_list = [];
var port_cmd_list = [];
var ageTimeIndex = 0;
var ageLinkLossIndex = 1;
var staMacIndex = ageLinkLossIndex + 1;
for(var i=0;i<port_config.length;++i){

	if(port_config[i][0] == 1){
		port_cmd_list.push("fastethernet "+ port_config[i][1] + "/" + port_config[i][2]);
		port_title_list.push("FE"+ port_config[i][1] + "/" + port_config[i][2]);
	}else if(port_config[i][0] == 2){
		port_cmd_list.push("gigabitethernet "+ port_config[i][1] + "/" + port_config[i][2]);
		port_title_list.push("GE"+ port_config[i][1] + "/" + port_config[i][2]);
	}
	//switch_interface.push([i, port_title_list[i]]);
}

var vlan_id = [];

for (i=1; i<=4094; i++) {
	vlan_id[i-1] = i;
}
var mac_d = new webGrid();

mac_d.onDataChanged = function()
{
	verifyFields();
}

mac_d.dataToView = function(data) {
	return [data[0], data[1], data[2],data[3]];
}

mac_d.verifyFields = function(row, quiet)
{
	return 1;
}



mac_d.setup = function()
{
	this.init('bs-grid', ['sort', 'move', 'readonly'], 8192,[
		{ type: 'text'}, 
		{ type: 'text'},
		{ type: 'text'},
		{ type: 'text'}
	]);

	this.headerSet([mac.dynamic_mac, ui.vlan_id, ui.prio, port.port]);

	var tmp_config = [];
	for(var i = 0;i < dynamic_fdb.length;++i){
		tmp_config[i] = [];
		//mac
		tmp_config[i][0] = dynamic_fdb[i][0].toString();
		//vlan id
		tmp_config[i][1] = dynamic_fdb[i][1].toString();
		//priority
		tmp_config[i][2] = dynamic_fdb[i][2].toString();
		//memeber ports
		tmp_config[i][3] = [];
		for(var j=0;j<dynamic_fdb[i][3].length;++j){
			if(dynamic_fdb[i][3][j][0] == 1)
				tmp_config[i][3].push('FE'+dynamic_fdb[i][3][j][1]+'/'+dynamic_fdb[i][3][j][2]);
			else if(dynamic_fdb[i][3][j][0] == 2)
				tmp_config[i][3].push('GE'+dynamic_fdb[i][3][j][1]+'/'+dynamic_fdb[i][3][j][2]);
			else if((dynamic_fdb[i][3][j][0] == (0))&&(dynamic_fdb[i][3][j][1] == (0)))
				tmp_config[i][3].push('T'+dynamic_fdb[i][3][j][2]);
		}
		tmp_config[i][3] = tmp_config[i][3].toString();

		mac_d.insertData(-1,tmp_config[i]);	
	}
	
	
	//this.showNewEditor();
	
}

function clear_verify()
{
	var ok = 1;
	var fom = E('_fom');
	var cmd = "";
	E('clear-button').disabled = true;

	if(E('_clear_type').value == 'port'){
		E('_by_vlan').style.display = 'none';
		E('_by_port').style.display = '';
	}else if(E('_clear_type').value == 'vlan'){
		E('_by_port').style.display = 'none';
		E('_by_vlan').style.display = '';
	}else{
		E('_by_vlan').style.display = 'none';
		E('_by_port').style.display = 'none';
	}

	if(E('_clear_type').value == 'port'){
		cmd += "!" + "\n";
		for(var i = 0;i<port_title_list.length;++i){
			if(E('_by_port').value == port_title_list[i]){
				cmd += "clear mac address-table dynamic interface " + port_cmd_list[i]+ "\n";
				break;
			}
		}
	}else if(E('_clear_type').value == 'vlan'){
		cmd += "!" + "\n";
		cmd += "clear mac address-table dynamic vlan " + E('_by_vlan').value + "\n";
	}else if(E('_clear_type').value == 'all'){
		cmd += "!" + "\n";
		cmd += "clear mac address-table dynamic" + "\n";
	}
	
	if (user_info.priv < admin_priv) {
		elem.display('clear-button', false);
	}else{
		elem.display('clear-button', true);
		fom._web_cmd.value = cmd;
		E('clear-button').disabled = (cmd=="");	
	}
	
	return ok;
}


function clear_command_send()
{
	clear_verify();
	//alert(E('_fom')._web_cmd.value);
	form.submit('_fom', 1);
}

function creatSelect(options,value,name)
{
	var string = '<td><select onchange=clear_verify() id=_'+''+name+'>';

	for(var i = 0;i < options.length;i++){
		if(value == options[i]){
			string +='<option value='+options[i]+' selected>'+options[i]+'</option>';
		}else{
			string +='<option value='+options[i]+'>'+options[i]+'</option>';
		}
	}
	string +="</select></td>";

	return string;
}


function verifyFields(focused, quiet)
{
	var ok = 1;
	var fom = E('_fom');
	var cmd = "";
	E('clear-button').disabled = true;
	
	if (mac_d.isEditing()) return;
	//check delete
/*
	var data = mac_d.getAllData();
	if(data.length < dynamic_fdb.length){
		for(var i = 0;i < dynamic_fdb.length;++i){
			for(var j = 0;j < data.length;){
				var tmp_data = data[j];
				if(dynamic_fdb[i][0] == tmp_data[0]){
					break;
				}else{
					j++;
					if(j == data.length){
						cmd += "!" + "\n";
						cmd += "clear mac-address-table dynamic " + dynamic_fdb[i][0] + "\n";
					}
				}
			}
		}
	}
*/	

	//check aging time
	if(E('_mac_aging_time').value != fdb_config[ageTimeIndex]){
		cmd += "!" + "\n";
		if((E('_mac_aging_time').value != '')&&(E('_mac_aging_time').value != '0')){
			cmd += "mac address-table aging-time " + E('_mac_aging_time').value + "\n";
		}else if(E('_mac_aging_time').value == '0'){//never age
			cmd += "no mac address-table aging-time" + "\n";
		}else{
			cmd += "default mac address-table aging-time" + "\n";
		}
	}

	//
	if ((E('_link_loss_age').checked ? 1:0) != fdb_config[ageLinkLossIndex]){
		cmd += "!" + "\n";
		cmd += (E('_link_loss_age').checked ? (""):("no "))+ "mac address-table flush-down\n"
	}

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

	if (cookie.get("debugcmd") == 1)
		alert(E('_fom')._web_cmd.value);

	if((E('_fom')._web_cmd.value != '')&&(cookie.get('autosave') == 1)){
		E('_fom')._web_cmd.value += "!"+"\n"+"copy running-config startup-config"+"\n";	
	}
	
	form.submit('_fom', 1);
}

function init()
{
	//mac_d.recolor();
	//mac_d.resetNewEditor();
	if((cookie.get('autosave')) == null){
		cookie.set('autosave', 1);
	}

	
}

function create_checkbox(onChangeHandle, id, name, defaultState)
{
	var agt=navigator.userAgent.toLowerCase();
	if (agt.indexOf("msie") != -1) {//IE
		W("<td><input type='checkbox' onpropertychange='"+onChangeHandle+"()' id='"+id+"' name='"+name+"' "+ (defaultState ? 'checked' : '') +  "></td>");
	}else{
		W("<td><input type='checkbox' onchange='"+onChangeHandle+"()' id='"+id+"' name='"+name+"' "+ (defaultState ? 'checked' : '') +  "></td>");
	}
}

</script>
</head>
<body onload='init()'>
<form id='_fom' method='post' action='apply.cgi'>
<input type='hidden' name='_web_cmd' value=''>


<div class='section-title'><script type='text/javascript'>W(mac.learn_opts);</script></div>
<div class='section'>
<script type='text/javascript'>

createFieldTable('', [
	{ title: mac.aging_time, indent: 2, name: 'mac_aging_time', 
		type: 'text', maxlen: 15, size: 17,suffix: ' (0|15-3825)'+ui.seconds, value: fdb_config[ageTimeIndex]},	
	{ title: mac.age_link, indent: 2, name: 'link_loss_age', 
		type: 'checkbox', value: (fdb_config[ageLinkLossIndex]?true:false)}
]);
</script>
</div>


<div class='section-title'><script type='text/javascript'>W(mac.config_clear);</script></div>
<div class='section'>
<script type='text/javascript'>

/*
createFieldTable('', [
	{ title: mac.clear_all , indent: 2, name: 'clear_all', type: 'checkbox', value: 0},
	{ title: mac.clear_mac_vlan , indent: 2, name: 'clear_mac_vlan', type: 'select', options: vlan_id, value: 0},
	{ title: mac.clear_mac_port , indent: 2, name: 'clear_mac_port', type: 'select', options: switch_interface, value: 0},	
]);
*/

W("<td width=120>" + mac.clear_mac_by + " " + "</td>");
W(creatSelect(clear_type,0,'clear_type'));
W(creatSelect(port_title_list,0,'by_port'));
W(creatSelect(vlan_id,0,'by_vlan'));
W("<td width=120>" + "  " + "</td>");
W("<td><input type='button' onclick='clear_command_send();' id='clear-button' value='" + ui.clr + "'></td>");
W("</tr>");	

</script>
</div>
<div class='section'>
<script type='text/javascript'>
if(cookie.get('autosave') == 1)
	ui.aply=ui.aply_save;
genStdFooter("");

</script>
</div>

<div class='section'> </div>
<div class='section'> </div>

<div class='section-title'><script type='text/javascript'>
	GetText(mac.dynamic_list);
</script></div>

<div class='section'>
<table>
		<tr><td ><script type='text/javascript'>GetText(mac.tot);</script>: </td><td id='count'><script type='text/javascript'>GetText(dynFdbCnt);</script></td></tr>


</table>
<table class='web-grid' id='bs-grid'></table>
</div>


</form>
<script type='text/javascript'>mac_d.setup();</script>
<script type='text/javascript'>clear_verify();</script>
<script type='text/javascript'>verifyFields();</script>
</body>
</html>
