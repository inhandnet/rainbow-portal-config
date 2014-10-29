<% pagehead(menu.ipsec_setting) %>

<style type='text/css'>

#ipsecprof-grid {
	width: 700px;
}
#ipsecprof-grid .co1 {
	width: 100px;
	text-align: center;
}
#ipsecprof-grid .co2 {
	width: 120px;
	text-align: center;
}
#ipsecprof-grid .co3 {
	width: 100px;
	text-align: center;	
}
#ipsecprof-grid .co4 {
	width: 80px;
	text-align: center;	
}
#ipsecprof-grid .co5 {
	width: 80px;
	text-align: center;	
}
#ipsecprof-grid .co8 {
	width: 80px;
	text-align: center;	
}


#map-grid {
	width: 700px;
}
#map-grid .co1 {
	width: 85px;
	text-align: center;
}
#map-grid .co2 {
	width: 60px;
	text-align: center;
}
#map-grid .co3 {
	width: 85px;
	text-align: center;	
}
#map-grid .co4 {
	width: 85px;
	text-align: center;	
}
#map-grid .co5 {
	width: 85px;
	text-align: center;	
}
#map-grid .co6 {
	width: 85px;
	text-align: center;	
}
#map-grid .co7 {
	width: 85px;
	text-align: center;	
}
#map-grid .co8 {
	width: 85px;
	text-align: center;	
}


#icmp_map-grid {
	width: 700px;
}
#icmp_map-grid .co1 {
	width: 85px;
	text-align: center;
}
#icmp_map-grid .co2 {
	width: 60px;
	text-align: center;
}
#icmp_map-grid .co3 {
	width: 85px;
	text-align: center;	
}
#icmp_map-grid .co4 {
	width: 85px;
	text-align: center;	
}
#icmp_map-grid .co5 {
	width: 85px;
	text-align: center;	
}
#icmp_map-grid .co6 {
	width: 85px;
	text-align: center;	
}
#icmp_map-grid .co7 {
	width: 85px;
	text-align: center;	
}

#crypto-grid {
	width: 700px;
	text-align: center;
}
#crypto-grid .co1 {
	width: 200px;
	text-align: center;
}
#crypto-grid .co2 {
	width: 350px;
	text-align: center;
}

#crypto_head {
	background: #e2dff7;
}

</style>

<script type='text/javascript'>

<% ih_sysinfo() %>
<% ih_user_info() %>

<% web_exec('show running-config crypto')%>
<% web_exec('show running-config netwatcher')%>
<% web_exec('show interface')%>

//define option list
var vifs = [].concat(cellular_interface, eth_interface, xdsl_interface, svi_interface, gre_interface);
var now_vifs_options = new Array();
now_vifs_options = grid_list_all_vif_opts(vifs);


function resetOptions(objSelect,options){
    var optObj = objSelect.options;

    //save old value
    var old_value = objSelect.value;

    //remove all old options
    while(optObj.length != 0){
        optObj[0] = null;
    }

    //add new options
    for(var i=0;i < options.length;i++){
        var varItem = new Option(options[i], options[i]);     
        optObj.add(varItem);     
    }

    //resume value
    objSelect.value=old_value;
    
}


//var ipsec_prof_config = [['ihtest1', 'test1', 'test1', '2', '3600', '540', '100', '0'],['ihtest2', 'test1', 'test2', '1', '1200', '540', '10','1']];
//var map_config = [['mytest1', '1', '1.1.1.2', '100', 'test1', 'test1', '1', '800','540','100'],
//					['mytest2', '4', '1.2.3.4', '101', 'test1', 'test1', '1', '900','540','10']];

//var isa_prof_config = [['test1', '0', '1', 'abc', '0', '1.1.1.1', 'test1', '1', '60', '60']];
//var transform_config = [['test1', '0', '0', '1', '1'],['test2', '1', '1', '1', '1']];

//var if_map_config = [['cellular 1', 'abc']];
if(if_map_config.length == 0) {
	if_map_config = [['','']];
}

var map_name_options = [];
var map_id_options = [];

var icmp_map_config=netwatcher_config.ipsec_keepalive;

function creatSelect(options,value,id)
{
	var string = "<td><select onchange=verifyFields() id= " + id + ">";

	for(var i = 0;i < options.length;i++){
		if(value == options[i]){
			string +='<option value="'+options[i]+'" selected>'+options[i]+'</option>';
		}else{
			string +='<option value="'+options[i]+'">'+options[i]+'</option>';
		}
	}
	string +="</select></td>";

	return string;
}

