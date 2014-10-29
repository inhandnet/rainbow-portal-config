<% pagehead(menu.switch_raps_instance) %>

<style type='text/css'>
#raps_grid {
	width: 800px;	
	text-align: center;
}

.co1 {
	width: 8%;
}
.co2 {
	width: 15%;
}
.co3 {
	width: 12%;
}
.co4 {
	width: 10%;
}
.co5 {
	width: 10%;
}
.co6 {
	width: 25%;
}
.co7 {
	width: 10%;
}
.co8 {
	width: 10%;
}




</style>

<script type='text/javascript'>

<% ih_sysinfo() %>
<% ih_user_info(); %>
var vlan_config = [];
var port_config= [];
var g8032_config = [];
/*
vlan_config=[[1,0,0,'VLAN0001',untagged=[[1,1,2],[1,1,3],[1,1,5],[1,1,6],[1,1,7],[1,1,8],[2,1,1],[2,1,2],[2,1,3]],tagged=[]],
					[5,0,0,'VLAN0005',untagged=[[1,1,1],[1,1,4]],tagged=[[1,1,2],[1,1,3]]],
					[6,0,0,'VLAN0001',untagged=[[1,1,2],[1,1,3],[1,1,5],[1,1,6],[1,1,7],[1,1,8],[2,1,1],[2,1,2],[2,1,3]],tagged=[]],
					[7,0,0,'VLAN0001',untagged=[[1,1,2],[1,1,3],[1,1,5],[1,1,6],[1,1,7],[1,1,8],[2,1,1],[2,1,2],[2,1,3]],tagged=[]],
					[8,0,0,'VLAN0001',untagged=[],tagged=[[1,1,2],[1,1,3],[1,1,5],[1,1,6],[1,1,7],[1,1,8],[2,1,1],[2,1,2],[2,1,3]]]
					];
port_config=[['1','1','1',1,3,2,1,0,0,0,0,0,0,1,0,0,0,'abc1,23'],
					['1','1','2',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],
					['1','1','3',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],
					['1','1','4',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],
					['1','1','5',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],
					['1','1','6',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],
					['1','1','7',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],
					['1','1','8',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],
					['2','1','1',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],
					['2','1','2',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],
					['2','1','3',1,3,2,1,0,0,0,0,0,0,1,0,0,0,'']
					];
g8032_config = [[1,1,[5,6],[1,1,5],[1,1,6],1,0,0,1,1]];
*/

<% web_exec('show running-config g8032d') %>
<% web_exec('show running-config interface') %>
<% web_exec('show running-config vlan') %>
<% ih_sysinfo() %>

/* ####### var index define start ########*/
/*JSON Index*/
var idIndex = 0;
var cVlanIndex = 1;
var sVlanIndex = 2;
var lPortIndex = 3;
var rPortIndex = 4;
var ringTypeIndex = 5;
var majorRingID = 6;
var nodeTypeIndex = 7;
var insEnabledIndex = 8;

/*Web Table Index*/
var tbIDIndex = 0;
var tbRingTypeIndex = 1;
var tbMajorRingIDIndex = 2;
var tbNodeTypeIndex = 3;
var tbCVLANIndex = 4;
var tbSVLANIndex = 5;
var tbLPortIndex = 6;
var tbRPortIndex = 7;
/* ####### var index define end ########*/

//for (var i = 0; i < g8032_config.length; i++){
//	g8032_config[i][interConnIndex] += 1;
//}

var switch_interface = [[0, ' ']];
var port_cmd_list = [' '];
var tmp_old_config = [];

//var node_type = [' ',raps.normal_node,raps.owner_node,raps.neighbor_node,raps.next_neighbor_node];
//var ring_type = [' ',raps.major_ring,raps.sub_no_vchan,raps.sub_with_vchan];
var cmd_ring_type = [' ','major-ring','sub-ring','virtual-sub-ring'];
var cmd_node_type = [' ','normal','owner','neighbor','interconnection'];
var all_vlan_options = [[0, ' ']];
var all_vlan_select = [' '];


var all_ring_type_options = [[0,' '],[1,raps.major_ring],[2,raps.sub_no_vchan],[3,raps.sub_with_vchan]];
var major_ring_node_type_options = [[0,' '],[1,raps.normal_node],[2,raps.owner_node],[3,raps.neighbor_node]];
var sub_ring_node_type_options = [[0,' '],[1,raps.normal_node],[2,raps.owner_node],[3,raps.neighbor_node], [4,raps.interconnection]];

var vid_options = [[0, ' ']];
var cvid_options = [[0, ' ']];
var l_port_options = [[0, ' ']];
var r_port_options = [[0, ' ']];
var major_ring_id_options = [[0, '--']];





