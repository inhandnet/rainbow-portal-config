<% pagehead(menu.status_ssid) %>
<style type='text/css'>
#ap-grid .co1 {
	width: 10%;
}
</style>

<script type='text/javascript'>

<% web_exec('show dot11 sta ssid'); %>

var ap = new webGrid();

ap.loadData = function() {
	var i, a, status;
	
	for (i = 0; i < wlan0_scan.length; ++i) {
		a = wlan0_scan[i];
		if(a[6]=='1') status = ui.connected;
		else if(a[6]=='0') status = ui.disconnected;
		else status = '';
		this.insertData(-1, [a[0],a[1],a[2],a[3],a[4],a[5],status]);
	}
}

ap.setup = function() {
	this.init('ap-grid', ['sort', 'readonly']);
	this.headerSet([ui.wl_channel, 'SSID', 'BSSID', ui.wl_security, ui.wl_signal+'(%)', ui.wl_mode, ui.stat]);
	ap.loadData();
}

var ref = new webRefresh('status-wlan0-ssid.jsx', '', 0, 'status_wlan0_ssid_refresh');

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

function show()
{	
	ap.removeAllData();
	ap.loadData();
}

function earlyInit()
{
	ap.setup();
	show();
}

function init()
{
	ap.recolor();
	ref.initPage(3000, 3);
}

</script>

</head>
<body onload='init()'>
<form>

<div class='section-title'></div>
<div class='section'>
	<table class='web-grid' id='ap-grid'></table>
</div>

<div id='footer'>
	<script type='text/javascript'>genStdRefresh(1,0,'ref.toggle()');</script>
</div>
</form>

<script type='text/javascript'>earlyInit();</script>
</body>
</html>
