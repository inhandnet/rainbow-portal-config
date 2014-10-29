<% pagehead(menu.service_ovdp) %>

<script type='text/javascript'>

<% ih_user_info(); %>
<% web_exec('show running-config ovdp') %>

function displayOrhidenComponet(show)
{
	var display = show ? "" : "none";
	var modeTr			= elem.parentElem('_f_ovdp_mode', 'TR');
	var vendorTr		= elem.parentElem('_ovdp_vendor_id', 'TR');
	var deviceIdTr		= elem.parentElem('_ovdp_device_id', 'TR');
	var serverTr		= elem.parentElem('_ovdp_center', 'TR');
	var portTr			= elem.parentElem('_ovdp_center_port', 'TR');
	var loginRetriesTr	= elem.parentElem('_ovdp_login_retries', 'TR');
	var hbIntervalTr	= elem.parentElem('_ovdp_hb_interval', 'TR');

	modeTr.style.display			= display;
	vendorTr.style.display			= display; 
	deviceIdTr.style.display		= display;
	serverTr.style.display			= display;
	portTr.style.display			= display;
	loginRetriesTr.style.display	= display;
	hbIntervalTr.style.display		= display;
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
	var select = E('_f_ovdp_mode').value;
	var phone;
	var cmd = "";
	var enableVar = E('_f_ovdp_enable').checked;	

	E('save-button').disabled = true;
	
	displayOrhidenComponet(enableVar);

	if(enableVar == false){
		cmd += "no ovdp server" + "\n";
		cmd += "no ovdp login retries" + "\n";
		cmd += "no ovdp heartbeat interval" + "\n";
		cmd += "interface cellular 1\n";
		cmd += "no traffic-stated statistic\n";
		cmd += "!\n";
		elem.display('save-button', 'cancel-button', true);
		E('_fom')._web_cmd.value = cmd;
		E('save-button').disabled = (cmd=="");
		return 1;
	}

	if ( select==0 ) return 1;
	
	if ( select==1) return 1;
		
	if ( select==2 ) {
		elem.enable(('_ovdp_device_id'), false);
	
		if (!v_domain('_ovdp_center', quiet)){
			ferror.set(E('_ovdp_center'), "This must be domain or IP address", quiet); 
			return 0;
		}
		if (!v_length('_ovdp_center', quiet, 1, 64)){ 
			ferror.set(E('_ovdp_center'), "The length of domain or IP address is too long!", quiet);
			return 0;
		} 
		/*else {
			ferror.clean(E('_ovdp_center'));
		}
		*/
		if (!v_port('_ovdp_center_port', quiet)){
			 return 0;
		}

		if(E('_ovdp_login_retries').value != ''){
			if (!v_range('_ovdp_login_retries', quiet, 1, 1000000)){
				 return 0;
			}
		}

		if(E('_ovdp_hb_interval').value != ''){
			if (!v_range('_ovdp_hb_interval', quiet, 1, 3600)){
				 return 0;
			}
		}
		//if (!v_range('_ovdp_rx_timeout', quiet, 1, 120)) return 0;
		//if (!v_range('_ovdp_tx_retries', quiet, 1, 100)) return 0;
	}

//	if (!v_range('_ovdp_sms_interval', quiet, 1, 1000000)) return 0;
//	if (!verifyPhone('_ovdp_trust_list',quiet)) return 0;


	if(select=='2'){
		if((E('_ovdp_center').value != ovdp_config.ovdp_center) || 
		   (E('_ovdp_center_port').value != ovdp_config.ovdp_center_port)){
			if( E('_ovdp_center').value != '' ){
				if(E('_ovdp_center_port').value == ovdp_config.ovdp_center_port){
					cmd += "ovdp server " + E('_ovdp_center').value + "\n";
				}else{
					cmd += "ovdp server " + E('_ovdp_center').value + " " + E('_ovdp_center_port').value + "\n";
				}
				cmd += "interface cellular 1\n";
				cmd += "traffic-stated statistic\n";
				cmd += "!\n";
			}else{
				cmd += "no ovdp server" + "\n";
				cmd += "interface cellular 1\n";
				cmd += "no traffic-stated statistic\n";
				cmd += "!\n";
			}
		}

		if(E('_ovdp_login_retries').value != ovdp_config.ovdp_login_retries){
			if(E('_ovdp_login_retries').value != ''){
				cmd += "ovdp login retries " + E('_ovdp_login_retries').value + "\n";
			}else{
				cmd += "no ovdp login retries" + "\n";
			}
		}
		
		if(E('_ovdp_hb_interval').value != ovdp_config.ovdp_hb_interval){
			if(E('_ovdp_hb_interval').value != ''){
				cmd += "ovdp heartbeat interval " + E('_ovdp_hb_interval').value + "\n";
			}else{
				cmd += "no ovdp heartbeat interval" + "\n";
			}
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

if ( !ovdp_config.ovdp_mode ) ovdp_config.ovdp_mode = '2';
if ( !ovdp_config.ovdp_rx_timeout ) ovdp_config.ovdp_rx_timeout='30';
if ( !ovdp_config.ovdp_tx_retries ) ovdp_config.ovdp_tx_retries = '3';
if ( !ovdp_config.ovdp_hb_retries ) ovdp_config.ovdp_hb_retries = '3';
if ( !ovdp_config.ovdp_sms_interval ) ovdp_config.ovdp_sms_interval='24';

createFieldTable('', [
	{ title: ovdp.enable, name: 'f_ovdp_enable', type: 'checkbox', value: ovdp_config.ovdp_enable},
	{ title: ovdp.mode, name: 'f_ovdp_mode', type: 'select',
		//options: [['0',ovdp.mode0],['1',ovdp.mode1],['2',ovdp.mode2]], value: ovdp_config.ovdp_mode},
		options: [['2',ovdp.mode2]], value: ovdp_config.ovdp_mode},
	{ title: ovdp.vendor, name: 'ovdp_vendor_id', type: 'select', options: [
		['0003',ui.deflt]], value: ovdp_config.ovdp_vendor_id},
	{ title: ovdp.device_id, name: 'ovdp_device_id', type: 'text', maxlen: 10, size: 24, value: ovdp_config.ovdp_device_id },
	{ title: ui.server, name: 'ovdp_center', type: 'text', maxlen: 128, size: 24, value: ovdp_config.ovdp_center },
	{ title: ui.prt, name: 'ovdp_center_port', type: 'text', maxlen: 10, size: 10, value: ovdp_config.ovdp_center_port },
	{ title: ovdp.login_retries, name: 'ovdp_login_retries', type: 'text', maxlen: 20, size: 10, value: ovdp_config.ovdp_login_retries },
	{ title: ovdp.hb_interval, name: 'ovdp_hb_interval', type: 'text', suffix: ui.seconds, maxlen: 20, size: 10, value: ovdp_config.ovdp_hb_interval }
//	{ title: ovdp.rx_timeout, name: 'ovdp_rx_timeout', type: 'text', suffix: ui.seconds, maxlen: 20, size: 10, value: nvram.ovdp_rx_timeout },
//	{ title: ovdp.tx_retries, name: 'ovdp_tx_retries', type: 'text', maxlen: 20, size: 10, value: nvram.ovdp_tx_retries },
//	{ title: ovdp.sms_interval, name: 'ovdp_sms_interval', type: 'text', suffix: ui.hours, maxlen: 20, size: 10, value: nvram.ovdp_sms_interval },
//	{ title: ovdp.trust_list, name: 'ovdp_trust_list', type: 'text', maxlen: 128, size: 60, value: nvram.ovdp_trust_list }
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
