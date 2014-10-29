<% pagehead(menu.switch_alarm_out) %>

<style type='text/css'>

#email-addr{
	width: 240px;
}

#relay-alarm{
	width: 320px;
}

#email-alarm{
	width: 320px;
}

#td_indent{
	text-indent: 10px;
}
#peer_email{
	width: 320px;
}


</style>

<script type='text/javascript'>

<% ih_sysinfo() %>
<% ih_user_info(); %>

<% web_exec('show running-config email') %>

/*
<% web_exec('show running-config relay') %>
*/

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

function verifyEmailSvr(e)
{
	var svr = E(e).value;
	var tmp = [];
	
	//ip
	if(v_ipnz(e, true, 1)) return 1;
	
	//domain
	if(!v_domain(e, true)) return 0;
	tmp = svr.split('.');
	if (tmp.length < 2) return 0;
	for (var i = 0; i < tmp.length; i++){
		if (tmp[i].length == 0) return 0;
	}

	if (tmp[tmp.length - 1].length < 2) return 0;

	return 1;
	
}

function verifyEmailAddr(e)
{
	/*zhengyb@inhand.com.cn*/
	var email = e.value;
	var user = "";
	var svr = "";
	var tmp = [];

	if (v_f_text(e, true, 1, 64) == 0) return 0;
	
	tmp = email.split('@');
	if (tmp.length != 2) return 0;
	
	user = tmp[0];
	svr = tmp[1];
	if (user.length == 0 || svr.length == 0) return 0;
	
	tmp = svr.split('.');
 	if (tmp.length < 2) return 0;

	for (var i = 0; i < tmp.length; i++){
		if (tmp[i].length == 0) return 0;
	}

	if (tmp[tmp.length - 1].length < 2 || tmp[tmp.length - 1].length > 3) return 0;
	
	return 1;
}

function clrAllClr()
{
	ferror.clear('_mail_server');
	ferror.clear('_svr_port');
	ferror.clear('_account');
	ferror.clear('_password');
	
}

function disableTestEmail()
{
	if ((email_config.enable == 1)
		&& (email_config.server.length != 0)
		&& (email_config.port.length != 0)
		&& (email_config.username.length != 0)
		&& (email_config.password.length != 0)
		&& (email_config.peer_list.length != 0))
		E('test-button').disabled = false;
	else
		E('test-button').disabled = true;
}

function verifyFields(focused, quiet)
{
	clrAllClr();
	E('save-button').disabled = true;	
	if (E('_email_enable').checked == false){
		E('_mail_server').disabled = true;
		E('_svr_port').disabled = true;
		E('_account').disabled = true;
		E('_password').disabled = true;
		E('_link_type').disabled = true;
		
		E('peer_email').style.display ="none";
	}else{
		E('_mail_server').disabled = false;
		E('_svr_port').disabled = false;
		E('_account').disabled = false;
		E('_password').disabled = false;
		E('_link_type').disabled = false;

		E('peer_email').style.display ="";
	}

	if (E('_email_enable').checked){
		
		//server addr 
		if (E('_mail_server').value.length == 0){
			ferror.set('_mail_server', errmsg.adm3, quiet);
			return 0;
		}else{
			ferror.clear('_mail_server');
		}
		if (haveChineseChar(E('_mail_server').value)){
			ferror.set('_mail_server', errmsg.cn_chars, quiet);
			return 0;
		}else{
			ferror.clear('_mail_server');
		}
		if (!verifyEmailSvr('_mail_server')){
			ferror.set('_mail_server', errmsg.domain_name, quiet);
			return 0;
		}else{
			ferror.clear('_mail_server');
		}
		
		
		//server port
		
		if (!v_f_number(E('_svr_port'), quiet, false, 1, 65535)) return 0;

		
		//account
		if (E('_account').value.length == 0){
			ferror.set('_account', errmsg.adm3, quiet);
			return 0;
		}else{
			ferror.clear('_account');
		}
		if (!verifyEmailAddr(E('_account'))){
			ferror.set(E('_account'), errmsg.bad_email, quiet);
			return 0;
		}else{
			ferror.clear(E('_account'));
		}
		
		
		//password
		if (E('_password').value.length == 0){
			ferror.set('_password', errmsg.adm3, quiet);
			return 0;
		}else{
			ferror.clear('_password');
		}

		//peer email addr
		var data = peer_email.getAllData();
		if (data.length == 0)
			return 0;
	}

	if (user_info.priv < admin_priv) {
		elem.display('save-button', 'cancel-button', false);
	}else{
		elem.display('save-button', 'cancel-button', true);
		E('save-button').disabled = (generate_cmd() == "");	
	}
	
	return 1;
}


