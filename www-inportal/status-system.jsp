<% pagehead(menu.status_system) %>

<script src="js/jquery.min.js" type="text/javascript"></script>

<script type="text/javascript" src="status-system.jsx"></script>

<script type='text/javascript'>
	
<% ih_sysinfo() %>
<% web_exec('show ip mac') %>

var sync_button = " <input type='button' style='width:100px' value='" + ui.sync + "' onclick='sync()' id='sync-button'>";

var ref = new webRefresh('status-system.jsx', '', 0, 'status_system_refresh');
var stats;

ref.refresh = function(text)
{
	stats = {};
	try {
		eval(text);
	}
	catch (ex) {
		stats = {};
	}
	show();
}

function sync()
{
	var now = new Date();
	
	location.href = 'settime.cgi?time=' + now.getTime()/1000;
}

function c(id, htm)
{
	E(id).cells[1].innerHTML = htm;
}

var conn_type = [ui.statc, ui.DHCP, ui.pppoe];
var if_stat = [ui.dn,ui.up];

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

/*Ê××ÖÄ¸´óÐ´*/
function vif_name_format(ifname)
{
	var reg = /\b(\w)|\s(\w)/g;
	return ifname.replace(reg,function(m){return m.toUpperCase()})
}

function show()
{	
	var now = new Date();
	var a;
	
	//stats.ostime = now.toLocaleString();
	a = now.getYear();
	if (a<1900) a += 1900;
	stats.ostime = a + '-';
	a = now.getMonth()+1;
	stats.ostime += a > 9 ? a : ('0' + a);
	stats.ostime += '-';
	a = now.getDate();
	stats.ostime += a > 9 ? a : ('0' + a);

	stats.ostime += ' ';
	
	a = now.getHours();
	stats.ostime += a > 9 ? a : ('0' + a);
	
	stats.ostime += ':';
	a = now.getMinutes();
	stats.ostime += a > 9 ? a : ('0' + a);
	
	stats.ostime += ':';
	a = now.getSeconds();
	stats.ostime += a > 9 ? a : ('0' + a);
	
	c('cpu', stats.cpuload);
	c('uptime', stats.uptime);
	c('rtime', stats.time);
	c('ostime', stats.ostime);
	if(stats.ostime==stats.time)
		c('ostime', stats.ostime);
	else
		c('ostime', stats.ostime + sync_button);
		
	c('memory', stats.memory);
	showNetwork();

}

var reg_status_list=[modem.reg_0, modem.reg_1, modem.reg_2, modem.reg_3, modem.reg_4, modem.reg_5, modem.reg_6];