/************************************************************
*	FE1/9 can't be used as RING PORT in ISM2009D .
*	matchModel(ih_sysinfo.model_name, specialModel)	
*************************************************************/
var specialModel = "2009";//ISM2009D

function matchModel(matchedModel, specialModel)
{
	if ( matchedModel.indexOf(specialModel) > 0)
		return 1;
	return 0; 
}

function specialPort(portId)
{
	//FE1/9 is special port
	if ((parseInt(portId[0], 10) == 1)
			&& (parseInt(portId[1], 10) == 1)
			&& (parseInt(portId[2], 10) == 9))
			return 1;
	return 0;
}

for(var i=0;i<port_config.length;++i){
	/************************************************************
	*	FE1/9 can't be used as RING PORT in ISM2009D .
	*************************************************************/
	if (matchModel(ih_sysinfo.model_name, specialModel) 
		&& specialPort(port_config[i]))
			continue;
	
	if(port_config[i][0] == 1){
		port_cmd_list.push("fastethernet "+ port_config[i][1] + "/" + port_config[i][2]);
		switch_interface.push([i+1, "FE"+ port_config[i][1] + "/" + port_config[i][2]]);
	}else if(port_config[i][0] == 2){
		port_cmd_list.push("gigabitethernet "+ port_config[i][1] + "/" + port_config[i][2]);
		switch_interface.push([i+1, "GE"+ port_config[i][1] + "/" + port_config[i][2]]);
	}
	
}

for(var i=0;i<vlan_config.length;++i){
	all_vlan_options.push([i+1,vlan_config[i][0].toString()]);
	all_vlan_select.push(vlan_config[i][0].toString());
}

function getNodeTypeIndex(json_value)
{/*1,2,4,8,16,32,64,128 -> 1,2,3,4,5,6,7*/
	switch(json_value){
		case 1:
			return 1;
		case 2:
			return 2;
		case 4:
			return 3;
		case 9:
			return 4;
		default:
			return 0;
	}

	return 1;
}


function getPortName(portId)
{
	var port_name = "";
	
	if (portId.length < 3)
		return "Undefined";

	if (portId[0] == 1)
		port_name = "FE"+ portId[1] + "/" + portId[2];
	else if (portId[0] == 2)
		port_name = "GE"+ portId[1] + "/" + portId[2];
	else
		return "Undefined";

	return port_name;
	
}


function getPortGlobalIndex(portId)
{
	if (portId.length < 3)
		return -1;

	/************************************************************
	*	FE1/9 can't be used as RING PORT in ISM2009D .
	*************************************************************/
	if (matchModel(ih_sysinfo.model_name, specialModel) 
		&& specialPort(portId)){
		return -1;
	}

	for (var i = 0; i < port_config.length; i++){
		if ((portId[0] == parseInt(port_config[i][0], 10))
			&& (portId[1] == parseInt(port_config[i][1], 10))
			&& (portId[2] == parseInt(port_config[i][2], 10))
		)
			return i;
	}

	return 0;	
}


function getVlanGlobalIndex(vid)
{
	for (var i = 0; i < all_vlan_options.length; i++){
		if (vid == all_vlan_options[i][1])
			return i;
	}

	return 0;
}



var instance = new webGrid();


instance.onDataChanged = function()
{
	verifyFields(null, false);
}


instance.exist = function(f, v)
{
	var data = this.getAllData();
	for (var i = 0; i < data.length; ++i) {
		if (data[i][f] == v) return true;
	}
	return false;
}


instance.onClick = function(cell) 
{
	return 1;
}

/*get Service VLAN IDs: '1,2,3' => [1,2,3] */
function getSVlan(text)
{
	var vlan_list = [];
	var ret_vlan_list = [];
	
	vlan_list = text.split(',');

	for (var i = 0; i < vlan_list.length; i++){
		if (vlan_list[i] == '') continue;
		if (isDigit(vlan_list[i]))
			ret_vlan_list.push(vlan_list[i]);
	}
	return ret_vlan_list;
}

/*Service VLAN ID must be 1-4094*/
function verifySVlanList(f, quiet)
{
	var vlan_list = [];

	vlan_list = f.value.split(',');

	for (var i = 0; i < vlan_list.length; i++){
		if ((!isDigit(vlan_list[i]) && vlan_list[i] != '' && vlan_list[i] != ' ') 
			|| (vlan_list[i] < 1 && vlan_list[i] > 4094)){
			ferror.set(f,errmsg.bad_value, quiet);
			return 0;
		}else{
			ferror.clear(f);
		}
	}

	return 1;	
}
/*VLAN vid is used by ring instance*/
function vlanUsedInInstance(vid)
{
	var data = instance.getAllData();
	var vlan_list = [];
	
	for (var i = 0; i < data.length; i++){
		/*c-vlan*/
		if (data[i][tbCVLANIndex] == vid)
			return data[i][tbIDIndex];//id
		
		/*s-vlan*/
		/*
		vlan_list = getSVlan(data[i][tbSVLANIndex]);
		for (var j = 0; j < vlan_list.length; j++){
			if (parseInt(vlan_list[j], 10) == vid)
				return data[i][tbIDIndex];//id
		}
		*/
		
	}
	
	return 0;
}

