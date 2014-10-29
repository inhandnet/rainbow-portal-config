<% pagehead(menu.status_interfaces) %>

<style type='text/css'>
#layout-grid {
	text-align: center;
}

</style>

<script type='text/javascript'>

<% ih_sysinfo() %>
<% ih_user_info() %>

<% web_exec('show interface statistics') %>

//ports_stats=[[1,1,1,'00000000000000000000','00000000000000000000','0000000000','0000000000','0000000000','0000000000','0000000000','0000000000','0000000000'],[1,1,2,'00000000000000000000','00000000000000000000','0000000000','0000000000','0000000000','0000000000','0000000000','0000000000','0000000000'],[1,1,3,'00000000000007880375','00000000000022236570','0000000000','0000022749','0000029403','0000003049','0000000003','0000004751','0000000003'],[1,1,4,'00000000000000000000','00000000000000000000','0000000000','0000000000','0000000000','0000000000','0000000000','0000000000','0000000000'],[1,1,5,'00000000000000000000','00000000000000000000','0000000000','0000000000','0000000000','0000000000','0000000000','0000000000','0000000000'],[1,1,6,'00000000000000000000','00000000000000000000','0000000000','0000000000','0000000000','0000000000','0000000000','0000000000','0000000000'],[1,1,7,'00000000000000000000','00000000000000000000','0000000000','0000000000','0000000000','0000000000','0000000000','0000000000','0000000000'],[1,1,8,'00000000000000000000','00000000000000000000','0000000000','0000000000','0000000000','0000000000','0000000000','0000000000','0000000000'],[2,1,1,'00000000000000000000','00000000000000000000','0000000000','0000000000','0000000000','0000000000','0000000000','0000000000','0000000000'],[2,1,2,'00000000000000000000','00000000000000000000','0000000000','0000000000','0000000000','0000000000','0000000000','0000000000','0000000000']];

<% web_exec('show running-config interface') %>
//var port_config=[['1','1','1',1,3,2,1,0,0,0,0,0,0,1,0,0,0,'abc1,23'],['1','1','2',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],['1','1','3',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],['1','1','4',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],['1','1','5',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],['1','1','6',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],['1','1','7',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],['1','1','8',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],['2','1','1',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],['2','1','2',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],['2','1','3',1,3,2,1,0,0,0,0,0,0,1,0,0,0,'']];

var port_type = ['undefine','FE','GE'];
var port_title_list = [];
var port_cmd_list = [];
/*
for(var i=0;i<ports_stats.length;++i){
	if(ports_stats[i][0] == '1')
		port_title_list.push("FE"+ports_stats[i][1]+"/"+ports_stats[i][2]);
	else 
		port_title_list.push("GE"+ports_stats[i][1]+"/"+ports_stats[i][2]);
}
*/

function getPortTitle(portId)
{
	if (portId.length < 3)
		return "";

	for (var i = 0; i < port_config.length; i++){
		if ((portId[0] == parseInt(port_config[i][0], 10))
			&& (portId[1] == parseInt(port_config[i][1], 10))
			&& (portId[2] == parseInt(port_config[i][2], 10)))
			return port_title_list[i];
	}

	return "";
}

function getPortCmdbyName(portName)
{
	for (var i = 0; i < port_title_list.length; i++){
		if (portName == port_title_list[i])
			return port_cmd_list[i];
	}

	return "";
}


for(var i=0;i<port_config.length;++i){

	if(port_config[i][0] == 1){
		port_cmd_list.push("fastethernet "+ port_config[i][1] + "/" + port_config[i][2]);
		port_title_list.push("FE"+ port_config[i][1] + "/" + port_config[i][2]);
	}else if(port_config[i][0] == 2){
		port_cmd_list.push("gigabitethernet "+ port_config[i][1] + "/" + port_config[i][2]);
		port_title_list.push("GE"+ port_config[i][1] + "/" + port_config[i][2]);
	}
}

var port_grid = new webGrid();

port_grid.dataToView = function(data) {
	return data;
}

port_grid.verifyFields = function(row, quiet) {
	return 1;
}

port_grid.onClick = function(cell) {
	var cmd = "";
	
	var interface_id = PR(cell).getRowData()[0];

	var port_cmd = getPortCmdbyName(interface_id);

	if (port_cmd == "") return;

	cmd = "show interface "+port_cmd+" statistics";
	/*
	if(interface_id[0] == 'F')
		port_cmd_list.push("show interface fastethernet "+interface_id[2]+interface_id[3]+interface_id[4]+" statistics");
	else
		port_cmd_list.push("show interface gigabitethernet "+interface_id[2]+interface_id[3]+interface_id[4]+" statistics");
	*/
	E('_interface_id').value = cmd;
	E('_fom').submit();

}

port_grid.setup = function() {
	this.init('layout-grid', ['readonly'], 4, [
		{ type: 'text', maxlen: 64 }, 
		{ type: 'text', maxlen: 64 }, 
		{ type: 'text', maxlen: 64 },
		{ type: 'text', maxlen: 64 }, 
		{ type: 'text', maxlen: 64 }, 
		{ type: 'text', maxlen: 64 }, 
		{ type: 'text', maxlen: 64 }, 
		{ type: 'text', maxlen: 64 }, 
		{ type: 'text', maxlen: 64 }, 
		{ type: 'text', maxlen: 64 }
		
		]);
	this.headerSet([ port.port, portstatus.inoctets, portstatus.outoctets, portstatus.indiscard,
		portstatus.inunicasts,portstatus.outunicasts,portstatus.inmcast,portstatus.outmcast,portstatus.inbroad,portstatus.outbroad]);	
}

var ref = new webRefresh('status-interfaces-statistics.jsx', '', 0, 'status_interfaces_refresh');

ref.refresh = function(text)
{
	try {
		eval(text);
	}
	catch (ex) {
		;
	}
	update();
}




function update()
{
	var n = 0;			
	var tmp_old_config = [];			
	port_grid.removeAllData();
	var tmp_port_id = [1, 1 ,1];
	for (var i = 0; i < ports_stats.length; ++i) {		
			tmp_old_config[i] = [];
			//port title
			//tmp_old_config[i][0] = port_title_list[i];

			tmp_port_id[0] = ports_stats[i][0];
			tmp_port_id[1] = ports_stats[i][1];
			tmp_port_id[2] = ports_stats[i][2];
			
			tmp_old_config[i][0] = getPortTitle(tmp_port_id);//port_title_list[i];
			for(var j=3;j<ports_stats[i].length;++j){
				tmp_old_config[i][j-2] = ports_stats[i][j].toString();
			}
						
//			var img = '<img border=0 src="images/green' + '.gif"/>';

			port_grid.insertData(-1, tmp_old_config[i]);
	
	}
	
}


function verifyFields(focused, quiet)
{
	return 1;
}

function save()
{
	return;
}

function earlyInit()
{
	port_grid.setup();
	update();
}

function init()
{
	ref.initPage(5000, 0);
	verifyFields(null, 1);
}
</script>

</head>
<body onload="init()">
<form id='_fom' method='post' action='status-port-detailed.jsp'>
<input type='hidden' name='interface_id' id='_interface_id'/>

<!--
<div id='_port_grid_title' class='section-title'></div>
-->
<div id='_port_grid' class='section'>
	<table class='web-grid' id='layout-grid'></table>	
</div>
<div id='footer'>
	<script type='text/javascript'>genStdRefresh(1,5,'ref.toggle()');</script>
</div>

<script type='text/javascript'>earlyInit()</script>
</form>
</body>
</html>
