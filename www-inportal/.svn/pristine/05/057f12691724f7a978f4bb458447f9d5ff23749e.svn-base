<% pagehead(menu.route_ripd) %>

<style type='text/css'>

#network-grid {
	width: 450px;
}
#network-grid .co1 {
	width: 150px;
	text-align: center;
}
#network-grid .co2 {
	width: 150px;
	text-align: center;
}
#network-grid .co3 {
	width: 150px;
	text-align: center;
}

#range-grid {
	width: 550px;
	text-align: center;
}
#range-grid .co1 {
	width: 100px;
}
#range-grid.co2 {
	width: 150px;
}
#range-grid .co3 {
	width: 150px;
}
#range-grid .co4 {
	width: 50px;
}
#range-grid .co5 {
	width: 100px;
}

#filter-grid {
	width: 350px;
	text-align: center;
}
#filter-grid .co1 {
	width: 100px;
}
#filter-grid.co2 {
	width: 100px;
}
#filter-grid .co3 {
	width: 150px;
}

#type-grid {
	width: 450px;
	text-align: center;
}
#type-grid .co1 {
	width: 150px;
}
#type-grid.co2 {
	width: 100px;
}
#type-grid .co3 {
	width: 50px;
}
#type-grid .co4 {
	width: 150px;
}

#vlink-grid {
	width: 850px;
	text-align: center;
}
#vlink-grid .co1 {
	width: 80px;
}
#vlink-grid.co2 {
	width: 150px;
}
#vlink-grid .co3 {
	width: 80px;
}
#vlink-grid .co4 {
	width: 80px;
}
#vlink-grid .co5 {
	width: 80px;
}
#vlink-grid .co6 {
	width: 80px;
}
#vlink-grid .co7 {
	width: 80px;
}
#vlink-grid .co8 {
	width: 80px;
}
#vlink-grid .co9 {
	width: 80px;
}


#redistribute-grid {
	width: 400px;
	text-align: center;
}
#redistribute-grid .co1 {vlin
	width: 100px;
}
#redistribute-grid .co2 {
	width: 100px;
}
#redistribute-grid .co3 {
	width: 100px;
}
#redistribute-grid .co4 {
	width: 100px;
}
/*
#distribute-grid {
	width: 300px;
	text-align: center;
}
#distribute-grid .co1 {
	width: 150px;
}
#distribute-grid.co2 {
	width: 150px;
}
*/
#distance-grid {
	width: 300px;
	text-align: center;
}
#distance-grid .co1 {
	width: 150px;
}
#distance-grid.co2 {
	width: 150px;
}

#if_basic-grid {
	width: 500px;
	text-align: center;
}
#if_basic-grid .co1 {
	width: 120px;
}
#if_basic-grid .co2 {
	width: 100px;
}
#interface_basic-grid .co3 {
	width: 70px;
}
#if_basic-grid .co4 {
	width: 70px;
}
#if_basic-grid .co5 {
	width: 70px;
}
#if_basic-grid .co6 {
	width: 70px;
}

#if_adv-grid {
	width: 580px;
	text-align: center;
}
#if_adv-grid .co1 {
	width: 120px;
}
#if_adv-grid .co2 {
	width: 70px;
}
#if_adv-grid .co3 {
	width: 70px;
}
#if_adv-grid .co4 {
	width: 70px;
}
#if_adv-grid .co5 {
	width: 100px;
}
#if_adv-grid .co6 {
	width: 70px;
}
#if_adv-grid .co7 {
	width: 70px;
}


</style>

<script type='text/javascript'>

<% ih_sysinfo(); %>
<% ih_user_info(); %>
/*
var ospf_config=[
'1',
[['1.1.1.1','255.255.255.0',123],['4.4.4.4','255.255.255.0',456]],
'1.2.3.4',
'1',
'0',
'1',
'100',
'200',
'2000',
'1',
'2000',
'101',
[['100','1.1.1.1','255.255.0.0','1','200','3', 'acl-name1'],['200','1.1.1.2','255.255.0.0','0','220','2', 'acl-name2']],
[['101','3','1','2' ],['102','4','0','1']],
[['103', '2.2.2.2', '2', '20', 'okok', '10', '40', '20', '5'],['106', '20.12.2.2', '1', '', 'okok', '20', '80', '10', '6']],
[['2', '132', '2', 'routemap-name'],['3','244','1','routemap2']],
'200',
'1',
'210',
'2',
'default-info routemap',
[['distribute-acl-name1','2'],['distribute-acl2','3']],
'123',
[['1','20'],['2','40']],
[['fastethernet 0/1','3','40','10','1','5']],
[['fastethernet 0/2','1','123','20','2','5','koko']]
];
*/
<% web_exec('show running-config ospf')%>
<% web_exec('show interface')%>
var vifs = [].concat(cellular_interface, eth_interface, sub_eth_interface, svi_interface, xdsl_interface, gre_interface, vp_interface,openvpn_interface);
var now_vifs_options = new Array();
now_vifs_options = grid_list_all_vif_opts(vifs);

var network_type=[['1','broadcast'], ['2','non-broadcast'],['3','point-to-multipoint'],['4','point-to-point']];
var abr_type=[['1','cisco'], ['2','ibm'],['3','standard'],['4','shortcut']];
var max_metric_type=[['1','startup'], ['2','shutdown'],['3','administrative']];
var auth_type=[['0',''],['1','authentication'], ['2','message-digital']];
var area_sort=[['0',''],
		['1','stub'], 
		['2','nssa-translate-always'],
		['3','nssa-translate-candidate'],
		['4','nssa-translate-never']
		];
var filter_type=[['0', ''],['1', 'import'], ['2','export'], ['3','filter-in'],['4','filter-out']];
var redistribute_type=[['1','connected'],['2','static'], ['3', 'rip']];
var distance_type=[['1','inter-area'],['2','intra-area'],['3','external']];
var metric_type=[['0',''],['1', '1'], ['2', '2']];			
var ospf_types=[[1,'Broadcast'],[2,'NBMA'],[3,'Point-to-Multipoint'],[4,'Point-to-Point']];

var enable_json=ospf_config[0];
var network_json=ospf_config[1];
var router_id_json=ospf_config[2];
var abr_type_json = ospf_config[3];
var rfc1583_json=ospf_config[4];
var opaque_json=ospf_config[5];

var spf_delay_json=ospf_config[6];
var spf_init_json=ospf_config[7];
var spf_max_json=ospf_config[8];
var max_metric_json=ospf_config[9];
var max_metric_val_json=ospf_config[10];
var bandwidth_json=ospf_config[11];

var area_range_json=ospf_config[12];
var area_filter_json=ospf_config[13];
var area_type_json=ospf_config[14];
var area_vlink_json=ospf_config[15];

var redistribute_json=ospf_config[16];
var def_metric_json=ospf_config[17];
var info_always_json=ospf_config[18];
var info_metric_json=ospf_config[19];
var info_type_json=ospf_config[20];
var info_routemap_json=ospf_config[21];
var distribute_json = ospf_config[22];

var distance_adm_json= ospf_config[23];
var distance_json= ospf_config[24];
var if_basic_json = ospf_config[25];
var if_adv_json = ospf_config[26];


var network = new webGrid();
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
		ferror.clear(f[0]);
	}

	if(!v_range(f[2], quiet, 0, 4294967295)) {
		return 0;
	} else if(f[2].value.length == 0) {
		ferror.set(f[2], errmsg.adm3, quiet);
		return 0;
	} else {
		ferror.clear(f[0]);
	}
	return 1;	
}
network.resetNewEditor = function()
{
	var f = fields.getAll(this.newEditor);

	f[0].value = '';
	f[1].value = '';
	f[2].value = '';

	ferror.clearAll(fields.getAll(this.newEditor));	
}
network.setup = function()
{
	this.init('network-grid', 'move', 64, [
		{ type: 'text', maxlen: 32 }, 
		{ type: 'text', maxlen: 32 }, 
		{ type: 'text', maxlen: 32 } 
	]);
	this.headerSet([ui.ip, ui.netmask, ospf.area_id]);

	for (var i = 0; i < network_json.length; i++)
		this.insertData(-1, [network_json[i][0], network_json[i][1], network_json[i][2]]);
	this.showNewEditor();
	this.resetNewEditor();
}