//var map_options = [];
var select_map_name = ["none"];
for(var i = 0; i < map_config.length; i++)
{
//	map_options.push([map_config[i][0], map_config[i][0]]);
	//FIXME
	if(i>0 && map_config[i][0]==map_config[i-1][0]) {
		//duplicate
	} else {
		select_map_name.push(map_config[i][0]);
	}
}

//var interface_options=[];
var select_map_iface=[];
for(var i = 0; i < now_vifs_options.length; i++) {
//	interface_options.push([interface_name_list[i], interface_name_list[i]]);
	select_map_iface.push(now_vifs_options[i][0]);
}

var isaprof_options = [];
var transform_options = [];

for(var i = 0; i < isa_prof_config.length; i++) {
	isaprof_options.push([isa_prof_config[i][0], isa_prof_config[i][0]]);
}

for(var i = 0; i < transform_config.length; i++) {
	transform_options.push([transform_config[i][0], transform_config[i][0]]);
}

var ipsecprof = new webGrid();

ipsecprof.exist = function(f, v)
{
	var data = this.getAllData();
	for (var i = 0; i < data.length; ++i) {
		if (data[i][f] == v) return true;
	}
	return false;
}

ipsecprof.existName = function(name)
{
	return this.exist(0, name);
}

ipsecprof.dataToView = function(data) {
	var pfs, sim;
	if(data[3] == '0') {
		pfs = ipsec.none;
	} else if(data[3] == '1') {
		pfs = 'Group 1';
	} else if(data[3] == '2') {
		pfs = 'Group 2';
	} else if(data[3] == '5') {
		pfs = 'Group 5';
	}
	if(data[7] == '2') {
		sim = 'SIM2';
	} else if(data[7] == '1') {
		sim = 'SIM1';
	} else {
		sim = ipsec.none;
	}


	return [data[0],
			data[1],
			data[2],
			pfs,
			data[4],
			data[5],
			data[6],
			sim];
}

ipsecprof.fieldValuesToData = function(row) {
	var f = fields.getAll(row);
	return [f[0].value, f[1].value, f[2].value, f[3].value, f[4].value, f[5].value, f[6].value, f[7].value];
}

ipsecprof.onDataChanged = function() {
	verifyFields(null, 1);
}

ipsecprof.verifyFields = function(row, quiet) {
	var f = fields.getAll(row);

	if(haveChineseChar(f[0].value)) {
		ferror.set(f[0], errmsg.cn_chars, quiet);
		return 0;	
	} else if(!v_length(f[0], quiet, 1, 64)) {
		return 0;
	} else if(f[0].value.indexOf(" ") >= 0) {
		ferror.set(f[0], errmsg.bad_description, quiet);
		return 0;
	} else if(this.existName(f[0].value)) {
		ferror.set(f[0], errmsg.bad_name4, quiet);
		return 0;
	} else {
		ferror.clear(f[0]);
	}

//	if(f[1].length == 0) {
	if(f[1].value == '') {
		ferror.set(f[1], "Invalid argument.Please configure the ISAKMP Profile first!", quiet);
		return 0;
	} else {
		ferror.clear(f[1]);
	}

//	if(f[2].length == 0) {
	if(f[2].value == '') {
		ferror.set(f[2], "Invalid argument.Please configure the Transform-set first!", quiet);
		return 0;
	} else {
		ferror.clear(f[2]);
	}

	if(!v_range(f[4], quiet, 1200, 86400)) {
		return 0;
	}
	if(!v_range(f[5], quiet, 30, 1800)) {
		return 0;
	}
	if(!v_range(f[6], quiet, 0, 100)) {
		return 0;
	}

	return 1;
}

ipsecprof.resetNewEditor = function() {
	var f = fields.getAll(this.newEditor);
	
	f[0].value = '';

	for(var i = 1;i < f.length-1; i++) {
		f[i].value = 0;
	}
	f[4].value = '3600';
	f[5].value = '540';
	f[6].value = '100';

	ferror.clearAll(fields.getAll(this.newEditor));
}

