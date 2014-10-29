<% pagehead(menu.route_ripd) %>

<style type='text/css'>
#network-grid {
	width: 400px;
	text-align: center;
}
#network-grid .co1 {
	width: 200px;
}
#network-grid .co2 {
	width: 200px;
}


#neighbor-grid {
	width: 200px;
	text-align: center;
}


#offset-grid {
	width: 500px;
	text-align: center;
}
#offset-grid .co1 {
	width: 80px;
}
#offset-grid .co2 {
	width: 80px;
}
#offset-grid .co3 {
	width: 150px;
}
#offset-grid .co4 {
	width: 150px;
}

#distribute-grid {
	width: 500px;
	text-align: center;
}
#distribute-grid .co1 {
	width: 100px;
}
#distribute-grid .co2 {
	width: 150px;
}
#distribute-grid .co3 {
	width: 80px;
}
#distribute-grid .co4 {
	width: 150px;
}

#distance-grid {
	width: 500px;
	text-align: center;
}
#distance-grid .co1 {
	width: 80px;
}
#distance-grid .co2 {
	width: 150px;
}
#distance-grid .co3 {
	width: 150px;
}
#distance-grid .co4 {
	width: 120px;
}

#rip-if-grid {
	width: 780px;
	text-align: center;
}
#rip-if-grid .co1 {
	width: 150px;
}
#rip-if-grid .co2 {
	width: 80px;
}
#rip-if-grid .co3 {
	width: 80px;
}
#rip-if-grid .co4 {
	width: 80px;
}
#rip-if-grid .co5 {
	width: 150px;
}
#rip-if-grid .co6 {
	width: 100px;
}
#rip-if-grid .co7 {
	width: 100px;
}

</style>

<script type='text/javascript'>

<% ih_sysinfo(); %>
<% ih_user_info(); %>
/*
var rip_config=[1,
[['1.1.1.1','255.255.255.0'],['4.4.4.4','255.255.255.0']],
['1.1.1.1'],
10,
20,
30,
2, //version
0, //police in
1, //police out
1, //default-info
13, //default metric
120,//distance
[0,8],
[0,0],
[0,6],
1,
['fastethernet 0/1','fastethernet 0/2'],
[['5','1','fastethernet 0/1','offset-list-name']],
[['1','distribute-list-name','1','fastethernet 0/1']],
[['100','6.6.6.6','255.255.255.0','acl-list-name']],
[['fastethernet 0/1','0','1','2','1','1','key'],['fastethernet 0/2','1','0','1','2','2','momo']]
];
*/
<% web_exec('show running rip')%>
<% web_exec('show interface')%>

//define option list
//var vifs = [].concat(cellular_interface, eth_interface, sub_eth_interface, svi_interface,xdsl_interface, vp_interface,openvpn_interface);
var vifs = [].concat(cellular_interface, eth_interface, sub_eth_interface, svi_interface,xdsl_interface, vp_interface,openvpn_interface);
var now_vifs_options = new Array();
now_vifs_options = grid_list_all_vif_opts(vifs);

var filter_type = [['1', 'access-list'],
			['2', 'prefix-list']];

var filter_direct = [['1', 'in'],
			['2', 'out']];
var split_poison = [['0', ''], 
			['1', 'split-horizon'],
			['2', 'disabled']];
var rip_version_type = [
		[0,ui.deflt],
		[1,rip.ver_v1],
		[2,rip.ver_v2]];
var rip_auth_mode = [
		[0, ''],
		[1, 'text'],
		[2, 'md5']];

//rip json
var rip_enable_json = rip_config[0];
if(rip_config.length != 0) {
	var rip_network_json = rip_config[1];
	var rip_neighbor_json = rip_config[2];
	var rip_conn_json = rip_config[12];
	var rip_kernel_json = rip_config[13];
	var rip_ospf_json = rip_config[14];
	var rip_passive_json = rip_config[16];
} else {
	var rip_network_json = [];
	var rip_neighbor_json = [];
	var rip_conn_json = [];
	var rip_kernel_json = [];
	var rip_ospf_json = [];
	var rip_passive_json = [];
}


var rip_timer_update_json = rip_config[3];
var rip_timer_info_json = rip_config[4];
var rip_timer_gc_json = rip_config[5];
var rip_version_json = rip_config[6];
var rip_filter_policy_in_json = rip_config[7];
var rip_filter_policy_out_json = rip_config[8];
var rip_default_info_json = rip_config[9];
var rip_default_metric_json = rip_config[10];
//var rip_distance_json = rip_config[11];
//var rip_passive_all_json = rip_config[15];

var rip_offset_json= rip_config[17];
var rip_distribute_json= rip_config[18];
var rip_distance_if_json=rip_config[19];
var rip_if_json=rip_config[20];

