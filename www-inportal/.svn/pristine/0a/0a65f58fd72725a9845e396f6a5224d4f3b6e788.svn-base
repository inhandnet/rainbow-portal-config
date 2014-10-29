<% pagehead(menu.status_g8032) %>

<style type='text/css'>
#g8032-grid{
	Text-align: center;
	width: 800px;
}

#g8032-head{
	background: #e7e7e7;
}
</style>

<script type='text/javascript'>

<% ih_sysinfo() %>
<% ih_user_info(); %>


//var g8032_active_statistique=[[1, 1, 2, 0, [0,1,1,3], 0, [1,1,3,1], []],
//								[2, 1, 1, 0, [0,1,1,3], 0, [1,1,3,1], [1,1,4,0]]];
<% web_exec('show g8032 active') %>


var ring_types =['Undefined', raps.major_ring, raps.sub_no_vchan, raps.sub_with_vchan];
var node_types =[raps.normal_node, raps.owner_node, raps.neighbor_node, raps.next_neighbor_node, raps.interconnection, 'Undefined'];
var interconnection=[ui.noSel,ui.yesSel];
var node_current_status=[raps.idle, raps.prt, raps.man, raps.foc, raps.ped];
var ring_port_status=[raps.fwd, raps.blk];

/*****************JSON ID START**********************/
var jsIDIndex = 0;
var jsRingTypeIndex = 1;
var jsNodeTypeIndex = 2;
var jsInterconnectionIndex = 3;
var jsMajorRingIDIndex = 4;
var jsRPLPortIndex = 5;
var jsStatusIndex = 6;
var jsLPortIndex = 7;
var jsRPortIndex = 8;

/*****************JSON ID END**********************/



/**/
var ifNodeTypeIDNor = 0;
var ifNodeTypeIDOwn = 1;
var ifNodeTypeIDNeb = 2;
var ifNodeTypeIDNNeb = 3;
var ifNodeTypeIDIntCon = 4;
var ifNodeTypeIDUndef = 5;




function node_type_index(protocol_id)
{
	switch(protocol_id){
	case 1:
		return ifNodeTypeIDNor;
	case 2:
		return ifNodeTypeIDOwn;		
	case 4:
		return ifNodeTypeIDNeb;		
	case 8:
		return ifNodeTypeIDNNeb;				
	case 9:
		return ifNodeTypeIDIntCon;			
	default:
		return ifNodeTypeIDUndef;
	}
}



function get_instance_status(instance_status)
{	
	var tmp_ins_status =[];
	var port_name = "";
	var port_status = "";
	
	tmp_ins_status.push(instance_status[jsIDIndex]);//ID
	tmp_ins_status.push(ring_types[instance_status[jsRingTypeIndex]]);//Ring ID
	tmp_ins_status.push((instance_status[jsMajorRingIDIndex] == 0)?("--"):(instance_status[jsMajorRingIDIndex]));//major ring ID
	tmp_ins_status.push(node_types[node_type_index(instance_status[jsNodeTypeIndex])]);
//	tmp_ins_status.push(interconnection[instance_status[jsInterconnectionIndex]]);
	if (instance_status[jsRPLPortIndex].length <3)
		port_name = "--";
	else
		port_name = ((instance_status[jsRPLPortIndex][0]==2)?"GE":"FE")+ instance_status[jsRPLPortIndex][1] +"/"+ instance_status[jsRPLPortIndex][2];
	tmp_ins_status.push(port_name);
	tmp_ins_status.push(node_current_status[instance_status[jsStatusIndex]]);
	if (instance_status[jsLPortIndex].length <3){
		port_name = "--";
		port_status = "";
	}else{	
		port_name = ((instance_status[jsLPortIndex][0]==2)?"GE":"FE")+ instance_status[jsLPortIndex][1] +"/"+ instance_status[jsLPortIndex][2];
		port_status = "(" + ring_port_status[instance_status[jsLPortIndex][3]] + ")";
	}
	tmp_ins_status.push(port_name + port_status);
	if (instance_status[jsRPortIndex].length <3){
		port_name = "--";
		port_status = "";
	}else{	
		port_name = ((instance_status[jsRPortIndex][0]==2)?"GE":"FE")+ instance_status[jsRPortIndex][1] +"/"+ instance_status[jsRPortIndex][2];
		port_status = "(" + ring_port_status[instance_status[jsRPortIndex][3]] + ")";
	}
	tmp_ins_status.push(port_name + port_status);

	return tmp_ins_status;
}
var instance_tb = new webGrid();

instance_tb.loadData = function() 
{
	var instance_status = [];
	
	for(var i = 0; i < g8032_active_statistique.length; i++){
		if (g8032_active_statistique[i].length < 8)
			continue;
		instance_status = [];
		instance_status = get_instance_status(g8032_active_statistique[i]);
		this.insertData(-1, instance_status);
	}
}


instance_tb.setup = function() {
	this.init('g8032-grid', ['readonly'], 10, [
		{ type: 'text'},
		{ type: 'text'},
		{ type: 'text'},
	//	{ type: 'text'},
		{ type: 'text'},
		{ type: 'text'},
		{ type: 'text'},
		{ type: 'text'},
		{ type: 'text'}
	]);
	this.headerSet([
		g8032.sta_id, 
		g8032.sta_ring, 
		raps.majorID,
		g8032.sta_node, 
//		g8032.sta_connect, 
		g8032.sta_rpl, 
		g8032.sta_node_status,
		g8032.sta_lring_status, 
		g8032.sta_rring_status
	]);
	instance_tb.loadData();
}


var ref = new webRefresh('status-g8032.jsx', '', 0, 'status_g8032_refresh');

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
	instance_tb.removeAllData();
	instance_tb.loadData();
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
	<table class='web-grid' cellspacing=1 id='g8032-grid'></table>
	<script type='text/javascript'>instance_tb.setup();</script>
</div>

<div id='footer'>
	<script type='text/javascript'>genStdRefresh(1,0,'ref.toggle()');</script>
</div>
</form>
<script type='text/javascript'>earlyInit();</script>
</body>
</html>
