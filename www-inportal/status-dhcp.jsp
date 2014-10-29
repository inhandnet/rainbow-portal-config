<% pagehead(menu.status_devices) %>

<style type='text/css'>

#dev-grid {
	width: 700px;
}
#dev-grid .co1 {
	width: 10%;
	text-align: center;
}
#dev-grid .co2 {
	width: 18%;
	text-align: center;
}
#dev-grid .co3 {
	width: 17%;
	text-align: center;
}
#dev-grid .co4 {
	width: 24%;
	text-align: center;
}
#dev-grid .co5 {
	width: 8%;
	text-align: center;
}
#dev-grid .header {
	text-align: center;
}
</style>

<script type='text/javascript'>

dhcp_status = [];//for when dhcp server is disabled 

<% web_exec('show ip dhcp-server') %>

for(var i=0;i<dhcp_status.length;i++){
	dhcp_status[i][0] = dhcp_status[i][0].replace('eth1.','Vlan');
	dhcp_status[i][0] = dhcp_status[i][0].replace('eth2.','Vlan');
	dhcp_status[i][0] = dhcp_status[i][0].replace('eth0','Fastethernet0/1');
	dhcp_status[i][0] = dhcp_status[i][0].replace('eth1','Fastethernet0/2');
	dhcp_status[i][0] = dhcp_status[i][0].replace('wlan0','Dot11radio1');
}

//dhcp_status = [['eth0.1','00:18:15:AA:BB:CC','1.1.1.1','IR7','300'],
//	       ['eth0.2','00:18:15:DD:EE:FF','1.1.1.4','InSwitch','3600']];

<% devlist(); %>

list = [];

for(var i=0;i<arplist.length;i++){
	arplist[i][2] = arplist[i][2].replace('eth1.','Vlan');
	arplist[i][2] = arplist[i][2].replace('eth2.','Vlan');
	arplist[i][2] = arplist[i][2].replace('eth0','Fastethernet0/1');
	arplist[i][2] = arplist[i][2].replace('eth1','Fastethernet0/2');
	arplist[i][2] = arplist[i][2].replace('wlan0','Dot11radio1');
}

function find(mac, ip)
{
	var e, i;
	
	mac = mac.toUpperCase();
	for (i = list.length - 1; i >= 0; --i) {
		e = list[i];
		if ((e.mac == mac) && ((e.ip == ip) || (e.ip == '') || (ip == null))) {
			return e;
		}
	}
	return null;
}

function get(mac, ip)
{
	var e, i;
	
	mac = mac.toUpperCase();
	if ((e = find(mac, ip)) != null) {
		if (ip) e.ip = ip;
		return e;
	}
	
	e = {
		mac: mac,
		ip: ip || '',
		ifname: '',
		name: '',
		lease: ''
	};
	list.push(e);

	return e;
}


var xob = null;

function _deleteLease(ip)
{
	form.submitHidden('dhcpd.cgi', { remove: ip });
}

function deleteLease(a, ip)
{
	if (xob) return;
	if ((xob = new XmlHttp()) == null) {
		_deleteLease(ip);
		return;
	}

	a = E(a);
	a.innerHTML = ui.deleting;

	xob.onCompleted = function(text, xml) {
		a.innerHTML = ui.deleted;
		xob = null;
	}
	xob.onError = function() {
		_deleteLease(ip);
	}

	xob.post('dhcpd.cgi', 'remove=' + ip);
}

function addStatic(n)
{
	var e = list[n];
	cookie.set('addstatic', [e.mac, e.ip, e.name.split(',')[0]].join(','), 1);
	location.href = 'setup-dhcp.jsp';
}

//var ref = new webRefresh('update.cgi', 'exec=devlist', 0, 'status_dhcpd_refresh');
var ref = new webRefresh('status-dhcp.jsx', '', 0, 'status_dhcpd_refresh');

ref.refresh = function(text)
{
	eval(text);

	for(var i=0;i<dhcp_status.length;i++){
		dhcp_status[i][0] = dhcp_status[i][0].replace('eth1.','Vlan');
		dhcp_status[i][0] = dhcp_status[i][0].replace('eth2.','Vlan');
		dhcp_status[i][0] = dhcp_status[i][0].replace('eth0','Fastethernet0/1');
		dhcp_status[i][0] = dhcp_status[i][0].replace('eth1','Fastethernet0/2');
		dhcp_status[i][0] = dhcp_status[i][0].replace('wlan0','Dot11radio1');
	}

	for(var i=0;i<arplist.length;i++){
		arplist[i][2] = arplist[i][2].replace('eth1.','Vlan');
		arplist[i][2] = arplist[i][2].replace('eth2.','Vlan');
		arplist[i][2] = arplist[i][2].replace('eth0','Fastethernet0/1');
		arplist[i][2] = arplist[i][2].replace('eth1','Fastethernet0/2');		
		arplist[i][2] = arplist[i][2].replace('wlan0','Dot11radio1');		
	}

	dg.removeAllData();
	dg.populate();
	dg.resort();
}


