<% pagehead(menu.status_interfacesstatus_interfaces) %>
<style type='text/css'>
#intf-grid {
	width: 800px;	
	text-align: center;
}

</style>

<script type='text/javascript'>
<% ih_sysinfo() %>
<% ih_user_info(); %>
/*
var spanning_tree_port_active_statistique=[[[1,1,1],1,3,45,0,0,46,0,0],
											[[1,1,2],0,3,45,0,0,46,0,0],
											[[1,1,3],0,3,45,0,0,46,0,0],
											[[1,1,4],1,3,45,0,0,46,0,0],
											[[1,1,5],0,3,45,0,0,46,0,0],
											[[1,1,6],0,3,45,0,0,46,0,0],
											[[1,1,7],0,3,45,0,0,46,0,0],
											[[1,1,8],1,3,45,0,0,46,0,0],
											[[2,1,1],0,3,45,0,0,46,0,0],
											[[2,1,2],0,3,45,0,0,46,0,0]
											];
*/
var spanning_tree_port_active_statistique = [];
<% web_exec('show spanning active') %>

<% web_exec('show running-config interface') %>
/*
	port_config = [[1,1,1,1,3,2,1,0,0,0,0,0,0,0,0,0,1,0,0,0,'',0],
						[1,1,2,1,3,2,1,0,0,0,0,0,0,0,0,0,1,0,0,0,'',1],
						[1,1,3,1,3,2,1,0,0,0,0,0,0,0,0,0,1,0,0,0,'',0],
						[1,1,4,1,3,2,1,0,0,0,0,0,0,0,0,0,1,0,0,0,'',0],
						[1,1,5,1,3,2,1,0,0,0,0,0,0,0,0,0,1,0,0,0,'',0],
						[1,1,6,1,3,2,1,0,0,0,0,0,0,0,0,0,1,0,0,0,'',0],
						[1,1,7,1,3,2,1,0,0,0,0,0,0,0,0,0,1,0,0,0,'',0],
						[1,1,8,1,3,2,1,0,0,0,0,0,0,0,0,0,1,0,0,0,'',0],
						[2,1,1,1,3,2,1,0,0,0,0,0,0,0,0,0,100,0,0,0,'',0],
						[2,1,2,1,3,2,1,0,0,0,0,0,0,0,0,0,100,0,0,0,'',0]];

*/
if (spanning_tree_port_active_statistique.length == 0){
	for (var i = 0; i < port_config.length; i++){
		spanning_tree_port_active_statistique.push(
			[[port_config[i][0],port_config[i][1],port_config[i][2]],
			0,3,'--', 0,0,0,0,0,0]);
	}
}


var rstp_port_states = [
	'LINK-DOWN',
 	'DISCARDING',
	'LEARNING',
	'FORWARDING',
	'DISABLED'];
var port_title_list = [];
var port_cmd_list = [];
for(var i=0;i<spanning_tree_port_active_statistique.length;i++){
	if(spanning_tree_port_active_statistique[i][0][0] == 1){
		port_cmd_list.push("fastethernet "
				+ spanning_tree_port_active_statistique[i][0][1] 
				+ "/" 
				+ spanning_tree_port_active_statistique[i][0][2]);
		port_title_list.push("FE"
				+ spanning_tree_port_active_statistique[i][0][1] 
				+ "/" 
				+ spanning_tree_port_active_statistique[i][0][2]);
	}else if(spanning_tree_port_active_statistique[i][0][0] == 2){
		port_cmd_list.push("gigabitethernet "
				+ spanning_tree_port_active_statistique[i][0][1] 
				+ "/" 
				+ spanning_tree_port_active_statistique[i][0][2]);
		port_title_list.push("GE"
				+ spanning_tree_port_active_statistique[i][0][1] 
				+ "/" 
				+ spanning_tree_port_active_statistique[i][0][2]);
	}

}



var intf = new webGrid();

intf.loadData = function() {
	var port_data = [];
	var now_status = [];
	
	now_status =spanning_tree_port_active_statistique;

	for (var i = 0; i < now_status.length; ++i) {
		port_data = [];
		port_data.push(port_title_list[i]);//port name
		port_data.push(['Disabled','Enabled'][now_status[i][1]]);//protocol
		port_data.push(rstp_port_states[now_status[i][2]]);//states

		port_data.push(now_status[i][3]);//role
		
		port_data.push(now_status[i][4]);//rx rsts
		port_data.push(now_status[i][7]);//tx rsts
		
		port_data.push(now_status[i][5]);//rx configs
		port_data.push(now_status[i][8]);//tx configs
		
		port_data.push(now_status[i][6]);//rx tcn		
		port_data.push(now_status[i][9]);//tx tcn

		this.insertData(-1, port_data);
	}
}

intf.onClick = function(cell) 
{
	var q = PR(cell);
	var port_index = q.rowIndex - 1;
	var rstp_port_detail_cmd = "";

	//alert("onClick: rowIndex = "+ q.rowIndex +"\n");
	if (spanning_tree_port_active_statistique[port_index][1] == 0)
		return;
	
	rstp_port_detail_cmd = "show spanning interface " + port_cmd_list[port_index];
	
	E('_rstp_detail_cmd').value = rstp_port_detail_cmd;
	E('_rstp_index').value = port_index;
	E('_detail').submit();	
}


intf.setup = function() {
	var i, a;
	var header_title = [rstp.st_port,rstp.st_protocol,rstp.st_status, rstp.st_role, rstp.st_rxrst,rstp.st_txrst,rstp.st_rconf,rstp.st_tconf,rstp.st_rtcn,rstp.st_ttcn];

	this.init('intf-grid', ['sort', 'readonly'], 80, [
		{ type: 'text'},
		{ type: 'text'},
		{ type: 'text'},
		{ type: 'text'},
		{ type: 'text'},
		{ type: 'text'},
		{ type: 'text'},
		{ type: 'text'},
		{ type: 'text'},
		{ type: 'text'}
	]);
	this.headerSet(header_title);
	intf.loadData();
}



var ref = new webRefresh('status-port-rstp.jsx', '', 0, 'status_port_rstp_refresh');

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
	intf.removeAllData();
	intf.loadData();
}

function earlyInit()
{
	intf.setup();
	//show();
}

function init()
{
	intf.recolor();
	ref.initPage(3000, 0);
}

</script>

</head>
<body onload='init()'>
<form id='_detail' method='post' action='status-port-rstp-detail.jsp'>
<input type='hidden' name='rstp_detail_cmd' id='_rstp_detail_cmd'/>
<input type='hidden' name='rstp_index' id='_rstp_index'/>
</form>

<form>
<div class='section'>
	<table class='web-grid' id='intf-grid'></table>
</div>

<div id='footer'>
	<script type='text/javascript'>genStdRefresh(1,0,'ref.toggle()');</script>
</div>
</form>

<script type='text/javascript'>earlyInit();</script>
</body>
</html>
