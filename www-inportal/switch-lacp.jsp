<% pagehead() %>

<style tyle='text/css'>
#bs-grid {
	width:500px;
	text-align: center;
}

</style>

<script type='text/javascript'>

<% ih_sysinfo() %>
<% ih_user_info(); %>

<% web_exec('show running-config lacp') %>
/*
var lacp_config = {
	system_priority: 2,
	lacp_port: [[[1,1,1], 1, 1,1],[[1,1,2], 1, 0,1],[[1,1,3], 1, 0,1],[[1,1,4], 1, 0,1],[[1,1,5],1, 0,1],[[1,1,6], 1, 0,1],[[1,1,7], 1, 0,1],[[1,1,8], 1, 0,1],[[2,1,1], 1, 0,1],[[2,1,2], 1, 0,1],[[2,1,3], 1, 0,1]]
}
*/

var tmp_old_config = [];
var port_title_list = [];
var port_cmd_list = [];
var switch_interface = [];
var channel_group = ['--','1','2','3','4','5','6'];
var lacp_mode=['passive','active'];

for (var i=0; i<lacp_config.lacp_port.length; i++) {
	if(lacp_config.lacp_port[i][0][0] == 1){
		port_cmd_list.push("fastethernet "+ lacp_config.lacp_port[i][0][1] + "/" + lacp_config.lacp_port[i][0][2]);
		port_title_list.push("FE"+ lacp_config.lacp_port[i][0][1] + "/" + lacp_config.lacp_port[i][0][2]);
	}else if(lacp_config.lacp_port[i][0][0] == 2){
		port_cmd_list.push("gigabitethernet "+ lacp_config.lacp_port[i][0][1] + "/" + lacp_config.lacp_port[i][0][2]);
		port_title_list.push("GE"+ lacp_config.lacp_port[i][0][1] + "/" + lacp_config.lacp_port[i][0][2]);
	}
	
}

function isDigit(str)
{ 
  var reg = /^\d*$/; 

  return reg.test(str); 
 }

function check_port_change(quiet)
{
	var cmd = '';

	for(var i=0;i<lacp_config.lacp_port.length;++i){
		var interface_view =1;
		if(E('_'+i+'_channel_group').value == '--')
			E('_'+i+'_lacp_mode').disabled = true;
		else
			E('_'+i+'_lacp_mode').disabled = false;
		//check group
		if(E('_'+i+'_channel_group').value != channel_group[lacp_config.lacp_port[i][2]]){
			if(interface_view){
				cmd += "!" + "\n";
				cmd += "interface "+ port_cmd_list[i]+"\n";
				interface_view = 0;
			}
			if(E('_'+i+'_channel_group').value != '--'){
				if(lacp_config.lacp_port[i][2] != 0)
					cmd += "no channel-group lacp" + "\n";
				cmd += "channel-group " + E('_'+i+'_channel_group').value + " mode " + E('_'+i+'_lacp_mode').value + "\n";
			}else{
				cmd += "no channel-group lacp" + "\n";
			}
			
		}else{//check mode
			if(E('_'+i+'_lacp_mode').value !=  lacp_mode[lacp_config.lacp_port[i][3]]){
				if(interface_view){
					cmd += "!" + "\n";
					cmd += "interface "+ port_cmd_list[i]+"\n";
					interface_view = 0;
				}
				cmd += "no channel-group lacp" + "\n";
				cmd += "channel-group " + E('_'+i+'_channel_group').value + " mode " + E('_'+i+'_lacp_mode').value + "\n";
			}
		}
		//check priority
		if(E('_'+i+'_port_priority').value != lacp_config.lacp_port[i][1]){
			if(interface_view){
				cmd += "!" + "\n";
				cmd += "interface "+ port_cmd_list[i]+"\n";
				interface_view = 0;
			}
			if(E('_'+i+'_port_priority').value != '')
				cmd += "lacp port-priority " + E('_'+i+'_port_priority').value + "\n";
			else
				cmd += "no lacp port-priority" + "\n";
		}
	
	}

	return cmd;

}

