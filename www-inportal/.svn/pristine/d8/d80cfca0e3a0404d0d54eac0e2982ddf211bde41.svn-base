<% pagehead(menu.status_wan1) %>

<script type="text/javascript" src="status-wan1.jsx"></script>

<script type='text/javascript'>

/*
modem_info = {
	imei: '357789045598171',
	imsi: '460010212710328',
	phonenum: '14500102378',
	siglevel: '17',
	dbm: 79,
	regstatus: '1',
	network_type: '3G',
	submode_name: 'WCDMA',
	current_sim: 'SIM 1',
	current_operator: 'China Mobile',
	lac: '0000',
	cellid: 'ffff'
};
cellular_status = {
	wan1_status: '1',
	wan1_ip: '1.1.1.1',
	wan1_netmask: '2.2.2.2',
	wan1_gateway: '3.3.3.3',
	wan1_dns: '4.4.4.4',
	wan1_mtu: '1500',
	wan1_uptime: '176550'
};
*/


var reg_status_list=[modem.reg_0, modem.reg_1, modem.reg_2, modem.reg_3, modem.reg_4, modem.reg_5, modem.reg_6];

var ref = new webRefresh('status-wan1.jsx', '', 0, 'status_wan1_refresh');

ref.refresh = function(text)
{
	try {
		eval(text);
	}
	catch (ex) {
	}
	show_modem();
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

function show_modem()
{
	var r;
	var siglevel, reg;
	var bar, network;
	
	if (modem_info.siglevel=='') modem_info.siglevel = '0';
	siglevel = parseInt(modem_info.siglevel);
	
	if(siglevel==99) bar = 1;
	else if(siglevel<5) bar = 1;
	else if(siglevel<12) bar = 2;
	else if(siglevel<17) bar = 3;
	else if(siglevel<22) bar = 4;
	else if(siglevel<27) bar = 5;
	else if(siglevel>100){//for TD-SCDMA, signal level is 100~199
		if(siglevel<110) bar = 1;
		else if(siglevel<120) bar = 2;
		else if(siglevel<140) bar = 3;
		else if(siglevel<160) bar = 4;
		else if(siglevel<180) bar = 5;
		else bar = 6;
	}else{
		bar = 6;
	}
	bar = '<img border=0 src="images/bar' + bar + '.gif">(' + siglevel + ' asu ' + '-' + modem_info.dbm + ' dBm)';
	
	reg = parseInt(modem_info.regstatus);
	if(reg>=6) reg = 6;

	network = modem_info.network_type;
	if(modem_info.submode_name!=''){
		network += ' (' + modem_info.submode_name + ')';
	}
	
	c('imei', modem_info.imei);
	c('imsi', modem_info.imsi);
	c('phonenum', modem_info.phonenum);
	c('siglevel', bar);
	c('reg', reg_status_list[reg]);
	c('network', network);
	c('current', modem_info.current_sim);
	c('operator', modem_info.current_operator);
	c('lac', modem_info.lac);
	c('cellid', modem_info.cellid);
}

function show_networks()
{
	var uptime;
	var time;
	var i;
	var wan_status_list=[[0,ui.disconnected],[1,ui.connected]];

	c('wan1_status', wan_status_list[cellular_interface[0][2]][1]);
	if(cellular_interface[0][2] == 0){
		cellular_interface[0][3] = '0.0.0.0';//ip
		cellular_interface[0][4] = '0.0.0.0';//mask
		cellular_interface[0][5] = '0.0.0.0';//gateway
		cellular_interface[0][6] = '0.0.0.0';//dns
	}
	c('wan1_ip', cellular_interface[0][3]);
	c('wan1_netmask', cellular_interface[0][4]);
	c('wan1_gateway', cellular_interface[0][5]);
	c('wan1_dns', cellular_interface[0][6]);
	c('wan1_mtu', cellular_interface[0][7]);
	time = formatTime(cellular_interface[0][8]);
	c('wan1_uptime', time);
}

function earlyInit()
{
	show_modem();
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
W("<div class='section-title' id='modem-title'>" + menu.status_modem + "</div>");
W("<div class='section' id='modem-section'>");

createFieldTable('', [
	{ title: modem.current_sim, rid: 'current'},
	{ title: modem.imei, rid: 'imei'},
	{ title: modem.imsi, rid: 'imsi'},
	{ title: modem.phonenum, rid: 'phonenum'},
	{ title: modem.siglevel, rid: 'siglevel'},
	{ title: modem.reg, rid: 'reg'},
	{ title: modem.operator, rid: 'operator'},
	{ title: modem.network, rid: 'network'},
	{ title: modem.lac, rid: 'lac'},
	{ title: modem.cellid, rid: 'cellid'}
]);
W("</div>");

W("<div class='section-title' id='networks-title'>" + menu.status_networks + "</div>");
W("<div class='section' id='networks-section'>");
createFieldTable('', [
	{ title: ui.stat, rid: 'wan1_status', text: { 
		'0':ui.disconnected, '1':ui.connected}
		[cellular_interface[0][2]] || '-'  },
	{ title: ui.ip, rid: 'wan1_ip' },
	{ title: ui.netmask, rid: 'wan1_netmask' },
	{ title: ui.gateway, rid: 'wan1_gateway' },
	{ title: ui.dns, rid: 'wan1_dns' },
	{ title: ui.mtu, rid: 'wan1_mtu'},
	{ title: ui.conn_time, rid: 'wan1_uptime' }
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