//network
var network = new webGrid();
function display_disable_network(e)
{	
	var x = e?"":"none";
	E('network-grid').style.display = x;
	E('network_title').style.display = x;
	E('network_body').style.display = x;

	E('network-grid').disabled = !e;
	E('network_title').disabled = !e;
	E('network_body').disabled = !e;
	return 1;
}
network.exist = function(f, v)
{
	var data = this.getAllData();
	for (var i = 0; i < data.length; ++i) {
		if (data[i][f] == v) return true;
	}
	return false;
}
network.existName = function(name)
{
	return this.exist(0, name);
}
network.onDataChanged = function() {
	verifyFields(null, 1);
}
network.verifyFields = function(row, quiet)
{
	var f = fields.getAll(row);
	ferror.clearAll(f);
	if(this.existName(f[0].value)) {
		ferror.set(f[0], errmsg.bad_addr2, quiet);
		return 0;
	} else if(!v_ip(f[0], quiet)) {
		return 0;
	} else {
		ferror.clear(f[0]);
	}
	if(!v_mask(f[1], quiet)) {
		return 0;
	} else {
		ferror.clear(f[1]);
	}

	return 1;	
}
network.dataToView = function(data)
{
	return [data[0],data[1]];
}
network.fieldValuesToData = function(row) 
{
	var f = fields.getAll(row);
	return [f[0].value,f[1].value];
}
network.resetNewEditor = function() 
{
	var f = fields.getAll(this.newEditor);
	f[0].value = '';
	f[1].value = '';
			
	ferror.clearAll(fields.getAll(this.newEditor));
}
network.setup = function()
{
	this.init('network-grid', 'move', 64, [
		{ type: 'text', maxlen: 32 }, 
		{ type: 'text', maxlen: 32 } 
	]);
	this.headerSet([ui.ip, ui.netmask]);

	for (var i = 0; i < rip_network_json.length; i++)
		this.insertData(-1, [rip_network_json[i][0], rip_network_json[i][1]]);
	this.showNewEditor();
	this.resetNewEditor();
}
//offset
var offset = new webGrid();
function display_disable_offset(e)
{	
	var x = e?"":"none";
	
	E('offset-grid').style.display = x;
	//E('offset_title').style.display = x;
	//E('offset_body').style.display = x;

	E('offset-grid').disabled = !e;
	//E('offset_title').disabled = !e;
	//E('offset_body').disabled = !e;
	return 1;
}
offset.exist = function(f, v)
{
	var data = this.getAllData();
	for (var i = 0; i < data.length; ++i) {
		if (data[i][f] == v) return true;
	}
	return false;
}
offset.existName = function(name)
{
	return this.exist(0, name);
}
offset.onDataChanged = function() {
	verifyFields(null, 1);
}
offset.verifyFields = function(row, quiet)
{
	var f = fields.getAll(row);
	if(!v_range(f[0],quiet,1,16)) return 0;
	if( f[2].value == ''){
		ferror.set(f[2], errmsg.adm3, quiet);
		return 0;
	}else {
		ferror.clear(f[2]);
	}
	if( f[3].value == ''){
		ferror.set(f[3], errmsg.adm3, quiet);
		return 0;
	}else {
		ferror.clear(f[3]);
	}
	return 1;	
}
offset.dataToView = function(data) 
{
	return [data[0],filter_direct[data[1]-1][1],data[2],data[3]];
}
offset.fieldValuesToData = function(row)
{
	var f = fields.getAll(row);
	return [f[0].value,f[1].value,f[2].value,f[3].value];
}
offset.resetNewEditor = function() 
{
	var f = fields.getAll(this.newEditor);
	f[0].value = '';
	f[1].value = '';
	f[2].value = '';
	f[3].value = '';			
	ferror.clearAll(fields.getAll(this.newEditor));
}
offset.setup = function()
{
	this.init('offset-grid', 'move', 64, [
		{ type: 'text', maxlen: 32 }, 
		{ type: 'select', options: filter_direct},
		{ type: 'select', options: now_vifs_options },
		{ type: 'text', maxlen: 32 }
	]);
	grid_vif_opts_add(now_vifs_options, "");
	this.headerSet([rip.metric, rip.direct, rip.interface, rip.acl]);
	for (var i = 0; i < rip_offset_json.length; i++){
		this.insertData(-1, [rip_offset_json[i][0], rip_offset_json[i][1], rip_offset_json[i][2], rip_offset_json[i][3]]);
	}
	this.showNewEditor();
	this.resetNewEditor();
}
//distribute
var distribute = new webGrid();
function display_disable_distribute(e)
{	
	var x = e?"":"none";
	
	E('distribute-grid').style.display = x;
	E('distribute_title').style.display = x;
	E('distribute_body').style.display = x;

	E('distribute-grid').disabled = !e;
	E('distribute_title').disabled = !e;
	E('distribute_body').disabled = !e;
	return 1;
}
distribute.exist = function(f, v)
{
	var data = this.getAllData();
	for (var i = 0; i < data.length; ++i) {
		if (data[i][f] == v) return true;
	}
	return false;
}
distribute.existName = function(name)
{
	return this.exist(0, name);
}
distribute.onDataChanged = function() {
	verifyFields(null, 1);
}
distribute.verifyFields = function(row, quiet)
{
	var f = fields.getAll(row);
	if(this.existName(f[1].value)) {
		ferror.set(f[1], errmsg.bad_name4, quiet);
		return 0;
	} else if(f[1].value==''){
		ferror.set(f[1], errmsg.adm3, quiet);
		return 0;
	}else {
		ferror.clear(f[1]);
	}
	
	return 1;	
}
distribute.dataToView = function(data) 
{
	return [filter_type[data[0]-1][1], data[1], filter_direct[data[2]-1][1], data[3]];
}
distribute.fieldValuesToData = function(row)
{
	var f = fields.getAll(row);
	return [f[0].value,f[1].value,f[2].value,f[3].value];
}
distribute.resetNewEditor = function() 
{
	var f = fields.getAll(this.newEditor);
	f[0].value = '';
	f[1].value = '';
	f[2].value = '';
	f[3].value = '';			
	ferror.clearAll(fields.getAll(this.newEditor));
}
distribute.setup = function()
{
	this.init('distribute-grid', 'move', 64, [
		{ type: 'select', options: filter_type},
		{ type: 'text', maxlen: 32 }, 
		{ type: 'select', options: filter_direct},
		{ type: 'select', options: now_vifs_options }
	]);
	grid_vif_opts_add(now_vifs_options, "");
	this.headerSet([rip.filter_mode, rip.filter_name, rip.direct, rip.interface]);
	for (var i = 0; i < rip_distribute_json.length; i++){
		this.insertData(-1, [rip_distribute_json[i][0], rip_distribute_json[i][1], rip_distribute_json[i][2], rip_distribute_json[i][3]]);
	}
	this.showNewEditor();
	this.resetNewEditor();
}
//distance
var distance = new webGrid();
function display_disable_distance(e)
{	
	var x = e?"":"none";
	
	E('distance-grid').style.display = x;
	E('distance_title').style.display = x;
	E('distance_body').style.display = x;

	E('distance-grid').disabled = !e;
	E('distance_title').disabled = !e;
	E('distance_body').disabled = !e;
	return 1;
}
distance.exist = function(f, v)
{
	var data = this.getAllData();
	for (var i = 0; i < data.length; ++i) {
		if (data[i][f] == v) return true;
	}
	return false;
}
distance.existName = function(name)
{
	return this.exist(0, name);
}
distance.onDataChanged = function() {
	verifyFields(null, 1);
}
distance.verifyFields = function(row, quiet)
{
	var f = fields.getAll(row);
	
	if(!v_range(f[0],quiet,1,255)) return 0;
	if( f[1].value != ''){
		if( !v_ip(f[1],quiet) ) return 0;
	}
	if( f[1].value != ''){
		if( !v_netmask(f[2],quiet) ) return 0;
	}
	if(this.existName(f[3].value)) {
		ferror.set(f[3], errmsg.bad_name4, quiet);
		return 0;
	} else {
		ferror.clear(f[3]);
	}
	return 1;	
}
distance.dataToView = function(data) 
{
	return [data[0], data[1], data[2], data[3]];
}
distance.fieldValuesToData = function(row)
{
	var f = fields.getAll(row);
	return [f[0].value,f[1].value,f[2].value,f[3].value];
}
distance.resetNewEditor = function() 
{
	var f = fields.getAll(this.newEditor);
	f[0].value = '';
	f[1].value = '';
	f[2].value = '';
	f[3].value = '';			
	ferror.clearAll(fields.getAll(this.newEditor));
}
distance.setup = function()
{
	this.init('distance-grid', 'move', 64, [
		{ type: 'text',maxlen: 32 },
		{ type: 'text', maxlen: 32 }, 
		{ type: 'text', maxlen: 32 }, 
		{ type: 'text', maxlen: 32 }, 
	]);
	this.headerSet([rip.distance, ui.ip, ui.netmask, rip.acl]);
	for (var i = 0; i < rip_distance_if_json.length; i++){
		this.insertData(-1, [rip_distance_if_json[i][0], rip_distance_if_json[i][1], rip_distance_if_json[i][2], rip_distance_if_json[i][3]]);
	}
	this.showNewEditor();
	this.resetNewEditor();
}
//neighbor
var neighbor = new webGrid();
function display_disable_neighbor(e)
{	
	var x = e?"":"none";
	
	E('neighbor-grid').style.display = x;
	E('neighbor_title').style.display = x;
	E('neighbor_body').style.display = x;

	E('neighbor-grid').disabled = !e;
	E('neighbor_title').disabled = !e;
	E('neighbor_body').disabled = !e;
	return 1;
}
neighbor.exist = function(f, v)
{
	var data = this.getAllData();
	for (var i = 0; i < data.length; ++i) {
		if (data[i][f] == v) return true;
	}
	return false;
}
neighbor.dataToView = function(data) {
	return [data[0]];
}