/*VLAN vid is used by ring instance*/
function vlanUsedbyInstance(vid)
{
	var data = instance.getAllData();
	var vlan_list = [];
	
	for (var i = 0; i < data.length; i++){
		/*c-vlan*/
		if (data[i][tbCVLANIndex] == vid)
			return data[i][tbIDIndex];//id
		
		/*s-vlan*/
		
		vlan_list = getSVlan(data[i][tbSVLANIndex]);
		for (var j = 0; j < vlan_list.length; j++){
			if (parseInt(vlan_list[j], 10) == vid)
				return data[i][tbIDIndex];//id
		}
		
		
	}
	
	return 0;
}

function vlanUsedAsSVLANinRing(vid, ring_id)
{
	var data = instance.getAllData();
	var vlan_list = [];
	
	for (var i = 0; i < data.length; i++){
		if (parseInt(data[i][tbIDIndex], 10) != ring_id)
			continue;
		vlan_list = getSVlan(data[i][tbSVLANIndex]);
		for (var j = 0; j < vlan_list.length; j++){
			if (parseInt(vlan_list[j], 10) == vid)
				return 1;//id
		}
		return 0;
	}

	return 0;
}
/*
function generateMajorRingIDOptions()
{
	major_ring_id_options = [[0, '--']];

	var data = instance.getAllData();

	for (var i = 1; i < 11; i++){//ID:1-10
		for (var j = 0; j < data.length; j++){
			if ((parseInt(data[j][tbIDIndex], 10) == i)
				&& (data[j][tbRingTypeIndex] == 1)){//major ring
				major_ring_id_options.push([data[j][tbIDIndex], ''+data[j][tbIDIndex]]);
			}
		}
	}
}


*/
function verifySubRingInterNodeSVLAN(vid, major_ring_id, f, quiet)	
{
	if (!vlanUsedAsSVLANinRing(vid, major_ring_id)) {
		ferror.set(f, 'VLAN '+vid+errmsg.subRingSVLAN0+major_ring_id+errmsg.subRingSVLAN1, quiet);
		return 0;
	}else {
		ferror.clear(f);
		return 1;
	}
}

/*Generate control VLAN ID options*/
function generatecVlanIdOptions()
{
	cvid_options = [[0, '']];

	for (var i = 1; i < all_vlan_options.length; i++){
		//if (vlanUsedInInstance(all_vlan_options[i][1]) == 0){  
		if (vlanUsedbyInstance(all_vlan_options[i][1]) == 0){
			cvid_options.push(all_vlan_options[i]);
		}
	}
}

/*VLAN is vaild*/
function vailVlanId(vid)
{
	for (var i = 1; i < all_vlan_options.length; i++){
		if (vid == all_vlan_options[i][1])
			return true;
	}

	return false;
}

/*Port port_option_id is VLAN member*/
function portIsVlanMember(port_option_id, vlan_id)
{
	//alert(switch_interface[port_option_id][1]+" is in vlan " + vlan_id +"?");
	for (var i =0; i < vlan_config.length; i++){
		if (vlan_id != vlan_config[i][0]) continue;
		
		/*untagged*/
		for (var j = 0; j < vlan_config[i][4].length; j++){
			if ((vlan_config[i][4][j][0] == parseInt(port_config[port_option_id - 1][0], 10))
				&& (vlan_config[i][4][j][1] == parseInt(port_config[port_option_id - 1][1], 10))
				&& (vlan_config[i][4][j][2] == parseInt(port_config[port_option_id - 1][2], 10)))
				return true;
		}
		/*tagged*/
		for (var j = 0; j < vlan_config[i][5].length; j++){
			if ((vlan_config[i][5][j][0] == parseInt(port_config[port_option_id - 1][0], 10))
				&& (vlan_config[i][5][j][1] == parseInt(port_config[port_option_id - 1][1], 10))
				&& (vlan_config[i][5][j][2] == parseInt(port_config[port_option_id - 1][2], 10)))
				return true;
		}
	}
	
	return false;
}

