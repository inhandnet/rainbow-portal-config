<% pagehead(menu.status_vrrp) %>

<style type='text/css'>
#vrrp-grid {
	text-align: center;
	width: 560px;
}

#vrrp-grid .co1{
	width: 120px;
}
#vrrp-grid .co3 {
	width: 100px;
}
#vrrp-grid .co4 {
	width: 60px;
}
</style>

<script type='text/javascript'>

<% ih_sysinfo(); %>
<% ih_user_info(); %>

var vrrp_status=[];
<% web_exec('show vrrp') %>
var vrrp_track_stat_list = [['0', '-'],['1', 'negative'],['2', 'positive']];
var vrrp_stat_list = [];
//vrrp_status = [['10', 'vlan 1', 'a' , 'b' , 'c' , 'd' ],['10', 'vlan 2', 'a' , 'b' , 'c' , 'd' ],['10', 'vlan 3', 'a' , 'b' , 'c' , 'd' ]]


var stat_vrrp = new webGrid();

stat_vrrp.loadData = function() {

	var vrrps = vrrp_status;
	for (var i = 0; i < vrrps.length; ++i) {		
		this.insertData(-1, [vrrps[i][0], vrrps[i][1], vrrps[i][2] , vrrps[i][3] , vrrp_track_stat_list[vrrps[i][4]][1]]);
	}
}

stat_vrrp.setup = function() {
	this.init('vrrp-grid', ['sort', 'readonly']);
	this.headerSet([vrrpd.vid, ui.iface, vrrpd.vrrp_status,  vrrpd.priority, vrrpd.track_status]);
	stat_vrrp.loadData();
}

var ref = new webRefresh('status-vrrp.jsx', '', 0, 'status_vrrp_refresh');

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
	stat_vrrp.removeAllData();
	stat_vrrp.loadData();
}

function earlyInit()
{
	stat_vrrp.setup();
	show();
}

function init()
{
	stat_vrrp.recolor();
	ref.initPage(3000, 3);
}
</script>
</head>
<body onload='init()'>
<form id='_fom' method='post' action='apply.cgi'>
<input type='hidden' name='_web_cmd' value=''>

<div class='section'>
	<table class='web-grid' id='vrrp-grid'></table>
</div>
<div id='footer'>
	<script type='text/javascript'>genStdRefresh(1,0,'ref.toggle()');</script>
</div>
</form>
<script type='text/javascript'>earlyInit()</script>
</body>
</html>

