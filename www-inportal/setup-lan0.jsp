<% pagehead(menu.setup_lan0) %>

<style type='text/css'>
#mip-grid .co1, #mip-grid .co2  {
	width: 15%;
}
#mip-grid .co3 {
	width: 55%;
}
</style>

<script type='text/javascript'>
<% nvram("lan0_ip,lan0_mtu_enable,lan0_mtu,lan0_netmask,lan0_mac,_lan0_mac,lan0_mip,lan0_server,wan0_proto,wan0_mac,lan0_mode,lan0_mdix,_model_name"); %>

function resetMac() {
	E('_f_lan0_mac').value = nvram._lan0_mac;
	ferror.clear('_f_lan0_mac');
}

function joinAddr(a) {
	var r, i, s;

	r = [];
	for (i = 0; i < a.length; ++i) {
		s = a[i];
		if ((s != '00:00:00:00:00:00') && (s != '0.0.0.0')) r.push(s);
	}
	return r.join(';');
}

function verifyFields(focused, quiet)
{
	var i;
	var ok = 1;
	var a, b, c, d, e;


	// --- visibility ---

	var vis = {
		_lan0_ip: 1,
		_lan0_netmask: 1,
//		_lan0_gateway: 1,
		
		_lan0_mtu_enable: 1,
		_f_lan0_mtu: 1
	};

	var s = nvram._model_name;
	if(s.substr(2,1)==4) {
		elem.display2('_lan0_mode', 0);
	}

	if (E('_lan0_mtu_enable').value == 0) {
		vis._f_lan0_mtu = 0;
		a = E('_f_lan0_mtu');
		a.value = 1500;
	}
	
	E('_f_lan0_mtu').disabled = vis._f_lan0_mtu ? false : true;
	elem.display(PR('_lan0_ip'), PR('_lan0_netmask'), vis._lan0_ip);	
//	elem.display(PR('_lan0_ip'), PR('_lan0_netmask'), PR('_lan0_gateway'), vis._lan0_ip);	
	
	// --- verify ---
	ferror.clear('_f_lan0_mac');
	if (E('_f_lan0_mac').value=="") {
		
	}else if (!v_mac('_f_lan0_mac', quiet)){
			ok = 0;		
	//}else	if (nvram.wan0_proto!='none' && E('_f_lan0_mac').value == nvram.wan0_mac){
	//		ferror.set('_f_lan0_mac', errmsg.bad_mac, quiet);
	//		ok = 0;
	}

	// IP address
	a = ['_lan0_ip'];
//	a = ['_lan0_gateway','_lan0_ip'];
	for (i = a.length - 1; i >= 0; --i){
		if ((vis[a[i]]) && (!v_ipnz(a[i], quiet))) ok = 0;
	}
	
	// netmask
	a = E('_lan0_netmask');
	if (a.value.length==0) a.value = '255.255.255.0';
	if (vis._lan0_netmask && !v_netmask('_lan0_netmask', quiet)) ok = 0;

	a = E('_lan0_server');
	if (a.value.length==0) a.value = '0.0.0.0';
	if (!v_ip('_lan0_server', quiet)) ok = 0;

	return ok;
}

var mip = new webGrid();

mip.verifyFields = function(row, quiet) {
	var f = fields.getAll(row);

	if (f[1].value.length==0) f[1].value = '255.255.255.0';
	f[2].value = f[2].value.replace(';', '_');

	return v_ip(f[0], quiet) && v_netmask(f[1], quiet);
//	if (f[2].value.length==0) f[2].value = '0.0.0.0';
//	f[3].value = f[3].value.replace(';', '_');
//	return v_ip(f[0], quiet) && v_netmask(f[1], quiet) && v_ipz(f[2], quiet);
}