/*Generate left port options*/
function generateLPortOptions(c_vlan, s_vlan_list)
{
	var port_is_vlan_mem = 1;
	var vlan_port_is_used = 0;
	var tmp_port_options = []; 
	var data = instance.getAllData();
	l_port_options = [[0, ' ']];
	
	for (var i = 1; i < switch_interface.length; i++){		
		port_is_vlan_mem = 1;
		/*c_vlan*/		
		//if (!portIsVlanMember(i, c_vlan)) continue;
		for (var j = 0; j < s_vlan_list.length; j++){
			if (!portIsVlanMember(i, s_vlan_list[j])){
				port_is_vlan_mem = 0;
				break;
			}
		}
		if (port_is_vlan_mem) 
			tmp_port_options.push(switch_interface[i]);		
	}

	for (var i = 0; i < tmp_port_options.length; i++){
		vlan_port_is_used = 0;
		
		for (var j = 0; j < s_vlan_list.length; j++){
			if (vlan_port_is_used) break;
			for (var k = 0; k < data.length; k++){
				if (vlanUsedAsSVLANinRing(s_vlan_list[j], data[k][tbIDIndex])){
					if ((tmp_port_options[i][0] == data[k][tbLPortIndex])
						|| (tmp_port_options[i][0] == data[k][tbRPortIndex])){
						vlan_port_is_used = 1;
						break;
					}					
				}
			}
		}

		if (!vlan_port_is_used)
			l_port_options.push(tmp_port_options[i]);	
	}	
}

/*Generate right port options according to left port options*/
function generateRPortOptions(c_vlan, s_vlan_list, l_port_id)
{
	r_port_options = [[0, ' ']];

	for (var i = 1; i < l_port_options.length; i++){
		if (l_port_options[i][0] == l_port_id) continue;
		r_port_options.push(l_port_options[i]);
	}
}

/*Instance ID is used at running-config*/
function idUsedAtOldCfg(instance_id)
{
	for(var i = 0; i < g8032_config.length; ++i){
		if (g8032_config[i][idIndex] == instance_id)
			return true;
	}	

	return false;
}
/*
instance.onAdd = function() {
	var data;

	instance.moving = null;
	instance.rpHide();

	if (!instance.verifyFields(instance.newEditor, false)) return;

	data = instance.fieldValuesToData(instance.newEditor);
	instance.insertData(-1, data);

	instance.disableNewEditor(false);

	//generateMajorRingIDOptions();
	//instance.safeUpdateEditorField(tbMajorRingIDIndex, { type: 'select', options: major_ring_id_options});//major ring type
	//generatecVlanIdOptions();
	//instance.safeUpdateEditorField(tbCVLANIndex, { type: 'select', options: cvid_options});//c-vlan
	
	instance.resetNewEditor();
	instance.onDataChanged();
}
*/
instance.safeUpdateEditorField = function(i, editorField) {
	var f = fields.getAll(this.newEditor);
	var data = [];
	var j, e;
	var f_disabled = [];
	//get old datas of the row
	for (j = 0; j < f.length; j++){
		data.push(f[j].value);
		f_disabled.push(f[j].disabled);
	}
	
	//update
	instance.updateEditorField(i, editorField);

	//set datas
	f = fields.getAll(this.newEditor);
	ferror.clearAll(f);
	for (j = 0; j < f.length; ++j) {
		if (f[j].selectedIndex) f[j].selectedIndex = data[j];
		else f[j].value = data[j];
		f[j].disabled = f_disabled[j];
	}

	return f;
}

instance.disableAll  = function(row)
{
	var f = fields.getAll(row);
	
	for (var i = 0; i < f.length; i++){
			f[i].disabled = true;
	}

	return 1;
}

instance.enableField = function(row, fn)
{
	var f = fields.getAll(this.newEditor);
	if (f.length > fn)
		f[fn].disabled = false;
	return 1;
}