var area_type = new webGrid();
function display_disable_area_type(e)
{	
	var x = e?"":"none";
	
	E('type-grid').style.display = x;
	E('type_title').style.display = x;
	E('type_body').style.display = x;

	E('type-grid').disabled = !e;
	E('type_title').disabled = !e;
	E('type_body').disabled = !e;
	return 1;
}

area_type.exist = function(f, v)
{
	var data = this.getAllData();
	for (var i = 0; i < data.length; ++i) {
		if (data[i][f] == v) return true;
	}
	return false;
}
area_type.existName = function(name)
{
	return this.exist(0, name);
}
area_type.onDataChanged = function() 
{
	verifyFields(null, 1);
}
area_type.verifyFields = function(row, quiet)
{
	var f = fields.getAll(row);
	if(!v_range(f[0], quiet, 0, 4294967295)) {
		return 0;
	} else if(f[0].value.length == 0) {
		ferror.set(f[0], errmsg.adm3, quiet);
		return 0;
	} else {
		ferror.clear(f[0]);
	}
	if(f[1].value == '0'){
		f[2].disabled=true;
		if(f[3].value == '0') {
			ferror.set(f[3], errmsg.adm3, quiet);
			return 0;
		} else {
			ferror.clear(f[3]);
		}
	}
	return 1;	
}
area_type.resetNewEditor = function()
{
	var f = fields.getAll(this.newEditor);

	f[0].value = '';
	f[1].value = '';
	f[2].value = '';
	f[3].value = '';
	ferror.clearAll(fields.getAll(this.newEditor));	
}
area_type.setup = function()
{
	this.init('type-grid', 'move', 64, [		
		{ type: 'text', maxlen: 32 }, 
		{ type: 'select', options: area_sort },		
		{ type: 'checkbox'},		
		{ type: 'select', options: auth_type}
	]);
	this.headerSet([ospf.area_id, ospf.area, ospf.summary, ospf.auth]);

	for (var i = 0; i < area_type_json.length; i++)
		this.insertData(-1, [area_type_json[i][0], area_type_json[i][1], area_type_json[i][2], area_type_json[i][3]]);
	this.showNewEditor();
	this.resetNewEditor();
}
area_type.dataToView = function(data) 
{
	return [data[0], area_sort[data[1]][1], (data[2] != '0') ? ui.yes : ui.no, auth_type[data[3]][1]];
}
area_type.fieldValuesToData = function(row)
{
	var f = fields.getAll(row);
	return [f[0].value, f[1].value, f[2].checked ? 1 : 0, f[3].value];
}

var area_range = new webGrid();
function display_disable_area_range(e)
{	
	var x = e?"":"none";
	
	E('range-grid').style.display = x;
	E('range_title').style.display = x;
	E('range_body').style.display = x;

	E('range-grid').disabled = !e;
	E('range_title').disabled = !e;
	E('range_body').disabled = !e;
	return 1;
}

area_range.exist = function(f, v)
{
	var data = this.getAllData();
	for (var i = 0; i < data.length; ++i) {
		if (data[i][f] == v) return true;
	}
	return false;
}
area_range.existName = function(name)
{
	return this.exist(0, name);
}
area_range.onDataChanged = function() {
	verifyFields(null, 1);
}
area_range.verifyFields = function(row, quiet)
{
	var f = fields.getAll(row);
	if(!v_range(f[0], quiet, 0, 4294967295)) {
		return 0;
	} else if(f[0].value.length == 0) {
		ferror.set(f[0], errmsg.adm3, quiet);
		return 0;
	} else {
		ferror.clear(f[0]);
	} 
	if(f[1].value != "" && !v_ip(f[1], quiet)) {
		return 0;
	} else {
		ferror.clear(f[1]);
	}
	if(f[1].value != "" && !v_mask(f[2], quiet)) {
		return 0;
	} else {
		ferror.clear(f[2]);
	}
	if(this.existName(f[0].value) &&
		this.existName(f[1].value) && 
		this.existName(f[2].value) 
		) {
		ferror.set(f[0], errmsg.bad_name4, quiet);
		return 0;
	}else {
		ferror.clear(f[0]);
	}
	if(!v_range(f[4], quiet, 0, 16777215)) {
		return 0;
	} else {
		ferror.clear(f[4]);
	}
	return 1;	
}
area_range.resetNewEditor = function()
{
	var f = fields.getAll(this.newEditor);

	f[0].value = '';
	f[1].value = '';
	f[2].value = '';
	f[3].value = '';
	f[4].value = '';
	ferror.clearAll(fields.getAll(this.newEditor));	
}
area_range.setup = function()
{
	this.init('range-grid', 'move', 64, [
		{ type: 'text', maxlen: 32 }, 
		{ type: 'text', maxlen: 32 }, 
		{ type: 'text', maxlen: 32 },
		{ type: 'checkbox'},
 		{ type: 'text', maxlen: 32 }
	]);
	this.headerSet([ospf.area_id, ui.ip, ui.netmask, ospf.adver,  ospf.cost]);
	for (var i = 0; i < area_range_json.length; i++)
		this.insertData(-1, [area_range_json[i][0], area_range_json[i][1], area_range_json[i][2], area_range_json[i][3], area_range_json[i][4]]);
	this.showNewEditor();
	this.resetNewEditor();
}
area_range.dataToView = function(data) 
{
	return [data[0], data[1], data[2],(data[3] != '0') ? ui.yes : ui.no, data[4]];
}
area_range.fieldValuesToData = function(row)
{
	var f = fields.getAll(row);
	return [f[0].value, f[1].value, f[2].value, f[3].checked ? 1 : 0, f[4].value];
}


var area_filter = new webGrid();
function display_disable_area_filter(e)
{	
	var x = e?"":"none";
	
	E('filter-grid').style.display = x;
	E('filter_title').style.display = x;
	E('filter_body').style.display = x;

	E('filter-grid').disabled = !e;
	E('filter_title').disabled = !e;
	E('filter_body').disabled = !e;
	return 1;
}

area_filter.exist = function(f, v)
{
	var data = this.getAllData();
	for (var i = 0; i < data.length; ++i) {
		if (data[i][f] == v) return true;
	}
	return false;
}
area_filter.existName = function(name)
{
	return this.exist(0, name);
}
area_filter.onDataChanged = function() {
	verifyFields(null, 1);
}
area_filter.verifyFields = function(row, quiet)
{
	var f = fields.getAll(row);
	if(!v_range(f[0], quiet, 0, 4294967295)) {
		return 0;
	} else if(f[0].value.length == 0) {
		ferror.set(f[0], errmsg.adm3, quiet);
		return 0;
	} else {
		ferror.clear(f[0]);
	} 
	if(f[1].value!='0'){
		if(f[2].value == ''){		
			ferror.set(f[2], errmsg.adm3, quiet);
			return 0;
		}else {
			ferror.clear(f[2]);
		}
	}
	return 1;	
}
area_filter.resetNewEditor = function()
{
	var f = fields.getAll(this.newEditor);

	f[0].value = '';
	f[1].value = '';
	f[2].value = '';
	ferror.clearAll(fields.getAll(this.newEditor));	
}
area_filter.setup = function()
{
	this.init('filter-grid', 'move', 64, [
		{ type: 'text', maxlen: 32 },
		{ type: 'select', options: filter_type },	
		{ type: 'text', maxlen: 32 }
	]);
	this.headerSet([ospf.area_id,  ospf.filter, ospf.acl]);
	for (var i = 0; i < area_filter_json.length; i++)
		this.insertData(-1, [area_filter_json[i][0], area_filter_json[i][1], area_filter_json[i][2]]);
	this.showNewEditor();
	this.resetNewEditor();
}
area_filter.dataToView = function(data) 
{
	return [data[0],  filter_type[data[1]][1], data[2]];
}

var area_vlink = new webGrid();
function display_disable_area_vlink(e)
{	
	var x = e?"":"none";
	
	E('vlink-grid').style.display = x;
	E('vlink_title').style.display = x;
	E('vlink_body').style.display = x;

	E('vlink-grid').disabled = !e;
	E('vlink_title').disabled = !e;
	E('vlink_body').disabled = !e;
	return 1;
}

