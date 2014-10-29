<% pagehead(menu.wizard_wan1) %>

<script type='text/javascript'>

<% ih_sysinfo(); %>
<% ih_user_info(); %>
if(ih_sysinfo.oem_name == "welotec"){
	var profile_config = ['1','1','internet.t-d1.de','*99***1#','0','tm','tm'];
}else {
	var profile_config = ['1','1','3gnet','*99***1#','0','gprs','gprs'];
}

function
 verifyFields(focused, quiet)
{
	var ok = 1;	
	var cmd = "";
	var fom = E('_fom');

	E('save-button').disabled = true;
	
	var apn = E('_wan1_ppp_apn').value;
	var callno = E('_wan1_ppp_callno').value;
	var username = E('_wan1_ppp_username').value;
	var passwd = E('_wan1_ppp_passwd').value;
		//TODO: verify
	ferror.clearAll(fom);
	if(E('_wan1_ppp_apn').value==''){
		ferror.set('_wan1_ppp_apn', '', quiet);		
		return 0;
	}
	if(E('_wan1_ppp_callno').value==''){
		ferror.set('_wan1_ppp_callno', '', quiet);		
		return 0;
	}
	if(E('_wan1_ppp_username').value!=''){
		if(E('_wan1_ppp_passwd').value==''){
			ferror.set('_wan1_ppp_passwd', '', quiet);		
			return 0;
		}
	}
	//configure
	if(username!=''){
		cmd += "cellular 1 gsm profile 1 " + apn + " " + callno + " auto " + username + " " + passwd + "\n";
	}else{
		cmd += "cellular 1 gsm profile 1 " + apn + " " + callno + " auto\n";
	}
	cmd += "interface cellular 1\n";
	cmd += "no shutdown\n";
	cmd += "dialer profile 1\n";
	cmd += "ip nat outside\n";
	cmd += "!\n";
	
	//alert(cmd);
	//NAT
	if (E('_f_nat').checked) {
		cmd += "!\n";
		cmd += "no access-list 100\n";
		cmd += "access-list 100 permit ip any any\n";
		cmd += "ip snat inside list 100 interface cellular 1\n"
	}
	if (user_info.priv < admin_priv) {
		elem.display('save-button', 'cancel-button', false);
	}else{
		elem.display('save-button', 'cancel-button', true);
		E('save-button').disabled = (cmd=="");	
		fom._web_cmd.value = cmd;
		
	}

	return ok;
}

function earlyInit()
{
	verifyFields(null, true);
}

function init()
{
	if((cookie.get('autosave')) == null){
		cookie.set('autosave', 1);
	}
}

function save()
{
	var i;

	if (!verifyFields(null, false)) return;
	
	var fom = E('_fom');

	if((E('_fom')._web_cmd.value != '')&&(cookie.get('autosave') == 1)){
		E('_fom')._web_cmd.value += "!"+"\n"+"copy running-config startup-config"+"\n";	
	}

	form.submit(fom, 1);
}

</script>

</head>
<body>
<form id='_fom' method='post' action='apply.cgi'>
<input type='hidden' name='_web_cmd' value=''>

<div class='section'>
<script type='text/javascript'>

createFieldTable('', [
	//{ title: ui.enable, name: 'f_wan1_enable', type: 'checkbox', value: cellular1_config.enable=='1'},
	{ title: 'APN', name: 'wan1_ppp_apn', type: 'text', maxlen: 128, size: 17, value: profile_config[2] },
	{ title: ui.callno, name: 'wan1_ppp_callno', type: 'text', maxlen: 32, size: 17, value: profile_config[3] },
	{ title: ui.username, name: 'wan1_ppp_username', type: 'text', maxlen: 64, size: 17, value: profile_config[5] },
	{ title: ui.password, name: 'wan1_ppp_passwd', type: 'password', maxlen: 64, size: 17, value: profile_config[6] },
	{ title: menu.fw_nat, name: 'f_nat', type: 'checkbox', value: 0}
]);
</script>
</div>

</form>
<script type='text/javascript'>
if(cookie.get('autosave') == 1)
	ui.aply=ui.aply_save;
genStdFooter("");
</script>
<script type='text/javascript'>earlyInit()</script>
</body>
</html>
