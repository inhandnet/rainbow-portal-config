<% pagehead(menu.status_networks) %>

<script type="text/javascript" src="status-networks.jsx"></script>

<script type='text/javascript'>
show_dhcpc0 = (port.wan0_proto == 'dhcp');

function dhcpc(idx, what)
{
	form.submitHidden('dhcpc.cgi', { idx: idx, exec: what, _redirect: 'status-networks.jsp' });
}


function serv(service, sleep)
{
	form.submitHidden('service.cgi', { _service: service, _redirect: 'status-networks.jsp', _sleep: sleep });
}

function c(id, htm)
{
	E(id).cells[1].innerHTML = htm;
}

function show()
{
	show_dhcpc0 = (port.wan0_proto == 'dhcp');
	
	c('wan0_mac', port_stats.wan0_mac);
	c('wan0_ip', port_stats.wan0_ip);
	c('wan0_netmask', port_stats.wan0_netmask);
	c('wan0_gateway', port_stats.wan0_gateway);
	c('wan0_dns', port_stats.wan0_dns);
//	c('dns', port_stats.dns);	
//	c('wan0_status', port_stats.wan0_status);
	E('wan0_status').value = port_stats.wan0_status;
	c('wan0_uptime', port_stats.wan0_uptime);
	if (show_dhcpc0) c('wan0_lease', port_stats.wan0_lease);

	c('dns_static', port_stats.dns_static);	
}

function earlyInit()
{
	elem.display('wan0-title', port.wan0_proto!='none');
	elem.display('wan0-section', port.wan0_proto!='none');
	elem.display('b_dhcpc0', show_dhcpc0);
	show();
}

var ref = new webRefresh('status-networks.jsx', '', 0, 'status_networks_refresh');

ref.refresh = function(text)
{
	port_stats = {};
	try {
		eval(text);
	}
	catch (ex) {
		port_stats = {};
	}
	show();
}

function init()
{
	ref.initPage(3000, 0);
}

</script>

</head>
<body onload='init()'>
<form>

<div class='section-title' id='wan0-title' style='display:none'>
<script type='text/javascript'>
	GetText(menu.setup_wan0);
</script>
</div>
<div class='section' id='wan0-section' style='display:none'>
<script type='text/javascript'>
createFieldTable('', [
	{ title: ui.mac_address, rid: 'wan0_mac', text: port_stats.wan0_mac },
	{ title: ui.conn_type, text: { 
		'dhcp':ui.DHCP, 'static':ui.statc, 'disabled':ui.disable}
		[port.wan0_proto] || '-' },
	{ title: ui.ip, rid: 'wan0_ip', text: port_stats.wan0_ip },
	{ title: ui.netmask, rid: 'wan0_netmask', text: port_stats.wan0_netmask },
	{ title: ui.gateway, rid: 'wan0_gateway', text: port_stats.wan0_gateway },
	{ title: ui.dns, rid: 'wan0_dns', text: port_stats.wan0_dns },
	{ title: ui.mtu, rid: 'mtu', text: port_stats.wan0_run_mtu },
//	null,
//	{ title: ui.stat, rid: 'wan0_status', text: port_stats.wan0_status },
	{ title: ui.stat, rid: 'wan0_status', text: { 
		'renewing':ui.renewing, 'connected':ui.connected, 'disconnected':ui.disconnected}
		[port_stats.wan0_status] || '-' },
	{ title: ui.conn_time, rid: 'wan0_uptime', text: port_stats.wan0_uptime },
	{ title: ui.remainning_lease, rid: 'wan0_lease', text: port_stats.wan0_lease, ignore: !show_dhcpc0 }
]);
W("<span id='b_dhcpc0' style='display:none'>");
W("<input type='button' class='controls' onclick='dhcpc(\"0\", \"renew\")' value='" + ui.renew +"'/>");
W("<input type='button' class='controls' onclick='dhcpc(\"0\", \"release\")' value='" + ui.release +"'/>");
W("</span>");
</script>
</div>

<div id='footer'>
	<script type='text/javascript'>genStdRefresh(1,0,'ref.toggle()');</script>
</div>
</form>

<script type='text/javascript'>earlyInit();</script>
</body>
</html>
