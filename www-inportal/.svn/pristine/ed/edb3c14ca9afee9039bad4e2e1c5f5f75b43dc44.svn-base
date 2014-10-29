<% pagehead(menu.stat) %>
<style type='text/css'>
#stat_l2tp-grid {
	text-align: center;	
	width: 600px;
}
#stat_l2tp-grid .co1 {
	width: 15%;
}
#stat_l2tp-grid .co2 {
	width: 20%;
}
#stat_l2tp-grid .co3 {
	width: 25%;
}
</style>

<script type='text/javascript'>

<% web_exec('show interface virtual-ppp'); %>

//type,slot,port,server,status,time,localip,remoteip,rx_p,tx_p,rx_b,tx_b
//var vp_interface = [['11','0','1','192.168.2.35','2','21','1.1.1.1','1.1.1.2','','','','']];
//vp_interface = [['virtual-ppp 1','','1','0','','','','','','']];

//define option list

//define web grid
var stat_l2tp = new webGrid();

stat_l2tp.loadData = function() {
	var i, a;
	var stat_list = [['0',ui.disabled],['1',ui.disconnected],['2',ui.connected]];
	var stat_strings = "";
	
	for (i = 0; i < vp_interface.length; ++i) {
		a = vp_interface[i];
		stat_strings = stat_list[a[2]][1]; 
		if(a[2]=='2') {
			stat_strings += " ("+ a[3] + ui.second +")"; 
		}
		this.insertData(-1, [a[0],a[1],stat_strings,a[4]?a[4]:"-",a[5]?a[5]:"-"]);
	}
}

stat_l2tp.setup = function() {
	var i, a;

	this.init('stat_l2tp-grid', ['readonly']);
	this.headerSet([l2tpc.name, l2tpc.server, ui.stat, l2tpc.localip, l2tpc.remoteip]);
	stat_l2tp.loadData();
}

var ref = new webRefresh('status-l2tp.jsx', '', 0, 'status_l2tp_refresh');

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
	stat_l2tp.removeAllData();
	stat_l2tp.loadData();
}

function earlyInit()
{
	stat_l2tp.setup();
	show();
}

function init()
{
	stat_l2tp.recolor();
	ref.initPage(3000, 3);
}

</script>

</head>
<body onload='init()'>
<form>

<div class='section'>
	<table class='web-grid' id='stat_l2tp-grid'></table>
</div>

<div id='footer'>
	<script type='text/javascript'>genStdRefresh(1,0,'ref.toggle()');</script>
</div>
</form>

<script type='text/javascript'>earlyInit();</script>
</body>
</html>