instance.verifyFields = function(row, quiet) 
{
	var f = fields.getAll(row);
	ferror.clearAll(f);
	instance.disableAll(row);
	
	/*id*/
	instance.enableField(row, tbIDIndex);
	if (!v_f_number(f[tbIDIndex], quiet, false, 1, 10)) return 0;
	
	if (instance.exist(tbIDIndex, f[tbIDIndex].value)){
		ferror.set(f[tbIDIndex], errmsg.bad_id, quiet);
		return 0;
	}else{
		ferror.clear(f[tbIDIndex]);
	}

	if (idUsedAtOldCfg(f[tbIDIndex].value)){//old cfg instance id
		ferror.set(f[tbIDIndex], errmsg.oldused, quiet);
		return 0;
	}else{
		ferror.clear(f[tbIDIndex]);
	}

	/*Ring type*/
	instance.enableField(row, tbRingTypeIndex);
	if (f[tbRingTypeIndex].value == 0){//blank selected
		ferror.set(f[tbRingTypeIndex], errmsg.adm3, quiet);
		return 0;
	}else{
		ferror.clear(f[tbRingTypeIndex]);
	}

	/*Major Ring ID*/
	if (f[tbRingTypeIndex].value == 1){//'Major' Ring, change node type
		f[tbMajorRingIDIndex].value = '';//need not major ring id
	}else {
		instance.enableField(row, tbMajorRingIDIndex);
		if (!v_f_number(f[tbMajorRingIDIndex], quiet, false, 1, 10)) return 0;
		if (parseInt(f[tbMajorRingIDIndex].value, 10) == parseInt(f[tbIDIndex].value, 10)){
			ferror.set(f[tbMajorRingIDIndex], errmsg.badMjID, quiet);
			return 0;
		}else{		
			ferror.clear(f[tbMajorRingIDIndex]);
		}
		/*
		if (f[tbMajorRingIDIndex].value == 0){
			ferror.set(f[tbMajorRingIDIndex], errmsg.adm3, quiet);
			return 0;
		}else{
			ferror.clear(f[tbMajorRingIDIndex]);
		}
		*/
	}	
	
	/*node type*/
	instance.enableField(row, tbNodeTypeIndex);
	/*change Node type options according to ring type*/
	if (f[tbRingTypeIndex].value == 1){//'Major' Ring, change node type
		f = instance.safeUpdateEditorField(tbNodeTypeIndex, { type: 'select', options: major_ring_node_type_options});// node type
	}else{
		f = instance.safeUpdateEditorField(tbNodeTypeIndex, { type: 'select', options: sub_ring_node_type_options});// node type
	}
	if (f[tbNodeTypeIndex].value == 0){//blank selected
		ferror.set(f[tbNodeTypeIndex], errmsg.adm3, quiet);
		return 0;
	}else{
		ferror.clear(f[tbNodeTypeIndex]);
	}


	
	
	/* c-vlan*/
	instance.enableField(row, tbCVLANIndex);
	if (!v_f_number(f[tbCVLANIndex], quiet, false, 1, 4094)) return;
	if (vailVlanId(f[tbCVLANIndex].value)
		|| (vlanUsedbyInstance(f[tbCVLANIndex].value) != 0)){
		ferror.set(f[tbCVLANIndex], errmsg.ex_vlan, quiet);
		return 0;		
	}else{
		ferror.clear(f[tbCVLANIndex]);
	}



	/*s-vlan*/
	instance.enableField(row, tbSVLANIndex);
	var s_vlan_list = [];
	var used_id = 0;
	
	if (f[tbSVLANIndex].value == 0){//blank selected
		ferror.set(f[tbSVLANIndex], errmsg.adm3, quiet);
		return 0;
	}else{
		ferror.clear(f[tbSVLANIndex]);
	}
		
	if (!verifySVlanList(f[tbSVLANIndex], quiet)) return 0;//vlan-id:1-4094		

	s_vlan_list = getSVlan(f[tbSVLANIndex].value);
		
	if (s_vlan_list.length > 255){//too many s-vlan
		ferror.set(f[tbSVLANIndex], errmsg.bad_service_vlan1, quiet);
		return 0;
	}else{
		ferror.clear(f[tbSVLANIndex]);
	}

	for (var i = 0; i < s_vlan_list.length; i++){		
		if (!vailVlanId(s_vlan_list[i])){//not exist vlan
			ferror.set(f[tbSVLANIndex], errmsg.vlan_uncreated, quiet);
			return 0;			
		}else if (s_vlan_list[i] == f[tbCVLANIndex].value ){//used as c-vlan
			ferror.set(f[tbSVLANIndex], errmsg.bad_service_vlan, quiet);
			return 0;		
		}else {
			if (f[tbRingTypeIndex].value != 1 && f[tbNodeTypeIndex].value == 4){//sub ring and inter-connection node
				if(!verifySubRingInterNodeSVLAN(
							s_vlan_list[i],
							f[tbMajorRingIDIndex].value,
							f[tbSVLANIndex], 
							quiet))
					return 0;
			}else {
				if ((used_id = vlanUsedInInstance(s_vlan_list[i])) != 0){//used vlan in other instance
					ferror.set(f[tbSVLANIndex], errmsg.be_used, false);
					return 0;
				}else{
					ferror.clear(f[tbSVLANIndex]);
				}
			}
		}
	}		


	/*l-port*/
	instance.enableField(row, tbLPortIndex);
	//generateLPortOptions(all_vlan_options[f[tbCVLANIndex].value][1], s_vlan_list);
	generateLPortOptions(f[tbCVLANIndex].value, s_vlan_list);
	f = instance.safeUpdateEditorField(tbLPortIndex, { type: 'select', options: l_port_options});//l-port
	if (l_port_options.length == 1){//options empty
		ferror.set(f[tbLPortIndex], errmsg.opt_empty, quiet);
		return 0;
	}else{
		ferror.clear(f[tbLPortIndex]);
	}	
	
	if (f[tbLPortIndex].value == 0){//blank selected
		ferror.set(f[tbLPortIndex], errmsg.adm3, quiet);
		return 0;
	}else{
		ferror.clear(f[tbLPortIndex]);
	}		
	

	/*r-port*/
	if (!(f[tbRingTypeIndex].value != 1 && f[tbNodeTypeIndex].value == 4)){
		instance.enableField(row, tbRPortIndex);
	}
	if (!f[tbRPortIndex].disabled ){
		generateRPortOptions(f[tbCVLANIndex].value, s_vlan_list, f[tbLPortIndex].value);
		f = instance.safeUpdateEditorField(tbRPortIndex, { type: 'select', options: r_port_options});//r-port
		if (r_port_options.length == 1){//options empty
			ferror.set(f[tbRPortIndex],errmsg.opt_empty, quiet);
			return 0;
		}else{
			ferror.clear(f[tbRPortIndex]);
		}	
		
		if (f[tbRPortIndex].value == 0){//blank selected
			ferror.set(f[tbRPortIndex], errmsg.adm3, quiet);
			return 0;
		}else{
			ferror.clear(f[tbRPortIndex]);
		}
	}
	
	return 1;
}

