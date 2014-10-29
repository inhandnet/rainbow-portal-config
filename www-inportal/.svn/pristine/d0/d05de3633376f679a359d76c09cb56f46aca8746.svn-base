<% pagehead(menu.service_gps) %>

<script type='text/javascript'>

<% ih_user_info(); %>
<% web_exec('show running-config gps') %>

/*
function displayOrhidenComponet(show)
{
	var display = show ? "" : "none";

	var serverTr		= elem.parentElem('_gps_trap_server', 'TR');
	var portTr			= elem.parentElem('_gps_trap_port', 'TR');
	var fixIntervalTr	= elem.parentElem('_gps_fix_interval', 'TR');
	var trapIntervalTr	= elem.parentElem('_gps_trap_interval', 'TR');

	serverTr.style.display			= display;
	portTr.style.display			= display;
	fixIntervalTr.style.display	= display;
	trapIntervalTr.style.display		= display;
}*/

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
	//var ok = 1;
	var phone;
	var cmd = "";
	//var enableVar = E('_f_gps_enable').checked;	

	E('save-button').disabled = true;
	
	//displayOrhidenComponet(enableVar);
/*
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
	}*/
	
	/* verify the param of devlist server*/
	/*
	if (!v_domain('_gps_trap_server', quiet)){
		ferror.set(E('_gps_trap_server'), "This must be domain or IP address", quiet); 
		return 0;
	}

	if (!v_length('_gps_trap_server', quiet, 1, 100)){ 
		ferror.set(E('_gps_trap_server'), "The length of domain or IP address is too long!", quiet);
		return 0;
	}*/ 

	/* verify the param of devlist port*/
/*	
	if (E('_gps_trap_port').value != '' && !v_port('_gps_trap_port', quiet)){
		 return 0;
	}*/


	/* verify the param of devlist arp interval*/
	if(E('_gps_fix_interval').value != ''){
		if (!v_range('_gps_fix_interval', quiet, 1, 0x7FFFFFFF)){
			 return 0;
		}
	}
	
	/* verify the param of devlist trap interval*/
	if(E('_gps_trap_interval').value != ''){
		if (!v_range('_gps_trap_interval', quiet, 1, 0x7FFFFFFF)){
			 return 0;
		}
	}

	if((E('_gps_trap_server').value != gps_config.server_ip) || 
			E('_gps_trap_port').value != gps_config.server_port){
		if( E('_gps_trap_server').value != '' ){
			/* verify the param of devlist server*/
			if (!v_domain('_gps_trap_server', quiet)){
				ferror.set(E('_gps_trap_server'), "This must be domain or IP address", quiet); 
				return 0;
			}

			if (!v_length('_gps_trap_server', quiet, 1, 100)){ 
				ferror.set(E('_gps_trap_server'), "The length of domain or IP address is too long!", quiet);
				return 0;
			} 

			if(E('_gps_trap_port').value != gps_config.server_port){
				if(E('_gps_trap_port').value != ''){
					/* verify the param of devlist port*/
					if (E('_gps_trap_port').value != '' && !v_port('_gps_trap_port', quiet)){
						 return 0;
					}

					cmd += "!\n";
					cmd += "gps-trap server " + E('_gps_trap_server').value + " " + E('_gps_trap_port').value + "\n";
				}else{
					cmd += "!\n";
					cmd += "gps-trap server " + E('_gps_trap_server').value + " " + "\n";
				}
			}else{
				cmd += "!\n";
				cmd += "gps-trap server " + E('_gps_trap_server').value + " " + "\n";
			}
			cmd += "!\n";
		}else{
			cmd += "!\n";
			cmd += "no gps-trap server" + "\n";
			cmd += "!\n";
		}
	}

	if(E('_gps_fix_interval').value != gps_config.fix_interval){
		if(E('_gps_fix_interval').value != ''){
			cmd += "gps-position locate interval " + E('_gps_fix_interval').value + "\n";
			cmd += "!\n";
		}else{
			cmd += "no gps-position locate interval " + "\n";
			cmd += "!\n";
		}
	}

	if(E('_gps_trap_interval').value != gps_config.trap_interval){
		if(E('_gps_trap_interval').value != ''){
			cmd += "gps-trap interval " + E('_gps_trap_interval').value + "\n";
			cmd += "!\n";
		}else{
			cmd += "no gps-trap interval " + "\n";
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
	//{ title: devlist.enable, name: 'f_gps_enable', type: 'checkbox', value: devlist_config.devlist_enable},
	{ title: ui.server, name: 'gps_trap_server', type: 'text', maxlen: 128, size: 24, value: gps_config.server_ip},
	{ title: ui.prt, name: 'gps_trap_port', type: 'text', maxlen: 10, size: 10, value: gps_config.server_port },
	{ title: gps.fix_interval, name: 'gps_fix_interval', type: 'text', suffix: ui.seconds, maxlen: 20, size: 10, value:gps_config.fix_interval},
	{ title: gps.trap_interval, name: 'gps_trap_interval', type: 'text', suffix: ui.seconds, maxlen: 20, size: 10, value: gps_config.trap_interval}
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