area_vlink.exist = function(f, v)
{
	var data = this.getAllData();
	for (var i = 0; i < data.length; ++i) {
		if (data[i][f] == v) return true;
	}
	return false;
}
area_vlink.existName = function(name)
{
	return this.exist(0, name);
}
area_vlink.onDataChanged = function() {
	verifyFields(null, 1);
}
area_vlink.verifyFields = function(row, quiet)
{
	var f = fields.getAll(row);
	if(!v_range(f[0], quiet, 0, 4294967295)) {
		return 0;
	} else if(f[0].value.length == 0) {
		ferror.set(f[0], errmsg.adm3, quiet);
		return 0;
	} else {
		ferror.clear(f[0]);
	}
	if(this.existName(f[1].value)) {
		ferror.set(f[1], errmsg.bad_addr2, quiet);
		return 0;
	} else if(!v_ip(f[1], quiet)) {
		return 0;
	} else {
		ferror.clear(f[1]);
	}
	if(f[2].value == '2'){
		if(!v_range(f[3], quiet, 1, 255)) {
			return 0;
		} else if(f[3].value.length == 0) {
			ferror.set(f[3], errmsg.adm3, quiet);
			return 0;
		} else {
			ferror.clear(f[3]);
		}
		if(f[4].value.length == 0) {
			ferror.set(f[4], errmsg.adm3, quiet);
			return 0;
		} else {
			ferror.clear(f[4]);
		}
	}else if(f[2].value == '1'){
		if(f[4].value.length == 0) {
			ferror.set(f[4], errmsg.adm3, quiet);
			return 0;
		} else {
			ferror.clear(f[4]);
		}
	}
	if(f[5].value != '' && !v_range(f[5], quiet, 1, 65535)) {
		return 0;
	} else {
		ferror.clear(f[5]);
	}
	if(f[6].value != '' && !v_range(f[6], quiet, 1, 65535)) {
		return 0;
	} else {
		ferror.clear(f[6]);
	}
	if(f[7].value != '' && !v_range(f[7], quiet, 1, 65535)) {
		return 0;
	} else {
		ferror.clear(f[7]);
	}
	if(f[8].value != '' && !v_range(f[8], quiet, 1, 65535)) {
		return 0;
	} else {
		ferror.clear(f[8]);
	}
	return 1;	
}
area_vlink.resetNewEditor = function()
{
	var f = fields.getAll(this.newEditor);

	f[0].value = '';
	f[1].value = '';
	f[2].value = '';
	f[3].value = '';
	f[4].value = '';
	f[5].value = '10';
	f[6].value = '40';
	f[7].value = '5';
	f[8].value = '1';
	ferror.clearAll(fields.getAll(this.newEditor));	
}
area_vlink.setup = function()
{
	this.init('vlink-grid', 'move', 64, [
		{ type: 'text', maxlen: 32 }, 
		{ type: 'text', maxlen: 32 }, 
		{ type: 'select', options: auth_type },
		{ type: 'text', maxlen: 32 },
 		{ type: 'password', maxlen: 32 },
		{ type: 'text', maxlen: 32 },
 		{ type: 'text', maxlen: 32 },
		{ type: 'text', maxlen: 32 },
 		{ type: 'text', maxlen: 32 },
		
	]);
	this.headerSet([ospf.area_id, ospf.abr,  ospf.auth, ospf.keyid, ospf.key, ospf.hello_interval, ospf.dead_interval, ospf.retrans_interval, ospf.trans_delay]);

	for (var i = 0; i < area_vlink_json.length; i++)
		this.insertData(-1, [area_vlink_json[i][0], area_vlink_json[i][1], area_vlink_json[i][2], area_vlink_json[i][3], area_vlink_json[i][4], area_vlink_json[i][5], area_vlink_json[i][6], area_vlink_json[i][7],area_vlink_json[i][8]]);
	this.showNewEditor();
	this.resetNewEditor();
}
area_vlink.dataToView = function(data) 
{
	return [data[0], data[1], auth_type[data[2]][1], data[3], (data[4]=='')?'':'******',data[5],data[6],data[7],data[8]];
}

var redistribute = new webGrid();
function display_disable_redistribute(e)
{	
	var x = e?"":"none";
	
	E('redistribute-grid').style.display = x;
	E('redistribute_title').style.display = x;
	E('redistribute_body').style.display = x;

	E('redistribute-grid').disabled = !e;
	E('redistribute_title').disabled = !e;
	E('redistribute_body').disabled = !e;
	return 1;
}

redistribute.exist = function(f, v)
{
	var data = this.getAllData();
	for (var i = 0; i < data.length; ++i) {
		if (data[i][f] == v) return true;
	}
	return false;
}
redistribute.existName = function(name)
{
	return this.exist(0, name);
}
redistribute.onDataChanged = function() 
{
	verifyFields(null, 1);
}
redistribute.verifyFields = function(row, quiet)
{
	var f = fields.getAll(row);
	if(this.existName(f[0].value)) {
		ferror.set(f[0], errmsg.bad_name4, quiet);
		return 0;
	} else {
		ferror.clear(f[0]);
	}
	if(!v_range(f[1], quiet, 0, 16777214)) {
		return 0;
	} else {
		ferror.clear(f[1]);
	}
	if(f[1].value == ''){
		f[2].disabled =true;	
	}else {
		f[2].disabled =false;	
	}
	f[3].disabled =true;
	return 1;	
}

redistribute.setup = function()
{
	this.init('redistribute-grid', 'move', 3, [
		{ type: 'select', options: redistribute_type },
		{ type: 'text', maxlen: 32 }, 
		{ type: 'select', options: metric_type },
 		{ type: 'text', maxlen: 32 }
	]);
	this.headerSet([ospf.redistr_type, ospf.metric, ospf.metric_type, ospf.routemap]);
	for (var i = 0; i < redistribute_json.length; i++)
		this.insertData(-1, [redistribute_json[i][0], redistribute_json[i][1], redistribute_json[i][2], redistribute_json[i][3]]);
	this.showNewEditor();
	this.resetNewEditor();
}
redistribute.resetNewEditor = function()
{
	var f = fields.getAll(this.newEditor);

	f[0].value = '';
	f[1].value = '';
	f[2].value = '';
	f[3].value = '';
	ferror.clearAll(fields.getAll(this.newEditor));	
}
redistribute.dataToView = function(data) 
{
	return [redistribute_type[data[0]-1][1], data[1], metric_type[data[2]][1], data[3]];
}
/*
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
distribute.onDataChanged = function() 
{
	verifyFields(null, 1);
}
distribute.verifyFields = function(row, quiet)
{
	var f = fields.getAll(row);
	if(this.existName(f[0].value)) {
		ferror.set(f[1], errmsg.bad_name4, quiet);
		return 0;
	} else {
		ferror.clear(f[0]);
	}
	return 1;	
}
distribute.setup = function()
{
	this.init('distribute-grid', 'move', 64, [
		{ type: 'text', maxlen: 32 }, 
		{ type: 'select', options: redistribute_type}
	]);
	this.headerSet([ospf.acl, ospf.redistr_type]);
	for (var i = 0; i < distribute_json.length; i++)
		this.insertData(-1, [distribute_json[i][0], distribute_json[i][1]]);
	this.showNewEditor();
	this.resetNewEditor();
}
distribute.resetNewEditor = function()
{
	var f = fields.getAll(this.newEditor);

	f[0].value = '';
	f[1].value = '';
	ferror.clearAll(fields.getAll(this.newEditor));	
}
distribute.dataToView = function(data) 
{
	return [data[0], redistribute_type[data[1]-1][1]];
}
*/

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
distance.onDataChanged = function() 
{
	verifyFields(null, 1);
}
distance.verifyFields = function(row, quiet)
{
	var f = fields.getAll(row);
	if(this.existName(f[0].value)) {
		ferror.set(f[0], errmsg.bad_name4, quiet);
		return 0;
	} else {
		ferror.clear(f[0]);
	}
	if(!v_range(f[1], quiet, 1, 255)) {
		return 0;
	} else if(f[1].value.length == 0) {
		ferror.set(f[1], errmsg.adm3, quiet);
		return 0;
	} else {
		ferror.clear(f[1]);
	}
	return 1;	
}
distance.setup = function()
{
	this.init('distance-grid', 'move', 3, [
		{ type: 'select', options: distance_type},
		{ type: 'text', maxlen: 32 }
	]);
	this.headerSet([ospf.type, ospf.distance]);
	for (var i = 0; i < distance_json.length; i++)
		this.insertData(-1, [distance_json[i][0], distance_json[i][1]]);
	this.showNewEditor();
	this.resetNewEditor();
}
distance.resetNewEditor = function()
{
	var f = fields.getAll(this.newEditor);

	f[0].value = '';
	f[1].value = '';
	ferror.clearAll(fields.getAll(this.newEditor));	
}
distance.dataToView = function(data) 
{
	return [distance_type[data[0]-1][1],data[1]];
}