function generate_cmd()
{
	var cmd = "";
	var view_flag = 0;

/*
	//enable relay
	if (E('_relay_enable').checked != relay_config.enable){
		if (!view_flag){
			cmd += "!\n"
			view_flag = 1;
		}
		cmd += ((E('_relay_enable').checked)?(""):("no ")) + "relay\n"
	}
*/

	//enable email
	if (E('_email_enable').checked != email_config.enable){
		if (!view_flag){
			cmd += "!\n"
			view_flag = 1;
		}
		cmd += ((E('_email_enable').checked)?(""):("no ")) + "email\n"
	}

	if (!E('_email_enable').checked){
		E('_fom')._web_cmd.value = cmd;
		return cmd;
	}

	//server addr
	if (E('_mail_server').value != email_config.server){
		if (!view_flag){
			cmd += "!\n"
			view_flag = 1;
		}
		
		if (email_config.server.length > 0)
			cmd += "no email server-address\n";
		if (E('_mail_server').value.length > 0)
			cmd += "email server-address "+ E('_mail_server').value +"\n";		
	}
	//server port
	if (E('_svr_port').value != email_config.port){
		if (!view_flag){
			cmd += "!\n"
			view_flag = 1;
		}
		if (email_config.port.length > 0)
			//cmd += "no email port "+email_config.port+"\n";
			cmd += "no email port\n";
		if (E('_svr_port').value.length > 0)
			cmd += "email port "+ E('_svr_port').value +"\n";		
	}


	if (E('_account').value != email_config.username){
		if (!view_flag){
			cmd += "!\n"
			view_flag = 1;
		}
		if (email_config.username > 0){
			cmd += "no email username\n";
		}
		cmd += "email username "+ E('_account').value +"\n";
	}

	if (E('_password').value != email_config.password){
		if (!view_flag){
			cmd += "!\n"
			view_flag = 1;
		}
		if (email_config.password > 0){
			cmd += "no email password\n";
		}
		cmd += "email password "+ E('_password').value +"\n";
	}


	//TODO: crypt
	if (E('_link_type').selectedIndex != email_config.crpyt){
		if (!view_flag){
			cmd += "!\n"
			view_flag = 1;
		}
		
		if (E('_link_type').selectedIndex)
			cmd += "email crypt tls\n";
		else
			cmd += "no email crypt\n";
	}

	//peer email addr
	var peer_email_cmd = peer_email.gencmd();
	if (peer_email_cmd.length > 0){
		if (!view_flag){
			cmd += "!\n"
			view_flag = 1;
		}
		cmd += peer_email_cmd;
	}


	E('_fom')._web_cmd.value = cmd;

	return cmd;
}

var peer_email = new webGrid();
peer_email.setup = function() {
	this.init('peer_email', 'sort', 10, [{ type: 'text'}]);
	this.headerSet([alarm.email_addr]);


	for (var i = 0; i < email_config.peer_list.length ;i++){
		peer_email.insertData(-1, [email_config.peer_list[i]]);
	}

	
	peer_email.showNewEditor();
	//peer_email.resetNewEditor();
}

peer_email.verifyFields = function(row, quiet) {
	var f = fields.getAll(row);
	var s;

	if (!v_length(f[0], quiet, 1))  return 0;

	if (!verifyEmailAddr(f[0])){
		ferror.set(f[0], errmsg.bad_email, quiet);
		return 0;
	}else{
		ferror.clear(f[0]);
	}

	if (peer_email.existEmail(0, f[0].value)){
		ferror.set(f[0], errmsg.dupemail, quiet);
		return 0;
	}else{
		ferror.clear(f[0]);
	}

	return 1;
}

peer_email.existEmail = function(f, v)
{
	var data = this.getAllData();
	for (var i = 0; i < data.length; ++i) {
		if (data[i][f] == v) return true;
	}
	return false;
}

