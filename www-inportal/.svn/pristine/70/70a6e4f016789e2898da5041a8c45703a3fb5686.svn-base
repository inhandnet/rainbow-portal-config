<% pagehead(menu.multicast_groups) %>

<style type='text/css'>
#igmp_grid {
	width: 800px;
	text-align: center;
}


</style>

<script type='text/javascript'>

<% ih_sysinfo() %>
<% ih_user_info(); %>


var port_config = [];
var vlan_config = [];
var Static_groups_config = [];

<% web_exec('show running-config multicast') %>
<% web_exec('show running-config interface') %>
<% web_exec('show running-config vlan') %>

/*
port_config=[['1','1','1',1,3,2,1,0,0,0,0,0,0,1,0,0,0,'abc1,23'],['1','1','2',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],['1','1','3',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],['1','1','4',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],['1','1','5',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],['1','1','6',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],['1','1','7',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],['1','1','8',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],['2','1','1',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],['2','1','2',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],['2','1','3',1,3,2,1,0,0,0,0,0,0,1,0,0,0,'']];
vlan_config=[[1,0,0,'VLAN0001',untagged=[[1,1,2],[1,1,3],[1,1,5],[1,1,6],[1,1,7],[1,1,8],[2,1,1],[2,1,2],[2,1,3]],tagged=[]],[5,0,0,'VLAN0005',untagged=[[1,1,1],[1,1,4]],tagged=[[1,1,2],[1,1,3]]]];

Static_groups_config = [				
	{
		vlan_id: 1,		
		mac_addr: "0100.1234.5678",
		pri:3,
		member_ports: [['1','1','2'],['1','1','3'],['2','1','1']]
	},
	{
		vlan_id: 5,
		mac_addr: "0100.1234.0000",
		pri:4,
		member_ports: [['1','1','2'],['1','1','3'],['2','1','1']]
	}
];
*/


var priority_select = ['','0','1','2','3','4','5','6','7'];
var priority_options = [[0,''],[1,'0'],[2,'1'],[3,'2'],[4,'3'],[5,'4'],[6,'5'],[7,'6'],[8,'7']];
var port_title_list = [];
var port_cmd_list = [];
var port_list = [];

for(var i=0;i<port_config.length;++i){
	
	port_list[i] = [];
	port_list[i][0] = port_config[i][0];
	port_list[i][1] = port_config[i][1];
	port_list[i][2] = port_config[i][2];
	
	if(port_config[i][0] == 1){
		port_cmd_list.push("fastethernet "+ port_config[i][1] + "/" + port_config[i][2]);
		port_title_list.push("FE"+ port_config[i][1] + "/" + port_config[i][2]);
	}else if(port_config[i][0] == 2){
		port_cmd_list.push("gigabitethernet "+ port_config[i][1] + "/" + port_config[i][2]);
		port_title_list.push("GE"+ port_config[i][1] + "/" + port_config[i][2]);
	}	
}

var tmp_old_config = [];
var vlan_options = [];
var vlan_select = [];

for (i=0; i<vlan_config.length; i++) {
	vlan_options.push([i,vlan_config[i][0]]);
	vlan_select.push(vlan_config[i][0]);
}



var multicast_grid = new webGrid();
multicast_grid.setup = function() {
	var tmp_config = [];
	var port_list = "";
	
	var header_title = [ui.mac_address,'VLAN ID',ui.prio, ui.prt];
	var config_options = [
		{ type: 'text'},
		{ type: 'text'},
		{ type: 'text'},
		{ type: 'text'}
		];


	this.init('igmp_grid', ['sort', 'readonly','select'], 256,config_options );
	//this.init('igmp_grid', 'move', 80,config_options );
	this.headerSet(header_title);

	for(var i = 0;i < Static_groups_config.length;++i){
		tmp_config = [];

		//mac addr
		tmp_config.push( Static_groups_config[i].mac_addr.toString());
		//vlan id
		tmp_config.push( Static_groups_config[i].vlan_id.toString());
		//priority
		tmp_config.push( Static_groups_config[i].pri.toString());
		//port
		port_list = "";
		for(var k=0;k<Static_groups_config[i].member_ports.length;++k){
			if(Static_groups_config[i].member_ports[k][0] == 1){
				port_list += (k==0?"":",")+"FE"+ Static_groups_config[i].member_ports[k][1] + "/" + Static_groups_config[i].member_ports[k][2];
			}else if(Static_groups_config[i].member_ports[k][0] == 2){
				port_list += (k==0?"":",")+ "GE"+ Static_groups_config[i].member_ports[k][1] + "/" + Static_groups_config[i].member_ports[k][2];
			}
		}
		tmp_config.push( port_list);
		multicast_grid.insertData(-1,tmp_config);
	}

	if (user_info.priv >= admin_priv)
		multicast_grid.footerButtonsSet(0);


}
multicast_grid.jump = function(){
	document.location = 'switch-mcast-groupN.jsp';	
}

multicast_grid.footerAdd = function(){
	cookie.unset('mcast-modify-mac');
	cookie.unset('mcast-modify-vid');
	multicast_grid.jump();		
}
	
multicast_grid.footerModify = function(){
	var f = multicast_grid.getAllData();
	if (multicast_grid.selectedRowIndex < 0 || multicast_grid.selectedColIndex < 0)
		return;

	var mac = f[multicast_grid.selectedRowIndex - 1][0];
	var vid = f[multicast_grid.selectedRowIndex - 1][1];
	
	cookie.set('mcast-modify-mac', mac);
	cookie.set('mcast-modify-vid', vid);

	multicast_grid.jump();
}
	
multicast_grid.footerDel = function(){
	var send_cmd = [];
	var f = multicast_grid.getAllData();
	if (multicast_grid.selectedRowIndex < 0 || this.selectedColIndex < 0)
		return;
	var mac = f[multicast_grid.selectedRowIndex - 1][0];
	var vid = f[multicast_grid.selectedRowIndex - 1][1];

	E('_fom')._web_cmd.value += "!"+"\n"+"no mac address-table multicast "+mac+" vlan "+vid+"\n";
	
	if((E('_fom')._web_cmd.value != '')&&(cookie.get('autosave') == 1)){
		E('_fom')._web_cmd.value += "!"+"\n"+"copy running-config startup-config"+"\n";	
	}

	form.submit('_fom', 1);
}



function init()
{
	if((cookie.get('autosave')) == null){
		cookie.set('autosave', 1);
	}
	
}
</script>
</head>
<body onload='init()'>
<form id='_fom' method='post' action='apply.cgi'>
<input type='hidden' name='_web_cmd' value=''>

<div class='section'>
	<table class='web-grid' cellspacing=1 id='igmp_grid' name='test'></table>
	<script type='text/javascript'>multicast_grid.setup();</script>
</div>

<script type='text/javascript'>
init();

</script>
</form>
</body>
</html>
