<% pagehead(menu.switch_trunk) %>

<style type='text/css'>
#adm-head{
	Text-align: center;
	background: #e7e7e7;
}
.web-grid input{
	width:auto;
}

#adm_grid{
	Text-align: center;
	width: 800px;
} 
#adm_grid .co1 {
	width: 100px;
}

</style>

<script type='text/javascript'>

<% ih_sysinfo() %>
<% ih_user_info(); %>

<% web_exec('show running-config port-channel') %>
<% web_exec('show running-config interface') %>

//var trunk_config=[1,[1,member=[]],[2,member=[]],[3,member=[]],[4,member=[]],[5,member=[]],[6,member=[]]];
//var port_config=[['1','1','1',1,3,2,1,0,0,0,0,0,0,1,0,0,0,'abc1,23'],['1','1','2',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],['1','1','3',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],['1','1','4',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],['1','1','5',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],['1','1','6',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],['1','1','7',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],['1','1','8',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],['2','1','1',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],['2','1','2',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],['2','1','3',1,3,2,1,0,0,0,0,0,0,1,0,0,0,'']];

<% web_exec('show running-config vlan') %>

var port_cmd_list = [];
var port_type = ['undefine','FE','GE'];

for(var i=0;i<port_config.length;++i){

	if(port_config[i][0] == 1){
		port_cmd_list.push("fastethernet "+ port_config[i][1] + "/" + port_config[i][2]);
	}else if(port_config[i][0] == 2){
		port_cmd_list.push("gigabitethernet "+ port_config[i][1] + "/" + port_config[i][2]);
	}
	
}

//var trunk = new webGrid();

var trunk_policy = ['sada','hash'];
var trunk_range = ['1','2','3','4','5','6'];
var vlan_disabled = [];
// save  trunk old config
var trunk_config_old = [];

for(var i = 0;i < trunk_range.length;++i){
	trunk_config_old[trunk_range[i]] = [];
	for(var j = 0;j < port_config.length;++j){
		trunk_config_old[trunk_range[i]][j] = 0;
	}
}

for(var i = 1;i < trunk_config.length;++i){
	for(var j=0;j<trunk_config[i][1].length;++j){
		for(var k=0;k<port_config.length;){
			if((port_config[k][0] == trunk_config[i][1][j][0])&&(port_config[k][1] == trunk_config[i][1][j][1])&&(port_config[k][2] == trunk_config[i][1][j][2])){
				trunk_config_old[trunk_config[i][0]][k] = 1;
				break;
			}else{
				k++;
				if(k == port_config.length)
					alert("Port Error!");
			}
		}
	}
	
}




function portIsNonDefaultVlanMember(port_config_id)
{
	for (var i =0; i < vlan_config.length; i++){
		if (vlan_config[i][0] == 1) continue;
		
		/*untagged*/
		for (var j = 0; j < vlan_config[i][4].length; j++){
			if ((vlan_config[i][4][j][0] == parseInt(port_config[port_config_id][0], 10))
				&& (vlan_config[i][4][j][1] == parseInt(port_config[port_config_id][1], 10))
				&& (vlan_config[i][4][j][2] == parseInt(port_config[port_config_id][2], 10)))
				return true;
		}
		/*tagged*/
		for (var j = 0; j < vlan_config[i][5].length; j++){
			if ((vlan_config[i][5][j][0] == parseInt(port_config[port_config_id][0], 10))
				&& (vlan_config[i][5][j][1] == parseInt(port_config[port_config_id][1], 10))
				&& (vlan_config[i][5][j][2] == parseInt(port_config[port_config_id][2], 10)))
				return true;
		}
	}
	return false;
}

function vlanDisablePort()
{
	/*vlan disable*/
	for(var i = 0;i < port_config.length; i++){
		if (portIsNonDefaultVlanMember(i)){
			vlan_disabled.push(true);
			for(var k =0;k < trunk_range.length;++k){
				E('_' + k + i + '_port').disabled = true;
			}
		}else{
			vlan_disabled.push(false);
			for(var k =0;k < trunk_range.length;++k){
				E('_' + k + i + '_port').disabled = false;
			}
		}
	}
}