instance.resetNewEditor = function() {
	var f = fields.getAll(this.newEditor);

	f[tbIDIndex].value = '';
	for (var i = 1; i<f.length; i++){
		if (i == tbSVLANIndex 
			|| i== tbCVLANIndex
			|| i == tbMajorRingIDIndex) f[i].value = '';
		else f[i].value = 0;
	}
				
	ferror.clearAll(fields.getAll(this.newEditor));
}

instance.verifyDelete = function(data)
{
	//Major Ring is used by sub ring
	var all_data = instance.getAllData();

	for (var k = 0; k < all_ring_type_options.length; k++){
		if (data[tbRingTypeIndex] != all_ring_type_options[k][1])
			continue;
		for (var i = 0; i < all_data.length; i++){
			if (all_data[i][tbMajorRingIDIndex] == data[tbIDIndex])
				return false;
		}		
	}
	
	return true;
}
/*
instance.rpDel = function(e) {
	e = PR(e);

	var data = [];

	for (i=0; i<e.cells.length; i++) data.push(e.cells[i].innerHTML);
	
	if (instance.verifyDelete(data) == false) return;

	TGO(e).moving = null;
	e.parentNode.removeChild(e);
	instance.recolor();
	instance.rpHide();
	instance.onDataChanged();

//	generatecVlanIdOptions();
//	instance.safeUpdateEditorField(tbCVLANIndex, { type: 'select', options: cvid_options});//c-vlan

}
*/
	
instance.dataToView = function(data) {
	
	var tmp = [
		data[tbIDIndex],//ID
		all_ring_type_options[data[tbRingTypeIndex]][1],		//Ring type
		''+data[tbMajorRingIDIndex],//major_ring_id_options[0][1],//major ring id
		sub_ring_node_type_options[data[tbNodeTypeIndex]][1],//node type
		data[tbCVLANIndex],//c-vlan
		data[tbSVLANIndex],//s-vlan
		switch_interface[data[tbLPortIndex]][1],//left port
		switch_interface[data[tbRPortIndex]][1] //right port
		];

	return tmp;
}

instance.fieldValuesToData = function(row) {
	var f = fields.getAll(row);
	var data = [];

	for (var i = 0; i < f.length; i++)
		data.push(f[i].value);
	
	return data;
}

instance.setup = function() {
	var data = [];

	/** generate major ring id options
	***/
	/*
	major_ring_id_options = [[0, '--']];
	for (var i = 1; i < 11; i++){//ID:1-10
		for (var j = 0; j < g8032_config.length; j++){
			if ((parseInt(g8032_config[j][idIndex], 10) == i)
				&& (g8032_config[j][ringTypeIndex] == 1)){//major ring
				major_ring_id_options.push([g8032_config[j][idIndex], ''+g8032_config[j][idIndex]]);
			}
		}
	}
	*/

	this.init('raps_grid', 'move', 10, [
		{ type: 'text'},//ID		
		{ type: 'select', options: all_ring_type_options},//ring type
		//{ type: 'select', options: major_ring_id_options},//major ring id , only for sub ring
		{ type: 'text'},//major ring id , only for sub ring
		{ type: 'select', options: sub_ring_node_type_options},//node type
		
		//{ type: 'select', options: all_vlan_options},//c-vlan
		{ type: 'text'},//c-vlan
		{ type: 'text'},//s-vlan
		{ type: 'select', options: switch_interface},//L-port
		{ type: 'select', options: switch_interface}//R-port		
		]);
	this.headerSet([raps.instance_id,				
					raps.ring_type,	
					raps.majorID,
					raps.node_type,						
					raps.control_vlan,
					raps.service_vlan,
					raps.left_port,
					raps.right_port]);

	/*insert old config*/
	for (var i = 0; i < g8032_config.length; i++){
		data = [];
		data.push(g8032_config[i][idIndex].toString());	//ID
		data.push(g8032_config[i][ringTypeIndex]);		//ring type
		if (g8032_config[i][majorRingID] == 0)
			data.push('');//major ring id
		else
			data.push(''+g8032_config[i][majorRingID]);//major ring id
		data.push(getNodeTypeIndex(g8032_config[i][nodeTypeIndex]));//node type
		//data.push(getVlanGlobalIndex(g8032_config[i][cVlanIndex]));//c-vlan
		data.push(g8032_config[i][cVlanIndex].toString());//c-vlan
		//s-vlan
		var s_vlan_str = "";
		for (var j = 0; j < g8032_config[i][sVlanIndex].length; j++){
			s_vlan_str += g8032_config[i][sVlanIndex][j].toString();
			if (j < g8032_config[i][sVlanIndex].length -1)
				s_vlan_str += ",";
		}
		data.push(s_vlan_str);
		
		//left port
		data.push(getPortGlobalIndex(g8032_config[i][lPortIndex]) + 1);
		//right port
		data.push(getPortGlobalIndex(g8032_config[i][rPortIndex]) + 1);	

		instance.insertData(-1,data);

	}

	
	instance.showNewEditor();

//	generatecVlanIdOptions();
//	instance.safeUpdateEditorField(tbCVLANIndex, { type: 'select', options: cvid_options});//c-vlan
	
	instance.resetNewEditor();
	
}

