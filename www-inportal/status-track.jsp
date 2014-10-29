<% pagehead(menu.status_sla) %>
<style type='text/css'>
#stat_track-grid {
	text-align: center;	
	width: 300px;
}
#stat_track-grid .co1 {
	width: 30%;
}
</style>

<script type='text/javascript'>

<% web_exec('show track'); %>

//var track_status = [['1','1'],['2','2']];

//define option list
var stat_list = [['0', '-'],['1', 'negative'],['2', 'positive']];

var stat_track = new webGrid();

stat_track.loadData = function() {
	var i, a;
	
	for (i = 0; i < track_status.length; ++i) {
		a = track_status[i];
		this.insertData(-1, [a[0],stat_list[a[1]][1]]);
	}
}

stat_track.setup = function() {
	var i, a;

	this.init('stat_track-grid', ['sort', 'readonly']);
	this.headerSet([track.id, ui.stat]);
	stat_track.loadData();
}

var ref = new webRefresh('status-track.jsx', '', 0, 'status_track_refresh');

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
	stat_track.removeAllData();
	stat_track.loadData();
}

function earlyInit()
{
	stat_track.setup();
	show();
}

function init()
{
	stat_track.recolor();
	ref.initPage(3000, 3);
}

</script>

</head>
<body onload='init()'>
<form>

<div class='section'>
	<table class='web-grid' id='stat_track-grid'></table>
</div>

<div id='footer'>
	<script type='text/javascript'>genStdRefresh(1,0,'ref.toggle()');</script>
</div>
</form>

<script type='text/javascript'>earlyInit();</script>
</body>
</html>

