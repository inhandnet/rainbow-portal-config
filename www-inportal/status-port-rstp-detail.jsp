<% pagehead(menu.status_interfaces) %>
<style type='text/css'>
#status-grid {
	text-align: center;
}
#back_line{
	background: #e7e7e7;
	Text-align: left;
}
#value_unit{
	Text-align: center;
}

#port-grid{
	width: 600px;
} 

#port-detail{
	width: 400px;
}
#port-detail.co1{
	width: 200px;
	Text-align: left;
}
#port-detail.co2{
	width: 200px;
	Text-align: center;
}

</style>

<script type='text/javascript'>
<% ih_sysinfo() %>
<% ih_user_info(); %>
/*
var spanning_tree_port_statistique=[
		[1,1,2],
		0,
		64,
		[0,20000],
		[0,1],
		[0,1],
		['A', "20480-000fe24c3644", 13892, 18, 128],
		3,
		45,
		0,
		0,
		46,
		0,
		0
];
*/
var spanning_tree_port_statistique= [];
<% web_rstp_port() %>
//var send_index = '<% cgi_get("rstp_index") %>';

var port_title = "";
var port_cmd = "";
var port_stp = 0;
var port_stp_str = "";
var port_pri = 0;
var role_str = "";
var dest_br_id = "";
var dest_cost = "";
var dest_port_id = "";
var dest_port_prio = "";
var config_cost = "";
var active_cost = 0; 
var config_p2p = "";
var active_p2p = ""; 
var config_edge = 0;
var active_edge = 0; 
var opers = ['False', 'True'];
var rstp_port_states = ['LINK-DOWN', 'DISCARDING',	'LEARNING', 'FORWARDING', 'DISABLED'];
var port_states = 0;
var rx_rsts = 0;
var tx_rsts = 0;
var rx_configs = 0;
var tx_configs = 0;
var rx_tcns = 0;
var tx_tcns = 0;
var bpdu_guard = '';
//function load_data()
function myload_data()
{
	if ((spanning_tree_port_statistique.length > 0)
		&& (spanning_tree_port_statistique[0].length == 3)){
		if (spanning_tree_port_statistique[0][0] == 1){
			port_title = "FE"+spanning_tree_port_statistique[0][1]+"/"+spanning_tree_port_statistique[0][2];
			port_cmd = "fastethernet "+spanning_tree_port_statistique[0][1]+"/"+spanning_tree_port_statistique[0][2];
		}else if(spanning_tree_port_statistique[0][0] == 2){
			port_title = "GE"+spanning_tree_port_statistique[0][1]+"/"+spanning_tree_port_statistique[0][2];
			port_cmd = "gigabitethernet "+spanning_tree_port_statistique[0][1]+"/"+spanning_tree_port_statistique[0][2];
		}
	}
	
	if (spanning_tree_port_statistique.length > 1){
		port_stp_str = (spanning_tree_port_statistique[1])? ("Disabled"):("Enabled");
	}
	
	if (spanning_tree_port_statistique.length > 2){
		port_pri = spanning_tree_port_statistique[2];
	}

	if (spanning_tree_port_statistique.length > 6){
		if (spanning_tree_port_statistique[6].length > 0){
			switch(spanning_tree_port_statistique[6][0]){
				case 'A':role_str = "Alternate";break;
				case 'B':role_str = "Backup";break;
				case 'D':role_str = "Designated";break;
				case 'R':role_str = "Root";break;
				defaule:role_str = "NonStp";break;
			}
			if (spanning_tree_port_statistique[6].length > 1){
				dest_br_id = ""+spanning_tree_port_statistique[6][1];
				dest_cost = ""+spanning_tree_port_statistique[6][2];
				dest_port_id = ""+spanning_tree_port_statistique[6][3];
				dest_port_prio = ""+spanning_tree_port_statistique[6][4];
			}else{
				dest_br_id = "--";
				dest_cost = "--";
				dest_port_id = "--";
				dest_port_prio = "--";
			}			
		}else{
			role_str = "--";
			dest_br_id = "--";
			dest_cost = "--";
			dest_port_id = "--";
			dest_port_prio = "--";
		}
		

		
	}

	if(spanning_tree_port_statistique.length > 3){
		if (spanning_tree_port_statistique[3].length == 2){
			if (spanning_tree_port_statistique[3][0] > 0)
				config_cost = ""+spanning_tree_port_statistique[3][0];
			else
				config_cost = "Auto";
			active_cost = spanning_tree_port_statistique[3][1];
		}
	}
	if(spanning_tree_port_statistique.length > 4){
		if (spanning_tree_port_statistique[4].length == 2){
			switch(spanning_tree_port_statistique[4][0]){
				case 0: config_p2p = "Force False"; break;
				case 1: config_p2p = "Force True"; break;
				default: config_p2p = "Auto"; break;
			}
			switch(spanning_tree_port_statistique[4][1]){
				case 0: active_p2p = "False"+((config_p2p == "(Auto)")?(config_p2p):("")); break;
				default: active_p2p = "True"+((config_p2p == "(Auto)")?(config_p2p):("")); break;
			}
		}
	}
	if(spanning_tree_port_statistique.length > 5){
		if (spanning_tree_port_statistique[5].length == 2){
			config_edge = spanning_tree_port_statistique[5][0];
			active_edge = spanning_tree_port_statistique[5][1];
		}
	}

	if (spanning_tree_port_statistique.length > 7){
		port_states = spanning_tree_port_statistique[7];
	}
	if (spanning_tree_port_statistique.length >= 13){
		rx_rsts = spanning_tree_port_statistique[8];
		tx_rsts = spanning_tree_port_statistique[11];
		rx_configs = spanning_tree_port_statistique[9];
		tx_configs = spanning_tree_port_statistique[12];
		rx_tcns = spanning_tree_port_statistique[10];
		tx_tcns = spanning_tree_port_statistique[13];
	}

	if (spanning_tree_port_statistique.length >= 14){
		bpdu_guard = spanning_tree_port_statistique[14]; 
	}
}

