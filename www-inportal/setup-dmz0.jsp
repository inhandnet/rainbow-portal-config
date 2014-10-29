<% pagehead(menu.setup_dmz0) %>

<style type='text/css'>
#mip-grid .co1, #mip-grid .co2  {
	width: 15%;
}
#mip-grid .co3 {
	width: 55%;
}
</style>

<script type='text/javascript'>
<% nvram("dmz0_ip,dmz0_mtu_enable,dmz0_mtu,dmz0_netmask,dmz0_mac,_dmz0_mac,dmz0_mip"); %>

function resetMac() {
	E('_f_dmz0_mac').value = nvram._dmz0_mac;
	ferror.clear('_f_dmz0_mac');
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
		_dmz0_ip: 1,
		_dmz0_netmask: 1,
//		_dmz0_gateway: 1,
		
		_dmz0_mtu_enable: 1,
		_f_dmz0_mtu: 1
	};


	if (E('_dmz0_mtu_enable').value == 0) {
		vis._f_dmz0_mtu = 0;
		a = E('_f_dmz0_mtu');
		a.value = 1500;
	}
	
	E('_f_dmz0_mtu').disabled = vis._f_dmz0_mtu ? false : true;
	elem.display(PR('_dmz0_ip'), PR('_dmz0_netmask'), vis._dmz0_ip);	
//	elem.display(PR('_dmz0_ip'), PR('_dmz0_netmask'), PR('_dmz0_gateway'), vis._dmz0_ip);	
	
	// --- verify ---
	ferror.clear('_f_dmz0_mac');
	if (E('_f_dmz0_mac').value=="") {
		
	}else if (!v_mac('_f_dmz0_mac', quiet)){
			ok = 0;		
	//}else	if (nvram.wan0_proto!='none' && E('_f_dmz0_mac').value == nvram.wan0_mac){
	//		ferror.set('_f_dmz0_mac', errmsg.bad_mac, quiet);
	//		ok = 0;
	}
	elem.enable(('_f_dmz0_mac'), false);

	// IP address
	a = ['_dmz0_ip'];
//	a = ['_dmz0_gateway','_dmz0_ip'];
	for (i = a.length - 1; i >= 0; --i){
		if ((vis[a[i]]) && (!v_ipnz(a[i], quiet))) ok = 0;
	}
	
	// netmask
	a = E('_dmz0_netmask');
	if (a.value.length==0) a.value = '255.255.255.0';
	if (vis._dmz0_netmask && !v_netmask('_dmz0_netmask', quiet)) ok = 0;

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
	var mip = nvram.dmz0_mip.split(';');
	
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

	fom.dmz0_mac.value = fom.f_dmz0_mac.value;
	
	fom.dmz0_mtu.disabled = fom.dmz0_mtu_enable.disabled; 	
	if(fom.dmz0_mtu_enable.value=='0'){
		fom.dmz0_mtu.value = 1500;
	}else{
		fom.dmz0_mtu.value = fom.f_dmz0_mtu.value;		
	}
	
	var data = mip.getAllData();
	var r = [];
	for (var i = 0; i < data.length; ++i) r.push(data[i].join(','));
	fom.dmz0_mip.value = r.join(';');
	
	form.submit(fom, 1);
}
</script>

</head>
<body>
<form id='_fom' method='post' action='apply.cgi'>
<input type='hidden' name='_nextwait' value='10'\>
<input type='hidden' name='_service' value='dmz0-restart'\>
<input type='hidden' name='_moveip' value='0'\>

<input type='hidden' name='dmz0_iface' value="eth0.3"\>
<input type='hidden' name='dmz0_mtu'\>
<input type='hidden' name='dmz0_mac'\>
<input type='hidden' name='dmz0_mip'\>
<div class='section-title'></div>

<script type='text/javascript'>
W("<div class='section'>");

createFieldTable('', [
//attrib: "readonly=1",
	{ title: ui.mac, name: 'f_dmz0_mac', type: 'text', maxlen: 17, size: 20, 
		suffix: "<input type='button' value='" + ui.deflt + "' onclick='resetMac()'>",
		value: nvram.dmz0_mac },
	{ title: ui.ip, name: 'dmz0_ip', type: 'text', maxlen: 15, size: 17, value: nvram.dmz0_ip },
	{ title: ui.netmask, name: 'dmz0_netmask', type: 'text', maxlen: 15, size: 17, value: nvram.dmz0_netmask },
//	{ title: ui.gateway, name: 'dmz0_gateway', type: 'text', maxlen: 15, size: 17, value: nvram.dmz0_gateway },
	{ title: 'MTU', multi: [
		{ name: 'dmz0_mtu_enable', type: 'select', options: [['0', ui.deflt],['1',ui.manual]], value: nvram.dmz0_mtu_enable },
		{ name: 'f_dmz0_mtu', type: 'text', maxlen: 4, size: 6, value: nvram.dmz0_mtu } ] }
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
