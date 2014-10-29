<% pagehead(menu.service_ovdp) %>

<script type='text/javascript'>

<% ih_user_info(); %>
<% web_exec('show running-config rainbow') %>

function displayOrhidenComponet(show)
{
	var display = show ? "" : "none";
	var serverTr		= elem.parentElem('_f_rb_server', 'TR');
	var portTr			= elem.parentElem('_f_rb_port', 'TR');

	serverTr.style.display			= display;
	portTr.style.display			= display;
}

function verifyFields(focused, quiet)
{
	var ok = 1;
	var cmd = "";
	var enableVar = E('_f_rb_enable').checked;	

	E('save-button').disabled = true;
	
	displayOrhidenComponet(enableVar);

	if (!v_info_url('_f_rb_server',quiet,1)) return 0;
	if (!v_info_num_range('_f_rb_port',quiet,0,1,65535)) return 0;

	if (E('_f_rb_server').value != rainbow_config.server
		|| E('_f_rb_port').value != rainbow_config.port){
		if (E('_f_rb_server').value.length == 0)
			cmd += "no rainbow server\n";
		else
			cmd += "rainbow server "+ E('_f_rb_server').value +" port "+E('_f_rb_port').value+"\n";
		cmd += "!\n";
	}
	if (enableVar != rainbow_config.enable){
		cmd += (enableVar?"":"no ")+"rainbow\n";
		cmd += "!\n";
	}
	//alert(cmd);
	if (user_info.priv < admin_priv) {
		elem.display('save-button', 'cancel-button', false);
	}else{
		elem.display('save-button', 'cancel-button', true);
		E('_fom')._web_cmd.value = cmd;
		E('save-button').disabled = (cmd=="");
	}
	return 1;
}

function save()
{
	if (!verifyFields(null, 0)) return;

	if((E('_fom')._web_cmd.value != '')&&(cookie.get('autosave') == 1)){
		E('_fom')._web_cmd.value += "!"+"\n"+"copy running-config startup-config"+"\n";	
	}
	form.submit('_fom', 1);
}

function earlyInit()
{
	verifyFields(null, 1);
}
</script>
</head>
<body>

<form id='_fom' method='post' action='apply.cgi'>
<input type='hidden' name='_web_cmd' value=''/>


<div class='section-title'></div>
<div class='section'>
<script type='text/javascript'>

createFieldTable('', [
	{ title: ui.enable, name: 'f_rb_enable', type: 'checkbox', value: rainbow_config.enable},
	{ title: ui.server, name: 'f_rb_server', type: 'text', maxlen: 128, size: 24, value: rainbow_config.server},
	{ title: ui.prt, name: 'f_rb_port', type: 'text', maxlen: 5, size: 5, value: rainbow_config.port},
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
