<% pagehead(menu.status_ipsec) %>
<style type='text/css'>

#ipsecstat-grid {
	width: 600px;
}

#ipsecstat-grid .co1, #ipsecstat-grid .co3 {
	width: 30%;
}
</style>

<script type='text/javascript'>
var ipsec_status = [];
<% web_exec('show crypto')%>
//var ipsec_status = [['tun1', '0', '0'], ['tun2', '1', '1']];

var ipsecstat = new webGrid();

ipsecstat.dataToView = function(data) {
	
	return [data[0], data[1],
	       (data[2] == '0') ? "Disconnected" : "Connected"];
}

ipsecstat.fieldValuesToData = function(row) {
	var f = fields.getAll(row);
	return [f[0].value, f[1].value, f[2].value];
}

ipsecstat.loadData = function() {
	var i;
	
	for (i = 0; i < ipsec_status.length; ++i) {
		this.insertData(-1, [ipsec_status[i][0], ipsec_status[i][1], ipsec_status[i][2]]);
	}
}

ipsecstat.setup = function() {
	var i;

	this.init('ipsecstat-grid', ['sort', 'readonly']);
	this.headerSet([ui.nam, ipsec.tunnel_desc, ui.stat]);
	ipsecstat.loadData();
}

var ref = new webRefresh('status-ipsec-tunnel.jsx', '', 0, 'status_ipsec_refresh');

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
	ipsecstat.removeAllData();
	ipsecstat.loadData();
}

function earlyInit()
{
	ipsecstat.setup();
	show();
}

function init()
{
	ipsecstat.recolor();
	ref.initPage(3000, 3);
}

</script>

</head>
<body onload='init()'>
<form>

<div class='section-title'></div>
<div class='section'>
	<table class='web-grid' id='ipsecstat-grid'></table>
</div>

<div id='footer'>
	<script type='text/javascript'>genStdRefresh(1,0,'ref.toggle()');</script>
</div>
</form>

<script type='text/javascript'>earlyInit();</script>
</body>
</html>
