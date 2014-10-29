<% pagehead(menu.switch_interface_advanced) %>

<style type='text/css'>
#adm-head{
	Text-align: left;
	background: #e7e7e7;
}
#adm_grid{
	width: 1150px;
} 
#adm_grid .co1 {
	width: 100px;
}

</style>

<script type='text/javascript'>

<% ih_sysinfo() %>
<% ih_user_info(); %>

var	port_config=[];
<% web_exec('show running-config interface') %>
/*
	port_config = [[1,1,1,1,3,2,1,0,0,0,0,0,0,0,0,0,1,0,0,0,'',0],
						[1,1,2,1,3,2,1,0,0,0,0,0,0,0,0,0,1,0,0,0,'',1],
						[1,1,3,1,3,2,1,0,0,0,0,0,0,0,0,0,1,0,0,0,'',0],
						[1,1,4,1,3,2,1,0,0,0,0,0,0,0,0,0,1,0,0,0,'',0],
						[1,1,5,1,3,2,1,0,0,0,0,0,0,0,0,0,1,0,0,0,'',0],
						[1,1,6,1,3,2,1,0,0,0,0,0,0,0,0,0,1,0,0,0,'',0],
						[1,1,7,1,3,2,1,0,0,0,0,0,0,0,0,0,1,0,0,0,'',0],
						[1,1,8,1,3,2,1,0,0,0,0,0,0,0,0,0,1,0,0,0,'',0],
						[2,1,1,1,3,2,1,0,0,0,0,0,0,0,0,0,100,0,0,0,'',0],
						[2,1,2,1,3,2,1,0,0,0,0,0,0,0,0,0,100,0,0,0,'',0]];

*/

var port_type = ['undefine','FE','GE'];
var select_learn = ['Disable','Enable'];
var select_discard = ['none','tagged','untagged'];
var select_storm = ['none','unicast','multicast','broadcast','multicast&unicast', 'broadcast&unicast', 'broadcast&multicast', 'all'];
var select_block = ['none','unicast','multicast','both'];
var select_exceed_action = ['none','drop','flow-control'];
var port_cmd_list = [];
var vlan_tunnel_options = ['Disable','Enable'];
for(var i=0;i<port_config.length;++i){

	if(port_config[i][0] == 1){
		port_cmd_list.push("fastethernet "+ port_config[i][1] + "/" + port_config[i][2]);
	}else if(port_config[i][0] == 2){
		port_cmd_list.push("gigabitethernet "+ port_config[i][1] + "/" + port_config[i][2]);
	}
}

function getStormId(cfg_num)
{
	var strom_option_id = 0;
	
	switch(cfg_num){
	case 0: strom_option_id = 0;break;//none
	case 1: strom_option_id = 1;break;//ucast
	case 2: strom_option_id = 2;break;//mcast
	case 3: strom_option_id = 4;break;//u+m
	case 4: strom_option_id = 3;break;//bcast
	case 5: strom_option_id = 5;break;//u+b
	case 6: strom_option_id = 6;break;//m+b
	case 7: strom_option_id = 7;break;//u+m+b
	default:strom_option_id = 0;
	}

	return strom_option_id;
}

function isDigit(str)
{ 
  var reg = /^\d*$/; 

  return reg.test(str); 
}

/*
function checkChange()
{
	for(var i = 0;i < port_config.length;i++){

		if(E('_'+i+'_learn').value == 'Disable'){
			E('_'+i+'_learn_limit').disabled = true; 
			E('_'+i+'_learn_limit').value = '';
		}else{
			E('_'+i+'_learn_limit').disabled = false;
		}

		if(E('_'+i+'_storm').value == 'none'){
			E('_' + i + '_control_value').disabled = true;
			E('_' + i + '_control_value').value = '';
		}else{
			E('_' + i + '_control_value').disabled = false;
		}
	}
}
*/
	
