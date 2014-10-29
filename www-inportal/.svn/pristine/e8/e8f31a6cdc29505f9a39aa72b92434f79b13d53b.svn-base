<% pagehead(menu.status_sla) %>
<style type='text/css'>
#stat_rsync-grid {
	text-align: center;	
	width: 500px;
}
#stat_rsync-grid .co1 {
	width: 10%;
}
#stat_rsync-grid .co2 {
	width: 10%;
}
#stat_rsync-grid .co3 {
	width: 45%;
}
#stat_rsync-grid .co4 {
	width: 20%;
}
</style>

<script type='text/javascript'>

<% ih_sysinfo(); %>
<% ih_user_info(); %>
<% web_exec('show remote-sync'); %>

//var remote_sync_state = [['name', state, start, end], ...];

//define option list
var state_list = [[0, rsync.idle],[1,rsync.wait],[2,rsync.run]];

var stat_rsync = new webGrid();

function rsync_active(active) {
	var data = stat_rsync.getAllData();
	var cmd = '';
	var fom = E('_fom');
	var name = '';
	var i;
	var a = data[stat_rsync.selectedRowIndex - 1][0].split(".");

	for(i = 0; i < a.length - 1; i++) {
		if (i) name += '.';
		name += a[i];
	}
	cmd += "!\n"+(active?"":"no ")+"remote-sync "+name+" active\n!\n";

	E('_fom')._web_cmd.value = cmd;

	form.submit(fom, 1);
}

stat_rsync.footerButtonsSet = function(colNum){
		var r, c;

		this.footer = r = this.tb.insertRow(-1);
		r.className = 'controls';

		c = r.insertCell(0);
		c.colSpan = this.header.cells.length;

			if (this.canBeSelected)
				c.innerHTML =   '<input type=button style="width:100px" value=' + rsync.exec + ' onclick="rsync_active(1)" id="rsync-active">  '
								+'<input type=button style="width:100px" value=' + rsync.can + ' onclick="rsync_active(0)" id="rsync-noactive">  ';
	
		this.selectedColIndex = colNum;
		E('rsync-active').disabled = true;
		E('rsync-noactive').disabled = true;
	}

stat_rsync.onClick = function(cell) {
		if (this.canBeSelected){
			var q = PR(cell);
			this.selectedRowIndex = q.rowIndex;			
			this.recolor();
			var o = this.tb.rows[this.selectedRowIndex];
			o.className = 'selected';
			if (this.selectedColIndex != -1){
				E('rsync-active').disabled = false;
				E('rsync-noactive').disabled = false;
			}
			return;
		}
	}

function getLocalTime(nS) {     
   return new Date(parseInt(nS) * 1000).toLocaleString();//.replace(/:\d{1,2}$/,' ');     
} 

stat_rsync.loadData = function() {
	var i, a;
	
	for (i = 0; i < remote_sync_state.length; ++i) {
		a = remote_sync_state[i];
		if ((a[2] == 0) || (a[3] == 0))
			this.insertData(-1, [a[0]+'.rsync',state_list[a[1]][1], '----', ]);
		else
			this.insertData(-1, [a[0]+'.rsync',state_list[a[1]][1],getLocalTime(a[2])+ ' -- ' +getLocalTime(a[3])]);
	}

	stat_rsync.recolor();
	if (stat_rsync.selectedRowIndex > 0) {
		var o = stat_rsync.tb.rows[stat_rsync.selectedRowIndex];
		o.className = 'selected';
	}
}

stat_rsync.setup = function() {
	var i, a;

	this.init('stat_rsync-grid', ['readonly', 'select']);
	this.headerSet([rsync.task, ui.stat, rsync.time]);
	stat_rsync.loadData();
	if (user_info.priv >= admin_priv)
		stat_rsync.footerButtonsSet(0);
}

var ref = new webRefresh('status-remote-sync.jsx', '', 0, 'status_rsync_refresh');

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
	stat_rsync.removeAllData();
	stat_rsync.loadData();
}

function earlyInit()
{
	stat_rsync.setup();
	show();
}

function init()
{
	stat_rsync.recolor();
	ref.initPage(3000, 3);
}

</script>

</head>
<body onload='init()'>
<form id='_fom' method='post' action='apply.cgi'>
<input type='hidden' name='_web_cmd' value=''>
<form>

<div class='section'>
	<table class='web-grid' id='stat_rsync-grid'></table>
</div>

<div id='footer'>
	<script type='text/javascript'>genStdRefresh(1,0,'ref.toggle()');</script>
</div>
</form>

<script type='text/javascript'>earlyInit();</script>
</body>
</html>

