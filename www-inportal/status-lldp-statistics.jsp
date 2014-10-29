<% pagehead(menu.status_lldp_sta) %>
<style type='text/css'>
#br-grid {
	width: 400px;	
}


</style>

<script type='text/javascript'>
<% ih_sysinfo() %>
<% ih_user_info(); %>

<% web_exec('show lldp statistic') %>

var unused;
var port_name = "";


var port_index = 0;
var discarded_index = 1;
var rx_errors_index = 2;
var rx_total_index = 3;
var tx_total_index = 4;
var rx_ageouts__index = 5;
var rx_tlv_index = 6;





var lldp_statistics_status = new webGrid();

lldp_statistics_status.loadData = function() {
	var lldp_port_sta = [];
	for(var i = 0; i < lldp_statistics.length; i++){
		lldp_port_sta = [];
		
		if (lldp_statistics[i][port_index].length == 3){
			if (lldp_statistics[i][port_index][0] == 1){
				port_name = "FE"+lldp_statistics[i][port_index][1]+
							"/"+lldp_statistics[i][port_index][2];
			
			}else if (lldp_statistics[i][port_index][0] == 2){
				port_name = "GE"+lldp_statistics[i][port_index][1]+
								"/"+lldp_statistics[i][port_index][2];
			}else
				port_name = "Undefined";
		}else{
				port_name = "--";
		}

		lldp_port_sta.push(port_name);
		lldp_port_sta.push(lldp_statistics[i][discarded_index].toString());
		lldp_port_sta.push(lldp_statistics[i][rx_errors_index].toString());
		lldp_port_sta.push(lldp_statistics[i][rx_total_index].toString());
		lldp_port_sta.push(lldp_statistics[i][tx_total_index].toString());
		lldp_port_sta.push(lldp_statistics[i][rx_ageouts__index].toString());
		lldp_port_sta.push(lldp_statistics[i][rx_tlv_index].toString());
		
		this.insertData(-1, lldp_port_sta);
	}
	
	
}


lldp_statistics_status.setup = function() {
	this.init('br-grid', ['readonly'], 20, [
		{ type: 'text', maxlen: 64 },
		{ type: 'text', maxlen: 64 },
		{ type: 'text', maxlen: 64 },
		{ type: 'text', maxlen: 64 },
		{ type: 'text', maxlen: 64 },
		{ type: 'text', maxlen: 64 },
		{ type: 'text', maxlen: 64 }
	]);
	this.headerSet([ui.prt, lldp.dt, lldp.re, lldp.rt, lldp.tt, lldp.ra, lldp.rd]);
	lldp_statistics_status.loadData();
}

var ref = new webRefresh('status-lldp-statistics.jsx', '', 0, 'status_lldp_statistics_refresh');

ref.refresh = function(text)
{
	lldp_statistics = [];
	try {
		eval(text);
	}
	catch (ex) {
		lldp_statistics = [];
	}
	show();
}



function show()
{	
	lldp_statistics_status.removeAllData();
	lldp_statistics_status.loadData();
}

function earlyInit()
{
	lldp_statistics_status.setup();
	//show();
}

function init()
{
	lldp_statistics_status.recolor();
	ref.initPage(3000, 0);
}



</script>

</head>
<body onload='init()'>
<form>

<div class='section'>
	<table class='web-grid' id='br-grid'></table>
</div>

<div id='footer'>
	<script type='text/javascript'>genStdRefresh(1,0,'ref.toggle()');</script>
</div>
</form>

<script type='text/javascript'>earlyInit();</script>
</body>
</html>

