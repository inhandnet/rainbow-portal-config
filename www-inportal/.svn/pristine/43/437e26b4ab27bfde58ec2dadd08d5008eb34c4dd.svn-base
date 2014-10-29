<% pagehead(menu.status_rmon_history) %>
<style type='text/css'>
#status-grid {
	width: 1000px;
	text-align: center;
}

</style>

<script type='text/javascript'>
<% ih_sysinfo() %>
<% ih_user_info(); %>
var cli_cmd = "";
<% web_rmon_cmd() %>

var send_index = '<% cgi_get(send_index) %>';

function back()
{
	document.location = 'switch-rmon-history.jsp';	
}

var status = new webGrid();

status.loadData = function() {
	
	for (var i = 0; i < hist_single_config.length;i++) {
		if(hist_single_config[i][0] == send_index){
			for(var j=0;j<hist_single_config[i][6].length;++j){
				var tmp_data = [];
				//sample
				
				for (var k = 0; k <  hist_single_config[i][6][j].length; k++){
					tmp_data.push(hist_single_config[i][6][j][k]);
				}
				
/*
				//alert('i='+i+',j='+j+',value='+hist_single_config[i][6][j][0]);
				tmp_data[0] = hist_single_config[i][6][j][0];
				//tmp_data[0] = "abc";//hist_single_config[i][6][j][0].toString();
				//startTime
				tmp_data[1] = hist_single_config[i][6][j][1];
				//dropEvents
				tmp_data[2] = hist_single_config[i][6][j][2];
				//inOctets
				tmp_data[3] = hist_single_config[i][6][j][3];
				//inpkts
				tmp_data[4] = hist_single_config[i][6][j][4];
				//inBroadcasts
				tmp_data[5] = hist_single_config[i][6][j][5];
				//inMulticasts
				tmp_data[6] = hist_single_config[i][6][j][6];
				//crcAlign
				tmp_data[7] = hist_single_config[i][6][j][7];
				//undersizePkts
				tmp_data[8] = hist_single_config[i][6][j][8];
				//oversizePkts
				tmp_data[9] = hist_single_config[i][6][j][9];
				//fragments
				tmp_data[10] = hist_single_config[i][6][j][10];
				//jabbers
				tmp_data[11] = hist_single_config[i][6][j][11];
				//collisions
				tmp_data[12] = hist_single_config[i][6][j][12];
				//utilization
				tmp_data[13] = hist_single_config[i][6][j][13];
*/
				this.insertData(-1, tmp_data);
			}
			break;
		}
	}
}

status.setup = function() {
	var i, a;

	this.init('status-grid', ['readonly']);
	this.headerSet([rmon.sample,rmon.start_time,rmon.drop_events,rmon.in_octets,rmon.inPkts,rmon.in_broadcasts,rmon.in_multicasts,rmon.CRCAlignErrors,rmon.undersizePkts,
					rmon.oversize_pkts,rmon.fragments,rmon.jabbers,rmon.collisions,rmon.utilization]);
	status.loadData();
}

var ref = new webRefresh('status-rmon-history.jsx', 'send_cmd='+cli_cmd, 0, 'status_rmon_history_refresh');

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
	//show();
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
