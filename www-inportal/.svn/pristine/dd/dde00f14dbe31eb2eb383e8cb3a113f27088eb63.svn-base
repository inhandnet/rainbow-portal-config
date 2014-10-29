<% pagehead(menu.switch_gmrp) %>

<style tyle='text/css'>
#bs-grid {
	width:300px;
	text-align: center;
}

</style>

<script type='text/javascript'>

<% ih_sysinfo() %>
<% ih_user_info(); %>

<% web_exec('show running-config gmrp') %>
/*
var GMRP_config = {

	global_aware: 1,                     //1--GMRP is globally enabled, 0--GMRP is globally disabled

	hold_timeval: 200,                                         //number is hold time value

	join_timeval: 400,                                           //number is join time value

	leave_timeval: 600,                                       //number is leave time value

	leaveall_timeval: 7000,                                            //number is leaveall time value

	RSTP_flooding: 1,                    //1 when enabled,0 when disabled

	if_mode:[['1','1','1',1],['1','1','2',1],['1','1','3',1],['1','1','4',1],['1','1','5',1],['1','1','6',1],['1','1','7',1],['1','1','8',1],['2','1','1',1],['2','1','2',1],['2','1','3',1]]

 }
*/
	
var gmrp_port_mode = ['Disable','Adv-Only','Adv&Learn'];
var tmp_old_config = [];
var port_title_list = [];
var port_cmd_list = [];
var switch_interface = [];

for (var i=0; i<GMRP_config.if_mode.length; i++) {
	if(GMRP_config.if_mode[i][0] == 1){
		port_cmd_list.push("fastethernet "+ GMRP_config.if_mode[i][1] + "/" + GMRP_config.if_mode[i][2]);
		port_title_list.push("FE"+ GMRP_config.if_mode[i][1] + "/" + GMRP_config.if_mode[i][2]);
	}else if(GMRP_config.if_mode[i][0] == 2){
		port_cmd_list.push("gigabitethernet "+ GMRP_config.if_mode[i][1] + "/" + GMRP_config.if_mode[i][2]);
		port_title_list.push("GE"+ GMRP_config.if_mode[i][1] + "/" + GMRP_config.if_mode[i][2]);
	}
}