ipsecprof.setup = function() 
{
	this.init('ipsecprof-grid', 'move', 10, [
		{ type: 'text', maxlen: 32 }, 
		{ type: 'select', options: isaprof_options},
		{ type: 'select', options: transform_options},
		{ type: 'select', options:[
			['0', ipsec.none],
			['1', 'Group 1'],
			['2', 'Group 2'],
			['5', 'Group 5']
		]},
		{ type: 'text', maxlen: 32},
		{ type: 'text', maxlen: 32},
		{ type: 'text', maxlen: 32},
		{ type: 'select', options:[
			['0', ipsec.none],
			['1', 'SIM1'],
			['2', 'SIM2']
		]}
	]);
	this.headerSet([ui.nam, ipsec.profile, ipsec.transform_title, ipsec.pfs, ipsec.lifetime,ipsec.margin,ipsec.fuzz,ipsec.bindsim]);

	for(var i = 0; i < ipsec_prof_config.length; i++) 
		this.insertData(-1, [ipsec_prof_config[i][0], ipsec_prof_config[i][1], ipsec_prof_config[i][2],
						ipsec_prof_config[i][3], ipsec_prof_config[i][4], ipsec_prof_config[i][5],
						ipsec_prof_config[i][6], ipsec_prof_config[i][7]]);

	this.showNewEditor();
	this.resetNewEditor();
}

/////////////////////////////////////////////////////////////////////////////
var map = new webGrid();

map.exist = function(f, v)
{
	var data = this.getAllData();
	for (var i = 0; i < data.length; ++i) {
		if (data[i][f] == v) return true;
	}
	return false;
}

map.existName = function(name)
{
	return this.exist(0, name);
}

map.existID = function(id)
{
	return this.exist(1, id);
}

map.dataToView = function(data) {
	var pfs;
	if(data[6] == '0') {
		pfs = ipsec.none;
	} else if(data[6] == '1') {
		pfs = 'Group 1';
	} else if(data[6] == '2') {
		pfs = 'Group 2';
	} else if(data[6] == '5') {
		pfs = 'Group 5';
	}

	return [data[0],
			data[1],
			data[2],
			data[3],
			data[4],
			data[5],
			pfs,
			data[7],
			data[8],
			data[9]];
}

map.fieldValuesToData = function(row) {
	var f = fields.getAll(row);
	return [f[0].value, f[1].value, f[2].value, f[3].value, f[4].value, 
	       		f[5].value, f[6].value, f[7].value, f[8].value, f[9].value];
}

map.onDataChanged = function() {
    verifyFields(null, 1);
    //console.log('map.onDataChanged');
	map_name_options = [];
	map_id_options = [];


    var data = map.getAllData();
	options = ['none'];
    
    for(var i=0; i<data.length; i++){
        options.push(data[i][0]);
	map_name_options.push([data[i][0], data[i][0]]);
	map_id_options.push([data[i][1], data[i][1]]);
    }

    //console.log(options);

    resetOptions(E('_f_map_name'),options);

	icmp_map.updateEditorField(0, { type: 'select', maxlen: 15, options: map_name_options});
	icmp_map.updateEditorField(1, { type: 'select', maxlen: 15, options: map_id_options});
}

//reload two delete function to check if the map is in used
function check_map_used(map_name)
{
    //console.log('check:' + map_name);
    if(map_name == E('_f_map_name').value){
        show_alert('The map already been used');
        return 0;
    }else
        return 1;
}

map.existkr = function(f,v)
{
	var data = icmp_map.getAllData();
	for(var i = 0; i < data.length;++i){
		if(data[i][f] == v) return true;
	}
	return false;
}

map.existMap = function(mapname)
{
	return this.existkr(0,mapname);
}

map.verifyDelete = function(data) 
{
	var mydata = map.getAllData();

	if (this.existMap(data[0])) {
		show_alert("Crypto map "+data[0]+" is in used by ICMP Detection");		
		return 0;
	}

	for (var i=0; i < mydata.length; i++) {
		if(mydata[i][0] != (data[0]))	
			map_name_options.push([mydata[i][0], mydata[i][0]]);
		if(mydata[i][1] != (data[1]))	
			map_id_options.push([mydata[i][1], mydata[i][1]]);
				
	}
	icmp_map.updateEditorField(0, 
			{ type: 'select', maxlen: 15, options: map_name_options});

	icmp_map.updateEditorField(1, 
			{ type: 'select', maxlen: 15, options: map_id_options})

	return true;
}

map.onDelete = function() {
		var data = [];

		for (i=0; i<this.source.cells.length; i++) data.push(this.source.cells[i].innerHTML);

        if(check_map_used(data[0]) == false) return;

		if (this.verifyDelete(data)==false) return;

		this.removeEditor();
		elem.remove(this.source);
		this.source = null;
		this.disableNewEditor(false);
        this.onDataChanged();

        //console.log('onDelete')
}