myload_data();//for port_cmd

var port_detail = new webGrid();

port_detail.loadData = function() 
{
	myload_data();

	this.insertData(-1, [rstp.st_port+":",  ""+port_title]);
	this.insertData(-1, [rstp.st_protocol+":", ""+port_stp_str ]);
	this.insertData(-1, [rstp.st_status+":",  ""+rstp_port_states[port_states] ]);
	this.insertData(-1, [rstp.st_prio+":", ""+port_pri]);
	this.insertData(-1, [rstp.st_rxrst+":", ""+rx_rsts ]);
	this.insertData(-1, [rstp.st_txrst+":", ""+tx_rsts ]);
	this.insertData(-1, [rstp.st_rconf+":", ""+rx_configs ]);
	this.insertData(-1, [rstp.st_tconf+":", ""+tx_configs ]);
	this.insertData(-1, [rstp.st_rtcn+":", ""+rx_tcns]);
	this.insertData(-1, [rstp.st_ttcn+":", ""+tx_tcns ]);
	this.insertData(-1, [rstp.st_role+":", ""+role_str ]);
	this.insertData(-1, [rstp.st_dst_br+":", ""+dest_br_id ]);
	this.insertData(-1, [rstp.st_dst_cost+":", ""+dest_cost ]);
	this.insertData(-1, [rstp.st_dst_port+":", ""+dest_port_id ]);
	this.insertData(-1, [rstp.st_dst_prio+":", ""+dest_port_prio ]);
	this.insertData(-1, [rstp.st_conf_cost+":", ""+config_cost ]);
	this.insertData(-1, [rstp.st_active_cost+":", ""+active_cost ]);
	this.insertData(-1, [rstp.st_conf_p2p+":", ""+config_p2p ]);
	this.insertData(-1, [rstp.st_active_p2p+":", ""+active_p2p]);
	this.insertData(-1, [rstp.st_conf_edge+":", ""+opers[config_edge] ]);
	this.insertData(-1, [rstp.st_active_edge+":", ""+opers[active_edge] ]);
	this.insertData(-1, [rstp.guard+":", ""+bpdu_guard ]);

	spanning_tree_port_statistique = [];//for test

}


port_detail.setup = function() {
	this.init('port-detail', ['readonly'], 25, [
		{ type: 'text', maxlen: 64, id:'port-detail.co1' },
		{ type: 'text', maxlen: 64, id:'port-detail.co2' }
	]);
	port_detail.loadData();
}


function back()
{
	document.location = 'status-port-rstp.jsp';	
}



var ref = new webRefresh('status-port-rstp-detail.jsx', 'rstp_detail_cmd=show spanning interface '+port_cmd, 0, 'status_port_rstp_detail_refresh');

ref.refresh = function(text)
{
//	stats = {};
	try {
		eval(text);
	}
	catch (ex) {
//		stats = {};
		;
	}
	show();
}

function show()
{	
	//alert(spanning_tree_port_statistique.length);
	port_detail.removeAllData();
	port_detail.loadData();
}

function earlyInit()
{
	port_detail.setup();
//	show();
}

function init()
{
	port_detail.recolor();
	ref.initPage(3000, 0);
}

</script>

</head>

<body onload='init()'>
<form>

<div class='section'>
	<table class='web-grid' id='port-detail'></table>
</div>

<div id='footer'>
	<script type='text/javascript'>genStdRefresh(1,0,'ref.toggle()');</script>
</div>
</form>


<script>
W("</div>");		
W("<div id='footer'>");
W("<span id='footer-msg'></span>");
W("<input type='button' value='" + ui.bk + "' id='back-button' onclick='back();'/>");	
W("</div>");
</script>

<script type='text/javascript'>earlyInit();</script>

</body>
</html>