function createNewInstance(tmp_data)
{
	var cmd = '';
	var s_vlan_list = [];
	//ID
	cmd += "!" + "\n";
	cmd += "g8032 " + tmp_data[0]+ "\n";

	//control vlan
	if(tmp_data[tbCVLANIndex] != 0)
		cmd += "control-vlan " + tmp_data[tbCVLANIndex] + "\n";
	
	//ring type
	if(tmp_data[tbRingTypeIndex] != 0)
		cmd += "ring-type " + cmd_ring_type[tmp_data[tbRingTypeIndex]]  
				+ ((tmp_data[tbRingTypeIndex] == 1)?(""):(" "+tmp_data[tbMajorRingIDIndex])) +"\n";

	//node-type
		cmd += "node-type " + cmd_node_type[tmp_data[tbNodeTypeIndex]] + "\n";

	//service vlan
	if(tmp_data[tbSVLANIndex] != ''){
		s_vlan_list = getSVlan(tmp_data[tbSVLANIndex]);
		for(var j = 0; j < s_vlan_list.length; ++j){
			cmd += "service-vlan " + s_vlan_list[j] + "\n";	
		}
	}
	
	//left port
	if(tmp_data[tbLPortIndex] != 0)
		cmd += "port left " + port_cmd_list[tmp_data[tbLPortIndex]]+ "\n";
	
	//right port
	if(tmp_data[tbRPortIndex] != 0)
		cmd += "port right " + port_cmd_list[tmp_data[tbRPortIndex]]+ "\n";

	//enable
	cmd += "enable" + "\n";

	//exit g8032 viewer
	cmd += "!" + "\n";

	return cmd;
}


function isCfgChanged(old_cfg, new_data)
{


	return false;
}