neighbor.fieldValuesToData = function(row) {
	var f = fields.getAll(row);
	return [f[0].value];
}
neighbor.existName = function(name)
{
	return this.exist(0, name);
}

neighbor.onDataChanged = function() {
	verifyFields(null, 1);
}
neighbor.verifyFields = function(row, quiet)
{
	var f = fields.getAll(row);

	if(this.existName(f[0].value)) {
		ferror.set(f[0], errmsg.bad_addr2, quiet);
		return 0;
	} else if(!v_ip(f[0], quiet)) {
		return 0;
	} else {
		ferror.clear(f[0]);
	}
	return 1;	
}
neighbor.resetNewEditor = function() {
	var f = fields.getAll(this.newEditor);

	f[0].value = '';
			
	ferror.clearAll(fields.getAll(this.newEditor));
}
neighbor.setup = function()
{
	this.init('neighbor-grid', 'move', 64, [
		{ type: 'text', maxlen: 32 }
	]);
	this.headerSet([ui.ip]);

	for (var i = 0; i < rip_neighbor_json.length; i++)
		this.insertData(-1, [rip_neighbor_json[i]]);
	this.showNewEditor();
	this.resetNewEditor();
}
//rip interface
var rip_if = new webGrid();
function display_disable_rip_if(e)
{	
	var x = e?"":"none";
	
	E('rip-if-grid').style.display = x;
	E('rip-if_title').style.display = x;
	E('rip-if_body').style.display = x;

	E('rip-if-grid').disabled = !e;
	E('rip-if_title').disabled = !e;
	E('rip-if_body').disabled = !e;
	return 1;
}
rip_if.exist = function(f, v)
{
	var data = this.getAllData();
	for (var i = 0; i < data.length; ++i) {
		if (data[i][f] == v) return true;
	}
	return false;
}
rip_if.existName = function(name)
{
	return this.exist(0, name);
}
rip_if.onDataChanged = function() 
{
	verifyFields(null, 1);
}
rip_if.verifyFields = function(row, quiet)
{
	var f = fields.getAll(row);
	if(this.existName(f[0].value)) {
		ferror.set(f[0], errmsg.bad_name4, quiet);
		return 0;
	}else if(f[0].value ==''){
		ferror.set(f[0], errmsg.adm3, quiet);
		return 0;
	}else {
		ferror.clear(f[0]);
	}
	if(f[5].value != '0'){
		if(f[6].value ==''){
			ferror.set(f[6], errmsg.adm3, quiet);
			return 0;
		}else {
			ferror.clear(f[6]);
		}
	}
	return 1;	
}
rip_if.dataToView = function(data) 
{
	return [data[0], (data[1] != '0') ? ui.yes : ui.no, rip_version_type[data[2]][1], rip_version_type[data[3]][1], 
		split_poison[data[4]][1],rip_auth_mode[data[5]][1],(data[6]=='')?'':'******'];
}
rip_if.fieldValuesToData = function(row)
{
	var f = fields.getAll(row);
	return [f[0].value,f[1].checked ? 1 : 0, f[2].value,f[3].value,f[4].value,f[5].value,f[6].value,f[6].value];
}
rip_if.resetNewEditor = function() 
{
	var f = fields.getAll(this.newEditor);
	f[0].value = '';
	f[1].value = '';
	f[2].value = '';
	f[3].value = '';
	f[4].value = '';
	f[5].value = '';
	f[6].value = '';	
	ferror.clearAll(fields.getAll(this.newEditor));
}
rip_if.setup = function()
{
	this.init('rip-if-grid', 'move', 64, [
		{ type: 'select', options: now_vifs_options },
		{ type: 'checkbox' },
		{ type: 'select', options: rip_version_type },
		{ type: 'select', options: rip_version_type },
		{ type: 'select', options: split_poison },
		{ type: 'select', options: rip_auth_mode },
		{ type: 'password', maxlen: 32 }
	]);
	this.headerSet([rip.interface, rip.passive, rip.send_ver, rip.recv_ver, rip.splite, rip.auth_mode, rip.key_text]);
	for (var i = 0; i < rip_if_json.length; i++){
		this.insertData(-1, [rip_if_json[i][0], rip_if_json[i][1], rip_if_json[i][2], rip_if_json[i][3], rip_if_json[i][4], rip_if_json[i][5], rip_if_json[i][6]]);
	}
	this.showNewEditor();
	this.resetNewEditor();
}

