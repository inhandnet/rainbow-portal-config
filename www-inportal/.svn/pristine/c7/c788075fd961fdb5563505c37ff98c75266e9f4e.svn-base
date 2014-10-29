<% pagehead(menu.status_gmrp_groups) %>
<style type='text/css'>

#group-grid {
	width: 800px;	
	text-align: center;
}

</style>

<script type='text/javascript'>

<% ih_sysinfo() %>
<% ih_user_info() %>


var GMRP_groups = [];

//<% web_exec('show gmrp groups') %>


<% web_exec('show mac address-table multicast') %>
/*
var GMRP_groups = [
	{
	vlan_id: 1,     
	mac_addr: '0000.0000.0002',  
	gmrp_dyn_ports: [[1,1,1], [1,1,2]]

	},
	{
	vlan_id: 3,     
	mac_addr: '0000.0000.0004',  
	gmrp_dyn_ports: [[1,1,3], [1,1,4],[2,1,2]]

	}
	
];

var Static_groups= [
	{
		vlan_id: 1,
		mac_addr: "0000.0000.0002",
		member_ports: [[1,1,2],[1,1,3],[2,1,1]],	
	},
	{
		vlan_id: 5,
		mac_addr: "0000.1234.5678",
		member_ports: [[1,1,2],[1,1,3],[2,1,1]],	
	},
	{
		vlan_id: 6,
		mac_addr: "0000.1234.5678",
		member_ports: [[1,1,2],[1,1,3],[2,1,1]],	
	}

];
*/

var table = new webGrid();

table.duplicateGroup = function(vid,mac_addr){
	for(var i=0;i<GMRP_groups.length;++i){
		if((GMRP_groups[i].vlan_id == vid)&&(GMRP_groups[i].mac_addr == mac_addr)){
			return true;
		}
	}

	return false;
}

table.loadData = function() {
	var tmp_data = [];

	
	//GMRP
	for (var i = 0; i < GMRP_groups.length; ++i) {
		tmp_data[i] = [];
		tmp_data[i][0] = GMRP_groups[i].vlan_id.toString();
		tmp_data[i][1] = GMRP_groups[i].mac_addr.toString();
		
		//static port
		tmp_data[i][2] = [];
		for(var j=0;j<Static_groups.length;){
			if((GMRP_groups[i].vlan_id == Static_groups[j].vlan_id)&&(GMRP_groups[i].mac_addr == Static_groups[j].mac_addr)){
				for(var k=0;k< Static_groups[j].member_ports.length;++k){
					if(Static_groups[j].member_ports[k][0] == 1)
						tmp_data[i][2].push("FE"+Static_groups[j].member_ports[k][1]+"/"+Static_groups[j].member_ports[k][2]);
					else if(Static_groups[j].member_ports[k][0] == 2)
						tmp_data[i][2].push("GE"+Static_groups[j].member_ports[k][1]+"/"+Static_groups[j].member_ports[k][2]);
				}
				break;
			}
			++j;
			if(j == Static_groups.length){
				tmp_data[i][2] = '';		
			}
		}
		
		//gmrp dynamic port
		tmp_data[i][3] = [];
		for(var j=0;j<GMRP_groups[i].gmrp_dyn_ports.length;++j){
			if(GMRP_groups[i].gmrp_dyn_ports[j][0] == 1)
				tmp_data[i][3].push("FE"+GMRP_groups[i].gmrp_dyn_ports[j][1]+"/"+GMRP_groups[i].gmrp_dyn_ports[j][2]);
			else if(GMRP_groups[i].gmrp_dyn_ports[j][0] == 2)
				tmp_data[i][3].push("GE"+GMRP_groups[i].gmrp_dyn_ports[j][1]+"/"+GMRP_groups[i].gmrp_dyn_ports[j][2]);
		}
				
		this.insertData(-1, tmp_data[i]);

	}
	

	//static group
	for (var i = 0; i < Static_groups.length; ++i) {
		tmp_data[i] = [];
	
		if(this.duplicateGroup(Static_groups[i].vlan_id,Static_groups[i].mac_addr)){
			continue;
		}
		
		tmp_data[i][0] = Static_groups[i].vlan_id.toString();
		tmp_data[i][1] = Static_groups[i].mac_addr.toString();
		
		//static port
		tmp_data[i][2] = [];
		for(var k=0;k< Static_groups[i].member_ports.length;++k){
			if(Static_groups[i].member_ports[k][0] == 1)
				tmp_data[i][2].push("FE"+Static_groups[i].member_ports[k][1]+"/"+Static_groups[i].member_ports[k][2]);
			else if(Static_groups[i].member_ports[k][0] == 2)
				tmp_data[i][2].push("GE"+Static_groups[i].member_ports[k][1]+"/"+Static_groups[i].member_ports[k][2]);
		}
			
		//gmrp dynamic port
		tmp_data[i][3] = '';
						
		this.insertData(-1, tmp_data[i]);

	}
	
}


table.setup = function() {
	this.init('group-grid', ['sort', 'readonly']);
	this.headerSet([ui.vlan_id,mac.mac_address,ui.static_port,ui.gmrp_dynamic_port]);
	//this.headerSet([ui.vlan_id,mac.mac_address,ui.static_port]);
	table.loadData();
}

var ref = new webRefresh('status-gmrp-groups.jsx', '', 0, 'status_gmrp_groups_refresh');

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
	table.removeAllData();
	table.loadData();
}

function earlyInit()
{
	table.setup();
	show();
}

function init()
{
	table.recolor();
	ref.initPage(3000, 0);
}

</script>

</head>
<body onload='init()'>
<form>

<div class='section'>
	<table class='web-grid' id='group-grid'></table>
</div>

<div id='footer'>
	<script type='text/javascript'>genStdRefresh(1,0,'ref.toggle()');</script>
</div>
</form>

<script type='text/javascript'>earlyInit();</script>
</body>
</html>