map.rpDel = function(e) {
		e = PR(e);

		var data = [];

		for (i=0; i<e.cells.length; i++) data.push(e.cells[i].innerHTML);

        if(check_map_used(data[0]) == false) return;
        
        if (this.verifyDelete(data)==false) return;

		TGO(e).moving = null;
		e.parentNode.removeChild(e);
		this.recolor();
		this.rpHide();
		this.disableNewEditor(false);
		this.onDataChanged();		
        
        //console.log('rpDel')
}

map.verifyFields = function(row, quiet) {
	var f = fields.getAll(row);

	if(haveChineseChar(f[0].value)) {
		ferror.set(f[0], errmsg.cn_chars, quiet);
		return 0;	
	} else if(!v_length(f[0], quiet, 1, 64)) {
		return 0;
	} else if(f[0].value.indexOf(" ") >= 0) {
		ferror.set(f[0], errmsg.bad_description, quiet);
		return 0;
	} else {
		ferror.clear(f[0]);
	}

	if(this.existName(f[0].value) && this.existID(f[1].value)) {
		ferror.set(f[1], errmsg.bad_name4, quiet);
		return 0;
	} else {
		ferror.clear(f[1]);
    	}

   	if(!v_range(f[1], quiet, 1, 10)) {
		return 0;
	}
	
	if(!v_ip(f[2], quiet)) {
		ferror.set(f[2], errmsg.ip, quiet);
		return 0;
	}

	if(!v_range(f[3], quiet, 100, 199)) {
		return 0;
	}

	if(f[4].length == 0) {
		ferror.set(f[4], "Invalid argument.Please configure the ISAKMP Profile first!", quiet);
		return 0;
	} else {
		ferror.clear(f[4]);
	}

	if(f[5].length == 0) {
		ferror.set(f[5], "Invalid argument.Please configure the Transform-set first!", quiet);
		return 0;
	} else {
		ferror.clear(f[5]);
	}

	if(!v_range(f[7], quiet, 1200, 86400)) {
		return 0;
	}
	if(!v_range(f[8], quiet, 30, 1800)) {
		return 0;
	}
	if(!v_range(f[9], quiet, 0, 100)) {
		return 0;
	}
	return 1;
}

map.resetNewEditor = function() {
	var f = fields.getAll(this.newEditor);
	f[0].value = '';
	f[1].value = '';
	f[2].value = '';
	f[3].value = '';

	for(var i = 4;i < f.length-1; i++) {
		f[i].value = 0;
	}
	f[7].value = '3600';
	f[8].value = '540';
	f[9].value = '100';

	ferror.clearAll(fields.getAll(this.newEditor));
}

map.setup = function() 
{
	this.init('map-grid', 'move', 20, [
		{ type: 'text', maxlen: 32 }, 
		{ type: 'text', maxlen: 32 }, 
		{ type: 'text', maxlen: 32 }, 
		{ type: 'text', maxlen: 32 }, 
		{ type: 'select', options: isaprof_options},
		{ type: 'select', options: transform_options},
		{ type: 'select', options:[
			['0', ipsec.none],
			['1', 'Group 1'],
			['2', 'Group 2'],
			['5', 'Group 5']
		]},
		{ type: 'text', maxlen: 32},
		{ type: 'text', maxlen: 32},
		{ type: 'text', maxlen: 32}
	]);
	this.headerSet([ui.nam, ipsec.id, ui.peer, ipsec.acl, ipsec.profile, ipsec.transform_title, ipsec.pfs, ipsec.lifetime,ipsec.margin,ipsec.fuzz]);

	for(var i = 0; i < map_config.length; i++) 
		this.insertData(-1, [map_config[i][0], map_config[i][1], map_config[i][2],
							map_config[i][3], map_config[i][4], map_config[i][5],
							map_config[i][6], map_config[i][7], map_config[i][8],
							map_config[i][9]]);

	this.showNewEditor();
	this.resetNewEditor();
}


