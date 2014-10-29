<% pagehead(menu.route_static) %>

<style type='text/css'>
#route-grid .co1, #route-grid .co2, #route-grid .co3  {
	width: 15%;
}
#route-grid .co4 {
	width: 10%;
}
#route-grid .co5 {
	width: 39%;
}
</style>

<script type='text/javascript'>
<% nvram("routes_static,wan0_proto,dmz0_iface"); %>
var route = new webGrid();
var ifaces = [['lan0','LAN']];

if (nvram.wan0_proto=='none'){
	if(nvram.dmz0_iface=='none')
		ifaces = [['lan0','LAN']];
	else
		ifaces = [['lan0','LAN'],['dmz0','DMZ']];
}else{
	if(nvram.dmz0_iface=='none')
		ifaces = [['lan0','LAN'],['wan0','WAN']];
	else
		ifaces = [['lan0','LAN'],['wan0','WAN'],['dmz0','DMZ']];
}

route.verifyFields = function(row, quiet) {
	var f = fields.getAll(row);
	if (f[1].value.length==0) f[1].value = '255.255.255.0';
	if (f[2].value.length==0) f[2].value = '0.0.0.0';
	f[4].value = f[4].value.replace(';', '_');
	return v_ip(f[0], quiet) && v_netmask(f[1], quiet) && v_ip(f[2], quiet);
}

route.resetNewEditor = function() {
	var f, c;

	f = fields.getAll(this.newEditor);
	ferror.clearAll(f);
	
	f[0].value = '0.0.0.0';
	f[1].value = '255.255.255.0';
	f[2].value = '0.0.0.0';
	f[3].value = '0';
	f[4].selectedIndex = 0;
}

route.setup = function() {
	this.init('route-grid', 'move', 20, [
		{ type: 'text', maxlen: 15 }, { type: 'text', maxlen: 15 }, { type: 'text', maxlen: 15 },
		{ type: 'select', options: ifaces }, { type: 'text', maxlen: 32 }]);
	this.headerSet([ui.dst, ui.netmask, ui.gateway, ui.iface, ui.desc]);
	var routes = nvram.routes_static.split(';');
	for (var i = 0; i < routes.length; ++i) {
		var r;
		if (r = routes[i].match(/^(.+),(.+),(.+),(.*),(.*)$/)) {
			this.insertData(-1, [r[1], r[2], r[3], r[4], r[5]]);
		}
	}
	this.showNewEditor();
	this.resetNewEditor();
}

function verifyFields(focused, quiet)
{
	return 1;
}

function save()
{
	if (route.isEditing()) return;

	var fom = E('_fom');
	var data = route.getAllData();
	var r = [];
	for (var i = 0; i < data.length; ++i) r.push(data[i].join(','));
	fom.routes_static.value = r.join(';');

	form.submit(fom, 1);
}

function earlyInit()
{
	route.setup();
}

function init()
{
	route.recolor();
}
</script>
</head>
<body onload='init()'>
<form id='_fom' method='post' action='apply.cgi'>
<input type='hidden' name='_service' value='routing-restart'>
<input type='hidden' name='routes_static'>

<div class='section-title'></div>
<div class='section'>
	<table class='web-grid' id='route-grid'></table>
</div>

<script type='text/javascript'>genStdFooter("");</script>
</form>
<script type='text/javascript'>earlyInit()</script>
</body>
</html>

