<% pagehead(ui.alarm) %>
<style type='text/css'>

#alarm-grid {
	width: 95%;
	text-align: left;
}

</style>

<script type='text/javascript'>

var alarm_log = [];
var alarm_count = 0;
<% web_exec('show alarm count'); %>
<% web_exec('show alarm state all number 5'); %>
var ref = new webRefresh('alarms.jsx', '', 0, 'alarms_refresh');
ref.refresh = function(text)
{
	alarm_log = [];
	alarm_count = 0;
	try {
		eval(text);
	}
	catch (ex) {
		alarm_log = [];
		alarm_count = 0;
	}
	show();	
}

var alarmg = new webGrid();

alarmg.verifyFields = function(row, quiet) {
	return 1;
}


alarmg.setup = function() {
	this.init('alarm-grid', ['readonly'], 5, [{ type: 'text', maxlen: 256 }]);
	this.headerSet([alarm.sum]);
}

function c(id, htm)
{
	//E(id).cells[1].innerHTML = htm;
	document.getElementById(id).innerHTML = htm;
}

function show()
{
	c('count', alarm_count);
	alarmg.removeAllData();
	for (var i = 0; i < alarm_log.length; ++i) {
		//alarmg.insertData(-1, ['[ '+alarm_log[i][4]+' ]  '+alarm_log[i][6]]);
		alarmg.insertData(-1, [' [ '+alarm_log[i][3]+' ]: ']);
		alarmg.insertData(-1, [alarm_log[i][5]]);
	}
}

function init()
{
	ref.initPage(3000, 3);
}
</script>
</head>
<body onload='init()'>
<form id='_fom' method='post' action='apply.cgi'>
	<div class='section'>
		<table>
		<tr><td ><script type='text/javascript'>GetText(alarm.tot);</script>: </td><td id='count'>0</td></tr>
		</table>
		<table class='web-grid' cellspacing=1 id='alarm-grid'></table>
		<script type='text/javascript'>alarmg.setup();	show(); </script>
	</div>
	<div id='footer'>
	<script type='text/javascript'>genStdRefresh(1,0,'ref.toggle()'); </script>
	</div>
</form>
</body>
</html>
