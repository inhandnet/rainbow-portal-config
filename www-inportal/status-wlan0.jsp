<% pagehead(menu.status_wlan) %>

<script type="text/javascript" src="status-wlan0.jsx"></script>

<script type='text/javascript'>

<% ih_sysinfo() %>
<% web_exec('show ip mac') %>

/*
dot11radio_interface = [['dot11radio 1','',1,'0.0.0.0','255.255.255.0',0]];

wlan0_config = {
	'enable':'1',
	'station_role':'1',
	'ssid_broadcast':'1',
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
sta_info = {
	'state':'0'
};
*/

var ref = new webRefresh('status-wlan0.jsx', '', 0, 'status_wlan0_refresh');
var mode=wlan0_config.station_role;

ref.refresh = function(text)
{
	try {
		eval(text);
	}
	catch (ex) {
	}
	show_wlan();
	show_networks();
}

function formatTime(second) {
    var time = parseFloat(second); 
    var data = "";
    
    if (null!= time &&""!= time) {
	     var day = parseInt(Math.floor(time / 86400));  
   	     var hour = Math.floor(parseInt(Math.floor(time/3600)) - parseInt(Math.floor(time/86400)*24));  
   	     var minute = Math.floor(parseInt(Math.floor(time/60)) - parseInt(Math.floor(time/3600)*60));  
   	     var second = Math.floor(time - parseInt(Math.floor(time/60)*60)); 
	     
	     if(day <= 1) data += day + " day, ";
	     else if(day >= 2) data += day + " days, ";
	     else data += "0 day, ";
	     
   	     if ((hour > 0)&&(hour <= 9)) data += "0" + hour + ":";
   	     else if (hour >= 10) data += hour + ":";
	     else data += "00:"
	     
  	     if ((minute > 0)&&(minute <= 9)) data += "0" + minute + ":";  
	     else if(minute >= 10) data += minute + ":";
	     else data += "00:"
	     
  	     if ((second > 0)&&(second <= 9)) data += "0" + second;  
  	     else if (second >= 10) data += second;  
	     else data += "00";
    }else{  
        data = "";  
    }  
    return data;
}

function c(id, htm)
{
	E(id).cells[1].innerHTML = htm;
}

function show_wlan()
{
	var auth_options = [['0',ui.open],['1',ui.wlshared],['2',ui.wepauto],['3',"WPA-PSK"],
			['4',"WPA"],['5',"WPA2-PSK"],['6',"WPA2"],['7',"WPA/WPA2"],['8',"WPAPSK/WPA2PSK"]];
	var encrypt_options = [['0','NONE'],['1','WEP40'],['2','WEP104'],['3','TKIP'],['4','AES']];
	var wlan_status_list=[[0,ui.disconnected],[1,ui.connected]];
	var wlan_state_list=[[0,ui.disabled],[1,ui.enabled]];

	c('wlan_state', wlan_state_list[wlan0_config.enable][1]);
	c('mac_addr', cpu_mac.mac2);
	if (mode == '1'){
		c('station_role', ui.station_role_sta);

		c('ssid', wlan0_config.sta_ssid);
		c('auth', auth_options[wlan0_config.sta_auth][1]);
		c('encrypt', encrypt_options[wlan0_config.sta_encrypt][1]);

		c('state', wlan_status_list[sta_info.state][1]);
	} else if (mode == '0') {
		c('station_role', ui.station_role_ap);

		c('ssid', wlan0_config.ssid);
		c('channel', wlan0_config.channel);
		c('auth', auth_options[wlan0_config.auth][1]);
		c('encrypt', encrypt_options[wlan0_config.encrypt][1]);
	}
}

function show_networks()
{
	var time;
	var wlan_status_list=[[0,ui.disconnected],[1,ui.connected]];

	c('wlan0_status', wlan_status_list[dot11radio_interface[0][2]][1]);
	if(dot11radio_interface[0][2] == 0){
		dot11radio_interface[0][3] = '0.0.0.0';//ip
		dot11radio_interface[0][4] = '0.0.0.0';//mask
		dot11radio_interface[0][7] = '0.0.0.0';//gateway
		dot11radio_interface[0][8] = '0.0.0.0';//dns
	}

	c('wlan0_ip', dot11radio_interface[0][3]);
	c('wlan0_netmask', dot11radio_interface[0][4]);
	c('wlan0_gateway', dot11radio_interface[0][7]);
	c('wlan0_dns', dot11radio_interface[0][8]);
	time = formatTime(dot11radio_interface[0][10]);
	c('wlan0_uptime', time);

}

function earlyInit()
{
	show_wlan();
	show_networks();
}

function init()
{
	ref.initPage(3000, 0);
}

</script>

</head>
<body onload='init()'>
<form id='_fom' method='post' action=''>

<script type='text/javascript'>
W("<div class='section-title' id='wlan-title'>" + menu.status_wlan + "</div>");
W("<div class='section' id='wlan-section'>");

if (mode == '0') {
	createFieldTable('', [
		{ title: ui.wlan_state, rid: 'wlan_state'},
		{ title: ui.mac_address, rid: 'mac_addr'},
		{ title: ui.station_role, rid: 'station_role'},
		{ title: ui.ssid, rid: 'ssid'},
		{ title: ui.wlan_channel, rid: 'channel'},
		{ title: ui.wl_auth, rid: 'auth'},
		{ title: ui.wl_crypt, rid: 'encrypt'}
	]);
} else if (mode == '1'){
	createFieldTable('', [
		{ title: ui.wlan_state, rid: 'wlan_state'},
		{ title: ui.mac_address, rid: 'mac_addr'},
		{ title: ui.station_role, rid: 'station_role'},
		{ title: ui.ssid, rid: 'ssid'},
		{ title: ui.wl_auth, rid: 'auth'},
		{ title: ui.wl_crypt, rid: 'encrypt'},
		{ title: ui.sta_state, rid: 'state'}
	]);
} else {
	
}
W("</div>");	

W("<div class='section-title' id='networks-title'>" + menu.status_networks + "</div>");
W("<div class='section' id='networks-section'>");
createFieldTable('', [
	{ title: ui.stat, rid: 'wlan0_status', text: {
		'0':ui.disconnected, '1':ui.connected}
		[dot11radio_interface[0][2]] || '-'  },
	{ title: ui.ip, rid: 'wlan0_ip' },
	{ title: ui.netmask, rid: 'wlan0_netmask' },
	{ title: ui.gateway, rid: 'wlan0_gateway' },
	//{ title: ui.mtu, rid: 'wlan0_mtu'},
	{ title: ui.dns, rid: 'wlan0_dns' },
	{ title: ui.conn_time, rid: 'wlan0_uptime' }
]);
W("</div>");

</script>
</div>

<div id='footer'>
	<script type='text/javascript'>genStdRefresh(1,0,'ref.toggle()');</script>
</div>
</form>

<script type='text/javascript'>earlyInit();</script>
</body>
</html>