function isDigit(str)
{ 
  var reg = /^\d*$/; 

  return reg.test(str); 
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
	var dis;
	var cmd = "";
	var fom = E('_fom');
	var view_flag = 1;

	E('save-button').disabled = true;

	dis = !(E('_f_gmrp_enable').checked);
	E('_port_parameters').style.display = dis ? 'none' : 'block';
	E('_port_parameters_title').style.display = dis ? 'none' : 'block';

	if(E('_hold_timer').value != ''){
		if((E('_hold_timer').value  < 100) ||(E('_hold_timer').value  > 2000)||(!isDigit(E('_hold_timer').value))){
			ferror.set(E('_hold_timer'), errmsg.gmrp_holdtimer, false);
			return 0;
		}else{
			ferror.clear(E('_hold_timer'), errmsg.gmrp_holdtimer, false);
		}
	}else{
		ferror.clear(E('_hold_timer'), errmsg.gmrp_holdtimer, false);
	}

	if(E('_join_timer').value != ''){
		if((E('_join_timer').value  < 200) ||(E('_join_timer').value  > 4000)||(!isDigit(E('_join_timer').value))){
			ferror.set(E('_join_timer'), errmsg.gmrp_jointimer, false);
			return 0;
		}else{
			//join timer > 2*hold_timer
			if(E('_join_timer').value <E('_hold_timer').value*2){
				ferror.set(E('_join_timer'), errmsg.suggest_jointimer, false);	
			}else{
				ferror.clear(E('_join_timer'), errmsg.gmrp_jointimer, false);
			}
		}
	}else{
		ferror.clear(E('_join_timer'), errmsg.gmrp_jointimer, false);
	}

	if(E('_leave_timer').value != ''){
		if((E('_leave_timer').value  < 600) ||(E('_leave_timer').value  > 8000)||(!isDigit(E('_leave_timer').value))){
			ferror.set(E('_leave_timer'), errmsg.gmrp_leavetimer, false);
			return 0;
		}else{
			//leave timer > 2*join timer
			if(E('_leave_timer').value < E('_join_timer').value*2){
				ferror.set(E('_leave_timer'), errmsg.suggest_leavetimer, false);	
			}else{
				ferror.clear(E('_leave_timer'), errmsg.gmrp_leavetimer, false);
			}
		}
	}else{
		ferror.clear(E('_leave_timer'), errmsg.gmrp_leavetimer, false);
	}

	if(E('_leaveall_timer').value != ''){
		if((E('_leaveall_timer').value  < 6000) ||(E('_leaveall_timer').value  > 60000)||(!isDigit(E('_leaveall_timer').value))){
			ferror.set(E('_leaveall_timer'), errmsg.gmrp_leavealltimer, false);
			return 0;
		}else{
			if(parseInt(E('_leaveall_timer').value,10) < parseInt(E('_leave_timer').value,10)){
				ferror.set(E('_leaveall_timer'), errmsg.suggest_leavealltimer, false);	
			}else{
				ferror.clear(E('_leaveall_timer'), errmsg.gmrp_leavealltimer, false);
			}
		}
	}else{
		ferror.clear(E('_leaveall_timer'), errmsg.gmrp_leavealltimer, false);
	}
	
	//check gmrp enable
	if((E('_f_gmrp_enable').checked ? 1 : 0) != GMRP_config.global_aware){
		if(view_flag){
			cmd += "!" + "\n";
			view_flag = 0;
		}
		if(E('_f_gmrp_enable').checked){
			cmd += "gmrp global" + "\n";
		}else{
			cmd += "no gmrp global" + "\n";
		}

	}

	//rstp flooding enable
	if((E('_rstp_flooding_enable').checked ? 1 : 0) != GMRP_config.RSTP_flooding){
		if(view_flag){
			cmd += "!" + "\n";
			view_flag = 0;
		}
		if(E('_rstp_flooding_enable').checked){
			cmd += "gmrp rstp-flooding" + "\n";
		}else{
			cmd += "no gmrp rstp-flooding" + "\n";
		}

	}

	//hold timer
	if(E('_hold_timer').value != GMRP_config.hold_timeval){
		if(view_flag){
			cmd += "!" + "\n";
			view_flag = 0;
		}
		if(E('_hold_timer').value != ''){
			cmd += "gmrp timer hold " + E('_hold_timer').value + "\n";
		}else{
			cmd += "no gmrp timer hold" + "\n";
		}
	}
	//join timer
	if(E('_join_timer').value != GMRP_config.join_timeval){
		if(view_flag){
			cmd += "!" + "\n";
			view_flag = 0;
		}
		if(E('_join_timer').value != ''){
			cmd += "gmrp timer join " + E('_join_timer').value + "\n";
		}else{
			cmd += "no gmrp timer join" + "\n";
		}
	}
	//leave timer
	if(E('_leave_timer').value != GMRP_config.leave_timeval){
		if(view_flag){
			cmd += "!" + "\n";
			view_flag = 0;
		}
		if(E('_leave_timer').value != ''){
			cmd += "gmrp timer leave " + E('_leave_timer').value + "\n";
		}else{
			cmd += "no gmrp timer leave" + "\n";
		}
	}
	//leaveall timer
	if(E('_leaveall_timer').value != GMRP_config.leaveall_timeval){
		if(view_flag){
			cmd += "!" + "\n";
			view_flag = 0;
		}
		if(E('_leaveall_timer').value != ''){
			cmd += "gmrp timer lv-all " + E('_leaveall_timer').value + "\n";
		}else{
			cmd += "no gmrp timer lv-all" + "\n";
		}
	}
		
	//port  gmrp mode
	if(E('_f_gmrp_enable').checked){
		for(var i=0;i<GMRP_config.if_mode.length;++i){
			if(E('_'+i+'_port_gmrp_enable').value != gmrp_port_mode[GMRP_config.if_mode[i][3]]){
				if(view_flag){
					cmd += "!"+ "\n";
					view_flag = 0;
				}
				switch(E('_'+i+'_port_gmrp_enable').value){
					case 'Disable': cmd += "gmrp interface " + port_cmd_list[i] + " disabled" + "\n"; break;
					case 'Adv-Only': cmd += "gmrp interface " + port_cmd_list[i] + " adv-only" + "\n"; break;
					case 'Adv&Learn': cmd += "gmrp interface " + port_cmd_list[i] + " adv-learn" + "\n"; break;
					case 'Default': cmd += "no gmrp interface " + port_cmd_list[i] + "\n"; break;
					default: break;
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
	
	return ok;	
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
}
</script>
</head>
<body onload='init()'>
<form id='_fom' method='post' action='apply.cgi'>
<input type='hidden' name='_web_cmd' value=''>

<div class='section'>
<script type='text/javascript'>

createFieldTable('', [
	{ title: gmrp.gmrp_status, name: 'f_gmrp_enable', type: 'checkbox', value: GMRP_config.global_aware},
	{ title: gmrp.rstp_flooding, indent:2, hidden: true, name: 'rstp_flooding_enable', type: 'checkbox', value: GMRP_config.RSTP_flooding},
	{ title: gmrp.hold_timer, indent: 2, name: 'hold_timer', type: 'text', maxlen: 15, size: 17, suffix: ' '+'(100-2000)'+ui.mseconds,value: GMRP_config.hold_timeval},
	{ title: gmrp.join_timer, indent: 2, name: 'join_timer', type: 'text', maxlen: 15, size: 17,suffix: ' '+'(200-4000)'+ui.mseconds,value: GMRP_config.join_timeval},
	{ title: gmrp.leave_timer, indent: 2, name: 'leave_timer', type: 'text', maxlen: 15, size: 17,suffix: ' '+'(600-8000)'+ui.mseconds, value: GMRP_config.leave_timeval},
	{ title: gmrp.leaveall_timer, indent: 2, name: 'leaveall_timer', type: 'text', maxlen: 15, size: 17, suffix: ' '+'(6000-60000)'+ui.mseconds,value: GMRP_config.leaveall_timeval}
]);
</script>
</div>


<div class='section-title' id='_port_parameters_title'>
<script type='text/javascript'>
	GetText(ui.port_parameters);
</script>
</div>
<div class='section' id='_port_parameters'>
	<table class='web-grid' id='bs-grid'>

<script type='text/javascript'>
		W("<tr id='adm-head'>");
			W("<td width=80>" + rstp.select_port + "</td>");
			W("<td width=80>" + gmrp.port_mode + "</td>");
		W("</tr>");
		
		for( var i = 0; i < GMRP_config.if_mode.length; i++){
			W("<td>" + port_title_list[i] + "</td>");
			W(creatSelect(gmrp_port_mode,gmrp_port_mode[GMRP_config.if_mode[i][3]],i,'_port_gmrp_enable'));
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