peer_email.gencmd = function()
{
	var data = this.getAllData();
	var cmd = "";
	var email_found = 0;

	//delete
	for (var j = 0; j < email_config.peer_list.length; j++){
		email_found = 0;
		for (var i = 0; i < data.length; i++){
			if (data[i][0] == email_config.peer_list[j]){
				email_found = 1;
				break;
			}
		}
		if (!email_found)
			cmd += "no email email-peer "+email_config.peer_list[j]+"\n";
	}
	//add
	for (var i = 0; i < data.length; i++){
		email_found = 0;
		for (var j = 0; j < email_config.peer_list.length; j++){
			if (data[i][0] == email_config.peer_list[j]){
				email_found = 1;
				break;
			}			
		}
		if (!email_found)
			cmd += "email email-peer "+data[i][0]+"\n";
	}
	
	return cmd;
}

peer_email.onDataChanged = function()
{
	verifyFields();
}


function save()
{
	if (!verifyFields(null, false)) return;
	if (generate_cmd() == "") return;

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
	disableTestEmail();
}

function init()
{
	if((cookie.get('autosave')) == null){
		cookie.set('autosave', 1);
	}
}

function testEmail()
{
	if (!confirm(infomsg.test_email)) return;
	cookie.set('testemail', 1);
	E('_fom')._web_cmd.value += "!"+"\n"+"email test"+"\n";	

	form.submit('_fom', 1);
}

function myGenStdFooter(args)
{
	W("<div id='footer'>");
	W("<span id='footer-msg'></span>");
	W("<input type='button' style='width:100px' value='" + ui.aply + "' id='save-button' onclick='save(" + args + ")'>");
	W("<input type='button' style='width:100px' value='" + ui.cancel + "' id='cancel-button' onclick='reloadPage();'>");	
	W("<input type='button' style='width:150px'value='" + ui.test_email + "' id='test-button' onclick='testEmail();'/>");	
	W("</div>");
}



</script>
</head>
<body onload='init()'>
<form id='_fom' method='post' action='apply.cgi'>
<input type='hidden' name='_web_cmd' value=''>
<!--
<input type='hidden' name='_test_email' value=''>
-->


<!--
<div class='section-title'><script type='text/javascript'>W(alarm.relay);</script></div>
<div class='section'>
<table class='web-grid' cellspacing=1 id='relay-alarm'>
<script type='text/javascript'>
W("<td width=150>" + alarm.relay_en + "</td>"); 
W("<td width=150><input type='checkbox' onchange='verifyFields(null, true)' id='_relay_enable' name='relay_enable'" + ((relay_config.enable)?(" checked='' "):("")) + "></td>");
W("</tr>");

</script>
</table>
</div>
-->

<div class='section-title'><script type='text/javascript'>W(alarm.email);</script></div>
<div class='section'>
<table class='web-grid' cellspacing=1 id='email-alarm'>
<script type='text/javascript'>

W("<td width=150>" + alarm.email_en + "</td>"); 
W("<td width=150><input type='checkbox' onchange='verifyFields(null, true)'  onclick='verifyFields(null, true)' id='_email_enable' name='email_enable'" + ((email_config.enable)?(" checked='' "):("")) + "></td>");
W("</tr>");
W("<td width=150>" + alarm.server + "</td>"); 
W("<td width=150><input type='text' onchange='verifyFields(null, true)' id='_mail_server' name='mail_server' value='" + email_config.server + "'></td>");
W("</tr>");
W("<td width=150>" + alarm.svr_port + "</td>"); 
W("<td width=150><input type='text' onchange='verifyFields(null, true)' id='_svr_port' name='svr_port' value='" + email_config.port + "'></td>");
W("</tr>");
W("<td width=150>" + alarm.account_name + "</td>"); 
W("<td width=150><input type='text' onchange='verifyFields(null, true)' id='_account' name='account' value='" + email_config.username + "'></td>");
W("</tr>");
W("<td width=150>" + alarm.account_pw + "</td>"); 
W("<td width=150><input type='password' onchange='verifyFields(null, true)' id='_password' name='password' value='" + email_config.password + "'></td>");
W("</tr>");
W("<td width=150>" + alarm.link_type + "</td>"); 
W(creatSelect(['NO','TLS'], ['NO','TLS'][email_config.crpyt],'','link_type'));
W("</tr>");




</script>
</table>
</div>

<!-- peer email addr table -->
<div class='section'>
	<table class='web-grid' cellspacing=1 id='peer_email'></table>
	<script type='text/javascript'>peer_email.setup();</script>
</div>

<div class='section'>
<script type='text/javascript'>
init();
if(cookie.get('autosave') == 1)
	ui.aply=ui.aply_save;
myGenStdFooter("");
</script>
</div>
<!---->
</form>
<script type='text/javascript'>earlyInit();</script>
</body>
</html>

