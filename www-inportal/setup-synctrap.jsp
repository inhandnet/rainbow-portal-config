<% pagehead(menu.sync_trap) %>

<script type='text/javascript'>

<% ih_user_info(); %>
<% web_exec('show running-config sync-trap') %>

function displayOrhidenComponet(show)
{
	var display = show ? "" : "none";

	var serverTr		= elem.parentElem('_synctrap_server', 'TR');
	var portTr			= elem.parentElem('_synctrap_port', 'TR');
	var trapIntervalTr	= elem.parentElem('_sync_trap_interval', 'TR');

	serverTr.style.display			= display;
	portTr.style.display			= display;
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
	var enableVar = E('_f_synctrap_enable').checked;	

	E('save-button').disabled = true;
	
	displayOrhidenComponet(enableVar);

	if(enableVar == false){
		cmd += "no synctrap trap-interval" + "\n";
		cmd += "no synctrap server" + "\n";
		cmd += "!\n";
		elem.display('save-button', 'cancel-button', true);
		E('_fom')._web_cmd.value = cmd;
		E('save-button').disabled = (cmd=="");
		return 1;
	}
	
	/* verify the param of devlist server*/
	if (!v_domain('_synctrap_server', quiet)){
		ferror.set(E('_synctrap_server'), "This must be domain or IP address", quiet); 
		return 0;
	}

	if (!v_length('_synctrap_server', quiet, 1, 64)){ 
		ferror.set(E('_synctrap_server'), "The length of domain or IP address is too long!", quiet);
		return 0;
	} 

	/* verify the param of devlist port*/
	
	if (E('_synctrap_port').value != '' && !v_port('_synctrap_port', quiet)){
		 return 0;
	}

	/* verify the param of devlist trap interval*/
	if(E('_sync_trap_interval').value != ''){
		if (!v_range('_sync_trap_interval', quiet, 1, 3600)){
			 return 0;
		}
	}

	if((E('_synctrap_server').value != synctrap_config.server_ip) || 
			E('_synctrap_port').value != synctrap_config.server_port){
		if( E('_synctrap_server').value != '' ){
			if(E('_synctrap_port').value != synctrap_config.server_port){
				if(E('_synctrap_port').value != ''){
					cmd += "synctrap server " + E('_synctrap_server').value + " " + E('_synctrap_port').value + "\n";
				}else{
					cmd += "synctrap server " + E('_synctrap_server').value + " " + "\n";
				}
			}else{
				cmd += "synctrap server " + E('_synctrap_server').value + " " + "\n";
			}
			cmd += "!\n";
		}else{
			cmd += "no synctrap server" + "\n";
			cmd += "!\n";
		}
	}

	if(E('_sync_trap_interval').value != synctrap_config.trap_interval){
		if(E('_sync_trap_interval').value != ''){
			cmd += "synctrap trap-interval " + E('_sync_trap_interval').value + "\n";
			cmd += "!\n";
		}else{
			cmd += "no synctrap trap-interval " + "\n";
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
	{ title: synctrap.enable, name: 'f_synctrap_enable', type: 'checkbox', value: synctrap_config.synctrap_enable},
	{ title: ui.server, name: 'synctrap_server', type: 'text', maxlen: 128, size: 24, value: synctrap_config.server_ip},
	{ title: ui.prt, name: 'synctrap_port', type: 'text', maxlen: 10, size: 10, value: synctrap_config.server_port },
	{ title: synctrap.trap_interval, name: 'sync_trap_interval', type: 'text', suffix: ui.seconds, maxlen: 20, size: 10, value: synctrap_config.trap_interval}
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
