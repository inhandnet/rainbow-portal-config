<% pagehead(menu.status_sla) %>
<style type='text/css'>
#stat_sla-grid {
	text-align: center;	
	width: 500px;
}
#stat_sla-grid .co1 {
	width: 10%;
}
#stat_sla-grid .co2 {
	width: 18%;
}
#stat_sla-grid .co3 {
	width: 25%;
}
#stat_sla-grid .co4 {
	width: 20%;
}
</style>

<script type='text/javascript'>

<% web_exec('show sla'); %>

//var sla_status = [['1','1','1.1.1.1','1','0'],['2','1','1.1.1.1','1','0']];

//define option list
var type_list = [['0', ''],['1','icmp-echo']];
var stat_list = [['0', 'stop'],['1', 'start']];
var result_list = [['0', '-'],['1', 'down'],['2', 'up']];

var stat_sla = new webGrid();

stat_sla.loadData = function() {
	var i, a;
	
	for (i = 0; i < sla_status.length; ++i) {
		a = sla_status[i];
		this.insertData(-1, [a[0],type_list[a[1]][1],a[2],stat_list[a[3]][1],result_list[a[4]][1]]);
	}
}

stat_sla.setup = function() {
	var i, a;

	this.init('stat_sla-grid', ['sort', 'readonly']);
	this.headerSet([sla.id, sla.type, sla.ip, ui.stat, sla.stat_result]);
	stat_sla.loadData();
}

var ref = new webRefresh('status-sla.jsx', '', 0, 'status_sla_refresh');

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
	stat_sla.removeAllData();
	stat_sla.loadData();
}

function earlyInit()
{
	stat_sla.setup();
	show();
}

function init()
{
	stat_sla.recolor();
	ref.initPage(3000, 3);
}

</script>

</head>
<body onload='init()'>
<form>

<div class='section'>
	<table class='web-grid' id='stat_sla-grid'></table>
</div>

<div id='footer'>
	<script type='text/javascript'>genStdRefresh(1,0,'ref.toggle()');</script>
</div>
</form>

<script type='text/javascript'>earlyInit();</script>
</body>
</html>