/////////////////////////////////////////////////////////////////////////////
//icmp crypto map
function icmp_map_get_name()
{
	var crypte_name_list = new Array();
	var used_map = 0;
	crypte_name_list[used_map] = new Array(2);
	crypte_name_list[used_map][0] ='';
	crypte_name_list[used_map][1] ='';
	used_map++;
	for(var idx = 0; idx < map_config.length; idx ++){
		if(map_config[idx][0]){
			if(idx >0 && map_config[idx][0] == map_config[idx-1][0]){
				continue;
			}else {
				crypte_name_list[used_map] = new Array(2);
				crypte_name_list[used_map][0] = map_config[idx][0];
				crypte_name_list[used_map][1] = map_config[idx][0];
				used_map++;
			}
		}
	}	
	return crypte_name_list;
}

function icmp_map_get_id(name)
{
	var crypte_id_list = new Array();
	var used_id = 0;
	crypte_id_list[used_id] = new Array(2);
	crypte_id_list[used_id][0] = '';
	crypte_id_list[used_id][1] = '';
	used_id++;
	for(var idx = 0; idx < map_config.length; idx ++){
		if(map_config[idx][0] && map_config[idx][0] == name){
			crypte_id_list[used_id] = new Array(2);
			crypte_id_list[used_id][0] = map_config[idx][1];
			crypte_id_list[used_id][1] = map_config[idx][1];
			//alert("map id " + used_id + " id " + map_config[idx][1]);
			used_id++;
		}
	}	
	return crypte_id_list;
}

var icmp_map = new webGrid();

icmp_map.exist = function(f, v)
{
	var data = this.getAllData();
	for (var i = 0; i < data.length; ++i) {
		if (data[i][f] == v) return true;
	}
	return false;
}

icmp_map.existName = function(name)
{
	return this.exist(0, name);
}

icmp_map.existID = function(id)
{
	return this.exist(1, id);
}

icmp_map.dataToView = function(data) {
	
	return [data[0],data[1],data[2],data[3],data[4],data[5],data[6]];
}

icmp_map.fieldValuesToData = function(row) {
	var f = fields.getAll(row);
	return [f[0].value, f[1].value, f[2].value, f[3].value, f[4].value, 
	       		f[5].value, f[6].value];
}
icmp_map.onDataChanged = function() {
	verifyFields(null, 1);
}
icmp_map.verifyFields = function(row, quiet) {
	var f = fields.getAll(row);

	if(this.existName(f[0].value) && this.existID(f[1].value)) {
		f[1].disabled = false;
		ferror.set(f[1], errmsg.bad_name4, quiet);
		return 0;
	} else {
		ferror.clear(f[1]);
    	}

	if(!v_ip(f[2], quiet)) {
		ferror.set(f[2], errmsg.ip, quiet);
		return 0;
	}

	if(!v_ip(f[3], quiet)) {
		ferror.set(f[3], errmsg.ip, quiet);
		return 0;
	}

	if(!v_range(f[4], quiet, 1, 604800)) {
		return 0;
	}
	if(!v_range(f[5], quiet, 1, 604800)) {
		return 0;
	}
	if(!v_range(f[6], quiet, 1, 1000)) {
		return 0;
	}
	return 1;
}

icmp_map.resetNewEditor = function() {
	var f = fields.getAll(this.newEditor);
	//f[0].value = '';
	//f[1].value = '';
	f[2].value = '';
	f[3].value = '';
	f[4].value = '60';
	f[5].value = '5';
	f[6].value = '10';
	ferror.clearAll(fields.getAll(this.newEditor));

	//var map_name = icmp_map_get_name();
	//this.updateEditorField(0, { type: 'select', options:map_name} );
}

icmp_map.setup = function() 
{
	var map_data = map.getAllData();
	map_name_options = [];	//clear the keyring options
	map_id_options = [];	//clear the policy options

	for(var i=0; i<map_data.length; i++) {
		map_name_options.push([map_data[i][0], map_data[i][0]]);		
		map_id_options.push([map_data[i][1], map_data[i][1]]);
	}
	this.init('icmp_map-grid', 'move', 20, [
		{ type: 'select', options:map_name_options}, 
		{ type: 'select', options:map_id_options}, 
		{ type: 'text', maxlen: 32 }, 
		{ type: 'text', maxlen: 32 }, 
		{ type: 'text', maxlen: 32},
		{ type: 'text', maxlen: 32},
		{ type: 'text', maxlen: 32}
	]);
	this.headerSet([ui.nam, ipsec.id, ui.icmp_host, ui.icmp_local, ui.icmp_interval, ui.icmp_timeout, ui.icmp_retries]);

	for(var i = 0; i < icmp_map_config.length; i++) 
		this.insertData(-1, [icmp_map_config[i][0], icmp_map_config[i][1], icmp_map_config[i][2],
							icmp_map_config[i][3], icmp_map_config[i][4], icmp_map_config[i][5],
							icmp_map_config[i][6]]);

	this.showNewEditor();
	this.resetNewEditor();
}