function v_range(e, quiet, min, max, name)
{
	var v;

	if ((e = E(e)) == null) return 0;
	v = e.value * 1;
	if ((isNaN(v)) || (v < min) || (v > max)) {
		ferror.set(e, ui.invalid + '. ' + ui.valid_range + ': ' + min + '-' + max, quiet);
		return 0;
	}
	ferror.clear(e);
	return 1;
}

function verifyFields(focused, quiet)
{
	var ok = 1;
	var cmd="";
	var fom = E('_fom');

	var enable = E('_f_rip_enable').checked;
	var rip_conn = E('_rip_redistr_conn').checked;
	var rip_kernel = E('_rip_redistr_kernel').checked;
	var rip_ospf = E('_rip_redistr_ospf').checked;	
	var advanced = E('_rip_advanced').checked;

	var rip_update_timer = E('_rip_update_timer').value;
	var rip_timeout_timer = E('_rip_timeout_timer').value;
	var rip_garbage_timer = E('_rip_garbage_timer').value;
	var rip_filter_policy_out = E('_rip_filter_policy_out').checked;
	var rip_default_info = E('_rip_default_info').checked;
	var rip_version = E('_rip_version').value;
	var rip_default_metric = E('_rip_default_metric').value;
	//var rip_distance = E('_rip_distance').value;

	var conn_metric = E('_conn_metric').value;
	var kernel_metric = E('_kernel_metric').value;
	var ospf_metric = E('_ospf_metric').value;
	elem.display_and_enable(('_rip_version'), ('_rip_update_timer'), ('_rip_timeout_timer'), 
					('_rip_garbage_timer'), ('_rip_version'), ('_rip_advanced'), enable);
	elem.display_and_enable( ('_rip_filter_policy_out'), ('_rip_default_info'), ('_rip_default_metric'), 
					('_rip_redistr_conn'), ('_rip_redistr_kernel'), ('_rip_redistr_ospf'), 
					enable&advanced);

	elem.display_and_enable(('_conn_metric'), enable&advanced&rip_conn);
	elem.display_and_enable(('_kernel_metric'), enable&advanced&rip_kernel);
	elem.display_and_enable(('_ospf_metric'), enable&advanced&rip_ospf);
	//valid check
	if((!v_range('_conn_metric', quiet, 0, 16)) && (conn_metric != "")) return 0;
	if((!v_range('_kernel_metric', quiet, 0, 16)) && (kernel_metric != "")) return 0;
	if((!v_range('_ospf_metric', quiet, 0, 16)) && (ospf_metric != "")) return 0;

	if(!enable){		
		display_disable_network(0);
		display_disable_neighbor(0);
		display_disable_offset(0);
		display_disable_distribute(0);
		display_disable_distance(0);
		display_disable_rip_if(0);
		if(enable != rip_enable_json)
			cmd += "no router rip\n";
	}else {
		if(advanced) {
			cookie.set('rip_advanced', 1);	
		} else {
			cookie.set('rip_advanced', 0);
		}
		display_disable_network(1);
		display_disable_neighbor(advanced);
		display_disable_offset(advanced)
		display_disable_distribute(advanced);
		display_disable_distance(advanced);		
		display_disable_rip_if(advanced);		
		
		if(enable != rip_enable_json) {
			cmd += "!\n";
			cmd += "router rip\n";
		}
		//verify for the network grid
		var flag = 0;
		var datan = network.getAllData();
		var mnets = rip_network_json;

		//delete the network from json which have been deleted from web
		for(var i = 0; i < mnets.length; i++) {
			flag = 0;
			for (var j=0; j < datan.length; j++) {
				if((mnets[i][0] == datan[j][0]) && (mnets[i][1] == datan[j][1])) {
					flag = 1;	//The network is still in the web grid
					break;
				}
			}
			if(!flag) {
				cmd += "!\n";
				cmd += "router rip\n";
				cmd += "no network " + mnets[i][0] + " " + mnets[i][1] + "\n";
			}
		}
		//add the network into json which have been added by the web
		for(var i = 0; i < datan.length; i++) {
			flag = 0;
			for (var j=0; j < mnets.length; j++) {
				if((datan[i][0] == mnets[j][0]) && (datan[i][1] == mnets[j][1])) {
					flag = 1;
					break;
				}
			}
			if(!flag) {
				cmd += "!\n";
				cmd += "router rip\n";
				cmd += "network " + datan[i][0] + " " + datan[i][1] + "\n";			
			}
		}
		//verify for the neighbor grid
		var flag = 0;
		var datan = neighbor.getAllData();
		var mnets = rip_neighbor_json;

		//delete the neighbor from json which have been deleted from web
		for(var i = 0; i < mnets.length; i++) {
			flag = 0;
			for (var j=0; j < datan.length; j++) {
				if((mnets[i] == datan[j])) {
					flag = 1;
					break;
				}
			}
			if(!flag) {
				cmd += "!\n";
				cmd += "router rip\n";
				cmd += "no neighbor " + mnets[i] + "\n";
			}
		}

		//add the neighbor into json which have been added by the web
		for(var i = 0; i < datan.length; i++) {
			flag = 0;
			for (var j=0; j < mnets.length; j++) {
				if((datan[i] == mnets[j])) {
					flag = 1;
					break;
				}
			}
			if(!flag) {
				cmd += "!\n";
				cmd += "router rip\n";
				cmd += "neighbor " + datan[i] + "\n";			
			}
		}
		if((rip_update_timer != rip_timer_update_json) ||
			(rip_timeout_timer != rip_timer_info_json) ||
			(rip_garbage_timer != rip_timer_gc_json)) {
			if(rip_update_timer != "") {
				if(!v_range('_rip_update_timer', quiet, 5, 2147483647))
					return 0;
			}
			if(rip_timeout_timer != "") {
				if(!v_range('_rip_timeout_timer', quiet, 5, 2147483647))
					return 0;
			}
			if(rip_garbage_timer != "") {
				if(!v_range('_rip_garbage_timer', quiet, 5, 2147483647))
					return 0;
			}

			if(rip_update_timer == "")
				rip_update_timer=30;
			if(rip_timeout_timer == "")
				rip_timeout_timer=180;
			if(rip_garbage_timer == "")
				rip_garbage_timer=120;

			cmd += "!\n";
			cmd += "router rip\n";
			cmd += "timers basic " + rip_update_timer + " " + rip_timeout_timer + " " + rip_garbage_timer + "\n";
			ferror.clear('_rip_update_timer');
			ferror.clear('_rip_timeout_timer');
			ferror.clear('_rip_garbage_timer');
		}

		if(rip_version != rip_version_json) {
			cmd += "!\n";
			cmd += "router rip\n";
			if(rip_version == '0') {
				cmd += "no version\n";
			} else {
				cmd += "version " + rip_version + "\n";
			}
		}

		if ((rip_filter_policy_out) != (rip_filter_policy_out_json == 1)){
			if (!rip_filter_policy_out) {
				cmd += "!\n";
				cmd += "router rip\n";
				cmd += "no filter-policy 2 out\n";
			}else{
				cmd += "!\n";
				cmd += "router rip\n";
				cmd += "filter-policy 2 out permit interface default-route\n";
			}
		}		

		if(rip_default_info != rip_default_info_json) {
			cmd += "!\n";
			cmd += "router rip\n";
			if(rip_default_info != '1'){
				cmd += "no default-information originate\n";		
			} else {
				cmd += "default-information originate\n";	
			}
		}

		if(rip_default_metric != "") {
			if(!v_range('_rip_default_metric', quiet, 1, 16)) {
				return 0;
			} else {
				if(rip_default_metric != rip_default_metric_json) {
					cmd += "!\n";
					cmd += "router rip\n";
					cmd += "default-metric " + rip_default_metric +"\n";	
				}
			}
		} else {
			cmd += "no default-metric\n";	
		}
		
		
		var conn_metric_val = rip_conn_json[1]=='-1'?"":rip_conn_json[1];
		if(rip_conn_json[0]!=rip_conn || conn_metric != conn_metric_val) {
			if(!rip_conn) {
				cmd += "!\n";
				cmd += "router rip\n";
				cmd += "no redistribute connected\n";
			}else {
				cmd += "!\n";
				cmd += "router rip\n";
				if(conn_metric == "")
					cmd += "redistribute connected\n";
				else
					cmd += "redistribute connected metric " + conn_metric + "\n";
			}
		}
		var kernel_metric_val = rip_kernel_json[1]=='-1'?"":rip_kernel_json[1];
		if(rip_kernel_json[0]!=rip_kernel || kernel_metric_val != kernel_metric) {
			if(!rip_kernel) {
				cmd += "!\n";
				cmd += "router rip\n";
				cmd += "no redistribute static\n";
			}else {			
				cmd += "!\n";
				cmd += "router rip\n";
				if(kernel_metric == "")
					cmd += "redistribute static\n";
				else
					cmd += "redistribute static metric " + kernel_metric + "\n";
			}
		}
		var ospf_metric_val = rip_ospf_json[1]=='-1'?"":rip_ospf_json[1];
		if(rip_ospf_json[0] !=rip_ospf || ospf_metric_val != ospf_metric) {
			if(!rip_ospf ) {
				cmd += "!\n";
				cmd += "router rip\n";
				cmd += "no redistribute ospf\n";
			} else {
				cmd += "!\n";
				cmd += "router rip\n";
				if(ospf_metric == "")
					cmd += "redistribute ospf\n";
				else
					cmd += "redistribute ospf metric "+ospf_metric+"\n";
			}
		}
		//offset		
		var offset_data = offset.getAllData();
		// delete
		for(var i = 0; i < rip_offset_json.length; i++) {
			var found = 0;
			for(var j = 0; j < offset_data.length; j++) {
				if((rip_offset_json[i][2] == offset_data[j][2]) &&
				(rip_offset_json[i][3] == offset_data[j][3])){
					found = 1;
					break;
				}
			}
			if(!found) {
				cmd += "!\n";
				cmd += "router rip\n";
				cmd += "no offset-list "+ rip_offset_json[i][3] + " " + filter_direct[rip_offset_json[i][1]-1][1] 
					+ " " + rip_offset_json[i][0] + " " + rip_offset_json[i][2]+"\n" ;
			}
		}
		//add
		for(var i = 0; i < offset_data.length; i++) {
			var found = 0;
			var changed = 0;
			for(var j = 0; j < rip_offset_json.length; j++) {
				if(offset_data[i][2]==rip_offset_json[j][2] &&
					offset_data[i][3]==rip_offset_json[j][3]) {
					found = 1;
					if(offset_data[i][0]!=rip_offset_json[j][0] ||
						offset_data[i][1]!=rip_offset_json[j][1]) {
						changed = 1;
					}
					break;
				}
			}
			if(changed) {
				cmd += "!\n";
				cmd += "router rip\n";
				cmd += "no offset-list "+ rip_offset_json[i][3] + " " +filter_direct[rip_offset_json[i][1]-1][1] 
					+ " " + rip_offset_json[i][0] + " " + rip_offset_json[i][2] +"\n";	
				cmd += "offset-list "+ offset_data[i][3] + " " +filter_direct[offset_data[i][1]-1][1] 
					+ " " + offset_data[i][0] + " " + offset_data[i][2] +"\n";	
			} else if (!found) {
				cmd += "!\n";
				cmd += "router rip\n";
				cmd += "offset-list "+ offset_data[i][3] + " " +filter_direct[offset_data[i][1]-1][1] 
					+ " " + offset_data[i][0] + " " + offset_data[i][2] +"\n";	
			}
		}
		//distance		
		var distance_data = distance.getAllData();
		// delete
		for(var i = 0; i < rip_distance_if_json.length; i++) {
			var found = 0;
			for(var j = 0; j < distance_data.length; j++) {
				if((rip_distance_if_json[i][2] == distance_data[j][2]) &&
				(rip_distance_if_json[i][3] == distance_data[j][3]) &&
				(rip_distance_if_json[i][1] == distance_data[j][1])){
					found = 1;
					break;
				}
			}
			if(!found) {
				cmd += "!\n";
				cmd += "router rip\n";
				cmd += "no distance "+ rip_distance_if_json[i][0] + " " +rip_distance_if_json[i][1] + " " + rip_distance_if_json[i][2] + " " 						+rip_distance_if_json[i][3]+"\n";
			}
		}
		//add
		for(var i = 0; i < distance_data.length; i++) {
			var found = 0;
			var changed = 0;
			for(var j = 0; j < rip_distance_if_json.length; j++) {
				if(distance_data[i][1]==rip_distance_if_json[j][1] &&
					distance_data[i][2]==rip_distance_if_json[j][2] &&
					distance_data[i][3]==rip_distance_if_json[j][3]) {
					found = 1;
					if(distance_data[i][0]!=rip_distance_if_json[j][0]) {
						changed = 1;
					}
					break;
				}
			}

			if(changed) {
				cmd += "!\n";
				cmd += "router rip\n";
				cmd += "no distance "+ rip_distance_if_json[i][0] + " " + rip_distance_if_json[i][1] + " " + rip_distance_if_json[i][2]+ " " + rip_distance_if_json[i][3]+"\n";	
				cmd += "distance "+ distance_data[i][0] + " " + distance_data[i][1] + " " + distance_data[i][2]+ " " + distance_data[i][3]+"\n";	
			}

			if(!found) {
				cmd += "!\n";
				cmd += "router rip\n";
				cmd += "distance "+ distance_data[i][0] + " " + distance_data[i][1] + " " + distance_data[i][2]+ " " + distance_data[i][3]+"\n";	
			}
		}
		//distribute		
		var distribute_data = distribute.getAllData();
		// delete
		for(var i = 0; i < rip_distribute_json.length; i++) {
			var found = 0;
			for(var j = 0; j < distribute_data.length; j++) {
				if((rip_distribute_json[i][0] == distribute_data[j][0]) &&
				(rip_distribute_json[i][1] == distribute_data[j][1])){
					found = 1;
					break;
				}
			}
			if(!found) {
				if(rip_distribute_json[i][0] == '1'){
					cmd += "!\n";
					cmd += "router rip\n";
					cmd += "no distribute-list access-list " + rip_distribute_json[i][1] + " " + filter_direct[rip_distribute_json[i][2]-1][1] + " " +rip_distribute_json[i][3] +"\n";	
				}else {
					cmd += "!\n";
					cmd += "router rip\n";
					cmd += "no distribute-list prefix-list " + rip_distribute_json[i][1] + " " + filter_direct[rip_distribute_json[i][2]-1][1] + " " +rip_distribute_json[i][3]+"\n" ;	
				}
			}
		}
		//add
		for(var i = 0; i < distribute_data.length; i++) {
			var found = 0;
			var changed = 0;
			for(var j = 0; j < rip_distribute_json.length; j++) {
				if(distribute_data[i][0]==rip_distribute_json[j][0] &&
					distribute_data[i][1]==rip_distribute_json[j][1]) {
					found = 1;
					if(distribute_data[i][2]!=rip_distribute_json[j][2] ||
						distribute_data[i][3]!=rip_distribute_json[j][3]) {
						changed = 1;
					}
					break;
				}
			}

			if (changed) {
				if(distribute_data[i][0] == '1'){
					cmd += "!\n";
					cmd += "router rip\n";
					cmd += "no distribute-list access-list " + rip_distribute_json[i][1] + " " + filter_direct[rip_distribute_json[i][2]-1][1] + " " + rip_distribute_json[i][3]+"\n";	
					cmd += "distribute-list access-list " + distribute_data[i][1] + " " + filter_direct[distribute_data[i][2]-1][1] + " " +distribute_data[i][3]+"\n";	
				}else {
					cmd += "!\n";
					cmd += "router rip\n";
					cmd += "no distribute-list prefix-list " + rip_distribute_json[i][1] + " " + filter_direct[rip_distribute_json[i][2]-1][1] + " " + rip_distribute_json[i][3]+"\n";	
					cmd += "distribute-list prefix-list " + distribute_data[i][1] + " " + filter_direct[distribute_data[i][2]-1][1] + " " +distribute_data[i][3]+"\n";	
				}	
			} else if (!found) {
				if(distribute_data[i][0] == '1'){
					cmd += "!\n";
					cmd += "router rip\n";
					cmd += "distribute-list access-list " + distribute_data[i][1] + " " + filter_direct[distribute_data[i][2]-1][1] + " " +distribute_data[i][3]+"\n";	
				}else {
					cmd += "!\n";
					cmd += "router rip\n";
					cmd += "distribute-list prefix-list " + distribute_data[i][1] + " " + filter_direct[distribute_data[i][2]-1][1] + " " +distribute_data[i][3]+"\n";	
				}	
			} else {
				;	
			}
		}
		//interface		
		var rip_if_data = rip_if.getAllData();
		// delete
		for(var i = 0; i < rip_if_json.length; i++) {
			var found = 0;
			for(var j = 0; j < rip_if_data.length; j++) {
				if(rip_if_json[i][0] == rip_if_data[j][0]){
					found = 1;
					break;
				}
			}
			if(!found) {
				cmd += "!\n";
				cmd += "interface " + rip_if_json[i][0] + "\n";
				cmd += "no ip rip send version\n";
				cmd += "no ip rip receive version\n";	
				cmd += "no ip rip authentication mode\n";
				cmd += "no ip rip authentication string\n";
				cmd += "no ip rip split-horizon poisoned-reverse\n";
				cmd += "!\n";
				cmd += "router rip\n";
				cmd += "no passive-interface " +  rip_if_json[i][0] +" "+"\n";

			}
		}
		//add
		for(var i = 0; i < rip_if_data.length; i++) {
			var found = 0;
			var changed = 0;
			for(var j = 0; j < rip_if_json.length; j++) {
				if(rip_if_data[i][0]==rip_if_json[j][0]) {
					found = 1;
					if(rip_if_data[i][1]!=rip_if_json[j][1] ||
						rip_if_data[i][2]!=rip_if_json[j][2] ||
						rip_if_data[i][3]!=rip_if_json[j][3] ||
						rip_if_data[i][4]!=rip_if_json[j][4] ||
						rip_if_data[i][5]!=rip_if_json[j][5] ||
						rip_if_data[i][6]!=rip_if_json[j][6]) {
						changed = 1;
					}
					break;
				}
			}
			if(!found || changed) {
				
				if(rip_if_data[i][1] == '1'){			
					cmd += "!\n";
					cmd += "router rip\n";	
					cmd += "passive-interface " +  rip_if_data[i][0] +" "+"\n";
				}else {
					cmd += "!\n";
					cmd += "router rip\n";
					cmd += "no passive-interface " +  rip_if_data[i][0] +" "+"\n";
				}
				if(rip_if_data[i][2] !='0'){
					cmd += "!\n";
					cmd += "interface " + rip_if_data[i][0] + "\n";
					cmd += "ip rip send version " + rip_if_data[i][2]+ " " +"\n";	
				}else {
					cmd += "!\n";
					cmd += "interface " + rip_if_data[i][0] + "\n";
					cmd += "no ip rip send version\n";	
				}
				if(rip_if_data[i][3]!='0'){
					cmd += "!\n";
					cmd += "interface " + rip_if_data[i][0] + "\n";
					cmd += "ip rip receive version " + rip_if_data[i][3]+ " " +"\n";
				}else {
					cmd += "!\n";
					cmd += "interface " + rip_if_data[i][0] + "\n";
					cmd += "no ip rip receive version\n";
				}	
				 	
				if(rip_if_data[i][5]!='0'){
					cmd += "!\n";
					cmd += "interface " + rip_if_data[i][0] + "\n";
					cmd += "ip rip authentication mode " + rip_auth_mode[rip_if_data[i][5]][1]  +"\n";
					cmd += "ip rip authentication string " + rip_if_data[i][6] +"\n";
				}else {
					cmd += "!\n";
					cmd += "interface " + rip_if_data[i][0] + "\n";
					cmd += "no ip rip authentication mode\n";
					cmd += "no ip rip authentication string\n";
				}
							
				if(rip_if_data[i][4] == '1'){
					cmd += "!\n";
					cmd += "interface " + rip_if_data[i][0] + "\n";
					cmd += "ip rip split-horizon\n";
				} else if(rip_if_data[i][4] == '0'){
					cmd += "!\n";
					cmd += "interface " + rip_if_data[i][0] + "\n";
					cmd += "ip rip split-horizon poisoned-reverse\n";
				}else {
				 	cmd += "!\n";
					cmd += "interface " + rip_if_data[i][0] + "\n";
					cmd += "no ip rip split-horizon poisoned-reverse\n";
				}
			}
		}
	}
	
	//alert(cmd);
	if (user_info.priv < admin_priv) {
		elem.display('save-button', 'cancel-button', false);
	}else{
		elem.display('save-button', 'cancel-button', true);
		fom._web_cmd.value = cmd;
		E('save-button').disabled = (cmd=="");	
	}
	
	return 1;
}

