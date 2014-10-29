<% pagehead(menu.switch_interface_basic) %>

<style type='text/css'>
#adm-head{
	Text-align: left;
	background: #e7e7e7;
}
#adm_grid{
	width: 320px;
} 
#adm_grid .co1 {
	width: 100px;
}

</style>

<script type='text/javascript'>

<% ih_sysinfo() %>
<% ih_user_info(); %>

//var port_config=[['1','1','1',1,3,2,1,0,0,0,0,0,0,0,0,0,1,0,0,0,'abc1,23'],['1','1','2',1,3,2,1,0,0,0,0,0,0,0,0,0,1,0,0,0,'abc1,23'],['1','1','3',1,3,2,1,0,0,0,0,0,0,0,0,0,1,0,0,0,'abc1,23'],['1','1','4',1,3,2,1,0,0,0,0,0,0,0,0,0,1,0,0,0,'abc1,23'],['1','1','5',1,3,2,1,0,0,0,0,0,0,0,0,0,1,0,0,0,'abc1,23'],['1','1','6',1,3,2,1,0,0,0,0,0,0,0,0,0,1,0,0,0,'abc1,23'],['1','1','7',1,3,2,1,0,0,0,0,0,0,0,0,0,1,0,0,0,'abc1,23'],['1','1','8',1,3,2,1,0,0,0,0,0,64,0,128,0,1,0,0,0,'abc1,23'],['2','1','1',1,3,2,1,0,0,0,0,0,64,0,128,0,1,0,0,0,'abc1,23'],['2','1','2',1,3,2,1,0,0,0,0,0,64,0,128,0,1,0,0,0,'abc1,23'],['2','1','3',1,3,2,1,0,0,0,0,0,64,0,128,0,1,0,0,0,'abc1,23']];

<% web_exec('show running-config interface') %>


var select_enable = ['shutdown','up'];
var select_duplex = ['half','full','auto'];
var select_speed_ge = ['10','100','1000','auto']; 
var select_speed_fe = ['10','100','auto'];
var port_type = ['undefine','FE','GE'];
var select_storm = ['none','unicast','multicast','broadcast','all'];
var select_flow = ['Disable','Enable','Force-Enable'];
var select_discard = ['none','tagged frame','untagged frame'];
var select_protected = ['normal','isolated'];

var port_cmd_list = [];

