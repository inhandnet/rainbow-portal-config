<% pagehead(menu.status_vlan) %>
<style type='text/css'>

#vlan-grid {
	width: 800px;	
	text-align: center;
}


</style>

<script type='text/javascript'>

<% ih_sysinfo() %>
<% ih_user_info() %>
var vlan_config= [];
/*
vlan_config=[[1,0,0,'VLAN0001',untagged=[[1,1,2],[1,1,3],[1,1,5],[1,1,6],[1,1,7],[1,1,8],[2,1,1],[2,1,2],[2,1,3]],tagged=[]],
					[2,0,0,'VLAN0005',untagged=[[1,1,1],[1,1,4]],tagged=[[1,1,2],[1,1,3]]],
					[3,0,0,'VLAN0005',untagged=[[1,1,1],[1,1,4]],tagged=[[1,1,2],[1,1,3]]],
					[4,0,0,'VLAN0005',untagged=[[1,1,1],[1,1,4]],tagged=[[1,1,2],[1,1,3]]],
					[5,0,0,'VLAN0005',untagged=[[1,1,1],[1,1,4]],tagged=[[1,1,2],[1,1,3]]],
					[15,0,0,'VLAN0005',untagged=[[1,1,1],[1,1,4]],tagged=[[1,1,2],[1,1,3]]],
					[16,0,0,'VLAN0005',untagged=[[1,1,1],[1,1,4]],tagged=[[1,1,2],[1,1,3]]]
					];
*/
<% web_exec('show running-config vlan') %>


var vlan = new webGrid();

vlan.loadData = function() {
	var tmp_data = [];
	for (var i = 0; i < vlan_config.length; ++i) {
		tmp_data[i] = [];
		tmp_data[i][0] = vlan_config[i][0].toString()+((vlan_config[i][0] == 1)?('('+ui.deflt+')'):(''));
		tmp_data[i][1] = vlan_config[i][3].toString();
		tmp_data[i][2] = vlan_config[i][1].toString();
		//untagged port
		tmp_data[i][3] = [];
		for(var j=0;j<vlan_config[i][4].length;++j){
			if(vlan_config[i][4][j][0] == 1)
				tmp_data[i][3].push("FE"+vlan_config[i][4][j][1]+"/"+vlan_config[i][4][j][2]);
			else if(vlan_config[i][4][j][0] == 2)
				tmp_data[i][3].push("GE"+vlan_config[i][4][j][1]+"/"+vlan_config[i][4][j][2]);
			else if((vlan_config[i][4][j][0] == 0)
					&& (vlan_config[i][4][j][1] == 0))
				tmp_data[i][3].push("T"+vlan_config[i][4][j][2]);
		}
		//tagged port
		tmp_data[i][4] = [];
		for(var j=0;j<vlan_config[i][5].length;++j){
			if(vlan_config[i][5][j][0] == 1)
				tmp_data[i][4].push("FE"+vlan_config[i][5][j][1]+"/"+vlan_config[i][5][j][2]);
			else if(vlan_config[i][5][j][0] == 2)
				tmp_data[i][4].push("GE"+vlan_config[i][5][j][1]+"/"+vlan_config[i][5][j][2]);
			else if((vlan_config[i][5][j][0] == 0)
					&& (vlan_config[i][5][j][1] == 0))
				tmp_data[i][4].push("T"+vlan_config[i][5][j][2]);
		}
				
		this.insertData(-1, tmp_data[i]);

	}
}


vlan.setup = function() {
	this.init('vlan-grid', ['sort', 'readonly']);
	this.headerSet([ui.vlan_id,ui.nam,ui.prio,status.untagged_ports,status.tagged_ports]);
	vlan.loadData();
}

var ref = new webRefresh('status-vlan.jsx', '', 0, 'status_vlan_refresh');

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
	vlan.removeAllData();
	vlan.loadData();
}

function earlyInit()
{
	vlan.setup();
	//show();
}

function init()
{
	vlan.recolor();
	ref.initPage(3000, 0);
}

</script>

</head>
<body onload='init()'>
<form>

<div class='section'>
	<table class='web-grid' id='vlan-grid'></table>
</div>

<div id='footer'>
	<script type='text/javascript'>genStdRefresh(1,0,'ref.toggle()');</script>
</div>
</form>

<script type='text/javascript'>earlyInit();</script>
</body>
</html>
