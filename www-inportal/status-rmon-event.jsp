<% pagehead(menu.status_rmon_event) %>
<style type='text/css'>
#status-grid {
	text-align: center;
	width:480px;	
}
#status-grid.co1 {
	width:80px;	
}
#status-grid.co2 {
	width:200px;	
}
#status-grid.co3 {
	width:200px;	
}
</style>

<script type='text/javascript'>
<% ih_sysinfo() %>
<% ih_user_info(); %>
var cli_cmd = "";
<% web_rmon_cmd() %>


//var eventLog_config = [[1,2,'abc'],[2,2,'abc'],[3,2,'efg']];

function back()
{
	document.location = 'switch-rmon-event.jsp';	
}

var status = new webGrid();
status.loadData = function() {
	for (var i = 0; i < eventLog_config.length; ++i) {
		
		this.insertData(-1, eventLog_config[i]);
	}
}

status.setup = function() {
	var i, a;

	this.init('status-grid', ['sort', 'readonly']);
	this.headerSet([rmon.event_log,rmon.event_log_time,rmon.event_log_description]);
	status.loadData();
}

var ref = new webRefresh('status-rmon-event.jsx', 'send_cmd='+cli_cmd, 0, 'status_rmon_event_refresh');

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
	status.removeAllData();
	status.loadData();
}

function earlyInit()
{
	status.setup();
	show();
}

function init()
{
	status.recolor();
	ref.initPage(3000, 0);
}

</script>

</head>
<body onload='init()'>
<form>

<div class='section'>
	<table class='web-grid' id='status-grid'></table>
</div>

<div id='footer'>
	<script type='text/javascript'>genStdRefresh(1,0,'ref.toggle()');</script>
	
</div>
</form>
<script type='text/javascript'>earlyInit();</script>
<script>
W("</div>");		
W("<div id='footer'>");
W("<span id='footer-msg'></span>");
W("<input type='button' value='" + ui.bk + "' id='back-button' onclick='back();'/>");	
W("</div>");
</script>
</body>
</html>