for(var i=0;i<port_config.length;++i){

	if(port_config[i][0] == 1){
		port_cmd_list.push("fastethernet "+ port_config[i][1] + "/" + port_config[i][2]);
	}else if(port_config[i][0] == 2){
		port_cmd_list.push("gigabitethernet "+ port_config[i][1] + "/" + port_config[i][2]);
	}
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
	var cmd = "";
	var fom = E('_fom');

	E('save-button').disabled = true;

	for(var i = 0;i < port_config.length;i++){
		var interface_view_flag = 1;
		if (port_config[i][1] == 0)
				continue;		
		//compare port enable,shutdown port or not
		if(E('_'+i+'_port_enable').value != select_enable[port_config[i][3]]){
			if(interface_view_flag){
				cmd += "!" + "\n";
				cmd += "interface " + port_cmd_list[i]+ "\n";
				interface_view_flag = 0;
			}

			if(E('_'+i+'_port_enable').value == 'shutdown'){
				cmd += "shutdown " + "\n";
			}
			else{
				cmd += "no shutdown " + "\n";
			}
		}
		
		//compare port speed
		if(port_config[i][22] == 1 ){
			E('_'+i+'_speed').disabled = true;
			E('_'+i+'_duplex').disabled = true; 
		}
			
		if(E('_'+i+'_speed').value != select_speed_ge[port_config[i][4]]){
			if(interface_view_flag){
				cmd += "!" + "\n";
				cmd += "interface " + port_cmd_list[i] + "\n";
				interface_view_flag = 0;
			}
			cmd += "speed " + E('_'+i+'_speed').value + "\n" ;
		}

		//compare port duplex
		if(E('_'+i+'_duplex').value != select_duplex[port_config[i][5]]){
			if(interface_view_flag){
				cmd += "!" + "\n";
				cmd += "interface " + port_cmd_list[i] + "\n";
				interface_view_flag = 0;
			}
			cmd += "duplex " + E('_'+i+'_duplex').value + "\n" ;
		}

/*
		//compare port flow control
		if(E('_' + i + '_flow_control').value != select_flow[port_config[i][8]]){
			if(interface_view_flag){
				cmd += "!" + "\n";
				cmd += "interface " + port_cmd_list[i] + "\n";
				interface_view_flag = 0;
			}
			//alert(E('_' + i + '_flow_control').value);
			if(E('_' + i + '_flow_control').value == 'Disable'){
				cmd += "no flow-control " + "\n" ;
			}else if(E('_' + i + '_flow_control').value == 'Force-Enable'){
				cmd += "flow-control force" + "\n" ;
			}else{
				cmd += "flow-control " + "\n" ;
			}
			
		}

		//compare port protected 
		if(E('_' + i + '_protected').value != select_protected[port_config[i][9]]){
			if(interface_view_flag){
				cmd += "!" + "\n";
				cmd += "interface " + port_cmd_list[i]+ "\n";
				interface_view_flag = 0;
			}
			if(E('_' + i + '_protected').value == 'isolated'){
				cmd += "protected " +"\n" ;
			}else{
				cmd += "no protected " +"\n" ;
			}
			
		}

		//compare port description
		if (!v_f_text(E('_' + i + '_description'), quiet, 0, 15)) return 0;
	
		if(E('_' + i + '_description').value != port_config[i][20]){
			
			if(interface_view_flag){
				cmd += "!" + "\n";
				cmd += "interface " + port_cmd_list[i]+ "\n";
				interface_view_flag = 0;
			}
			if (E('_' + i + '_description').value != '')
				cmd += "description " + E('_' + i + '_description').value + "\n" ;
			else
				cmd += "no description\n";
		}
*/
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
	//alert(E('_fom')._web_cmd.value);
	if((E('_fom')._web_cmd.value != '')&&(cookie.get('autosave') == 1)){
		E('_fom')._web_cmd.value += "!"+"\n"+"copy running-config startup-config"+"\n";	
	}
	form.submit('_fom', 1);
}


function earlyInit()
{
	verifyFields(null,1);
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
	<table class='web-grid' cellspacing=1 id='adm_grid'>
<script type='text/javascript'>
		W("<tr id='adm-head'>");
			W("<td class='header' width=80>" + port.port + "</td>");
			W("<td class='header' width=80>" + port.status + "</td>");
			W("<td class='header' width=80>" + port.speed + "</td>");
			W("<td class='header' width=80>" + port.duplex + "</td>");
			/*
			W("<td width=140>" + port.flow_control + "</td>");
			W("<td width=80>" + port.protected + "</td>");
			
			W("<td width=120>" + port.description + "</td>");	
			*/
		W("</tr>");
		
		var i;
		var storm_type;
		for( i = 0; i < port_config.length; i++){
			if(port_config[i][0] == 'other'){
				port_config[i][0] = 0;
			}
			if (port_config[i][1] == 0)
				continue;
												
			W("<td>" + port_type[port_config[i][0]] + port_config[i][1] + "/" + port_config[i][2] + "</td>"); 
			W(creatSelect(select_enable,select_enable[port_config[i][3]],i,'_port_enable'));
			if(port_config[i][0] == '1'){
				if(port_config[i][4] == 3){
					W(creatSelect(select_speed_fe,select_speed_fe[port_config[i][4]-1],i,'_speed'));
				}else{
					W(creatSelect(select_speed_fe,select_speed_fe[port_config[i][4]],i,'_speed'));
				}
			}else if(port_config[i][0] == '2'){
				W(creatSelect(select_speed_ge,select_speed_ge[port_config[i][4]],i,'_speed'));
			}
			
			W(creatSelect(select_duplex,select_duplex[port_config[i][5]],i,'_duplex'));
			/*
			W(creatSelect(select_flow,select_flow[port_config[i][8]],i,'_flow_control'));
			W(creatSelect(select_protected,select_protected[port_config[i][9]],i,'_protected'));
			W("<td><input type='text' onchange='verifyFields(null, true)' id='_" + i + "_description' name='" + i + "_description' maxlength=15 value='" + escapeHTML('' + port_config[i][20]) + "'></td>");
			*/
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
</script></form>
<script type='text/javascript'>earlyInit();</script>
</body>
</html>