function showNetwork()
{
	var wan_status_list=[[0,ui.disconnected],[1,ui.connected]];
	var xdsl_idx;
	
	for (var i= 0; i < eth_interface.length; i++) {
		xdsl_idx = -1;
		for (var j = 0; j < xdsl_interface.length; j++) {
			if (eth_interface[i][0] == xdsl_interface[j][9]){
				xdsl_idx =  j;
				if (!xdsl_interface[xdsl_idx][2]) {
					xdsl_interface[xdsl_idx][3] = "0.0.0.0";
					xdsl_interface[xdsl_idx][4] = "0.0.0.0";
					xdsl_interface[xdsl_idx][5] = "0.0.0.0";
					xdsl_interface[xdsl_idx][6] = '0.0.0.0';
				}
				break;
			}
		}
		c('eth_conn_'+i, conn_type[(xdsl_idx >= 0)?2:eth_interface[i][6]]);
		c('eth_ip_'+i, (xdsl_idx >= 0)?xdsl_interface[xdsl_idx][3]:eth_interface[i][3]);
		c('eth_mask_'+i, (xdsl_idx >= 0)?xdsl_interface[xdsl_idx][4]:eth_interface[i][4]);
		c('eth_stat_'+i, if_stat[(xdsl_idx >= 0)?xdsl_interface[xdsl_idx][2]:eth_interface[i][2]]);
		c('eth_gw_'+i, (xdsl_idx >= 0)?xdsl_interface[xdsl_idx][5]:eth_interface[i][7]);
		c('eth_dns_'+i, (xdsl_idx >= 0)?xdsl_interface[xdsl_idx][6]:eth_interface[i][8]);
		c('eth_mtu_'+i, (xdsl_idx >= 0)?xdsl_interface[xdsl_idx][7]:eth_interface[i][11]);
		c('eth_uptime_'+i, formatTime((xdsl_idx >= 0)?xdsl_interface[xdsl_idx][8]:eth_interface[i][9]));
		c('eth_lease_'+i, formatTime(eth_interface[i][10]));
	}

if (cellular_interface.length > 0) {
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
	c('cell_siglevel', bar);
	c('cell_reg', reg_status_list[reg]);
	c('cell_status', wan_status_list[cellular_interface[0][2]][1]);
	if(cellular_interface[0][2] == 0){
		cellular_interface[0][3] = '0.0.0.0';//ip
		cellular_interface[0][4] = '0.0.0.0';//mask
		cellular_interface[0][5] = '0.0.0.0';//gateway
		cellular_interface[0][6] = '0.0.0.0';//dns
	}
	c('cell_ip', cellular_interface[0][3]);
	c('cell_netmask', cellular_interface[0][4]);
	c('cell_gateway', cellular_interface[0][5]);
	c('cell_dns', cellular_interface[0][6]);
	c('cell_mtu', cellular_interface[0][7]);
	time = formatTime(cellular_interface[0][8]);
	c('cell_uptime', time);	
}
}
function earlyInit()
{
	show();
}

function init()
{
	ref.initPage(3000, 3);
}


function showIcon(tar) {
	if ($("#"+tar).css("display") == "none") {
		$("#"+tar).css("display", "");
		var para = document.getElementById("show-"+tar).className = "x-tree-ec-icon elbow-minus"; 
	} else {
		$("#"+tar).css("display", "none");
		var para = document.getElementById("show-"+tar).className = "x-tree-ec-icon elbow-plus";
	}
}



</script>

</head>
<body onload='init()'>
<form id='_fom' method='post' action='settime.cgi'>
<input type='hidden' name='_nextwait' value='10'>
<input type='hidden' name='_service' value=''>
<input type='hidden' name='time'>
<div class='section-title' id='system-title'>
<img src="images/s.gif" onclick='showIcon("system")' name="show-system" id="show-system" class="x-tree-ec-icon  elbow-minus">
<script type='text/javascript'>GetText(menu.status_system);</script>
</div>
<div class='section' id="system">
<script type='text/javascript'>
var model_name, ext_features, v;

v = ih_sysinfo.model_name.indexOf('-', 0);
if(v==-1){
	model_name = ih_sysinfo.model_name;
	ext_features = "";
}else{
	model_name = ih_sysinfo.model_name.substr(0, v);
	ext_features = ih_sysinfo.model_name.substr(v);
}

v = model_name;

if(typeof(v)=='undefined')
	model_name = product.model.replace('${MODEL}', model_name) + ext_features;
else
	model_name = v + ext_features;