var if_basic = new webGrid();
function display_disable_if_basic(e)
{	
	var x = e?"":"none";
	
	E('if_basic-grid').style.display = x;
	E('if_basic_title').style.display = x;
	E('if_basic_body').style.display = x;

	E('if_basic-grid').disabled = !e;
	E('if_basic_title').disabled = !e;
	E('if_basic_body').disabled = !e;
	return 1;
}
if_basic.exist = function(f, v)
{
	var data = this.getAllData();
	for (var i = 0; i < data.length; ++i) {
		if (data[i][f] == v) return true;
	}
	return false;
}

if_basic.existName = function(name)
{
	return this.exist(0, name);
}

if_basic.onDataChanged = function() {
	verifyFields(null, 1);
}

if_basic.dataToView = function(data)
{
	var net_type;
	if(data[1] == 1) {
		net_type = "Broadcast";
	} else if(data[1] == 2) {
		net_type = "NBMA";
	} else if(data[1] == 3) {
		net_type = "Point To Multipoint";
	} else if(data[1] == 4) {
		net_type = "Point To Point";
	}

	return [data[0], net_type, data[2], data[3], data[4],data[5]];
}

if_basic.verifyFields = function(row,quiet)
{
	var f = fields.getAll(row);

	if(f[0].value == "" ){
		ferror.set(f[0], errmsg.adm3, quiet);
		return 0;
	}else if(this.existName(f[0].value)) {
		ferror.set(f[0], errmsg.bad_name4, quiet);
		return 0;
	} else {
		ferror.clear(f[0]);
	} 
	if((f[2].value != "") && (!v_range(f[2], quiet, 1, 65535))) {	//hello interval
		return 0;
	}

	if((f[3].value != "") && (!v_range(f[3], quiet, 1, 65535))) {	//dead interval
		return 0;
	}

	if((f[4].value != "") && (!v_range(f[4], quiet, 3, 65535))) {	//retransmit interval
		return 0;
	}

	if((f[5].value != "") && (!v_range(f[5], quiet, 1, 65535))) {	//transmit delay
		return 0;
	}
	
    return 1;
}

if_basic.resetNewEditor = function()
{
	var f = fields.getAll(this.newEditor);
	//init value
	f[0].value = '0';
	f[1].value = '1';
	f[2].value = '10';
	f[3].value = '40';
	f[4].value = '5';
	f[5].value = '1';
		
	ferror.clearAll(fields.getAll(this.newEditor));
}

if_basic.setup = function()
{
	grid_vif_opts_add(now_vifs_options, "");
	this.init('if_basic-grid', 'move', 100, [
		{ type: 'select', options: now_vifs_options }, 
		{ type: 'select', options: ospf_types },
		{ type: 'text', maxlen: 32 }, 
		{ type: 'text', maxlen: 32 }, 
		{ type: 'text', maxlen: 32 }, 
		{ type: 'text', maxlen: 32 }
	]);
	this.headerSet([ui.interface_name, ospf.network, ospf.hello_interval, ospf.dead_interval, ospf.retrans_interval, ospf.trans_delay]);
	
	for (var i = 0; i < if_basic_json.length; i++) {
		this.insertData(-1, [ if_basic_json[i][0],  if_basic_json[i][1],  if_basic_json[i][2], if_basic_json[i][3], if_basic_json[i][4], if_basic_json[i][5]]);
	}

	this.showNewEditor();
	this.resetNewEditor();
}


var if_adv = new webGrid();
function display_disable_if_adv(e)
{	
	var x = e?"":"none";
	
	E('if_adv-grid').style.display = x;
	E('if_adv_body').style.display = x;

	E('if_adv-grid').disabled = !e;
	E('if_adv_body').disabled = !e;
	return 1;
}
if_adv.exist = function(f, v)
{
	var data = this.getAllData();
	for (var i = 0; i < data.length; ++i) {
		if (data[i][f] == v) return true;
	}
	return false;
}

if_adv.existName = function(name)
{
	return this.exist(0, name);
}

if_adv.onDataChanged = function() {
	verifyFields(null, 1);
}

if_adv.verifyFields = function(row,quiet)
{
	var f = fields.getAll(row);

	if(f[0].value == "" || this.existName(f[0].value)) {
		ferror.set(f[0], errmsg.bad_name4, quiet);
		return 0;
	} else {
		ferror.clear(f[0]);
	}
	if((f[2].value != "") && (!v_range(f[2], quiet, 1, 65535))) {	//cost
		return 0;
	} 
	if((f[3].value != "") && (!v_range(f[3], quiet, 0, 255))) {		//priority
		return 0;
	}
	if(f[4].value == '2'){
		f[5].disabled = false;
		if(!v_range(f[5], quiet, 1, 255)) return 0;
		if(f[6].value == '0'){
			ferror.set(f[6], errmsg.bad_name4, quiet);
			return 0;
		} else {
			ferror.clear(f[6]);
		}
	}else {
		f[5].disabled = true;
		if(f[4].value != '0'){	
			if(f[6].value == ''){
				ferror.set(f[6], errmsg.bad_name4, quiet);
				return 0;
			} else {
				ferror.clear(f[6]);
			}
		}
	}
    	return 1;
}

if_adv.resetNewEditor = function()
{
	var f = fields.getAll(this.newEditor);
	
	//init value	
	f[0].value = '';
	f[1].value = '';
	f[2].value = '10';
	f[3].value = '10';
	f[4].value = '';
	f[5].value = '';
	f[6].value = '';

	ferror.clearAll(fields.getAll(this.newEditor));
}
if_adv.setup = function()
{
	grid_vif_opts_add(now_vifs_options, "");
	this.init('if_adv-grid', 'move', 100, [
		{ type: 'select', options: now_vifs_options }, 
		{ type: 'checkbox'},
		{ type: 'text', maxlen: 32 }, 
		{ type: 'text', maxlen: 32 }, 
		{ type: 'select', options: auth_type },
		{ type: 'text', maxlen: 32 }, 
		{ type: 'password', maxlen: 32 }
	]);
	this.headerSet([ui.interface_name, ospf.passive_int, ospf.cost, ospf.priority, ospf.auth, ospf.keyid, ospf.key]);
	
	for (var i = 0; i < if_adv_json.length; i++) {
		this.insertData(-1, [ if_adv_json[i][0],  if_adv_json[i][1],  if_adv_json[i][2], if_adv_json[i][3], if_adv_json[i][4], if_adv_json[i][5],if_adv_json[i][6]]);
	}

	this.showNewEditor();
	this.resetNewEditor();
}
if_adv.dataToView = function(data)
{
	return [data[0],(data[1] != '0') ? ui.yes : ui.no,  data[2], data[3], auth_type[data[4]][1], data[5], (data[6]=='')?'':'******'];
}
if_adv.fieldValuesToData = function(row)
{
	var f = fields.getAll(row);
	return [f[0].value,f[1].checked ? 1 : 0, f[2].value,f[3].value,f[4].value,f[5].value,f[6].value];
}