function creatSelect(options,value,idex,name)
{
	var string = '<td><select onchange=verifyFields() id=_'+idex+''+name+'>';

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
	var a;
	var ok = 1;
	var cmd = "";
	var fom = E('_fom');
	var view_flag = 1;

	E('save-button').disabled = true;

	if(E('_system_priority').value != ''){
		if((E('_system_priority').value < 1) ||(E('_system_priority').value > 65535)||(!isDigit(E('_system_priority').value))){
			ferror.set(E('_system_priority'), errmsg.lacp_priority, false);
			return 0;
		}else{
			ferror.clear(E('_system_priority'), errmsg.lacp_priority);
		}
	}

	/*check port config*/
	for(var i=0;i<lacp_config.lacp_port.length;++i){
		//check priority
		if(E('_'+i+'_port_priority').value != ''){
			if( (E('_'+i+'_port_priority').value < 1 || E('_'+i+'_port_priority').value > 65535)){//error
				ferror.set(E('_'+i+'_port_priority'), errmsg.lacp_priority, false);
				return 0;
			}else{//ok
				ferror.clear(E('_'+i+'_port_priority'), errmsg.lacp_priority);
			}
		}	
	}

	//system priority
	if(E('_system_priority').value != lacp_config.system_priority){
		if(E('_system_priority').value != ''){
			cmd += "!" + "\n";
			cmd += "lacp system-priority " + E('_system_priority').value + "\n";//set system priority
		}else{
			cmd += "!" + "\n";
			cmd += "no lacp system-priority" + "\n";//set default system priority 
		}
	}
	

	
	cmd += check_port_change(quiet);
	
	//alert(cmd);
	if (user_info.priv < admin_priv) {
		elem.display('save-button', false);
	}else{
		elem.display('save-button', true);
		fom._web_cmd.value = cmd;
		E('save-button').disabled = (cmd=="");	
	}
	
	return ok;	
}


function save()
{
	if (!verifyFields(null, false)) return;

	if((E('_fom')._web_cmd.value != '')&&(cookie.get('autosave') == 1)){
		E('_fom')._web_cmd.value += "!"+"\n"+"copy running-config startup-config"+"\n";	
	}

	if (cookie.get('debugcmd') == 1)
		alert(E('_fom')._web_cmd.value);

	form.submit('_fom', 1);
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

<div class='section-title'>
<script type='text/javascript'>
	GetText(lacp.global_title);
</script>
</div>
<div class='section'>
<script type='text/javascript'>

createFieldTable('', [
	{ title: lacp.system_priority, indent: 2, name: 'system_priority', type: 'text', maxlen: 15, size: 17,suffix:"(1-65535,default=32768)",value: lacp_config.system_priority}

]);
</script>
</div>


<div class='section-title' id='_port_parameters_title'>
<script type='text/javascript'>
	GetText(lacp.port_title);
</script>
</div>
<div class='section' id='_port_parameters'>
	<table class='web-grid' id='bs-grid'>

<script type='text/javascript'>
		W("<tr id='adm-head'>");
			W("<td width=80>" + rstp.select_port + "</td>");
			W("<td width=80>" + lacp.port_priority + "</td>");
			W("<td width=80>" + lacp.channel_goup + "</td>");
			W("<td width=80>" + lacp.lacp_mode + "</td>");
					
		W("</tr>");
		
		for( var i = 0; i < lacp_config.lacp_port.length; i++){
			W("<td>" + port_title_list[i] + "</td>");
			W("<td><input type='text' onchange='verifyFields()' id='_" + i + "_port_priority' name='" + i + "_port_priority' value='" + lacp_config.lacp_port[i][1] + "'></td>");
			W(creatSelect(channel_group,channel_group[lacp_config.lacp_port[i][2]],i,'_channel_group'));
			W(creatSelect(lacp_mode,lacp_mode[lacp_config.lacp_port[i][3]],i,'_lacp_mode'));
			
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
<script type='text/javascript'>verifyFields(null, 1);</script>
</body>
</html>