function generate_cmd()
{

	var data = instance.getAllData();
	var cmd ="";
	var instance_found = 0;
	var cfg_view_flag = 0;
	var to_delete = 0;
	var to_add = 0;
	
	//delete non-major
	for(var i = 0; i < g8032_config.length; ++i){
		if (g8032_config[i][ringTypeIndex] == 1) continue;//Major
		instance_found = 0;
		to_delete = 0;
		for (var j = 0; j < data.length; ++j){
			if (g8032_config[i][idIndex] == data[j][0]){//ID matched
				instance_found = 1;
				if (isCfgChanged(g8032_config[i], data[j])) to_delete = 1;
				break;
			}
		}
		if (!instance_found || to_delete){//not found, delete it
			if (!cfg_view_flag){
				cmd += "!\n";
				cfg_view_flag = 1;
			}

			cmd += "no g8032 " + g8032_config[i][idIndex]+ "\n";
		}
	}
	
	//delete major
	for(var i = 0; i < g8032_config.length; ++i){
		if (g8032_config[i][ringTypeIndex] != 1) continue;//non-Major
		instance_found = 0;
		to_delete = 0;
		for (var j = 0; j < data.length; ++j){
			if (g8032_config[i][idIndex] == data[j][0]){//ID matched
				instance_found = 1;
				if (isCfgChanged(g8032_config[i], data[j])) to_delete = 1;
				break;
			}
		}
		if (!instance_found || to_delete){//not found, delete it
			if (!cfg_view_flag){
				cmd += "!\n";
				cfg_view_flag = 1;
			}

			cmd += "no g8032 " + g8032_config[i][idIndex]+ "\n";
		}
	}


	//create major
	for (var j = 0; j < data.length; ++j){
		if (data[j][1] != 1) continue;//non-Major
		instance_found = 0;
		to_add = 0;
		for(var i = 0; i < g8032_config.length; ++i){
			if (data[j][0] == g8032_config[i][idIndex]){//ID matched
				instance_found = 1;
				if (isCfgChanged(g8032_config[i], data[j])) to_add = 1;
				else if (g8032_config[i][insEnabledIndex] == 0){//the old instance is not enabled
					cmd += "!\n";
					cmd += "g8032 " + g8032_config[i][idIndex] + "\n";
					cmd += "enable" + "\n";
					cmd += "!\n";
				}
				break;
			}
		}
		if (!instance_found || to_add){//not found, delete it
			cmd += createNewInstance(data[j]);			
		}		
	}


	//create non-major
	for (var j = 0; j < data.length; ++j){
		if (data[j][1] == 1) continue;//Major
		instance_found = 0;
		to_add = 0;
		for(var i = 0; i < g8032_config.length; ++i){
			if (data[j][0] == g8032_config[i][idIndex]){//ID matched
				instance_found = 1;
				if (isCfgChanged(g8032_config[i], data[j])) to_add = 1;
				else if (g8032_config[i][insEnabledIndex] == 0){//the old instance is not enabled
					cmd += "!\n";
					cmd += "g8032 " + g8032_config[i][idIndex] + "\n";
					cmd += "enable" + "\n";
					cmd += "!\n";
				}
				break;
			}
		}
		if (!instance_found || to_add){//not found, delete it
			cmd += createNewInstance(data[j]);			
		}		
	}

	E('_fom')._web_cmd.value = cmd;
	return cmd;
}



function verifyFields(focused, quiet)
{
	var cmd = "";
	var fom = E('_fom');

	E('save-button').disabled = true;	

	

	if (user_info.priv < admin_priv) {
		elem.display('save-button', false);
	}else{
		elem.display('save-button', true);
		fom._web_cmd.value = cmd;
		E('save-button').disabled = (generate_cmd()=="");	
	}

	return true;
}

function save()
{
	if (!verifyFields(null, false)) return;
	
	if (cookie.get('debugcmd') == 1)
		alert(E('_fom')._web_cmd.value);	

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
function earlyInit()
{
	instance.setup();
	//generateMajorRingIDOptions();
	//instance.safeUpdateEditorField(tbMajorRingIDIndex, { type: 'select', options: major_ring_id_options});//major id options

}
function fast_nornal()
{
	E('_fom')._web_cmd.value += "!"+"\n"+"default g8032"+"\n";
	if((E('_fom')._web_cmd.value != '')&&(cookie.get('autosave') == 1)){
		E('_fom')._web_cmd.value += "!"+"\n"+"copy running-config startup-config"+"\n";	
	}	
	form.submit('_fom', 1);
}

function fast_owner()
{
	E('_fom')._web_cmd.value += "!"+"\n"+"default g8032 owner"+"\n";
	if((E('_fom')._web_cmd.value != '')&&(cookie.get('autosave') == 1)){
		E('_fom')._web_cmd.value += "!"+"\n"+"copy running-config startup-config"+"\n";	
	}
	form.submit('_fom', 1);
}

function gen_fast_cfg_button()
{
	//W("<div >");
	W("<input type='button' style='width:150px;' value='" + raps.fast_nor + "' id='fast-nor-button' onclick='fast_nornal()'>");
	GetText(ui.or);
	W("<input type='button' style='width:150px;' value='" + raps.fast_own + "' id='fast-own-button' onclick='fast_owner()'>");
//	W("</div>");
}
</script>
</head>
<body onload='init()'>
<form id='_fom' method='post' action='apply.cgi'>
<input type='hidden' name='_web_cmd' value=''>


<div class='section-title' id='_fast_config'>
<script type='text/javascript'>
	GetText(raps.fast);
</script>
</div>
<div><script type='text/javascript'>
gen_fast_cfg_button();
</script></div>
<br/>
<br/>

<div class='section-title' id='_instance_list'>
<script type='text/javascript'>
	GetText(raps.instance_list);
</script>
</div>
<table class='web-grid' cellspacing=1 id='raps_grid'></table>



<div><script type='text/javascript'>GetText(ui.note);</script></div>
<div><script type='text/javascript'>GetText(raps.help1);</script></div>
<div><script type='text/javascript'>GetText(raps.help2);</script></div>
<div><script type='text/javascript'>GetText(raps.help3);</script></div>

<script type='text/javascript'>
init();
if(cookie.get('autosave') == 1)
	ui.aply=ui.aply_save;
genStdFooter("");
</script>

<script type='text/javascript'>earlyInit();</script>
<script type='text/javascript'>verifyFields();</script>
</form>
</body>
</html>