function creatSelect(options,value,idex,name)
{
	var string = "<td><select onchange='verifyFields(null, true)' id=_"+idex+""+name+">";

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


function strReplace(instr){
	var outstr=instr.replace(/&/g," ");
    return outstr;
}

function v_speed(e, quiet)
{
	var speed = parseInt(e.value, 10);

	if (speed >= 64 && speed < 1000){//64
		if (speed % 64 != 0){
			ferror.set(e, errmsg.bad_rate1, quiet);
			return 0;
		}
	}else if (speed >= 1000 && speed < 100000){//1M
		if (speed % 1000 != 0){
			ferror.set(e, errmsg.bad_rate2, quiet);
			return 0;
		}		
	}else if (speed >= 100000 && speed <= 1000000){
		if (speed % 100000 != 0){//100M
			ferror.set(e, errmsg.bad_rate3, quiet);
			return 0;
		}	
	}else{
		ferror.set(e, errmsg.bad_control_value, quiet);
		return 0;
	}

	ferror.clear(e);
	return 1;
}

function verifyFields(focused, quiet)
{
	var cmd = "";
	var fom = E('_fom');

	E('save-button').disabled = true;	

	for(var i = 0;i < port_config.length;i++){

		if(E('_'+i+'_learn').value == 'Disable'){
			E('_'+i+'_learn_limit').disabled = true; 
			E('_'+i+'_learn_limit').value = 0;
			ferror.clear(E('_'+i+'_learn_limit'));
		}else{
			E('_'+i+'_learn_limit').disabled = false;
			if (!v_f_number(E('_'+i+'_learn_limit'), quiet, true, 0, 255)) return 0;
		}

		if(E('_'+i+'_storm').value == 'none'){
			E('_' + i + '_control_value').disabled = true;
			E('_' + i + '_control_value').value = '';
			ferror.clear(E('_' + i + '_control_value'));
		}else{
			E('_' + i + '_control_value').disabled = false;
			if(E('_' + i + '_control_value').value == ''){
				ferror.set(E('_' + i + '_control_value'), errmsg.adm3, quiet);
				return 0;
			}
			if (!v_speed(E('_' + i + '_control_value'), quiet)) return 0;
		}

		
		if(E('_'+i+'_ingress_rate').value != 0){
			if (!v_speed(E('_'+i+'_ingress_rate'), quiet)) return 0;
	
		}

		if((E('_'+i+'_ingress_rate').value == '')||(E('_'+i+'_ingress_rate').value == 0)){
			
			ferror.clear(E('_'+i+'_exceed_action'));
			E('_' + i + '_exceed_action').disabled = true;
		}else{
			E('_' + i + '_exceed_action').disabled = false;
			if (E('_' + i + '_exceed_action').value  == 'none')
				E('_' + i + '_exceed_action').value = 'drop';			
		}

		if(E('_'+i+'_ingress_rate').value != 0){
			if(E('_' + i + '_exceed_action').value =='none'){
				ferror.set(E('_'+i+'_exceed_action'), errmsg.bad_exc_action, quiet);
				return 0;
			}else{
				ferror.clear(E('_'+i+'_exceed_action'));
			}
		}

		if(E('_'+i+'_egress_rate').value != 0){
			if (!v_speed(E('_'+i+'_egress_rate'), quiet)) return 0;

		}
				
	}


	for(var i = 0;i < port_config.length;i++){
		var interface_view_flag = 1;
		
		//compare port learn
		if(E('_'+i+'_learn').value != select_learn[port_config[i][6]]){
			if(interface_view_flag){
				cmd += "!" + "\n";
				cmd += "interface " + port_cmd_list[i] + "\n";
				interface_view_flag = 0;
			}

			if(E('_'+i+'_learn').value == 'Disable'){
				cmd += "no learn" + "\n";
			}else{
				cmd += "learn" + "\n";
			}
		}

		//compare port learn limit
		if(E('_'+i+'_learn_limit').value != port_config[i][7]){
			if(interface_view_flag){
				cmd += "!" + "\n";
				cmd += "interface " + port_cmd_list[i] + "\n";
				interface_view_flag = 0;
			}
			if(E('_'+i+'_learn_limit').value == '' || parseInt(E('_'+i+'_learn_limit').value, 10) == 0){
				cmd += "no learn limit" +  "\n";
			}else{
				cmd += "learn limit " + E('_'+i+'_learn_limit').value +  "\n";
			}
			
		}

		//compare port storm control 
		if((E('_'+i+'_storm').value != select_storm[getStormId(port_config[i][10])])
			|| (E('_' + i + '_control_value').value != port_config[i][11])){
			if(interface_view_flag){
				cmd += "!" + "\n";
				cmd += "interface " + port_cmd_list[i] + "\n";
				interface_view_flag = 0;
			}
			if(E('_'+i+'_storm').value == 'all'){
				cmd += "storm-control broadcast multicast unicast " + E('_' + i + '_control_value').value + "\n";
			}else if(E('_'+i+'_storm').value == 'none'){
				cmd += "no storm-control" + "\n";
			}else{
				cmd += "storm-control " + strReplace(E('_'+i+'_storm').value)+ " " + E('_' + i + '_control_value').value + "\n";
			}
		}

		//ingress rate and exceed action 
		if(E('_'+ i + '_ingress_rate').value != port_config[i][12]){
			if(interface_view_flag){
				cmd += "!" + "\n";
				cmd += "interface " + port_cmd_list[i] + "\n";
				interface_view_flag = 0;
			}
			if((E('_'+ i + '_ingress_rate').value == '')||(E('_'+ i + '_ingress_rate').value == 0))
				cmd += "no rate-limit bandwidth ingress" + "\n";
			else{
				if(E('_'+ i + '_exceed_action').value == 'flow-control')
					cmd += "rate-limit bandwidth " + E('_'+ i + '_ingress_rate').value + " " + "ingress" + " flow-control" + "\n";
				else
					cmd += "rate-limit bandwidth " + E('_'+ i + '_ingress_rate').value + " " + "ingress" + "\n";
			}
		}else{
			//exceed action 
			if(port_config[i][12] != 0){
				if(E('_'+ i + '_exceed_action').value != ['drop','flow-control'][port_config[i][13]]){
					if(interface_view_flag){
						cmd += "!" + "\n";
						cmd += "interface " + port_cmd_list[i] + "\n";
						interface_view_flag = 0;
					}
					if(E('_'+ i + '_exceed_action').value == 'drop')
						cmd += "rate-limit bandwidth " + E('_'+ i + '_ingress_rate').value + " " + "ingress" + "\n";	
					else
						cmd += "rate-limit bandwidth " + E('_'+ i + '_ingress_rate').value + " " + "ingress" + " flow-control" + "\n";
				}	
			}	
		}

		//egress rate
		if(E('_'+ i + '_egress_rate').value != port_config[i][14]){
			if(interface_view_flag){
				cmd += "!" + "\n";
				cmd += "interface " + port_cmd_list[i] + "\n";
				interface_view_flag = 0;
			}
			if((E('_'+ i + '_egress_rate').value == '')||(E('_'+ i + '_egress_rate').value == 0))
				cmd += "no rate-limit bandwidth egress" + "\n";
			else
				cmd += "rate-limit bandwidth " + E('_'+ i + '_egress_rate').value + " " + "egress" + "\n";
		}
		
		//compare port block
		if(E('_' + i + '_block').value != select_block[port_config[i][18]]){
			if(interface_view_flag){
				cmd += "!" + "\n";
				cmd += "interface " + port_cmd_list[i] + "\n";
				interface_view_flag = 0;
			}
			if(E('_' + i + '_block').value == 'none'){
				cmd += "no block" + "\n";
			}else{
				cmd += "block " + E('_' + i + '_block').value  + "\n";
			}
			
		}

		//compare port discard
		if(E('_' + i + '_discard').value != select_discard[port_config[i][19]]){
			//alert(E('_' + i + '_discard').value+" => "+select_discard[port_config[i][19]]);
			if(interface_view_flag){
				cmd += "!" + "\n";
				cmd += "interface " + port_cmd_list[i] + "\n";
				interface_view_flag = 0;
			}
			if(E('_' + i + '_discard').value == 'none'){
				cmd += "no discard" + "\n";
			}else{
				cmd += "discard " + E('_' + i + '_discard').value  + "\n";
			}
			
		}
		/*
		//vlan-tunnel
		if(E('_' + i + '_tunnel').value != vlan_tunnel_options[port_config[i][21]]){
			if(interface_view_flag){
				cmd += "!" + "\n";
				cmd += "interface " + port_cmd_list[i] + "\n";
				interface_view_flag = 0;
			}

			cmd += ((E('_' + i + '_tunnel').value == "Disable")?("no "):("")) + "vlan-tunnel" + "\n";
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
	if (cookie.get('debugcmd') == 1)
		alert(E('_fom')._web_cmd.value);
	if((E('_fom')._web_cmd.value != '')&&(cookie.get('autosave') == 1)){
		E('_fom')._web_cmd.value += "!"+"\n"+"copy running-config startup-config"+"\n";	
	}
	form.submit('_fom', 1);
}


function earlyInit()
{
	verifyFields(null,1);
	//checkChange();
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
			W("<td width=50>" + port.port + "</td>");
			W("<td width=80>" + port.learn_status + "</td>");
			W("<td width=80>" + port.learn_limit + "</td>");
			W("<td width=200>" + port.storm_control + "</td>");
			W("<td width=150>" + port.storm_rate+"(kbps)" + "</td>");
			W("<td width=150>" + port.ingress_rate+"(kbps)" + "</td>");
			W("<td width=150>" + port.exceed_action + "</td>");
			W("<td width=150>" + port.egress_rate+"(kbps)" + "</td>");
			W("<td width=150>" + port.block_type + "</td>");
			W("<td width=100>" + port.discard_frame + "</td>");	
			/* W("<td width=80>" + port.vlan_tunnel + "</td>"); */
		W("</tr>");
		
		var i;
		var storm_type;
		for( i = 0; i < port_config.length; i++){
			
			if(port_config[i][0] == 'other'){
				port_config[i][0] = 0;
			}

			storm_type = select_storm[getStormId(port_config[i][10])];
			/*
			if(port_config[i][10] == 4){
				storm_type = select_storm[3];	
			}else if(port_config[i][10] == 7){
				storm_type = select_storm[4];	
			}else{
				storm_type = select_storm[port_config[i][10]];	
			}
			*/
						
			W("<td>" + port_type[port_config[i][0]] + port_config[i][1] + "/" + port_config[i][2] + "</td>"); 
			W(creatSelect(select_learn,select_learn[port_config[i][6]],i,'_learn'));
			W("<td><input type='text' onchange='verifyFields(null, true)' id='_" + i + "_learn_limit' name='" + i + "_learn_limit' value='" + port_config[i][7] + "'></td>");
			W(creatSelect(select_storm,storm_type,i,'_storm'));
			W("<td><input type='text' onchange='verifyFields(null, true)' id='_" + i + "_control_value' name='" + i +"_control_value' value='"+ port_config[i][11] +"'></td>");
			W("<td><input type='text' onchange='verifyFields(null, true)' id='_" + i + "_ingress_rate' name='" + i +"_ingress_rate' value='"+ port_config[i][12] +"'></td>");
			//exceed action
			if(port_config[i][13] == 1){
				W(creatSelect(select_exceed_action,select_exceed_action[port_config[i][13]+1],i,'_exceed_action'));
			}else{
				if(port_config[i][12] ==0){
					W(creatSelect(select_exceed_action,select_exceed_action[0],i,'_exceed_action'));
				}else{
					W(creatSelect(select_exceed_action,select_exceed_action[1],i,'_exceed_action'));
				}
			}
			
			W("<td><input type='text' onchange='verifyFields(null, true)' id='_" + i + "_egress_rate' name='" + i +"_egress_rate' value='"+ port_config[i][14] +"'></td>");
			W(creatSelect(select_block,select_block[port_config[i][18]],i,'_block'));
			W(creatSelect(select_discard,select_discard[port_config[i][19]],i,'_discard'));
			/* W(creatSelect(vlan_tunnel_options,vlan_tunnel_options[port_config[i][21]],i,'_tunnel')); */
			W("</tr>");			
		}
</script>
	</table>
</div>
<div>
<script type='text/javascript'>GetText(ui.note);</script>
</div>
<div>
<script type='text/javascript'>GetText(infomsg.flowctl);</script>
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
