<% pagehead(menu.service_devlist) %>

<script type='text/javascript'>

<% ih_user_info(); %>
<% web_exec('show running-config devlist') %>

function displayOrhidenComponet(show)
{
	var display = show ? "" : "none";

	var serverTr		= elem.parentElem('_devlist_server', 'TR');
	var portTr			= elem.parentElem('_devlist_port', 'TR');
	//var tokenTr			= elem.parentElem('_access_token', 'TR');
	//var idTr			= elem.parentElem('_id', 'TR');
	var arpIntervalTr	= elem.parentElem('_devlist_arp_interval', 'TR');
	var trapIntervalTr	= elem.parentElem('_devlist_trap_interval', 'TR');

	serverTr.style.display			= display;
	portTr.style.display			= display;
	//tokenTr.style.display			= display;
	//idTr.style.display			= display;
	arpIntervalTr.style.display	= display;
	trapIntervalTr.style.display		= display;
}

function verifyPhone(e,quiet)
{
	var phone;
	
	if((e=E(e))==null) return 0;
	phone = E(e).value;
	
	if ( phone.length==0 ) return 1;
	else if ( v_length(e, quiet, 5, 64) ) return 1;
	return 0;
}

function verifyFields(focused, quiet)
{
	var ok = 1;
	var phone;
	var cmd = "";
	var enableVar = E('_f_devlist_enable').checked;	

	E('save-button').disabled = true;
	
	displayOrhidenComponet(enableVar);

	if(enableVar == false){
		//cmd += "no devlist server" + "\n";
		cmd += "no devlist trap-interval" + "\n";
		cmd += "no devlist scan-arp-interval" + "\n";
		cmd += "no devlist server" + "\n";
		cmd += "!\n";
		elem.display('save-button', 'cancel-button', true);
		E('_fom')._web_cmd.value = cmd;
		E('save-button').disabled = (cmd=="");
		return 1;
	}
	
	/* verify the param of devlist server*/
	if (!v_domain('_devlist_server', quiet)){
		ferror.set(E('_devlist_server'), "This must be domain or IP address", quiet); 
		return 0;
	}

	if (!v_length('_devlist_server', quiet, 1, 64)){ 
		ferror.set(E('_devlist_server'), "The length of domain or IP address is too long!", quiet);
		return 0;
	} 

	/* verify the param of devlist port*/
	
	if (E('_devlist_port').value != '' && !v_port('_devlist_port', quiet)){
		 return 0;
	}

	/* verify the param of devlist access token*/
	/*
	if (!v_length('_access_token', quiet, 1, 128)){ 
		ferror.set(E('_access_token'), "The length of access token is too long!", quiet);
		return 0;
	}*/

	/* verify the param of devlist access token*/
	/*
	if (!v_length('_id', quiet, 1, 64)){ 
		ferror.set(E('_id'), "The length of access token is too long!", quiet);
		return 0;
	}*/

	/* verify the param of devlist arp interval*/
	if(E('_devlist_arp_interval').value != ''){
		if (!v_range('_devlist_arp_interval', quiet, 1, 3600)){
			 return 0;
		}
	}
	
	/* verify the param of devlist trap interval*/
	if(E('_devlist_trap_interval').value != ''){
		if (!v_range('_devlist_trap_interval', quiet, 1, 3600)){
			 return 0;
		}
	}

	if((E('_devlist_server').value != devlist_config.server_ip) || 
			E('_devlist_port').value != devlist_config.server_port){
		if( E('_devlist_server').value != '' ){
			if(E('_devlist_port').value != devlist_config.server_port){
				if(E('_devlist_port').value != ''){
					cmd += "devlist server " + E('_devlist_server').value + " " + E('_devlist_port').value + "\n";
				}else{
					cmd += "devlist server " + E('_devlist_server').value + " " + "\n";
				}
			}else{
				cmd += "devlist server " + E('_devlist_server').value + " " + "\n";
			}
			cmd += "!\n";
		}else{
			cmd += "no devlist server" + "\n";
			cmd += "!\n";
		}
	}

	if(E('_devlist_arp_interval').value != devlist_config.arp_interval){
		if(E('_devlist_arp_interval').value != ''){
			cmd += "devlist scan-arp-interval " + E('_devlist_arp_interval').value + "\n";
			cmd += "!\n";
		}else{
			cmd += "no devlist scan-arp-interval " + "\n";
			cmd += "!\n";
		}
	}

	if(E('_devlist_trap_interval').value != devlist_config.trap_interval){
		if(E('_devlist_trap_interval').value != ''){
			cmd += "devlist trap-interval " + E('_devlist_trap_interval').value + "\n";
			cmd += "!\n";
		}else{
			cmd += "no devlist trap-interval " + "\n";
			cmd += "!\n";
		}
	}

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
<input type='hidden' name='ovdp_mode'/>
<input type='hidden' name='_web_cmd' value=''/>


<div class='section-title'></div>
<div class='section'>
<script type='text/javascript'>

createFieldTable('', [
	{ title: devlist.enable, name: 'f_devlist_enable', type: 'checkbox', value: devlist_config.devlist_enable},
	{ title: ui.server, name: 'devlist_server', type: 'text', maxlen: 128, size: 24, value: devlist_config.server_ip},
	{ title: ui.prt, name: 'devlist_port', type: 'text', maxlen: 10, size: 10, value: devlist_config.server_port },
	//{ title: devlist.token, name: 'access_token', type: 'text', maxlen: 128, size: 24, value: devlist_config.token},
	//{ title: devlist.id, name: 'id', type: 'text', maxlen: 64, size: 24, value: devlist_config.id},
	{ title: devlist.arp_interval, name: 'devlist_arp_interval', type: 'text', suffix: ui.seconds, maxlen: 20, size: 10, value: devlist_config.arp_interval},
	{ title: devlist.trap_interval, name: 'devlist_trap_interval', type: 'text', suffix: ui.seconds, maxlen: 20, size: 10, value: devlist_config.trap_interval}
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
