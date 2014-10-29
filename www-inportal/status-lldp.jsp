<% pagehead(menu.status_g8032) %>

<style type='text/css'>
#lldp-grid{
	Text-align: center;
	width: 1050px;
}

#lldp-head{
	background: #e7e7e7;
}
</style>

<script type='text/javascript'>

<% ih_sysinfo() %>
<% ih_user_info(); %>



//var lldp_neighbor_statistique=[[[1,1,3],'QjJhheha','00 26 55 3a 68 b1', '50','HP28851318471', 'x86 Family 6 Model 23 Stepping 10','Realtek RTL8168C(P)/8111C(P)','statioin','10.5.1.242']];
<% web_exec('show lldp neighbor') %>


var notused;

var lldp_tb = new webGrid();

lldp_tb.loadData = function() 
{
	var lldp_neighbor_ins = [];
	for(var i = 0; i < lldp_neighbor_statistique.length; i++){
		lldp_neighbor_ins = lldp_neighbor_statistique[i];
		if(lldp_neighbor_statistique[i][0][0] == 1)
			lldp_neighbor_ins[0] = "FE"+ lldp_neighbor_statistique[i][0][1] +"/"+lldp_neighbor_statistique[i][0][2];
		else if(lldp_neighbor_statistique[i][0][0] == 2)
			lldp_neighbor_ins[0] = "GE"+ lldp_neighbor_statistique[i][0][1] +"/"+lldp_neighbor_statistique[i][0][2];
		else
			lldp_neighbor_ins[0] = "Undefined";
		
		this.insertData(-1, lldp_neighbor_ins);
	}

}


lldp_tb.setup = function() {
	this.init('lldp-grid', ['readonly'], 100, [
		{ type: 'text'},
		{ type: 'text'},
		{ type: 'text'},
		{ type: 'text'},
		{ type: 'text'},
		{ type: 'text'},
		{ type: 'text'},
		{ type: 'text'}
	]);



	this.headerSet([
		port.port,
		lldp.chassis,
		lldp.port_id,
		//lldp.ttl,
		lldp.port_des,
		lldp.sys_name,
		lldp.sys_des,		
		lldp.sys_cap,
		lldp.ip
	]);
	lldp_tb.loadData();
}


var ref = new webRefresh('status-lldp.jsx', '', 0, 'status_lldp_refresh');

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
	lldp_tb.removeAllData();
	lldp_tb.loadData();
}


function earlyInit()
{
}

function init()
{
	//instance_tb.recolor();
	ref.initPage(3000, 0);
}

</script>
</head>
<body onload='init()'>
<form id='_fom' method='post' action='apply.cgi'>

<div class='section'>
	<table class='web-grid' cellspacing=1 id='lldp-grid'></table>
	<script type='text/javascript'>lldp_tb.setup();</script>
</div>

<div id='footer'>
	<script type='text/javascript'>genStdRefresh(1,0,'ref.toggle()');</script>
</div>

</form>
<script type='text/javascript'>earlyInit();</script>
</body>
</html>