mip.setup = function() {
	this.init('mip-grid', '', 8, [
		{ type: 'text', maxlen: 15 }, { type: 'text', maxlen: 15 }, { type: 'text', maxlen: 64 }]);
//		{ type: 'text', maxlen: 15 }, { type: 'text', maxlen: 15 }, { type: 'text', maxlen: 15 }, { type: 'text', maxlen: 32 }]);
//	this.headerSet([ui.ip, ui.netmask, ui.gateway, ui.desc]);
	this.headerSet([ui.ip, ui.netmask, ui.desc]);
	var mip = nvram.lan0_mip.split(';');
	
	for (var i = 0; i < mip.length; ++i) {
		var r;
//		if (r = mip[i].match(/^(.+),(.+),(.+),(.*)$/)) {
//			this.insertData(-1, [r[1], r[2], r[3], r[4]]);
//		}
		if (r = mip[i].match(/^(.+),(.+),(.*)$/)) {
			this.insertData(-1, [r[1], r[2], r[3]]);
		}
	}
	this.showNewEditor();
	this.resetNewEditor();
}

function earlyInit()
{
	mip.setup();
	verifyFields(null, 1);
}

function save()
{
	var a, b, c;
	var i;

	if (!verifyFields(null, false)) return;
	if (mip.isEditing()) return;

	var fom = E('_fom');

	fom.lan0_mac.value = fom.f_lan0_mac.value;
	
	fom.lan0_mtu.disabled = fom.lan0_mtu_enable.disabled; 	
	if(fom.lan0_mtu_enable.value=='0'){
		fom.lan0_mtu.value = 1500;
	}else{
		fom.lan0_mtu.value = fom.f_lan0_mtu.value;		
	}
	
	var data = mip.getAllData();
	var r = [];
	for (var i = 0; i < data.length; ++i) r.push(data[i].join(','));
	fom.lan0_mip.value = r.join(';');
	
	form.submit(fom, 1);
}
</script>

</head>
<body>
<form id='_fom' method='post' action='apply.cgi'>
<input type='hidden' name='_nextwait' value='10'\>
<input type='hidden' name='_service' value='lan0-restart,dhcpd-restart'\>
<input type='hidden' name='_moveip' value='0'\>

<input type='hidden' name='lan0_iface' value="eth0"\>
<input type='hidden' name='lan0_mtu'\>
<input type='hidden' name='lan0_mac'\>
<input type='hidden' name='lan0_mip'\>
<div class='section-title'></div>

<script type='text/javascript'>
W("<div class='section'>");

createFieldTable('', [
//attrib: "readonly=1",
	{ title: ui.mac, name: 'f_lan0_mac', type: 'text', maxlen: 17, size: 20, 
		suffix: "<input type='button' value='" + ui.deflt + "' onclick='resetMac()'>",
		value: nvram.lan0_mac },
	{ title: ui.ip, name: 'lan0_ip', type: 'text', maxlen: 15, size: 17, value: nvram.lan0_ip },
	{ title: ui.netmask, name: 'lan0_netmask', type: 'text', maxlen: 15, size: 17, value: nvram.lan0_netmask },
//	{ title: ui.gateway, name: 'lan0_gateway', type: 'text', maxlen: 15, size: 17, value: nvram.lan0_gateway },
	{ title: 'MTU', multi: [
		{ name: 'lan0_mtu_enable', type: 'select', options: [['0', ui.deflt],['1',ui.manual]], value: nvram.lan0_mtu_enable },
		{ name: 'f_lan0_mtu', type: 'text', maxlen: 4, size: 6, value: nvram.lan0_mtu } ] },
	{ title: ui.detect_host, name: 'lan0_server', type: 'text', maxlen: 15, size: 17, value: nvram.lan0_server },
	{ title: ui.lan_mode, name: 'lan0_mode', type: 'select', options: [['0', ui.autoneg],['1', ui.full100], ['2', ui.half100], ['3', ui.full10], ['4', ui.half10]], value: nvram.lan0_mode },
	{ title: ui.lan_mdix, name: 'lan0_mdix', type: 'select', hidden:1, options: [['0', ui.cross],['1', ui.straight]], value: nvram.lan0_mdix }
]);
</script>
</div>

<div id='pppoe_title' class='section-title'>
<script type='text/javascript'>
	GetText(ui.mip);
</script>
</div>
<div class='section'>
	<table class='web-grid' id='mip-grid'></table>	
</div>

<script type='text/javascript'>genStdFooter("");</script>
</form>
<script type='text/javascript'>earlyInit()</script>
</body>
</html>