function del_icmp_map_check(name, id)
{
	var i = 0;
	for(i = 0; i < icmp_map_config.length; i ++){
		if((icmp_map_config[i][0] && icmp_map_config[i][0] == name)
		 &&(icmp_map_config[i][1] && icmp_map_config[i][1] == id)){
			//alert("found icmp map " + i);
			return i;
 		}
	}	
	return 0;
}

function verifyFields(focused, quiet)
{
	var ok = 1;
	var cmd = "";
	var fom = E('_fom');

	E('save-button').disabled = true;

	var data_found = 0;
	var data_changed = 0;

	/* verfiy for the ipsecprof grid */
	var datap = ipsecprof.getAllData();
	var mprofs = ipsec_prof_config;

	//delete the ipsec profile from json which have been deleted from web
	for(var i = 0; i < mprofs.length; i++) {
		data_found = 0;
		data_changed = 0;

		for(var j = 0; j < datap.length; j++) {
			if(mprofs[i][0] == datap[j][0]) {
				data_found = 1;
				break;
			}
		}
		if(!data_found) {
			cmd += "no crypto ipsec profile " + mprofs[i][0] + "\n";
		}
	}

	//add the ipsec profile into json which have been added or changed by the web
	for(var i = 0; i < datap.length; i++) {
		var pfs;
		data_found = 0;
		data_changed = 0;

		if(datap[i][3] == '1') {
			pfs = "group1";
		} else if(datap[i][3] == '2') {
			pfs = "group2";
		} else if(datap[i][3] == '5') {
			pfs = "group5";
		}

		for(var j = 0; j < mprofs.length; j++) {
			if(datap[i][0] == mprofs[j][0]) {
				data_found = 1;
				if((datap[i][1] != mprofs[j][1]) ||
					(datap[i][2] != mprofs[j][2]) ||
					(datap[i][3] != mprofs[j][3]) ||
					(datap[i][4] != mprofs[j][4]) ||
					(datap[i][5] != mprofs[j][5]) ||
					(datap[i][6] != mprofs[j][6]) ||
					(datap[i][7] != mprofs[j][7])) {
					data_changed = 1;
				}
				break;
			}
		}
		
		if(!data_found || data_changed) {
			cmd += "!\n";
			cmd += "crypto ipsec profile "+datap[i][0]+"\n";
			cmd += "set isakmp-profile "+datap[i][1] +"\n";
			if(datap[i][3] == '0') {
				cmd += "no set pfs\n";
			} else {
				cmd += "set pfs "+pfs + "\n";
			}
			cmd += "set transform-set "+datap[i][2] +"\n";
			cmd += "set security-association lifetime seconds "+datap[i][4] +"\n";
			if(datap[i][5]!='540' || datap[i][6]!='100') {
				cmd += "set security-association rekey margin "+datap[i][5] +" fuzz " +datap[i][6] +"\n";
			} else {
				cmd += "no set security-association rekey\n";
			}
			if(datap[i][7] == '0') {
				cmd += "no bind sim\n";
			} else {
				cmd += "bind sim "+datap[i][7] + "\n";
			}
		}
	}

////////////////////////////////////////////////////////////////////////////////
	/* verfiy for the map grid */
	var datam = map.getAllData();
	var mmaps = map_config;
	var idx = -1;

	//delete the map from json which have been deleted from web
	for(var i = 0; i < mmaps.length; i++) {
		data_found = 0;
		data_changed = 0;

		for(var j = 0; j < datam.length; j++) {
			if((mmaps[i][0] == datam[j][0]) &&
				(mmaps[i][1] == datam[j][1])) {
				data_found = 1;
				break;
			}
		}
		if(!data_found) {
			cmd += "!" + "\n";
			idx = del_icmp_map_check(mmaps[i][0], mmaps[i][1]);
			if(idx>=0){
				cmd += "crypto map " + mmaps[i][0] +" "+ mmaps[i][1] + " ipsec-isakmp\n";
				cmd += "no keepalive icmp-echo\n";
				cmd += "!" + "\n";
			}
			cmd += "no crypto map " + mmaps[i][0] +" "+ mmaps[i][1] + "\n";
		}
	}

	//add the ipsec map into json which have been added or changed by the web
	for(var i = 0; i < datam.length; i++) {
		var pfs;
		data_found = 0;
		data_changed = 0;

		if(datam[i][6] == '1') {
			pfs = "group1";
		} else if(datam[i][6] == '2') {
			pfs = "group2";
		} else if(datam[i][6] == '5') {
			pfs = "group5";
		}

		for(var j = 0; j < mmaps.length; j++) {
			if((datam[i][0] == mmaps[j][0]) &&
				(datam[i][1] == mmaps[j][1])) {
				data_found = 1;
				if((datam[i][2] != mmaps[j][2]) ||
					(datam[i][3] != mmaps[j][3]) ||
					(datam[i][4] != mmaps[j][4]) ||
					(datam[i][5] != mmaps[j][5]) ||
					(datam[i][6] != mmaps[j][6]) ||
					(datam[i][7] != mmaps[j][7]) ||
					(datam[i][8] != mmaps[j][8]) ||
					(datam[i][9] != mmaps[j][9])) {
					data_changed = 1;
				}
				break;
			}
		}
		
		if(!data_found || data_changed) {
			cmd += "!\n";
			cmd += "crypto map "+datam[i][0]+" "+datam[i][1]+" ipsec-isakmp"+"\n";
			cmd += "match address "+datam[i][3]+"\n";	//ACL
			cmd += "set isakmp-profile "+datam[i][4] +"\n";
			cmd += "set peer "+datam[i][2]+"\n";

			if(datam[i][6] == '0') {	//pfs
				cmd += "no set pfs\n";
			} else {
				cmd += "set pfs "+pfs + "\n";
			}
			cmd += "set transform-set "+datam[i][5] +"\n";
			cmd += "set security-association lifetime seconds "+datam[i][7] +"\n";
			if(datam[i][8]!='540' || datam[i][9]!='100') {
				cmd += "set security-association rekey margin "+datam[i][8] +" fuzz " +datam[i][9] +"\n";
			} else {
				cmd += "no set security-association rekey\n";
			}
		}
	}	
////////////////////////////////////////////////////////////////////////////////
//crypto map icmp
	var icmpdatam = icmp_map.getAllData();
	var icmpmaps = icmp_map_config;
	
	//delete the map from json which have been deleted from web
	for(var i = 0; i < icmpmaps.length; i++) {
		data_found = 0;
		data_changed = 0;

		for(var j = 0; j < icmpdatam.length; j++) {
			if((icmpmaps[i][0] == icmpdatam[j][0]) &&
				(icmpmaps[i][1] == icmpdatam[j][1])&&
				(icmpmaps[i][2] == icmpdatam[j][2])&&
				(icmpmaps[i][3] == icmpdatam[j][3])&&
				(icmpmaps[i][4] == icmpdatam[j][4])&&
				(icmpmaps[i][5] == icmpdatam[j][5])&&
				(icmpmaps[i][6] == icmpdatam[j][6])) {
				data_found = 1;
				break;
			}
		}
		
		if(!data_found) {
			cmd += "!" + "\n";
			cmd += "crypto map " + icmpmaps[i][0] +" "+ icmpmaps[i][1] + " ipsec-isakmp\n";
			cmd += "no keepalive icmp-echo\n";
		}
	}

	//add the ipsec map into json which have been added or changed by the web
	for(var i = 0; i < icmpdatam.length; i++) {
		
		data_found = 0;
		data_changed = 0;
		
		for(var j = 0; j < icmpmaps.length; j++) {
			if((icmpdatam[i][0] == icmpmaps[j][0]) &&
				(icmpdatam[i][1] == icmpmaps[j][1])) {
				data_found = 1;
				if((icmpdatam[i][2] != icmpmaps[j][2]) ||
					(icmpdatam[i][3] != icmpmaps[j][3]) ||
					(icmpdatam[i][4] != icmpmaps[j][4]) ||
					(icmpdatam[i][5] != icmpmaps[j][5]) ||
					(icmpdatam[i][6] != icmpmaps[j][6])) {
					data_changed = 1;
				}
				break;
			}
		}

		if(!data_found || data_changed) {
			cmd += "!\n";
			cmd += "crypto map "+icmpdatam[i][0]+" "+icmpdatam[i][1]+" ipsec-isakmp\n";
			cmd += "keepalive icmp-echo "+icmpdatam[i][2]+ " interval "+icmpdatam[i][4]+" timeout "+icmpdatam[i][5]+" retry "+icmpdatam[i][6]
				+" source "+icmpdatam[i][3]+"\n";
		}
	}

////////////////////////////////////////////////////////////////////////////////
//crypto map interface
	var map_iface = E('_f_map_iface').value;
	var map_name = E('_f_map_name').value;
	var map_iface_json = if_map_config[0][0]
	var map_name_json = if_map_config[0][1];

	if(map_name_json == "")
		map_name_json = "none";

    var earlier_cmd = '';
    //when delete a map,must release the map first
    //so put the release cmd in earlier_cmd 
    //and earlier_cmd must be execute first    
	if(map_iface != map_iface_json) {
		if(map_iface_json != "") { 
			if(map_name_json != "none") {
				earlier_cmd += "!\n";
				earlier_cmd += "interface " + map_iface_json +"\n";
                earlier_cmd += "no crypto map "+ map_name_json +"\n";

                cmd = earlier_cmd + cmd;
			}
		}
		if(map_name != "none") {
			cmd += "!\n";
			cmd += "interface " + map_iface +"\n";
			cmd += "crypto map "+ map_name +"\n";
		}
	} else {
		if(map_name != map_name_json) {
			earlier_cmd += "!\n";
			earlier_cmd += "interface " + map_iface +"\n";
			earlier_cmd += "no crypto map "+ map_name_json +"\n";	
            
            cmd = earlier_cmd + cmd;
			
			if(map_name != "none") {
			    cmd += "!\n";
			    cmd += "interface " + map_iface +"\n";
				cmd += "crypto map "+ map_name +"\n";
			}
		}
	}

	
//	alert("Bone1:map_name:"+map_name+" map_iface:"+map_iface);

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

	if (ipsecprof.isEditing()) return;
	if (map.isEditing()) return;
	if (icmp_map.isEditing()) return;

	if((E('_fom')._web_cmd.value != '')&&(cookie.get('autosave') == 1)){
		E('_fom')._web_cmd.value += "!"+"\n"+"copy running-config startup-config"+"\n";	
	}
	form.submit('_fom', 1);
}