createFieldTable('', [
	{ title: ui.nam, text: ih_sysinfo.hostname },
	{ title: ui.model, hidden: (ih_sysinfo.oem_name=='welotec'), text: model_name },
	{ title: ui.sn, hidden: false,text: ih_sysinfo.serial_number },
	{ title: ui.desc, hidden:  (ih_sysinfo.oem_name!='welotec'),text: ih_sysinfo.description },
	{ title: ui.mac_address, text: cpu_mac.mac},
	{ title: ' ', text: cpu_mac.mac2},
	{ title: infomsg.cur_version, text: '<% version(1); %>'},
	{ title: infomsg.cur_bootloader_version, text: ih_sysinfo.bootloader},
	{ title: infomsg.ext_version, hidden: 1, text: '<% version(2); %>'},
	{ title: ui.buildtime, hidden: 1, text: '<% build_time(); %>'},
	null,
	{ title: ui.time, rid: 'rtime', text: stats.time },
	{ title: ui.ostime, rid: 'ostime', text: stats.ostime + sync_button},
	{ title: ui.uptime, rid: 'uptime', text:  stats.uptime },
	{ title: ui.cpuload, rid: 'cpu', text: stats.cpuload },
	{ title: ui.memfree, rid: 'memory', text: stats.memory }
]);
</script>
</div>
<div class='section-title' >
<img src="images/s.gif" onclick='showIcon("network")' name="show-network" id="show-network" class="x-tree-ec-icon  elbow-plus">
<script type='text/javascript'>GetText(menu.network_status);</script>
</div>
<div class='section' id='network' style="display:none">
<script type='text/javascript'>	
var net_list = [];
if (cellular_interface.length > 0) {
//cellular
net_list.push({ text: '<b>'+vif_name_format(cellular_interface[0][0]) + '</b>'+' <a href="setup-wan1.jsp">' + '['+ui.settings+']' + '</a>'});
net_list.push({ title: ui.stat, indent:2, rid: 'cell_status'});
	net_list.push({ title: modem.siglevel, indent:2, rid: 'cell_siglevel'});
net_list.push({ title: modem.reg, indent:2, rid: 'cell_reg'});
net_list.push({ title: ui.ip, indent:2, rid: 'cell_ip' });
net_list.push({ title: ui.netmask, indent:2, rid: 'cell_netmask' });
net_list.push({ title: ui.gateway, indent:2, rid: 'cell_gateway' });
net_list.push({ title: ui.dns, indent:2, rid: 'cell_dns' });
net_list.push({ title: ui.mtu, indent:2, rid: 'cell_mtu'});
net_list.push({ title: ui.conn_time, indent:2, rid: 'cell_uptime' });
net_list.push({ title: ''});
}
//ethernet
var xdsl_idx;
for (var i = 0; i < eth_interface.length; i++) {
	xdsl_idx = -1;
	for (var j = 0; j < xdsl_interface.length; j++) {
		if (eth_interface[i][0] == xdsl_interface[j][9]){
			xdsl_idx =  j;
			break;
		}
	}
	if (xdsl_idx >= 0)
		cfg_web = "setup-pppoe.jsp";
	else if (eth_interface[i][6]) 
		cfg_web = "setup-dhcpclient.jsp";
	else
		cfg_web = 'setup-eth'+(i+1)+'.jsp';
	net_list.push({ text: '<b>'+vif_name_format(eth_interface[i][0]) + '</b>'+' <a href="'+cfg_web+'">' + '['+ui.settings+']' + '</a>'});
	net_list.push({ title: menu.stat, indent:2, rid: 'eth_stat_'+i});
	net_list.push({ title: ui.conn_type, indent:2, rid:'eth_conn_'+i});
	net_list.push({ title: ui.ip, indent:2, rid: 'eth_ip_'+i});
	net_list.push({ title: ui.netmask, indent:2, rid: 'eth_mask_'+i});
	net_list.push({ title: ui.gateway, indent:2, rid: 'eth_gw_'+i});
	net_list.push({ title: ui.dns, indent:2, rid: 'eth_dns_'+i});
	net_list.push({ title: ui.mtu, indent:2, rid: 'eth_mtu_'+i});
	net_list.push({ title: ui.conn_time, indent:2, rid: 'eth_uptime_'+i});
	net_list.push({ title: ui.remainning_lease, indent:2, rid: 'eth_lease_'+i});
	net_list.push({ title: ''});
}





createFieldTable('', net_list);
</script>
</div>
<div id='footer'>
	<script type='text/javascript'>genStdRefresh(1,0,'ref.toggle()');</script>
</div>
</form>

<script type='text/javascript'>earlyInit();</script>
</body>
</html>