function save()
{
	if (!verifyFields(null, false)) return;
	
	if (network.isEditing()) return;
	if (neighbor.isEditing()) return;
	if (offset.isEditing()) return;
	if (distribute.isEditing()) return;
	if (distance.isEditing()) return;	
	if (rip_if.isEditing()) return;
	var fom = E('_fom');
	
	if((E('_fom')._web_cmd.value != '')&&(cookie.get('autosave') == 1)){
		E('_fom')._web_cmd.value += "!"+"\n"+"copy running-config startup-config"+"\n";	
	}
	form.submit(fom, 1);
}

function earlyInit()
{
	if(cookie.get('rip_advanced') == null) {
		cookie.set('rip_advanced', 0);
	}
	network.setup();
	neighbor.setup();
	offset.setup();
	distribute.setup();
	distance.setup();
	rip_if.setup();
	verifyFields(null, 1);
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
<script type='text/javascript'>
createFieldTable('', [{ title: ui.enable, name: 'f_rip_enable', type: 'checkbox', value: rip_enable_json=='1' },	
	{ title: rip.update_timer, name: 'rip_update_timer', type: 'text', maxlen: 6, size: 8, suffix: ui.second, value: rip_timer_update_json },
	{ title: rip.timeout_timer, name: 'rip_timeout_timer', type: 'text', maxlen: 6, size: 8, suffix: ui.second, value: rip_timer_info_json },
	{ title: rip.garbage_timer, name: 'rip_garbage_timer', type: 'text', maxlen: 6, size: 8, suffix: ui.second, value: rip_timer_gc_json },
	{ title: rip.version, name: 'rip_version', type: 'select', options:rip_version_type, value: rip_version_json }]);
</script>
</div>


<div class='section'>
<script type='text/javascript'>
createFieldTable('', [
	{ title: '<b>' + ui.advanced + '</b>', indent: 0, name: 'rip_advanced', type: 'checkbox', value: cookie.get('rip_advanced')==1},	

	{ title: rip.default_info, name: 'rip_default_info', type: 'checkbox', value: rip_default_info_json==1},
	{ title: rip.default_metric, name: 'rip_default_metric', type:'text', maxlen:16, size:16, value:rip_default_metric_json},
	{ title: rip.redistr_conn, name: 'rip_redistr_conn', type: 'checkbox', value: rip_conn_json[0]==1},
	{ title: rip.metric, indent: 2, name: 'conn_metric', type:'text', maxlen:16, size:16, value:(rip_conn_json[1]==-1)?"":rip_conn_json[1]},
	{ title: rip.redistr_static, name: 'rip_redistr_kernel', type: 'checkbox', value: rip_kernel_json[0] == 1 },
	{ title: rip.metric, indent: 2, name: 'kernel_metric', type:'text', maxlen:16, size:16, value:(rip_kernel_json[1]==-1)?"":rip_kernel_json[1]},
	{ title: rip.redistr_ospf, name: 'rip_redistr_ospf', type: 'checkbox', value: rip_ospf_json[0] == 1 },
	{ title: rip.metric, indent: 2, name: 'ospf_metric', type:'text', maxlen:16, size:16, value:(rip_ospf_json[1]==-1)?"":rip_ospf_json[1]}
]);
</script>
</div>


<div id='distance_title' class='section-title'>
<script type="text/javascript">
	GetText(rip.distance_mgnt);
</script>
</div>
<div id='distance_body' class='section'>
	<table class='web-grid' id='distance-grid'></table>
</div>
<div id='offset_body' class='section'>
	<table class='web-grid' id='offset-grid'></table>
</div>


<div id='distribute_title' class='section-title'>
<script type="text/javascript">
	GetText(rip.distribute);
</script>
</div>
<div id='distribute_body' class='section'>
	<table class='web-grid' id='distribute-grid'></table>
</div>
<div class='section'>
<script type='text/javascript'>
createFieldTable('', [
	{ title: rip.filter_out, name: 'rip_filter_policy_out', type: 'checkbox', value: rip_filter_policy_out_json==1}
]);
</script>
</div>


<div id='rip-if_title' class='section-title'>
<script type="text/javascript">
	GetText(rip.interface);
</script>
</div>
<div id='rip-if_body' class='section'>
	<table class='web-grid' id='rip-if-grid'></table>
</div>


<div id='neighbor_title' class='section-title'>
<script type="text/javascript">
	GetText(rip.neighbor);
</script>
</div>
<div id='neighbor_body' class='section'>
	<table class='web-grid' id='neighbor-grid'></table>
</div>


<div id='network_title' class='section-title'>
<script type="text/javascript">
	GetText(rip.network);
</script>
</div>
<div id='network_body' class='section'>
	<table class='web-grid' id='network-grid'></table>
</div>

</form>

<script type='text/javascript'>
if(cookie.get('autosave') == 1)
	ui.aply=ui.aply_save;
genStdFooter("");
</script>
<script type='text/javascript'>earlyInit()</script>
</body>
</html>
