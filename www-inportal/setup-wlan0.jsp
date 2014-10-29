<% pagehead(menu.setup_wlan) %>

<style type='text/css'>
#redial-grid {
	text-align: center;	
	width: 700px;
}

#redial-grid .co1 {
	width: 40px;
}
#redial-grid .co2 {
	width: 80px;
}
</style>

<script type='text/javascript'>

<% ih_sysinfo(); %>
<% ih_user_info(); %>

<% web_exec('show running-config dot11') %>

/*
wlan0_config = {
	'enable':1,
	'station_role':'0',
	'ssid_broadcast':1,
	'radio_type':'7',
	'channel':'4',
	'ssid':'abc',
	'auth':'0',
	'encrypt':'0',
	'wpa_encrypt':'3',
	'wep_key':'',
	'wpa_psk':'123456',
	'max_associations':'64',
	'tx_power':'20',
	'sta_ssid':'abc',
	'sta_auth':'0',
	'sta_encrypt':'0',
	'sta_wpa_encrypt':'3',
	'sta_wep_key':'',
	'sta_wpa_psk':'123456'
};
*/

function verifyFields(focused, quiet)
{
	var ok = 1;
	var cmd = "";
	var fom = E('_fom');
	var station_role_list = [['0','ap'],['1','workgroup-bridge']];
	var radio_type_list = [['0', 'dot11bg'],['1','dot11b'],['2',''],['3',''],['4','dot11g'],['5',''],['6','dot11n'],['7','dot11gn'],['8',''],['9','dot11bgn']];
	var encrypt_type_list = [['0',''],['1','wep40'],['2','wep104'],['3','tkip'],['4','aes-ccm']];
	var sta_auth_type_list = [['0','open'],['1','shared'],['2',''],['3','wpa 1'],['4',''],['5','wpa 2']];
	var sta_encrypt_type_list = [['0',''],['1','wep40'],['2','wep104'],['3','tkip'],['4','ccmp']];
	var bandwidth_list = [['0','20'],['1',''],['2','40']];

	E('save-button').disabled = true;

	// --- visibility ---	
	var enable = E('_f_wl0_enable').checked;
	var station_role = E('_wl0_station_role').value;
	if (station_role == '1') {//Client
		var auth_val = E('_wl0_sta_auth').value;
		var encrypt = E('_wl0_sta_encrypt').value;

		elem.display_and_enable(('_f_wl0_ssid_broadcast'), ('_wl0_radio_type'), ('_wl0_channel'), ('_wl0_ssid'),('_wl0_auth'),('_wl0_encrypt'),('_wl0_wpa_encrypt'),('_wl0_wep_key'),('_wl0_wpa_psk'),('_wl0_bw'),('_wl0_max_associations'), 0);
		elem.display_and_enable(('_wl0_station_role'),('_wl0_sta_ssid'),('_wl0_sta_auth'), enable);

		ferror.clear('_wl0_sta_ssid');
		ferror.clear('_wl0_sta_wep_key');
		ferror.clear('_wl0_sta_wpa_psk');
		if((auth_val=='0')||(auth_val=='1')||(auth_val=='2')) {
			elem.display_and_enable(('_wl0_sta_encrypt'), enable);
			elem.display_and_enable(('_wl0_sta_wpa_encrypt'),('_wl0_sta_wpa_psk'), 0);

			if(E('_wl0_sta_auth').value=='0') {
				elem.display_and_enable(('_wl0_sta_wep_key'), enable&&encrypt!='0');
				if(encrypt=='1') {
					if (!v_length('_wl0_sta_wep_key', quiet, 5, 5)){
						return 0;
					}
				} else if(encrypt=='2') {
					if (!v_length('_wl0_sta_wep_key', quiet, 13, 13)){
						return 0;
					}
				}
			} else {
				elem.display_and_enable(('_wl0_sta_wep_key'), enable);
				if(E('_wl0_sta_encrypt').value == '0')
					E('_wl0_sta_encrypt').value = '1';
				if(E('_wl0_sta_encrypt').value=='1') {
					if (!v_length('_wl0_sta_wep_key', quiet, 5, 5)){
						return 0;
					}
				} else if(E('_wl0_sta_encrypt').value=='2') {
					if (!v_length('_wl0_sta_wep_key', quiet, 13, 13)){
						return 0;
					}
				}
			}
		}else if((auth_val=='4')||(auth_val=='6')||(auth_val=='7')) {//802.1x
			//TODO
		}else{
			elem.display_and_enable(('_wl0_sta_wpa_encrypt'), enable);
			elem.display_and_enable(('_wl0_sta_wep_key'),('_wl0_sta_encrypt'), 0);
			elem.display_and_enable(('_wl0_sta_wpa_psk'), enable);
			if (!v_length('_wl0_sta_wpa_psk', quiet, 8, 63)){
				return 0;
			}
		}
		if (!v_length('_wl0_sta_ssid', quiet, 1, 32)){
			return 0;
		}

		// --- generate cmd ---	
		if(!enable) {
			if(wlan0_config.enable) {
				cmd += "!\n";
				cmd += "interface dot11radio 1\n";
				cmd += "shutdown\n";
			}
		} else {
			if(!wlan0_config.enable
				|| E('_wl0_station_role').value != wlan0_config.station_role
				|| E('_wl0_sta_ssid').value != wlan0_config.sta_ssid
				|| E('_wl0_sta_auth').value != wlan0_config.sta_auth) {
				cmd += "!\n";
				cmd += "interface dot11radio 1\n";
			}
			if(!wlan0_config.enable) {
				cmd += "no shutdown\n";
			}
			if(E('_wl0_station_role').value != wlan0_config.station_role) {
				cmd += "station-role " + station_role_list[E('_wl0_station_role').value][1] + "\n";
			}
			if(E('_wl0_sta_ssid').value != wlan0_config.sta_ssid) {
				cmd += "client-mode ssid " + E('_wl0_sta_ssid').value + "\n";
			}
			if(E('_wl0_sta_auth').value != wlan0_config.sta_auth) {
				cmd += "client-mode authentication-method " + sta_auth_type_list[E('_wl0_sta_auth').value][1] + "\n";
			}
			if((auth_val=='0')||(auth_val=='1')||(auth_val=='2')) {
				if(E('_wl0_sta_encrypt').value != wlan0_config.sta_encrypt
					|| E('_wl0_sta_wep_key').value != wlan0_config.sta_wep_key) {
					cmd += "!\n";
					cmd += "interface dot11radio 1\n";
					if(E('_wl0_sta_encrypt').value != '0') {
						cmd += "client-mode cipher-suite " + sta_encrypt_type_list[E('_wl0_sta_encrypt').value][1] + " ";
						cmd += "key-id 1 key ascii " + E('_wl0_sta_wep_key').value + "\n";
					} else {
						cmd += "no client-mode cipher-suite\n";
					}
				}
			}else if((auth_val=='4')||(auth_val=='6')||(auth_val=='7')) {//802.1x
			}else{
				if(E('_wl0_sta_wpa_encrypt').value != wlan0_config.sta_wpa_encrypt
					|| E('_wl0_sta_wpa_psk').value != wlan0_config.sta_wpa_psk) {
					cmd += "!\n";
					cmd += "interface dot11radio 1\n";
					cmd += "client-mode cipher-suite " + sta_encrypt_type_list[E('_wl0_sta_wpa_encrypt').value][1] + " key ascii " + E('_wl0_sta_wpa_psk').value + "\n";
				}
			}
		}
	} else {//ap
		var ssid_broadcast = E('_f_wl0_ssid_broadcast').checked;
		var auth_val = E('_wl0_auth').value;
		var encrypt = E('_wl0_encrypt').value;

		elem.display_and_enable(('_wl0_sta_ssid'),('_wl0_sta_auth'),('_wl0_sta_encrypt'),('_wl0_sta_wpa_encrypt'),('_wl0_sta_wep_key'),('_wl0_sta_wpa_psk'), 0);
		elem.display_and_enable(('_wl0_station_role'), ('_f_wl0_ssid_broadcast'), ('_wl0_radio_type'), ('_wl0_channel'), ('_wl0_ssid'),('_wl0_auth'),('_wl0_bw'),('_wl0_max_associations'), enable);
		ferror.clear('_wl0_ssid');
		ferror.clear('_wl0_wep_key');
		ferror.clear('_wl0_wpa_psk');
		ferror.clear('_wl0_max_associations');
		if((auth_val=='0')||(auth_val=='1')||(auth_val=='2')) {
			elem.display_and_enable(('_wl0_encrypt'), enable);
			elem.display_and_enable(('_wl0_wpa_encrypt'),('_wl0_wpa_psk'), 0);

			if(E('_wl0_auth').value=='0') {
				elem.display_and_enable(('_wl0_wep_key'), enable&&encrypt!='0');
				if(encrypt=='1') {
					if (!v_length('_wl0_wep_key', quiet, 5, 5)){
						return 0;
					}
				} else if(encrypt=='2') {
					if (!v_length('_wl0_wep_key', quiet, 13, 13)){
						return 0;
					}
				}
			} else {
				elem.display_and_enable(('_wl0_wep_key'), enable);
				if(E('_wl0_encrypt').value == '0')
					E('_wl0_encrypt').value = '1';
				if(E('_wl0_encrypt').value=='1') {
					if (!v_length('_wl0_wep_key', quiet, 5, 5)){
						return 0;
					}
				} else if(encrypt=='2') {
					if (!v_length('_wl0_wep_key', quiet, 13, 13)){
						return 0;
					}
				}
			}
		}else if((auth_val=='4')||(auth_val=='6')||(auth_val=='7')) {//802.1x
			//TODO
		}else{
			elem.display_and_enable(('_wl0_wpa_encrypt'), enable);
			elem.display_and_enable(('_wl0_wep_key'),('_wl0_encrypt'), 0);
			elem.display_and_enable(('_wl0_wpa_psk'), enable);
			if (!v_length('_wl0_wpa_psk', quiet, 8, 63)){
				return 0;
			}
		}
		if (!v_length('_wl0_ssid', quiet, 1, 32)){
			return 0;
		}
		if (E('_wl0_max_associations').value != '' && !v_range('_wl0_max_associations', quiet, 1, 128)){
			return 0;
		}

		// --- generate cmd ---	
		if(!enable) {
			if(wlan0_config.enable) {
				cmd += "!\n";
				cmd += "interface dot11radio 1\n";
				cmd += "shutdown\n";
			}
		} else {
			if(E('_wl0_ssid').value != wlan0_config.ssid) {
				//del old ssid, add new one
				cmd += "!\n";
				if(wlan0_config.ssid != '') {
					cmd += "no dot11 ssid " + wlan0_config.ssid + "\n";
				}
				cmd += "dot11 ssid " + E('_wl0_ssid').value + "\n";
				if(ssid_broadcast) {
					cmd += "guest-mode \n";
				}

				if(auth_val=='0') {
					cmd += "authentication open\n";
				} else if(auth_val=='1') {
					cmd += "authentication shared\n";
				} else if(auth_val=='3') {
					cmd += "authentication key-management wpa 1\n";
					cmd += "wpa-psk ascii " + E('_wl0_wpa_psk').value + "\n";
				} else if(auth_val=='5') {
					cmd += "authentication key-management wpa 2\n";
					cmd += "wpa-psk ascii " + E('_wl0_wpa_psk').value + "\n";
				}
				if(E('_wl0_max_associations').value != '') {
					cmd += "max-associations " + E('_wl0_max_associations').value + "\n";
				} else {
					cmd += "no max-associations\n";
				}
			} else {
				if(ssid_broadcast != wlan0_config.ssid_broadcast
					|| auth_val != wlan0_config.auth
					|| E('_wl0_wpa_psk').value != wlan0_config.wpa_psk
					|| E('_wl0_max_associations').value != wlan0_config.max_associations) {
					cmd += "!\n";
					cmd += "dot11 ssid " + E('_wl0_ssid').value + "\n";
				}
				if(ssid_broadcast != wlan0_config.ssid_broadcast) {
					if(ssid_broadcast) {
						cmd += "guest-mode\n";
					} else {
						cmd += "no guest-mode\n";
					}
				}
				if(auth_val != wlan0_config.auth) {
					if(auth_val=='0') {
						cmd += "authentication open\n";
					} else if(auth_val=='1') {
						cmd += "authentication shared\n";
					} else if(auth_val=='3') {
						cmd += "authentication key-management wpa 1\n";
					} else if(auth_val=='5') {
						cmd += "authentication key-management wpa 2\n";
					}
				}
				if(E('_wl0_wpa_psk').value != wlan0_config.wpa_psk) {
					cmd += "wpa-psk ascii " + E('_wl0_wpa_psk').value + "\n";
				}
				if(E('_wl0_max_associations').value != wlan0_config.max_associations) {
					if(E('_wl0_max_associations').value != '') {
						cmd += "max-associations " + E('_wl0_max_associations').value + "\n";
					} else {
						cmd += "no max-associations\n";
					}
				}
			}
			if(!wlan0_config.enable
				|| E('_wl0_station_role').value != wlan0_config.station_role
				|| E('_wl0_radio_type').value != wlan0_config.radio_type
				|| E('_wl0_ssid').value != wlan0_config.ssid
				|| E('_wl0_channel').value != wlan0_config.channel
				|| E('_wl0_bw').value != wlan0_config.bandwidth) {
				cmd += "!\n";
				cmd += "interface dot11radio 1\n";
			}
			if(!wlan0_config.enable) {
				cmd += "no shutdown\n";
			}
			if(E('_wl0_station_role').value != wlan0_config.station_role) {
				cmd += "station-role " + station_role_list[E('_wl0_station_role').value][1] + "\n";
			}
			if(E('_wl0_radio_type').value != wlan0_config.radio_type) {
				cmd += "radio-type " + radio_type_list[E('_wl0_radio_type').value][1] + "\n";
			}
			if(E('_wl0_ssid').value != wlan0_config.ssid) {
				cmd += "ssid " + E('_wl0_ssid').value + "\n";
			}
			if(E('_wl0_channel').value != wlan0_config.channel) {
				cmd += "channel " + E('_wl0_channel').value + "\n";
			}
			if((auth_val=='0')||(auth_val=='1')||(auth_val=='2')) {
				if(E('_wl0_encrypt').value != wlan0_config.encrypt) {
					cmd += "!\n";
					cmd += "interface dot11radio 1\n";
					if(E('_wl0_encrypt').value != '0') {
						cmd += "encryption mode ciphers " + encrypt_type_list[E('_wl0_encrypt').value][1] + "\n";
					} else {
						cmd += "no encryption mode ciphers\n";
					}
				}
				if(E('_wl0_wep_key').value != wlan0_config.wep_key) {
					if(E('_wl0_encrypt').value != '0') {
						cmd += "!\n";
						cmd += "interface dot11radio 1\n";
						cmd += "encryption key 1 size ";
						if(E('_wl0_encrypt').value == '1') {
							cmd += "40bit ";
						} else if(E('_wl0_encrypt').value == '2') {
							cmd += "104bit ";
						}
						cmd += "ascii " + E('_wl0_wep_key').value + "\n";
					}
				}

			}else if((auth_val=='4')||(auth_val=='6')||(auth_val=='7')) {//802.1x
			}else{
				if(E('_wl0_wpa_encrypt').value != wlan0_config.wpa_encrypt
					|| E('_wl0_wpa_psk').value != wlan0_config.wpa_psk) {
					cmd += "!\n";
					cmd += "interface dot11radio 1\n";
				}
				if(E('_wl0_wpa_encrypt').value != wlan0_config.wpa_encrypt) {
					cmd += "encryption mode ciphers " + encrypt_type_list[E('_wl0_wpa_encrypt').value][1] + "\n";
				}
			}
			if(E('_wl0_bw').value != wlan0_config.bandwidth) {
				cmd += "802.11n bandwidth " + bandwidth_list[E('_wl0_bw').value][1] + "\n";
			}
		}
	}
	//alert(cmd);

	if (user_info.priv < admin_priv) {
		elem.display('save-button', 'cancel-button', false);
	}else{
		elem.display('save-button', 'cancel-button', true);
		fom._web_cmd.value = cmd;
		E('save-button').disabled = (cmd=="");	
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
<body onload='init()'>
<form id='_fom' method='post' action='apply.cgi'>
<input type='hidden' name='_web_cmd' value=''>


<div class='section'>
<script type='text/javascript'>

createFieldTable('', [
	{ title: ui.enable, name: 'f_wl0_enable', type: 'checkbox', value: wlan0_config.enable=='1'},
	{ title: ui.station_role, name: 'wl0_station_role', type: 'select', options: [
		['0',ui.station_role_ap],
		['1',ui.station_role_sta]], value: wlan0_config.station_role},
	{ title: ui.ssid_brdcast, name: 'f_wl0_ssid_broadcast', type: 'checkbox', value: wlan0_config.ssid_broadcast == '1' },
	{ title: ui.wl_radio_type, name: 'wl0_radio_type', type: 'select', options: [
		['0',"802.11b/g"],
		['1',"802.11b"],
		['4',"802.11g"],
		['6',"802.11n"],
		['7',"802.11g/n"],
		['9',"802.11b/g/n"]], value: wlan0_config.radio_type},
	{ title: ui.wlan_channel, name: 'wl0_channel', type: 'select', options: [
		['0',"Auto"],['1',"1"],['2',"2"],['3',"3"],
		['4',"4"],['5',"5"],['6',"6"],['7',"7"],
		['8',"8"],['9',"9"],['10',"10"],['11',"11"],
		['12',"12"],['13',"13"]], value: wlan0_config.channel},
	{ title: ui.ssid, name: 'wl0_ssid', type: 'text', maxlen: 32, size: 16, value: wlan0_config.ssid },
	{ title: ui.wl_auth, name: 'wl0_auth', type: 'select', options: [
		['0',ui.open],
		['1',ui.wlshared],
		//['2',ui.wepauto],
		['3',"WPA-PSK"],
		//['4',"WPA"],
		//['5',"WPA2-PSK"],
		//['6',"WPA2"],
		//['7',"WPA/WPA2"],
		//['8',"WPAPSK/WPA2PSK"]], value: wlan0_config.auth},
		['5',"WPA2-PSK"]], value: wlan0_config.auth},
	{ title: ui.wl_crypt, name: 'wl0_encrypt', type: 'select', options: 
		[['0','NONE'],['1','WEP40'],['2','WEP104']],
	       	value: wlan0_config.encrypt},
	{ title: ui.wl_crypt, name: 'wl0_wpa_encrypt', type: 'select', options: 
		[['3','TKIP'],['4','AES']],
	       	value: wlan0_config.wpa_encrypt},
	{ title: ui.wl_wep_key, name: 'wl0_wep_key', type: 'password', maxlen: 16, size: 16, value: wlan0_config.wep_key },
	{ title: ui.wl_wpa_psk, name: 'wl0_wpa_psk', type: 'password', maxlen: 64, size: 16, value: wlan0_config.wpa_psk },
	{ title: ui.wl_bw, name: 'wl0_bw', type: 'select', options: 
		[['0','20MHz'],['2','40MHz']],
	       	value: wlan0_config.bandwidth},
	{ title: ui.wlan_maxsta, name: 'wl0_max_associations', type: 'text', maxlen: 16, size: 16, value: wlan0_config.max_associations },
	{ title: ui.ssid, name: 'wl0_sta_ssid', type: 'text', maxlen: 32, size: 16, value: wlan0_config.sta_ssid },
	{ title: ui.wl_auth, name: 'wl0_sta_auth', type: 'select', options: [
		['0',ui.open],
		['1',ui.wlshared],
		//['2',ui.wepauto],
		['3',"WPA-PSK"],
		//['4',"WPA"],
		//['5',"WPA2-PSK"],
		//['6',"WPA2"],
		//['7',"WPA/WPA2"],
		//['8',"WPAPSK/WPA2PSK"]], value: wlan0_config.sta_auth},
		['5',"WPA2-PSK"]], value: wlan0_config.sta_auth},
	{ title: ui.wl_crypt, name: 'wl0_sta_encrypt', type: 'select', options: 
		[['0','NONE'],['1','WEP40'],['2','WEP104']],
	       	value: wlan0_config.sta_encrypt},
	{ title: ui.wl_crypt, name: 'wl0_sta_wpa_encrypt', type: 'select', options: 
		[['3','TKIP'],['4','AES']],
	       	value: wlan0_config.sta_wpa_encrypt},
	{ title: ui.wl_wep_key, name: 'wl0_sta_wep_key', type: 'password', maxlen: 16, size: 16, value: wlan0_config.sta_wep_key },
	{ title: ui.wl_wpa_psk, name: 'wl0_sta_wpa_psk', type: 'password', maxlen: 64, size: 16, value: wlan0_config.sta_wpa_psk }
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
