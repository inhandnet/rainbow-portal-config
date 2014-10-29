<% pagehead(menu.status_eth) %>

<script type="text/javascript" src="status-eth.jsx"></script>

<script type='text/javascript'>

<% web_exec('show bridge') %>

var eth0_in_bridge = 0;
var eth1_in_bridge = 0;

for (var i = 0; i < bridge_interface.length; i++) {
	var br_info = bridge_interface[i];
	for (var j = 0; j < br_info[3].length; j++) {
		if (br_info[3][j] == "fastethernet 0/1")
			eth0_in_bridge = 1;
		else if (br_info[3][j] == "fastethernet 0/2") 
			eth1_in_bridge = 1;
	}
}

var ref = new webRefresh('status-eth.jsx', '', 0, 'status_eth_refresh');

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

function c(id, htm)
{
	E(id).cells[1].innerHTML = htm;
}

/*Ê××ÖÄ¸´óÐ´*/
function vif_name_format(ifname)
{
	var reg = /\b(\w)|\s(\w)/g;
	return ifname.replace(reg,function(m){return m.toUpperCase()})
}

function showNetwork()
{
	var wan_status_list=[[0,ui.disconnected],[1,ui.connected]];
	var xdsl_idx;
	
	for (var i= 0; i < eth_interface.length; i++) {
		xdsl_idx = -1;
		for (var j = 0; j < xdsl_interface.length; j++) {
			if (eth_interface[i][0] == xdsl_interface[j][9]){
				xdsl_idx =  j;
				if (!xdsl_interface[xdsl_idx][2]){
					xdsl_interface[xdsl_idx][3] = "0.0.0.0";
					xdsl_interface[xdsl_idx][4] = "0.0.0.0";
					xdsl_interface[xdsl_idx][5] = "0.0.0.0";
					xdsl_interface[xdsl_idx][6] = '0.0.0.0';
				}
				break;
			}
		}

		if (vif_name_format(eth_interface[i][0]) == "Fastethernet 0/1"
				&& eth0_in_bridge == 1) 
			continue;
		if (vif_name_format(eth_interface[i][0]) == "Fastethernet 0/2"
				&& eth1_in_bridge == 1) 
			continue;

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

	for (var i= 0; i < bridge_interface.length; i++) {
		c('br_ip_'+i, bridge_interface[i][1]);
		c('br_mask_'+i, bridge_interface[i][2]);
		c('br_stat_'+i, "Up");
		c('br_gw_'+i, "0.0.0.0");
		c('br_dns_'+i, "0.0.0.0");
		c('br_mtu_'+i, "1500");
	}

	for (var i= 0; i < svi_interface.length; i++) {
		xdsl_idx = -1;
		for (var j = 0; j < xdsl_interface.length; j++) {
			if (svi_interface[i][0] == xdsl_interface[j][9]){
				xdsl_idx =  j;
				if (!xdsl_interface[xdsl_idx][2]){
					xdsl_interface[xdsl_idx][3] = "0.0.0.0";
					xdsl_interface[xdsl_idx][4] = "0.0.0.0";
					xdsl_interface[xdsl_idx][5] = "0.0.0.0";
					xdsl_interface[xdsl_idx][6] = '0.0.0.0';
				}
				break;
			}
		}
/*
		if (vif_name_format(eth_interface[i][0]) == "Fastethernet 0/1"
				&& eth0_in_bridge == 1) 
			continue;
		if (vif_name_format(eth_interface[i][0]) == "Fastethernet 0/2"
				&& eth1_in_bridge == 1) 
			continue;
*/
		c('svi_conn_'+i, conn_type[(xdsl_idx >= 0)?2:svi_interface[i][6]]);
		c('svi_ip_'+i, (xdsl_idx >= 0)?xdsl_interface[xdsl_idx][3]:svi_interface[i][3]);
		c('svi_mask_'+i, (xdsl_idx >= 0)?xdsl_interface[xdsl_idx][4]:svi_interface[i][4]);
		c('svi_stat_'+i, if_stat[(xdsl_idx >= 0)?xdsl_interface[xdsl_idx][2]:svi_interface[i][2]]);
		c('svi_gw_'+i, (xdsl_idx >= 0)?xdsl_interface[xdsl_idx][5]:svi_interface[i][7]);
		c('svi_dns_'+i, (xdsl_idx >= 0)?xdsl_interface[xdsl_idx][6]:svi_interface[i][8]);
		//c('svi_mtu_'+i, (xdsl_idx >= 0)?xdsl_interface[xdsl_idx][7]:svi_interface[i][11]);
		c('svi_mtu_'+i, '1500');

		c('svi_uptime_'+i, formatTime((xdsl_idx >= 0)?xdsl_interface[xdsl_idx][8]:svi_interface[i][9]));
		c('svi_lease_'+i, formatTime(svi_interface[i][10]));
	}
	
}

ref.refresh = function(text)
{
	try {
		eval(text);
	}
	catch (ex) {
	}
	//alert(eth_interface);
	showNetwork();
}
function earlyInit()
{
	showNetwork();
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
var xdsl_idx;
for (var i = 0; i < eth_interface.length; i++) {
	var net_list = [];
	if (vif_name_format(eth_interface[i][0]) == "Fastethernet 0/1"
			&& eth0_in_bridge == 1) 
		continue;
	if (vif_name_format(eth_interface[i][0]) == "Fastethernet 0/2"
			&& eth1_in_bridge == 1) 
		continue;
	
	W("<div class='section-title' id='eth-title'>" + vif_name_format(eth_interface[i][0]) + "</div>");
	W("<div class='section' id='eth-section'>");	
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
	net_list.push({ title: ui.conn_type, rid:'eth_conn_'+i});
	net_list.push({ title: ui.ip, rid: 'eth_ip_'+i});
	net_list.push({ title: ui.netmask, rid: 'eth_mask_'+i});
	net_list.push({ title: ui.gateway, rid: 'eth_gw_'+i});
	net_list.push({ title: ui.dns, rid: 'eth_dns_'+i});
	net_list.push({ title: ui.mtu, rid: 'eth_mtu_'+i});
	net_list.push({ title: ''});
	net_list.push({ title: menu.stat, rid: 'eth_stat_'+i});
	net_list.push({ title: ui.conn_time, rid: 'eth_uptime_'+i});
	net_list.push({ title: ui.remainning_lease, rid: 'eth_lease_'+i});
	createFieldTable('', net_list);
	W("</div>");
}

for (var i = 0; i < bridge_interface.length; i++) {
	var br_list = [];
	if (bridge_interface[i][0] == 'bridge 1')
		bridge_interface[i][0] = 'Bridge 1';
	else if (bridge_interface[i][0] == 'bridge 2')
		bridge_interface[i][0] = 'Bridge 2';
	else if (bridge_interface[i][0] == 'bridge 3')
		bridge_interface[i][0] = 'Bridge 3';
	else if (bridge_interface[i][0] == 'bridge 4')
		bridge_interface[i][0] = 'Bridge 4';
	else 
		bridge_interface[i][0] = 'Bridge';

	W("<div class='section-title' id='br-title'>" + bridge_interface[i][0] + "</div>");
	W("<div class='section' id='eth-section'>");	

	br_list.push({ title: ui.ip, rid: 'br_ip_'+i});
	br_list.push({ title: ui.netmask, rid: 'br_mask_'+i});
	br_list.push({ title: ui.gateway, rid: 'br_gw_'+i});
	br_list.push({ title: ui.dns, rid: 'br_dns_'+i});
	br_list.push({ title: ui.mtu, rid: 'br_mtu_'+i});
	br_list.push({ title: ''});
	br_list.push({ title: menu.stat, rid: 'br_stat_'+i});
	br_list.push({ title: ui.conn_time, rid: 'eth_uptime_'+i});
	br_list.push({ title: ui.remainning_lease, rid: 'eth_lease_'+i});
	createFieldTable('', br_list);
	W("</div>");
}

for (var i = 0; i < svi_interface.length; i++) {
	var net_list = [];
	W("<div class='section-title' id='svi-title'>" + vif_name_format(svi_interface[i][0]) + "</div>");
	W("<div class='section' id='svi-section'>");	
	xdsl_idx = -1;
	for (var j = 0; j < xdsl_interface.length; j++) {
		if (svi_interface[i][0] == xdsl_interface[j][9]){
			xdsl_idx =  j;
			break;
		}
	}
	if (xdsl_idx >= 0)
		cfg_web = "setup-pppoe.jsp";
	else if (svi_interface[i][6]) 
		cfg_web = "setup-dhcpclient.jsp";
	else
		cfg_web = 'setup-vlan'+(i+1)+'.jsp';
	net_list.push({ title: ui.conn_type, rid:'svi_conn_'+i});
	net_list.push({ title: ui.ip, rid: 'svi_ip_'+i});
	net_list.push({ title: ui.netmask, rid: 'svi_mask_'+i});
	net_list.push({ title: ui.gateway, rid: 'svi_gw_'+i});
	net_list.push({ title: ui.dns, rid: 'svi_dns_'+i});
	net_list.push({ title: ui.mtu, rid: 'svi_mtu_'+i});
	net_list.push({ title: ''});
	net_list.push({ title: menu.stat, rid: 'svi_stat_'+i});
	net_list.push({ title: ui.conn_time, rid: 'svi_uptime_'+i});
	net_list.push({ title: ui.remainning_lease, rid: 'svi_lease_'+i});
	createFieldTable('', net_list);
	W("</div>");
}

</script>
</div>

<div id='footer'>
	<script type='text/javascript'>genStdRefresh(1,0,'ref.toggle()');</script>
</div>
</form>

<script type='text/javascript'>earlyInit();</script>
</body>
</html>
