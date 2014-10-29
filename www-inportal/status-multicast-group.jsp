<% pagehead(menu.status_multicast_group) %>
<style type='text/css'>

#groups-grid {
	width: 1000px;
	text-align: center;
}


</style>

<script type='text/javascript'>

<% ih_sysinfo() %>
<% ih_user_info() %>

<% web_exec('show ip igmp snooping groups') %>
/*
var groups_info = {
	count: 1,       
      	groups:[            
    	{
      		idx:1,  
    		vlan_id:2,
      		ip_addr:"10.5.1.178",      
  		mac_addr:"0000.1234.5678", 
     		router_ports:[[1,1,2],[1,1,3],[2,1,1]],
    		joined_ports:[[1,1,2],[1,1,3],[2,1,1]] 
      },
    ]
};
*/

var group = new webGrid();


group.loadData = function() {
		
	for (var i = 0; i < groups_info.count; ++i) {
		var tmp = [];
		tmp[0] = groups_info.groups[i].vlan_id.toString();
		tmp[1] = groups_info.groups[i].ip_addr.toString();
		//joined ports
		tmp[2] = [];
		for(var j=0;j<groups_info.groups[i].joined_ports.length;++j){
			if(groups_info.groups[i].joined_ports[j][0] == 1)
				tmp[2].push("FE"+ groups_info.groups[i].joined_ports[j][1] + "/" + groups_info.groups[i].joined_ports[j][2]);
			else
				tmp[2].push("GE"+ groups_info.groups[i].joined_ports[j][1] + "/" + groups_info.groups[i].joined_ports[j][2]);
		}
		//router ports
		tmp[3] = [];
		for(var j=0;j<groups_info.groups[i].router_ports.length;++j){
			if(groups_info.groups[i].router_ports[j][0] == 1)
				tmp[3].push("FE"+ groups_info.groups[i].router_ports[j][1] + "/" + groups_info.groups[i].router_ports[j][2]);
			else
				tmp[3].push("GE"+ groups_info.groups[i].router_ports[j][1] + "/" + groups_info.groups[i].router_ports[j][2]);
		}
		tmp[4] = groups_info.groups[i].mac_addr.toString();
				
		this.insertData(-1, [tmp[0],tmp[1],tmp[2], tmp[3],tmp[4]]);

	}
}


group.setup = function() {
	this.init('groups-grid', ['sort', 'readonly']);
	this.headerSet([ui.vlan_id,ui.ip,igmp.join_ports,igmp.router_ports,ui.mac_address]);
	group.loadData();
}

var ref = new webRefresh('status-multicast-group.jsx', '', 0, 'status_multicast_refresh');

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
	group.removeAllData();
	group.loadData();
}

function earlyInit()
{
	group.setup();
	show();
}

function init()
{
	group.recolor();
	ref.initPage(3000, 0);
}

</script>

</head>
<body onload='init()'>
<form>

<div class='section'>
	<table class='web-grid' id='groups-grid'></table>
</div>

<div id='footer'>
	<script type='text/javascript'>genStdRefresh(1,0,'ref.toggle()');</script>
</div>
</form>

<script type='text/javascript'>earlyInit();</script>
</body>
</html>