var dg = new webGrid();

dg.sortCompare = function(a, b) {
	var col = this.sortColumn;
	var ra = a.getRowData();
	var rb = b.getRowData();
	var r;

	switch (col) {
	case 2:
		r = cmpIP(ra.ip, rb.ip);
		break;
	default:
		r = cmpText(a.cells[col].innerHTML, b.cells[col].innerHTML);
	}
	if (r == 0) {
		r = cmpIP(ra.ip, rb.ip);
		if (r == 0) r = cmpText(ra.ifname, rb.ifname);
	}
	return this.sortAscending ? r : -r;
}

dg.populate = function()
{
	var i, a, b, c, e;

	list = [];

	for (i = 0; i < list.length; ++i) {
		list[i].ip = '';
		list[i].ifname = '';
		list[i].name = '';
		list[i].lease = '';
	}
	
	for (i = dhcpd_lease.length - 1; i >= 0; --i) {
		a = dhcpd_lease[i];
		e = get(a[2], a[1]);
		e.lease = '<a href="javascript:deleteLease(\'L' + i + '\',\'' + a[1] + '\')" title="'
			+ ui.delete_lease + '" id="L' + i + '">' + a[3] + '</a>';
		e.name = a[0];
		e.ifname = nvram._lan0_name;
	}

	for (i = arplist.length - 1; i >= 0; --i) {
		a = arplist[i];
		
		if ((e = get(a[1], a[0])) != null) {
			if (e.ifname == '') e.ifname = a[2];
		}
	}
	
	for (i = dhcpd_static.length - 1; i >= 0; --i) {
		a = dhcpd_static[i].split(',');
		if ((e = find(a[0], a[1])) == null) continue;
		if (e.name == '') {
			e.name = a[2];
		}
		else {
			b = e.name.toLowerCase();
			c = a[2].toLowerCase();
			if ((b.indexOf(c) == -1) && (c.indexOf(b) == -1)) {
				if (e.name != '') e.name += ', ';
				e.name += a[2];
			}
		}
	}

	for(i = 0; i < dhcp_status.length; ++i) {
		a = dhcp_status[i];

		if((e = get(a[1], a[2])) != null) {
			if(e.ifname == '') e.ifname = a[0];
			if(e.name == '') e.name = a[3];
			if(e.lease == '') e.lease = a[4];
		}
	}

	//insert the devlist
	for (i = list.length - 1; i >= 0; --i) {
		e = list[i];
		
		if ((e.ip.length == 0) || (e.ip == '-')) {
			a = '';
		}
		else {
			a = '<a href="javascript:addStatic(' + i + ')" title="' + ui.add_lease + '">' + e.ip + '</a>';
		}

		if (e.mac.match(/^(..):(..):(..)/)) {
			b = "<a href='http://standards.ieee.org/cgi-bin/ouisearch?" + RegExp.$1 + "-" + RegExp.$2 + "-" + RegExp.$3 + "' target='_new' title='OUI '" + ui.search + "'>" + e.mac + "</a>";
		}
		else {
			b = '';
		}
		
		this.insert(-1, e, [
			e.ifname, b, a, e.name,
			e.lease], false);
	}
}

dg.setup = function()
{
	this.init('dev-grid', ['sort', 'readonly']);
	this.headerSet([ui.iface, ui.mac_address, ui.ip, ui.hst, ui.lease]);
	this.populate();
	this.sort(2);
}

function earlyInit()
{
	dg.setup();
}

function init()
{
	dg.recolor();
	ref.initPage(3000, 0);
}
</script>
</head>
<body onload='init()'>

<div class='section'>
	<table id='dev-grid' class='web-grid' cellspacing=0></table>
</div>

<div id='footer' colspan=2><script type='text/javascript'>genStdRefresh(1,0,'ref.toggle()');</script></div>
<script type='text/javascript'>earlyInit();</script>
</body>
</html>