function earlyInit()
{
	ipsecprof.setup();
	map.setup();
	icmp_map.setup();
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

<div id='ipsecprof_title' class='section-title'>
IPSec Profile
</div>
<div id="ipsecprof_body" class='section'>
	<table class='web-grid' id='ipsecprof-grid'></table>	
</div>

<div id='map_title' class='section-title'>
<script type='text/javascript'>
	GetText(ipsec.map_title);
</script>
</div>
<div id="map_body" class='section'>
	<table class='web-grid' id='map-grid'></table>	
</div>
<div id="icmp_map_body" class='section'>
	<table class='web-grid' id='icmp_map-grid'></table>	
</div>
<div id='crypto_title' class='section-title'>
<script type='text/javascript'>
	GetText(ipsec.crypto_title);
</script>
</div>
<div class='section'>
	<table class=web-grid cellspacing=1 id='crypto-grid' >
<script type='text/javascript'>
/*
createFieldTable('', [
	{ title: '', multi: [
		{ custom: '<span id="map_name">Map Name &emsp;&emsp;&emsp;&emsp;&emsp;</span>'},
		{ custom: '<span id="map_iface">Map Interface </span>'}]},
	{ title: '', multi: [
		{ name: 'f_map_name', type: 'select', attrib:'style="width:100px;"', options: map_options, value: '0', suffix:'&emsp;&emsp;&thinsp;'},
		{ name: 'f_map_iface', type: 'select', attrib:'style="width:100px;"', options: interface_options, value: '0'}]}
	]);
*/
/*
	W("<tr id='crypto-head'>");
		<td>Map Name&emsp;&emsp;&emsp;&emsp;&emsp;</td>
		<td>Map Interface</td>
	W("</tr>");
*/
W("<tr id='crypto_head' >");
W("<th >");W(ipsec.map_iface);W("</th>");
W("<th >");W(ipsec.map_name);W("</th>");
W("</tr>");

W("<tr>");
W(creatSelect(select_map_iface, if_map_config[0][0], '_f_map_iface'));
W(creatSelect(select_map_name,if_map_config[0][1],'_f_map_name'));
W("</tr>");

</script>
	</table>
</div>

<script type='text/javascript'>
init();
if(cookie.get('autosave') == 1)
	ui.aply=ui.aply_save;
genStdFooter("ipsec.transform_title");
</script>
</form>
<script type='text/javascript'>earlyInit()</script>


</body>
</html>

