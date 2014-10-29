<% pagehead(menu.stat) %>
<style type='text/css'>
#stat_openvpn-grid {
	text-align: center;	
	width: 800px;
}
#stat_openvpn-grid .co1 {
	width: 10%;
}
#stat_openvpn-grid .co2 {
	width: 15%;
}
#stat_openvpn-grid .co3 {
	width: 25%;
}
#stat_openvpn-grid .co4 {
	width: 15%;
}
#stat_openvpn-grid .co5 {
	width: 15%;
}
#stat_openvpn-grid .co6 {
	width: 15%;
}
</style>

<script type='text/javascript'>

<% web_exec('show interface openvpn'); %>
//openvpn_interface=[['openvpn 6','1','192.168.2.35','0 day 12h 5s','1.1.1.1','1.1.1.2']];
//define option list
var connect_status=[['0','disconnected'],['1','connected']];
//define web grid
var stat_openvpn= new webGrid();

stat_openvpn.loadData = function() {
	var i, a;
	var stat_strings = "";
	
	for (i = 0; i < openvpn_interface.length; ++i) {
		a = openvpn_interface[i];
		if(a[2]=='1') {
			stat_strings =  connect_status[a[2]][1]+" ("+ a[6] + ui.second +")"; 
		}else {
			stat_strings =  connect_status[a[2]][1];
		}
		this.insertData(-1, [a[0],a[5]?a[5]:"-", stat_strings, a[3]?a[3]:"-", a[7]?a[7]:"-", a[1]]);
	}
}

stat_openvpn.setup = function() {
	var i, a;

	this.init('stat_openvpn-grid', ['readonly']);
	this.headerSet([openvpn.name, openvpn.server, ui.stat, openvpn.localip, openvpn.remoteip, openvpn.description]);
	stat_openvpn.loadData();
}

var ref = new webRefresh('status-openvpn.jsx', '', 0, 'status_openvpn_refresh');

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
	stat_openvpn.removeAllData();
	stat_openvpn.loadData();
}

function earlyInit()
{
	stat_openvpn.setup();
	show();
}

function init()
{
	stat_openvpn.recolor();
	ref.initPage(3000, 3);
}

</script>

</head>
<body onload='init()'>
<form>

<div class='section'>
	<table class='web-grid' id='stat_openvpn-grid'></table>
</div>

<div id='footer'>
	<script type='text/javascript'>genStdRefresh(1,0,'ref.toggle()');</script>
</div>
</form>

<script type='text/javascript'>earlyInit();</script>
</body>
</html>

