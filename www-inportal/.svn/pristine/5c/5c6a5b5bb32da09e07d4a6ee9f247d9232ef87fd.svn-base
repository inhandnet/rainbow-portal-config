<% pagehead(menu.status_interfaces) %>
<style type='text/css'>
#intf-grid {
	width: 500px;	
	text-align: left;
}

</style>

<script type='text/javascript'>
<% ih_sysinfo() %>
<% ih_user_info(); %>

<% web_exec('show fastethernet') %>

//var ports_status=[[1,1,1,1,-1,-1],[1,1,2,1,-1,1],[1,1,3,1,2,1],[1,1,4,1,2,0],[1,1,5,1,2,1],[1,1,6,1,2,1],[1,1,7,1,2,1],[1,1,8,1,2,1],[2,1,1,1,2,1],[2,1,2,1,2,1],[2,1,3,1,2,1]];

var port_title_list = [];
for(var i=0;i<ports_status.length;++i){
	if(ports_status[i][0] == 1){
		port_title_list.push("FE"+ ports_status[i][1] + "/" + ports_status[i][2]);
	}else if(ports_status[i][0] == 2){
		port_title_list.push("GE"+ ports_status[i][1] + "/" + ports_status[i][2]);
	}

}



var intf = new webGrid();

intf.loadData = function() {
	var tmp_data = [];
	
	for (var i = 0; i < ports_status.length; ++i) {
		if(ports_status[i][1] == 0) 
			continue;
		tmp_data[i] = [];
		//port id
		tmp_data[i][0] = port_title_list[i].toString();
		//port link status
		tmp_data[i][1] = ['LINK DOWN','LINK UP'][ports_status[i][3]].toString();
		/*
		//current speed 
		if (ports_status[i][4] < 0)
			tmp_data[i][2] = '---';
		else 
			tmp_data[i][2] = ['10M','100M','1000M'][ports_status[i][4]].toString();
		//current duplex
		if (ports_status[i][5] < 0)
			tmp_data[i][3] = '---';
		else 
			tmp_data[i][3] = ['HALF','FULL'][ports_status[i][5]].toString();
		*/
		//pvid
		tmp_data[i][2] = ports_status[i][6].toString();
		this.insertData(-1, tmp_data[i] );
	}
}

intf.setup = function() {
	var i, a;
//	var header_title = [port.port,sts.current_link,sts.current_speed,sts.current_duplex,'PVID'];
	var header_title = [port.port,sts.current_link,'PVID'];
	
	this.init('intf-grid', ['sort', 'readonly']);
	this.headerSet(header_title);
	intf.loadData();
}

var ref = new webRefresh('status-port.jsx', '', 0, 'status_port_refresh');

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
	show();
}

function init()
{
	intf.recolor();
	ref.initPage(3000, 0);
}

</script>

</head>
<body onload='init()'>
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