function checkChange()
{
	/*trunk*/
	for(var i=0;i < port_config.length;++i){
		if (vlan_disabled[i] == true) continue;
		var j;
		for(j=0;j < trunk_range.length;++j){
			if((E('_' + j + i + '_port').checked ? 1:0) == 1){
				line = j;
				column = i;
				break;
			}
		}
		if(j == trunk_range.length){
			for(var k =0;k < trunk_range.length;++k){
				E('_' + k + i + '_port').disabled = false;
			}
		}else{
			for(var k =0;k < trunk_range.length;++k){
				if(k != j){
					E('_' + k + i + '_port').disabled = true;
				}
			}
		}
	}
	
}

function verifyFields(focused, quiet)
{
	var cmd = "";
	var fom = E('_fom');

	E('save-button').disabled = true;	

	checkChange();
	// pre verify ports
	for(var i=0;i < trunk_range.length;++i){
		var count = 0;
		for(var j=0;j < port_config.length;++j){
			if((E('_' + i + j + '_port').checked ? 1:0) == 1){
				count++;
				if (count > 8){
					show_alert("Trunk "+trunk_range[i]+" "+ errmsg.tkover);
					return 0;
				}
			}
		}
	}
	
	//check policy
	if(E('_policy').value != trunk_config[0]){
		if(E('_policy').value == ''){
			cmd += "!" + "\n";
			cmd += "no port-channel load-balance" + "\n";
		}else{
			cmd += "!" + "\n";
			cmd += "port-channel load-balance " + trunk_policy[E('_policy').value] + "\n";
		}
	}


	
	//check trunk's port tobe del
	for(var i=0;i < trunk_range.length;++i){
		//delete
		for(var j=0;j < port_config.length;++j){
			if((E('_' + i + j + '_port').checked ? 1:0) != trunk_config_old[trunk_range[i]][j]){
				if((E('_' + i + j + '_port').checked ? 1:0) != 1){//delete port
					cmd += "!" + "\n";
					cmd += "interface " + port_cmd_list[j] + "\n";
					cmd += "no channel-group" + "\n";
				}
			}
		}

		//add
		for(var j=0;j < port_config.length;++j){
			if((E('_' + i + j + '_port').checked ? 1:0) != trunk_config_old[trunk_range[i]][j]){
				if((E('_' + i + j + '_port').checked ? 1:0) == 1){//add port
					cmd += "!" + "\n";
					cmd += "interface " + port_cmd_list[j] + "\n";
					cmd += "channel-group " + trunk_range[i] +" mode on"+ "\n";
				}
			}
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
	vlanDisablePort();
	verifyFields(null,1);
	//checkChange();

}

function init()
{
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

<!--
<div class='section-title'><script type='text/javascript'>/*W(trunk.policy);*/</script></div>
-->
<div class='section'>
<script type='text/javascript'>
createFieldTable('', [
	{ title: trunk.policy, name: 'policy', type: 'select',options: [[0,'sada'],[1,'hash']], value: trunk_config[0]}	
]);
</script>
</div>
<!--
<div class='section-title'><script type='text/javascript'>/*W(trunk.port);*/</script></div>
-->
<div class='section'>
	<table class='web-grid' cellspacing=1 id='adm_grid'>
<script type='text/javascript'>
		W("<tr id='adm-head'>");
			W("<td width=80>" + 'Trunk ID' + "</td>");
			for( var i = 0; i < trunk_range.length; i++){
				W("<td>" + trunk_range[i] + "</td>");		
			}		
		W("</tr>");
		for(var j=0;j<port_config.length;j++){
			W("<td>" + port_type[port_config[j][0]] + port_config[j][1] + "/" + port_config[j][2] + "</td>");
			for( var i = 0; i < trunk_range.length; i++){
				create_checkbox("verifyFields", "_" + i + j + "_port", i + j + "_port", ((trunk_config_old[trunk_range[i]][j]=='1') ? true : false));
			}
			W("</tr>");
		}
		
		
		
</script>
	</table>
</div>

<script type='text/javascript'>
init();
if(cookie.get('autosave') == 1)
	ui.aply=ui.aply_save;
genStdFooter("");
</script>
</form>
<script type='text/javascript'>earlyInit();</script>
</body>
</html>
