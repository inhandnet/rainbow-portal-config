<% pagehead(menu.status_stp) %>
<style type='text/css'>
#br-grid {
	width: 400px;	
}
#br-grid .co1{
	width: 200px;	
	text-align: left;
}
#br-grid.co2 {
	width: 200px;	
	text-align: center;
}
</style>

<script type='text/javascript'>
<% ih_sysinfo() %>
<% ih_user_info(); %>

//var spanning_tree_statistique=[0, "32768/00-10-a7-96-10-09", [[1,1,5],128,201380], "32768/00-10-a7-96-10-09", 20, 2, 15, 6, 0, 46];
//var spanning_tree_statistique=[0, "32768/00-10-a7-96-10-09", [], "32768/00-10-a7-96-10-09", 20, 2, 15, 6, 0, 46];

//var spanning_tree_statistique=[0, "32768/00-10-a7-96-10-09", [[1,1,5],128,201380], "root bridge","32768/00-10-a7-96-10-09", 0, "0 day 12:12:12", 6, 20, 2, 15, 40, 10, 30 ];

<% web_exec('show spanning detail') %>

var unused;
var root_id="";
var root_port="";
var root_path_prio = "";
var root_path_cost = "";


var state_index = 0;
//var root_id_index = 1;
var root_port_index = 1;
var bridge_role_index = 2;
var bridge_id_index = 3;
var tc_count_index = 4;
var last_tc_time_index = 5;
var tx_cnt_index = 6;
var cfg_max_index = 7;
var cfg_hello_index = 8;
var cfg_fwd_index = 9;
var learned_max_index = 10;
var learned_hello_index = 11;
var learned_fwd_index = 12;

var root_id_index = 0;
var root_port_name_index = 1;
var root_port_pri_index = 2;
var root_port_cost_index = 3;


var br_status = new webGrid();

br_status.loadData = function() {
	if ((spanning_tree_statistique.length > root_port_index)){
		if(spanning_tree_statistique[root_port_index].length > root_port_cost_index){
			//root_id
			root_id = spanning_tree_statistique[root_port_index][root_id_index];
			//root_port
			if (spanning_tree_statistique[root_port_index][root_port_name_index].length == 3){
				if (spanning_tree_statistique[root_port_index][root_port_name_index][0] == 1){
					root_port = "FE"+spanning_tree_statistique[root_port_index][root_port_name_index][1]+
									"/"+spanning_tree_statistique[root_port_index][root_port_name_index][2];
				}else if (spanning_tree_statistique[root_port_index][root_port_name_index][0] == 2){
					root_port = "GE"+spanning_tree_statistique[root_port_index][root_port_name_index][1]+
									"/"+spanning_tree_statistique[root_port_index][root_port_name_index][2];
				}else
					root_port = "Undefined";
			}else{
					root_port = "--";
			}
			//root_path_pri
			root_path_prio = "" + spanning_tree_statistique[root_port_index][root_port_pri_index];
			//root_path_cost
			root_path_cost = "" + spanning_tree_statistique[root_port_index][root_port_cost_index];
		}else{
			root_id = "--";
			root_port = "--";
			root_path_prio = "--";
			root_path_cost = "--";
		}
	}
	
	this.insertData(-1, [rstp.st_br_status, ""+spanning_tree_statistique[bridge_role_index]]);
	this.insertData(-1, [rstp.st_br_id, ""+spanning_tree_statistique[bridge_id_index]]);
	this.insertData(-1, [rstp.st_rootid, ""+root_id]);
	this.insertData(-1, [rstp.st_root_port, ""+root_port]);
	this.insertData(-1, [rstp.st_root_path_pri, ""+root_path_prio]);
	this.insertData(-1, [rstp.st_root_path_cost, ""+root_path_cost]);

	this.insertData(-1, [rstp.st_hell_time, ""+spanning_tree_statistique[cfg_hello_index]]);
	this.insertData(-1, [rstp.st_hell_time_learned, ""+spanning_tree_statistique[learned_hello_index]]);
	this.insertData(-1, [rstp.st_fw_delay, ""+spanning_tree_statistique[cfg_fwd_index]]);
	this.insertData(-1, [rstp.st_fw_delay_learned, ""+spanning_tree_statistique[learned_fwd_index]]);
	this.insertData(-1, [rstp.st_max_age, ""+spanning_tree_statistique[cfg_max_index]]);
	this.insertData(-1, [rstp.st_max_age_learned, ""+spanning_tree_statistique[learned_max_index]]);
		
	this.insertData(-1, [rstp.st_tc_count, ""+spanning_tree_statistique[tc_count_index]]);
	this.insertData(-1, [rstp.st_tc_time, ""+spanning_tree_statistique[last_tc_time_index]]);	
//	this.insertData(-1, [rstp.st_tx_cnt, ""+spanning_tree_statistique[tx_cnt_index]]);		
}


br_status.setup = function() {
	this.init('br-grid', ['readonly'], 20, [
		{ type: 'text', maxlen: 64 },
		{ type: 'text', maxlen: 64 }
	]);
	//this.headerSet([ui.vlan_id,ui.nam]);
	br_status.loadData();
}

var ref = new webRefresh('status-bridge-rstp.jsx', '', 0, 'status_bridge_rstp_refresh');

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
	br_status.removeAllData();
	br_status.loadData();
}

function earlyInit()
{
	br_status.setup();
	//show();
}

function init()
{
	br_status.recolor();
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