function verifyFields(focused, quiet)
{
	var ok = 1;
	var cmd="";
	var fom = E('_fom');
	
	var enable = E('_f_ospf_enable').checked;	
	var ospf_advanced = E('_ospf_advanced').checked;
	var area_advanced = E('_area_advanced').checked;
	var redistribute_advanced = E('_redistribute_advanced').checked;
	var if_advanced = E('_if_advanced').checked;

	var route_id=E('_ospf_router_id').value;
	var abr = E('_ospf_abr').value;
	var rfc1583 = E('_ospf_rfc1583').checked;
	var opaque = E('_ospf_opaque').checked;
	var delay =  E('_ospf_delay').value;
	var init =  E('_ospf_init').value;
	var max =  E('_ospf_max').value;
	//var maxmetric = E('_ospf_maxmetric').checked;
	//var maxmetric_val = E('_ospf_maxmetric_val').value;
	var band = E('_ospf_band').value;
	
	var always = E('_ospf_always').checked;
	var info_metric = E('_ospf_info_metric').value;
	var info_type = E('_ospf_info_type').value;
	var def_metric =  E('_ospf_def_metric').value;

	elem.display_and_enable(('_ospf_router_id'), ('_if_advanced'), ('_ospf_advanced'),('_area_advanced'), ('_redistribute_advanced'), enable);
	elem.display_and_enable(('_ospf_abr'), ('_ospf_rfc1583'), ('_ospf_opaque'),  ('_ospf_delay'), ('_ospf_init'), ('_ospf_max'), ('_ospf_band'),
				enable & ospf_advanced);
	elem.display_and_enable(('_ospf_always'), ('_ospf_info_metric'),  ('_ospf_info_type'), ('_ospf_def_metric'),
				enable & redistribute_advanced);

	display_disable_network(enable);
	display_disable_area_type(enable);
	display_disable_area_range(enable & area_advanced);
	display_disable_area_filter(enable & area_advanced);
	display_disable_area_vlink(enable & area_advanced);
	display_disable_redistribute(enable);
	display_disable_distance(enable & redistribute_advanced);
	display_disable_if_basic(enable);
	display_disable_if_adv(enable & if_advanced);

	if(!enable){		
		if(enable != enable_json)
			cmd += "no router ospf\n";
	}else {
		if(ospf_advanced) {
			cookie.set('ospf_advanced', 1);	
		} else {
			cookie.set('ospf_advanced', 0);
		}
		if(if_advanced) {
			cookie.set('if_advanced', 1);	
		} else {
			cookie.set('if_advanced', 0);
		}
		if(area_advanced) {
			cookie.set('area_advanced', 1);	
		} else {
			cookie.set('area_advanced', 0);
		}
		if(redistribute_advanced) {
			cookie.set('redistribute_advanced', 1);	
		} else {
			cookie.set('redistribute_advanced', 0);
		}
		//check valide 
		if(!v_ip('_ospf_router_id', quiet)) return 0;
		if(!v_range('_ospf_delay', quiet, 0, 600000)) return 0;
		if(!v_range('_ospf_init', quiet, 0, 600000)) return 0;
		if(!v_range('_ospf_max', quiet, 0, 600000)) return 0;
		if(!v_range('_ospf_band', quiet, 1, 4294967)) return 0;
		if(!v_range('_ospf_info_metric', quiet, 0, 16777214)) return 0;
		if(!v_range('_ospf_def_metric', quiet, 0, 16777214)) return 0;
		if(!enable_json) {
			cmd += "!\n";
			cmd += "router ospf\n";
		}
		if( route_id !=  router_id_json){
			cmd += "!\n";
			cmd += "router ospf\n";
			cmd += "router-id " + route_id +"\n";
		}
		if(abr != abr_type_json){
			cmd += "!\n";
			cmd += "router ospf\n";
			cmd += "ospf abr-type " + abr_type[abr-1][1] +"\n";
		}
		if(rfc1583 != rfc1583_json){
			cmd += "!\n";
			cmd += "router ospf\n";
			if(rfc1583 == '0'){
				cmd += "no ospf rfc1583-compatibility\n";
			}else {
				cmd += "ospf rfc1583-compatibility\n";
			}
		}
		if(opaque != opaque_json){
			cmd += "!\n";
			cmd += "router ospf\n";
			if(opaque == '0'){
				cmd += "no ospf opaque-lsa\n";
			}else {
				cmd += "ospf opaque-lsa\n";
			}
		}
		if( delay != spf_delay_json ||
			init != spf_init_json ||
			max != spf_max_json){
			cmd += "!\n";
			cmd += "router ospf\n";
			cmd += "timers throttle spf " + delay + " "+ init +" "+ max +"\n";
		}
		if(band != bandwidth_json){
			cmd += "!\n";
			cmd += "router ospf\n";
			cmd += "auto-cost reference-bandwidth " + band + "\n";
		}
		if(info_always_json != always ||
			info_metric_json != info_metric ||
			info_type_json != info_type){
			cmd += "!\n";
			cmd += "router ospf\n";
			cmd += "default-information originate ";
			if(always == '1'){
				cmd += "always ";
			}
			if(info_metric){
				cmd += "metric " + info_metric;
			}
			if(info_type !='0'){
				cmd += " metric-type " + info_type;
			}
			cmd += "\n";
		}
		if(def_metric != def_metric_json){
			cmd += "!\n";
			cmd += "router ospf\n";
			cmd += "default-metric " + def_metric + "\n";
		}
		//interface		
		var if_basic_data = if_basic.getAllData();
		// delete
		for(var i = 0; i < if_basic_json.length; i++) {
			var found = 0;
			for(var j = 0; j < if_basic_data.length; j++) {
				if(if_basic_json[i][0] == if_basic_data[j][0]){
					found = 1;
					break;
				}
			}
			if(!found) {
				cmd += "!\n";
				cmd += "interface " + if_basic_json[i][0] + "\n";
				cmd += "no ip ospf dead-interval\n";
				cmd += "no ip ospf hello-interval\n";
				cmd += "no ip ospf network\n";
				cmd += "no ip ospf retransmit-interval\n";
				cmd += "no ip ospf transmit-delay\n";
			}
		}
		//add
		for(var i = 0; i < if_basic_data.length; i++) {
			var found = 0;
			var changed = 0;
			for(var j = 0; j < if_basic_json.length; j++) {
				if(if_basic_data[i][0]==if_basic_json[j][0]) {
					found = 1;
					if(if_basic_data[i][1]!=if_basic_json[j][1]){						
						cmd += "!\n";
						cmd += "interface "+  if_basic_data[i][0]+ "\n";
						cmd += "ip ospf network "+ network_type[if_basic_data[i][1]-1][1] +"\n";			
					}
					if(if_basic_data[i][2]!=if_basic_json[j][2]){
						cmd += "!\n";
						cmd += "interface "+  if_basic_data[i][0]+ "\n";
						cmd += "ip ospf hello-interval " + if_basic_data[i][2]+ "\n";
					}
					if(if_basic_data[i][3]!=if_basic_json[j][3]){
						cmd += "!\n";
						cmd += "interface "+  if_basic_data[i][0]+ "\n";
						cmd += "ip ospf dead-interval " + if_basic_data[i][3]+ "\n";
					}
					if(if_basic_data[i][4]!=if_basic_json[j][4]){
						cmd += "!\n";
						cmd += "interface "+  if_basic_data[i][0]+ "\n";
						cmd += "ip ospf retransmit-interval "+ if_basic_data[i][4] +"\n";
					}
					if(if_basic_data[i][5]!=if_basic_json[j][5]) {						
						cmd += "!\n";
						cmd += "interface "+  if_basic_data[i][0]+ "\n";
						cmd += "ip ospf transmit-delay "+ if_basic_data[i][5] +"\n";
					}
					break;
				}
			}
			if(!found){
				cmd += "!\n";
				cmd += "interface "+  if_basic_data[i][0]+ "\n";
				cmd += "ip ospf network "+ network_type[if_basic_data[i][1]-1][1] +"\n";
				cmd += "ip ospf hello-interval " + if_basic_data[i][2]+ "\n";
				cmd += "ip ospf transmit-delay "+ if_basic_data[i][5] +"\n";
				cmd += "ip ospf dead-interval " + if_basic_data[i][3]+ "\n";
				cmd += "ip ospf retransmit-interval "+ if_basic_data[i][4] +"\n";
			}
		}
		//interface adv
		var if_adv_data = if_adv.getAllData();
		// delete
		for(var i = 0; i < if_adv_json.length; i++) {
			var found = 0;
			for(var j = 0; j < if_adv_data.length; j++) {
				if(if_adv_json[i][0] == if_adv_data[j][0]){
					found = 1;
					break;
				}
			}
			if(!found) {
				cmd += "!\n";
				cmd += "interface " + if_adv_json[i][0] + "\n";
				cmd += "no ip ospf cost\n";
				cmd += "no ip ospf priority\n";
				cmd += "no ip ospf authentication-key\n";
				cmd += "no ip ospf message-digest-key " +  if_adv_json[i][5]+ "\n";
				cmd += "!\n";
				cmd += "router ospf\n";
				cmd += "no passive-interface " +  if_adv_json[i][0] +" "+"\n";
			}
		}
		//add
		for(var i = 0; i < if_adv_data.length; i++) {
			var found = 0;
			for(var j = 0; j < if_adv_json.length; j++) {
				if(if_adv_data[i][0]==if_adv_json[j][0]) {
					found = 1;
					if(if_adv_data[i][1]!=if_adv_json[j][1]){
						cmd += "!\n";
						cmd += "router ospf\n";
						cmd += "passive-interface " +  if_adv_json[i][0] +" "+"\n";
					}
					if(if_adv_data[i][2]!=if_adv_json[j][2]){
						cmd += "!\n";
						cmd += "interface "+  if_adv_data[i][0]+ "\n";
						cmd += "ip ospf cost "+ if_adv_data[i][2] +"\n";
					}					
					if(if_adv_data[i][3]!=if_adv_json[j][3]){
						cmd += "!\n";
						cmd += "interface "+  if_adv_data[i][0]+ "\n";
						cmd += "ip ospf priority " + if_adv_data[i][3]+ "\n";
					}									
					if(if_adv_data[i][4]!=if_adv_json[j][4] ||
						if_adv_data[i][5]!=if_adv_json[j][5]||
						if_adv_data[i][6]!=if_adv_json[j][6]){
						cmd += "!\n";
						cmd += "interface "+  if_adv_data[i][0]+ "\n";
						if(if_adv_json[i][5]){
							cmd += "no ip ospf message-digest-key " +  if_adv_json[i][5]+ "\n";
						}else {
							cmd += "no ip ospf authentication-key\n";						
						}	
						if(if_adv_data[i][4] == '1'){
							cmd += "ip ospf authentication-key "+  if_adv_data[i][6]+"\n";
						}else {
							cmd += "ip ospf message-digest-key "+  if_adv_data[i][5]+ " md5 "+ if_adv_data[i][6]+ "\n";
						}
					}
					break;
				}
			}
			if(!found) {
				if(if_adv_data[i][1] == '1'){
					cmd += "!\n";
					cmd += "router ospf\n";
					cmd += "passive-interface " +  if_adv_data[i][0] +" "+"\n";
				}
				if(if_adv_data[i][2]!=''){
					cmd += "!\n";
					cmd += "interface "+  if_adv_data[i][0]+ "\n";
					cmd += "ip ospf cost "+ if_adv_data[i][2] +"\n";
				}					
				if(if_adv_data[i][3]!=''){
					cmd += "!\n";
					cmd += "interface "+  if_adv_data[i][0]+ "\n";
					cmd += "ip ospf priority " + if_adv_data[i][3]+ "\n";
				}							
				if(if_adv_data[i][4] == '1'){
					cmd += "ip ospf authentication-key "+  if_adv_data[i][6]+"\n";
				}else if(if_adv_data[i][4] == '2'){
					cmd += "ip ospf message-digest-key "+  if_adv_data[i][5]+ " md5 "+ if_adv_data[i][6]+ "\n";
				}
			}
		}
		//network
		var network_data = network.getAllData();
		// delete
		for(var i = 0; i < network_json.length; i++) {
			var found = 0;
			for(var j = 0; j < network_data.length; j++) {
				if(network_json[i][0] == network_data[j][0] && 
					network_json[i][1] == network_data[j][1]){
					found = 1;
					break;
				}
			}
			if(!found) {
				cmd += "!\n";
				cmd += "router ospf\n";
				cmd += "no network " +  network_json[i][0] +" "+network_json[i][1] +" area "+network_json[i][2]+"\n";
			}
		}
		//add
		for(var i = 0; i < network_data.length; i++) {
			var found = 0;
			var changed = 0;
			for(var j = 0; j < network_json.length; j++) {
				if(network_data[i][0]==network_json[j][0] &&
					network_data[i][1]==network_json[j][1] ) {
					found = 1;
					if(network_data[i][2] !=network_json[j][2] ) {
						changed = 1;
					}
					break;
				}
			}
			if(!found || changed) {
				cmd += "!\n";
				cmd += "router ospf\n";
				cmd += "network " +  network_data[i][0] +" "+network_data[i][1] +" area "+network_data[i][2]+"\n";
						
			}
		}
		//area filter
		var filter_data = area_filter.getAllData();
		// delete
		for(var i = 0; i < area_filter_json.length; i++) {
			var found = 0;
			for(var j = 0; j < filter_data.length; j++) {
				if(area_filter_json[i][2] == filter_data[j][2] &&
					area_filter_json[i][0] == filter_data[j][0]){
					found= 1;
					break;
				}
			}
			if(!found){
				cmd += "!\n";
				cmd += "router ospf\n";
				switch(area_filter_json[i][1]){
				case '0':
					break;
				case '1':
					cmd += "no area " +  area_filter_json[i][0] +" import-list "+area_filter_json[i][2]+ "\n";
					break;
				case '2':	
					cmd += "no area " +  area_filter_json[i][0] +" export-list "+area_filter_json[i][2]+ "\n";
					break;
				case '3':	
					cmd += "no area " +  area_filter_json[i][0] +" filter-list prefix "+area_filter_json[i][2] + " in\n";
					break;
				case '4':	
					cmd += "no area " +  area_filter_json[i][0] +" filter-list prefix "+area_filter_json[i][2] + " out\n";
					break;
				}
			}
		}
		//add
		for(var i = 0; i < filter_data.length; i++) {
			var found = 0;
			var changed=0;
			for(var j = 0; j < area_filter_json.length; j++) {
				if(filter_data[i][0]==area_filter_json[j][0]&&
					filter_data[i][2]==area_filter_json[j][2]) {	
					found =1;			
					if( filter_data[i][1]!=area_filter_json[j][1]){
						changed = 1;	
						break;
					}
				}
			}
			if(!found || changed) {
				cmd += "!\n";
				cmd += "router ospf\n";
				switch(filter_data[i][1]){
				case '0':
					break;
				case '1':
					cmd += " area " +  filter_data[i][0] +" import-list "+ filter_data[i][2]+ "\n";
					break;
				case '2':	
					cmd += "area " +  filter_data[i][0] +" export-list "+ filter_data[i][2]+ "\n";
					break;
				case '3':	
					cmd += "area " +  filter_data[i][0] +" filter-list prefix "+ filter_data[i][2] + " in\n";
					break;
				case '4':	
					cmd += "area " +  filter_data[i][0] +" filter-list prefix "+ filter_data[i][2] + " out\n";
					break;
				}
			}
		}
		//area range
		var range_data = area_range.getAllData();
		// delete
		for(var i = 0; i < area_range_json.length; i++) {
			var found = 0;
			for(var j = 0; j < range_data.length; j++) {
				if(area_range_json[i][0] == range_data[j][0]){
					found = 1;
					break;
				}
			}
			if(!found) {
				cmd += "!\n";
				cmd += "router ospf\n";
				cmd += "no area " +  area_range_json[i][0] +" "+area_range_json[i][1] + "\n";
			}
		}
		//add
		for(var i = 0; i < range_data.length; i++) {
			var found = 0;
			var changed =0;
			for(var j = 0; j < area_range_json.length; j++) {
				if(range_data[i][0]==area_range_json[j][0]) {	
					found = 1;				
					if( range_data[i][1]!=area_range_json[j][1] ||
						range_data[i][2]!=area_range_json[j][2]||
						range_data[i][3]!=area_range_json[j][3]||
						range_data[i][4]!=area_range_json[j][4]){	
						changed = 1;
					}
				}
			}
			if(!found || changed) {
				if(range_data[i][1] && range_data[i][2]){
					cmd += "!\n";
					cmd += "router ospf\n";
					if(range_data[i][3] == '1'){							
						cmd +="area " +  range_data[i][0] +" range "+range_data[i][1] +" "+range_data[i][2]+ " not-advertise\n";		
					}else {				
						cmd += "area " +  range_data[i][0] +" range "+range_data[i][1] +" "+range_data[i][2]+"\n";
					}
					if(range_data[i][4] != ''){							
						cmd += "area " +  range_data[i][0] +" range "+range_data[i][1] +" "+range_data[i][2]+" cost " + range_data[i][4]+"\n";		
					}else {
						cmd += "area " +  range_data[i][0] +" range "+range_data[i][1] +" "+range_data[i][2]+"\n";
					}
				}
			}
		}

		//area type
		var type_data = area_type.getAllData();
		// delete
		for(var i = 0; i < area_type_json.length; i++) {
			var found = 0;
			for(var j = 0; j < type_data.length; j++) {
				if(area_type_json[i][0] == type_data[j][0]){
					found = 1;
					break;
				}
			}
			if(!found) {
				cmd += "!\n";
				cmd += "router ospf\n";
				switch(area_type_json[i][1]){
				case '0':
					break;
				case '1':
					cmd += "no area " +  area_type_json[i][0]+ " stub ";
					break;
				case '2':	
					cmd += "no area " +  area_type_json[i][0]+ " nssa translate-always ";
					break;
				case '3':	
					cmd += "no area " +  area_type_json[i][0]+ " nssa translate-candidate ";
					break;
				case '4':	
					cmd += "no area " +  area_type_json[i][0]+ " nssa translate-never ";
					break;
				}
				if( area_type_json[j][1] !='0' && area_type_json[i][2]=='1'){
					cmd += "no-summary\n";
				}else {
					cmd += "\n";
				}
				cmd += "no area " +  area_type_json[i][0] + " authentication\n";
			}
		}
		//add
		for(var i = 0; i < type_data.length; i++) {
			var found = 0;
			var changed = 0;
			for(var j = 0; j < area_type_json.length; j++) {
				if(type_data[i][0]==area_type_json[j][0]) {
					found = 1;
					if( type_data[i][1]!=area_type_json[j][1] ||
						type_data[i][2]!=area_type_json[j][2] ||
						type_data[i][3]!=area_type_json[j][3]) {
						if(type_data[i][1]=='0'){
							cmd += "!\n";
							cmd += "router ospf\n";
							switch(area_type_json[j][1]){
							case '0':
								break;
							case '1':
								cmd += "no area " +  area_type_json[j][0]+ " stub ";
								break;
							case '2':	
								cmd += "no area " +  area_type_json[j][0]+ " nssa translate-always ";
								break;
							case '3':	
								cmd += "no area " +  area_type_json[j][0]+ " nssa translate-candidate ";
								break;
							case '4':	
								cmd += "no area " +  area_type_json[j][0]+ " nssa translate-never ";
								break;
							}
							if( area_type_json[j][1] !='0'&& area_type_json[j][2]=='1'){
								cmd += "no-summary\n";
							}else {
								cmd += "\n";
							}
						}
						changed = 1;
					}
					break;
				}
			}
			if(!found || changed) {
				cmd += "!\n";
				cmd += "router ospf\n";
				switch(type_data[i][1]){
				case '0':
					break;
				case '1':
					cmd += "area " +  type_data[i][0]+" stub ";
					break;
				case '2':	
					cmd += "area " +  type_data[i][0]+" nssa translate-always ";
					break;
				case '3':	
					cmd += "area " +  type_data[i][0]+" nssa translate-candidate ";
					break;
				case '4':	
					cmd += "area " +  type_data[i][0]+" nssa translate-never ";
					break;
				}
				if(type_data[i][1] !='0' && type_data[i][2]=='1'){
					cmd += " no-summary\n";
				}else {
					cmd += "\n";
				}
				if(type_data[i][3]==''){
					cmd += "no area " +  type_data[i][0] + " authentication\n";
				}else if(type_data[i][3]=='1') {
					cmd += "area " +  type_data[i][0] + "  authentication\n";
				}else if(type_data[i][3]=='2') {
					cmd += "area " +  type_data[i][0] + "  authentication message-digest\n";
				}
			}
		}
		//area vlink
		var vlink_data = area_vlink.getAllData();
		// delete
		for(var i = 0; i < area_vlink_json.length; i++) {
			var found = 0;
			for(var j = 0; j < vlink_data.length; j++) {
				if(area_vlink_json[i][0] == vlink_data[j][0] &&
					area_vlink_json[i][1] == vlink_data[j][1]){
					found = 1;
					break;
				}
			}
			if(!found) {
				cmd += "!\n";
				cmd += "router ospf\n";
				cmd += "no area " +  area_vlink_json[i][0] + " "+ area_vlink_json[i][1] + " hello-interval\n";
				cmd += "no area " +  area_vlink_json[i][0] + " "+ area_vlink_json[i][1] + " dead-interval\n";
				cmd += "no area " +  area_vlink_json[i][0] + " "+ area_vlink_json[i][1] + " retransmit-interval\n";
				cmd += "no area " +  area_vlink_json[i][0] + " "+ area_vlink_json[i][1] + " transmit-delay\n";	
				cmd += "no area " +  area_vlink_json[i][0] + " "+ area_vlink_json[i][1] + " authentication-key\n";
				if(area_vlink_json[i][3]){
					cmd += "no area " +  area_vlink_json[i][0] + " "+ area_vlink_json[i][1] + " message-digest-key " +  area_vlink_json[i][3] +"\n";
				}
			}
		}
		//add
		for(var i = 0; i < vlink_data.length; i++) {
			var found = 0;
			var changed = 0;
			for(var j = 0; j < area_vlink_json.length; j++) {
				if(vlink_data[i][0]==area_vlink_json[j][0]) {
					found = 1;
					if( vlink_data[i][1]!=area_vlink_json[j][1] ||
						vlink_data[i][2]!=area_vlink_json[j][2] ||
						vlink_data[i][3]!=area_vlink_json[j][3]||
						vlink_data[i][4]!=area_vlink_json[j][4]||
						vlink_data[i][5]!=area_vlink_json[j][5]||
						vlink_data[i][6]!=area_vlink_json[j][6]||
						vlink_data[i][7]!=area_vlink_json[j][7]||
						vlink_data[i][8]!=area_vlink_json[j][8]) {
						changed = 1;
					}
					break;
				}
			}
			if(!found || changed) {
				cmd += "!\n";
				cmd += "router ospf\n";
				switch(vlink_data[i][2]){
				case '0':
					cmd += "area " +  vlink_data[i][0] + " virtual-link "+ vlink_data[i][1]+"\n";
					break;
				case '1':
					cmd += "area " +  vlink_data[i][0] + " virtual-link "+ vlink_data[i][1] + " authentication-key " + vlink_data[i][4]+"\n";
					break;
				case '2':	
					cmd += "area " +  vlink_data[i][0] + " virtual-link "+ vlink_data[i][1] + " message-digest-key " + vlink_data[i][3]+" md5 " + vlink_data[i][4]+"\n";
					break;
				}
				if(vlink_data[i][5]){
					cmd += "area " +  vlink_data[i][0] + " virtual-link "+ vlink_data[i][1] + " hello-interval " + vlink_data[i][5]+"\n";
				}
				if(vlink_data[i][6]){
					cmd += "area " +  vlink_data[i][0] + " virtual-link "+ vlink_data[i][1] + " dead-interval " + vlink_data[i][6]+"\n";
				}
				if(vlink_data[i][7]){
					cmd += "area " +  vlink_data[i][0] + " virtual-link "+ vlink_data[i][1] + " retransmit-interval " + vlink_data[i][7]+"\n";
				}
				if(vlink_data[i][8]){
					cmd += "area " +  vlink_data[i][0] + " virtual-link "+ vlink_data[i][1] + " transmit-delay " + vlink_data[i][8]+"\n";
				}
			}
		}
		//redistribute
		var redistribute_data = redistribute.getAllData();
		// delete
		for(var i = 0; i < redistribute_json.length; i++) {
			var found = 0;
			for(var j = 0; j < redistribute_data.length; j++) {
				if(redistribute_json[i][0] == redistribute_data[j][0]){
					found = 1;
					break;
				}
			}
			if(!found) {
				cmd += "!\n";
				cmd += "router ospf\n";
				cmd += "no redistribute " +  redistribute_type[redistribute_json[i][0]-1][1] + "\n";
			}
		}
		//add
		for(var i = 0; i < redistribute_data.length; i++) {
			var found = 0;
			var changed = 0;
			for(var j = 0; j < redistribute_json.length; j++) {
				if(redistribute_data[i][0]==redistribute_json[j][0]) {
					found = 1;
					if( redistribute_data[i][1]!=redistribute_json[j][1] ||
						redistribute_data[i][2]!=redistribute_json[j][2] ||
						redistribute_data[i][3]!=redistribute_json[j][3]) {
						changed = 1;
					}
					break;
				}
			}
			if(!found || changed) {
				cmd += "!\n";
				cmd += "router ospf\n";
				cmd += "redistribute " +  redistribute_type[redistribute_data[i][0]-1][1];
				if(redistribute_data[i][1]!=''){
					cmd += " metric " + redistribute_data[i][1];	
					if(redistribute_data[i][2]!='0'){
						cmd += " metric-type " + redistribute_data[i][2];	
					}
				}	
				cmd += "\n";
			}
		}
		var distance_data = distance.getAllData();
		// delete
		for(var i = 0; i < distance_json.length; i++) {
			var found = 0;
			for(var j = 0; j < distance_data.length; j++) {
				if(distance_json[i][0] == distance_data[j][0]){
					found = 1;
					break;
				}
			}
			if(!found) {
				cmd += "!\n";
				cmd += "router ospf\n";
				cmd += "no distance ospf\n";
			}
		}
		//add
		for(var i = 0; i < distance_data.length; i++) {
			var found = 0;
			var changed = 0;
			for(var j = 0; j < distance_json.length; j++) {
				if(distance_data[i][0]==distance_json[j][0]) {
					found = 1;
					if( distance_data[i][1]!=distance_json[j][1]) {
						changed = 1;
					}
					break;
				}
			}
			if(!found || changed) {
				cmd += "!\n";
				cmd += "router ospf\n";
				cmd += "distance ospf " +  distance_type[distance_data[i][0]-1][1] + " " +distance_data[i][1]+"\n";
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
	
	var fom = E('_fom');

	if((E('_fom')._web_cmd.value != '')&&(cookie.get('autosave') == 1)){
		E('_fom')._web_cmd.value += "!"+"\n"+"copy running-config startup-config"+"\n";	
	}
	
	form.submit(fom, 1);
}


function earlyInit()
{
	if(cookie.get('ospf_advanced') == null) {
		cookie.set('ospf_advanced', 0);
	}	
	if(cookie.get('redistribute_advanced') == null) {
		cookie.set('redistribute_advanced', 0);
	}
	if(cookie.get('area_advanced') == null) {
		cookie.set('area_advanced', 0);
	}
	if(cookie.get('if_advanced') == null) {
		cookie.set('if_advanced', 0);
	}
	network.setup();
	area_type.setup();
	area_range.setup();
	area_filter.setup();
	area_vlink.setup();
	redistribute.setup();
	//distribute.setup();
	distance.setup();
	if_basic.setup();
	if_adv.setup();
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

createFieldTable('', [
	{ title: ui.enable, name: 'f_ospf_enable', type: 'checkbox', value: enable_json =='1'},
	{ title: ospf.router_id, name: 'ospf_router_id', type: 'text', maxlen: 16, size: 16, value: router_id_json },
	{ title: '<b>' + ospf.route_adv + '</b>', indent: 0, name: 'ospf_advanced', type: 'checkbox', value: cookie.get('ospf_advanced')==1},
	{ title: ospf.abr_type, name: 'ospf_abr', type: 'select', options:abr_type, value: abr_type_json },
	{ title: ospf.rfc1583, name: 'ospf_rfc1583', type: 'checkbox', value: rfc1583_json == '1'},
	{ title: ospf.opaque, name: 'ospf_opaque', type: 'checkbox', value: opaque_json == '1'},
	{ title: ospf.delay, name: 'ospf_delay', type: 'text', maxlen: 16, size: 16, suffix: ui.mseconds, value: spf_delay_json },
	{ title: ospf.init, name: 'ospf_init', type: 'text', maxlen: 16, size: 16, suffix: ui.mseconds, value: spf_init_json },
	{ title: ospf.max, name: 'ospf_max', type: 'text', maxlen: 16, size: 16, suffix: ui.mseconds, value: spf_max_json },
	//{ title: ospf.max_metric, name: 'ospf_maxmetric', type: 'select', options: max_metric_type ,value: max_metric_json},
	//{ title: ospf.max_metric_val, name: 'ospf_maxmetric_val', type: 'text', maxlen: 16, size: 16, value: max_metric_val_json },
	{ title: ospf.band, name: 'ospf_band', type: 'text', maxlen: 16, size: 16, suffix: ui.bandwidth, value: bandwidth_json }
]);
</script>
</div>

<div id='if_basic_title' class='section-title'>
<script type='text/javascript'>
	GetText(ui.iface);
</script>
</div>
<div id='if_basic_body' class='section'>
    <table class='web-grid' id='if_basic-grid'></table>
</div>
<div class='section'>
<script type='text/javascript'>
createFieldTable('', [
	{ title: '<b>' +ospf.if_adv + '</b>', indent: 0, name: 'if_advanced', type: 'checkbox', value: cookie.get('if_advanced')==1}
]);
</script>
</div>
<div id='if_adv_body' class='section'>
    <table class='web-grid' id='if_adv-grid'></table>
</div>

<div id='network_title' class='section-title'>
<script type='text/javascript'>
	GetText(ospf.network);
</script>
</div>
<div id='network_body' class='section'>
	<table class='web-grid' id='network-grid'></table>
</div>

<div id='type_title' class='section-title'>
<script type='text/javascript'>
	GetText(ospf.area);
</script>
</div>
<div id='type_body' class='section'>
	<table class='web-grid' id='type-grid'></table>
</div>
<div class='section'>
<script type='text/javascript'>
createFieldTable('', [
	{ title: '<b>' +ospf.area_adv + '</b>', indent: 0, name: 'area_advanced', type: 'checkbox', value: cookie.get('area_advanced')==1}
]);
</script>
</div>
<div id='range_title' class='section-title'>
<script type='text/javascript'>
	GetText(ospf.area_range);
</script>
</div>
<div id='range_body' class='section'>
	<table class='web-grid' id='range-grid'></table>
</div>
<div id='filter_title' class='section-title'>
<script type='text/javascript'>
	GetText(ospf.area_filter);
</script>
</div>
<div id='filter_body' class='section'>
	<table class='web-grid' id='filter-grid'></table>
</div>
<div id='vlink_title' class='section-title'>
<script type='text/javascript'>
	GetText(ospf.area_vlink);
</script>
</div>
<div id='vlink_body' class='section'>
	<table class='web-grid' id='vlink-grid'></table>
</div>

<div id='redistribute_title' class='section-title'>
<script type='text/javascript'>
	GetText(ospf.redistr);
</script>
</div>
<div id='redistribute_body' class='section'>
	<table class='web-grid' id='redistribute-grid'></table>
</div>

<div class='section'>
<script type='text/javascript'>
createFieldTable('', [
	{ title: '<b>' + ospf.redis_adv + '</b>', indent: 0, name: 'redistribute_advanced', type: 'checkbox', value: cookie.get('redistribute_advanced')==1},
	{ title: ospf.always, name: 'ospf_always', type: 'checkbox', value: info_always_json == '1'},
	{ title: ospf.info_metric, name: 'ospf_info_metric', type: 'text', maxlen: 16, size: 16, value: info_metric_json },
	{ title: ospf.info_type, name: 'ospf_info_type', type: 'select', options:metric_type, value: info_type_json },
	//{ title: ospf.info_routemap, name: 'ospf_info_routemap', type: 'text', maxlen: 16, size: 16, value: info_routemap_json },
	{ title: ospf.dft_metric, name: 'ospf_def_metric', type: 'text', maxlen: 16, size: 16, value: def_metric_json }
]);
</script>
</div>
<div id='distance_title' class='section-title'>
<script type='text/javascript'>
	GetText(ospf.distance_mgnt);
</script>
</div>
<div id='distance_body' class='section'>
	<table class='web-grid' id='distance-grid'></table>
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
