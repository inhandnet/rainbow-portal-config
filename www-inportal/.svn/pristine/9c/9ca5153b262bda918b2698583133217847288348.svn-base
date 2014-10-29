<% pagehead(lldp.lldp_title) %>

<style tyle='text/css'>
#bs-grid {
	width:300px;
	text-align: center;
}

</style>

<script type='text/javascript'>

<% ih_sysinfo() %>
<% ih_user_info(); %>

<% web_exec('show running-config lldp') %>

//var lldp_config = [1, 10, 2, 32768, 15, [[1,1,1], 0, 1],[[1,1,2], 0, 1],[[1,1,3], 0, 1],[[1,1,4], 0, 1],[[1,1,5], 0, 1],[[1,1,6], 0, 1],[[1,1,7], 0, 1],[[1,1,8], 0, 1],[[2,1,1], 0, 1],[[2,1,2], 0, 1],[[2,1,3], 0, 1]];

var tmp_old_config = [];
var port_title_list = [];
var port_cmd_list = [];
var switch_interface = [];
var admin_status=['Disabled','TxOnly','RxOnly','RxTx'];
var notification_options=['Disabled','Enabled'];
var port_cfg_index_start=6;
for (var i=port_cfg_index_start; i<lldp_config.length; i++) {
	if(lldp_config[i][0][0] == 1){
		port_cmd_list.push("fastethernet "+ lldp_config[i][0][1] + "/" + lldp_config[i][0][2]);
		port_title_list.push("FE"+ lldp_config[i][0][1] + "/" + lldp_config[i][0][2]);
	}else if(lldp_config[i][0][0] == 2){
		port_cmd_list.push("gigabitethernet "+ lldp_config[i][0][1] + "/" + lldp_config[i][0][2]);
		port_title_list.push("GE"+ lldp_config[i][0][1] + "/" + lldp_config[i][0][2]);
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
	
	for(var i=port_cfg_index_start;i<lldp_config.length;++i){
		var interface_view =1;
//		E('_'+i+'_port_notification').disabled = true;
		//check port admin status
		if(E('_'+i+'_port_admin_status').value != admin_status[lldp_config[i][1]]){
			
			if(interface_view){
				cmd += "!" + "\n";
				cmd += "interface "+ port_cmd_list[i-port_cfg_index_start]+"\n";
				interface_view = 0;
			}
			switch(E('_'+i+'_port_admin_status').value){
				case 'Disabled': cmd += "lldp disable" + "\n"; break;
				case 'TxOnly': cmd += "lldp txOnly" + "\n"; break;
				case 'RxOnly':  cmd += "lldp rxOnly" + "\n"; break;
				case 'RxTx': cmd += "lldp rxTx" + "\n"; break;
				default : break;
			}			
		}

		if (E('_'+i+'_port_notification').value != notification_options[lldp_config[i][2]]){
			if(interface_view){
				cmd += "!" + "\n";
				cmd += "interface "+ port_cmd_list[i-port_cfg_index_start]+"\n";
				interface_view = 0;
			}
			switch(E('_'+i+'_port_notification').value){
				case 'Disabled': cmd += "no lldp notification" + "\n"; break;
				case 'Enabled': cmd += "lldp notification" + "\n"; break;
				default : break;
			}
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
	var dis;
	var cmd = "";
	var fom = E('_fom');
	var view_flag = 1;
	var lldp_to_disable = 0;

	E('save-button').disabled = true;

	dis = !(E('_f_lldp_enable').checked);
	E('_port_parameters').style.display = dis ? 'none' : 'block';
	E('_port_parameters_title').style.display = dis ? 'none' : 'block';

	//interval
	if (!v_f_number(E('_lldp_tx_interval'), quiet, true, 5, 32768)) return 0;
	/*
	if(E('_lldp_tx_interval').value != ''){
		if((E('_lldp_tx_interval').value < 5) ||(E('_lldp_tx_interval').value > 32768)||(!isDigit(E('_lldp_tx_interval').value))){
			ferror.set(E('_lldp_tx_interval'), errmsg.lldp_tx_interval, false);
			return 0;
		}else{
			ferror.clear(E('_lldp_tx_interval'), errmsg.lldp_tx_interval);
		}
	}
	*/
	if (!v_f_number(E('_lldp_tx_hold'), quiet, true, 2, 10)) return 0;
	/*
	if(E('_lldp_tx_hold').value != ''){
		if((E('_lldp_tx_hold').value < 2) ||(E('_lldp_tx_hold').value > 10)||(!isDigit(E('_lldp_tx_hold').value))){
			ferror.set(E('_lldp_tx_hold'), errmsg.lldp_tx_hold, false);
			return 0;
		}else{
			ferror.clear(E('_lldp_tx_hold'), errmsg.lldp_tx_hold);
		}
	}
	*/
	//tx delay
	if (!v_f_number(E('_lldp_tx_delay'), quiet, true, 1, 8192)) return 0;
	if (E('_lldp_tx_delay').value  > (E('_lldp_tx_interval').value/4)){
		ferror.set(E('_lldp_tx_delay'), errmsg.lldp_tx_delay, false);
		return 0;
	}else{
		ferror.clear(E('_lldp_tx_delay'), errmsg.lldp_tx_delay);
	}
	/*
	if(E('_lldp_tx_delay').value != ''){
		if((E('_lldp_tx_delay').value < 1) ||(E('_lldp_tx_delay').value > 8192)||(!isDigit(E('_lldp_tx_delay').value))){
			ferror.set(E('_lldp_tx_delay'), errmsg.lldp_tx_delay, false);
			return 0;
		}else{
			ferror.clear(E('_lldp_tx_delay'), errmsg.lldp_tx_delay);
		}
	}
	*/
	//reinit delay
	if (!v_f_number(E('_lldp_reinit_delay'), quiet, true, 2, 5)) return 0;
	/*
	if(E('_lldp_reinit_delay').value != ''){
		if((E('_lldp_reinit_delay').value < 2) ||(E('_lldp_reinit_delay').value > 5)||(!isDigit(E('_lldp_reinit_delay').value))){
			ferror.set(E('_lldp_reinit_delay'), errmsg.lldp_reinit_delay, false);
			return 0;
		}else{
			ferror.clear(E('_lldp_reinit_delay'), errmsg.lldp_reinit_delay);
		}
	}
	*/
	//lldp_inter_noti
	if (!v_f_number(E('_lldp_inter_noti'), quiet, true, 5, 3600)) return 0;


//check change
	//lldp enable
	if((E('_f_lldp_enable').checked ? 1:0) != lldp_config[0]){
		if(view_flag){
			cmd += "!" + "\n";
			view_flag = 0;
		}
		if(E('_f_lldp_enable').checked)
			cmd += "lldp run" + "\n";
		else{
			cmd += "no lldp run" + "\n";
			lldp_to_disable = 1;
		}
	}

	//hold time
	if(E('_lldp_tx_hold').value != lldp_config[1]){
		if(view_flag){
			cmd += "!" + "\n";
			view_flag = 0;
		}
		if(E('_lldp_tx_hold').value != ''){
			cmd += "lldp holdcount " + E('_lldp_tx_hold').value + "\n";
		}else{
			cmd += "no lldp holdcount " + "\n";
		}
	}
	//reinit
	if(E('_lldp_reinit_delay').value != lldp_config[2]){
		if(view_flag){
			cmd += "!" + "\n";
			view_flag = 0;
		}
		if(E('_lldp_reinit_delay').value != ''){
			cmd += "lldp reinit " + E('_lldp_reinit_delay').value + "\n";
		}else{
			cmd += "no lldp reinit" + "\n";
		}
	}
	//interval
	if(E('_lldp_tx_interval').value != lldp_config[3]){
		if(view_flag){
			cmd += "!" + "\n";
			view_flag = 0;
		}
		if(E('_lldp_tx_interval').value != ''){
			cmd += "lldp timer " + E('_lldp_tx_interval').value + "\n";
		}else{
			cmd += "no lldp timer" + "\n";
		}
	}
	//tx delay
	if(E('_lldp_tx_delay').value != lldp_config[4]){
		if(view_flag){
			cmd += "!" + "\n";
			view_flag = 0;
		}
		if(E('_lldp_tx_delay').value != ''){
			cmd += "lldp txdelay " + E('_lldp_tx_delay').value + "\n";
		}else{
			cmd += "no lldp txdelay" + "\n";
		}
	}
	//intervalNotification
	if(E('_lldp_inter_noti').value != lldp_config[5]){
		if(view_flag){
			cmd += "!" + "\n";
			view_flag = 0;
		}
		if(E('_lldp_inter_noti').value != ''){
			cmd += "lldp intervalNotification " + E('_lldp_inter_noti').value + "\n";
		}else{
			cmd += "no lldp intervalNotification" + "\n";
		}
	}
	
	//check port's 
	if (!lldp_to_disable)
		cmd += check_port_change(quiet);
	
//	alert(cmd);
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
	{ title: ui.enable + ' LLDP', name: 'f_lldp_enable', type: 'checkbox', value: lldp_config[0]},
	{ title: lldp.tx_interval, indent: 2, name: 'lldp_tx_interval', type: 'text', maxlen: 15, size: 17, suffix: ' '+'(5-32768)'+ui.seconds,value: lldp_config[3]},
	{ title: lldp.tx_hold, indent: 2, name: 'lldp_tx_hold', type: 'text', maxlen: 15, size: 17, suffix: ' '+'(2-10)', value: lldp_config[1]},
	{ title: lldp.tx_delay, indent: 2, name: 'lldp_tx_delay', type: 'text', maxlen: 15, size: 17, suffix: ' '+'(1-8192)'+ui.seconds,value: lldp_config[4]},
	{ title: lldp.reinit_delay, indent: 2, name: 'lldp_reinit_delay', type: 'text', maxlen: 15, size: 17,suffix: ' '+'(2-5)'+ui.seconds, value: lldp_config[2]},
	{ title: lldp.inter_noti, indent: 2, name: 'lldp_inter_noti', type: 'text', maxlen: 15, size: 17,suffix: ' '+'(5-3600)'+ui.seconds, value: lldp_config[5]}

]);
</script>
</div>


<div class='section-title' id='_port_parameters_title'>
<script type='text/javascript'>
	GetText(lldp.port_config);
</script>
</div>
<div class='section' id='_port_parameters'>
	<table class='web-grid' id='bs-grid'>

<script type='text/javascript'>
		W("<tr id='adm-head'>");
			W("<td width=80>" + rstp.select_port + "</td>");
			W("<td width=80>" + lldp.admin_status + "</td>");
			W("<td width=80>" + lldp.notifications + "</td>");
			
		W("</tr>");
		
		for( var i = port_cfg_index_start; i < lldp_config.length; i++){
			W("<td>" + port_title_list[i-port_cfg_index_start] + "</td>");
			W(creatSelect(admin_status,admin_status[lldp_config[i][1]],i,'_port_admin_status'));
			W(creatSelect(notification_options,notification_options[lldp_config[i][2]],i,'_port_notification'));
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
