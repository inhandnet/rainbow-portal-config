<% pagehead(menu.fw_nat) %>
<style type='text/css'>

#nat-grid {
	width: 600px;	
	text-align: center;
}
#nat-grid .co1{
	width: 80px;	
	text-align: center;
}
#nat-grid .co2{
	width: 80px;	
	text-align: center;
}
#nat-grid .co3{
	width: 100px;	
	text-align: center;
}
#nat-grid .co4{
	width: 100px;	
	text-align: center;
}

#natposin-grid {
	width: 400px;	
	text-align: center;
}
#natposin-grid .co1 {
	width: 200px;
	text-align: center;
}
#natposin-grid .co2 {
	width: 200px;
	text-align: center;
}

#natposout-grid {
	width: 400px;	
	text-align: center;
}
#natposout-grid .co1 {
	width: 200px;
	text-align: center;
}
#natposout-grid .co2 {
	width: 200px;
	text-align: center;
}
</style>

<script type='text/javascript'>

<% ih_sysinfo() %>
<% ih_user_info() %>

var operator_priv = 12;

<% web_exec('show running-config nat') %>
//if_nat_config = [[[8, 0, 1], 1],[[5, 0, 1], 1]];

//nat_rule_config = [['0', '0', '0', '1', '1.1.1.1', '1.1.1.4']];
//nat_rule_config = [[0, 0, 5, 0, ["0.0.0.0", "0.0.0.0", 0, 100, [0, 0, 0]], ["0.0.0.0", "0.0.0.0", 0, 0, [5, 0, 1]]]];
//nat_rule_config = [
//	['0', '0', '5', '1', ['1.1.1.1', '255.255.255.0', '80', '100',[8, 0, 1]], ['1.1.1.4', '255.255.255.0', '8080', '100', [8,0,5]]]
//];

//cellular_interface=[['5','0','1']];
//cellular_interface=[];
//tunnel_interface=[['6','0','1']];
//tunnel_interface=[];
//svi_config = [[1,"192.168.2.1", "255.255.255.0", [["192.168.5.1", "255.255.255.0"], ["192.168.5.2", "255.255.255.0"],["192.168.5.3", "255.255.255.0"]]]];

<% web_exec('show interface')%>

var vifs = [].concat(cellular_interface, eth_interface, sub_eth_interface, svi_interface, xdsl_interface, gre_interface, vp_interface, openvpn_interface, dot11radio_interface);
var now_vifs_options = new Array();
now_vifs_options = grid_list_all_vif_opts(vifs);

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

var natposin= new webGrid();
var natposout= new webGrid();

var interface_obj_list = [];

for(var i=0 ; i< now_vifs_options.length;i++){
	var interface_obj = new Object();
	interface_obj.name = now_vifs_options[i][0];
    
	var flag = 0;
	for(var j=0; j< if_nat_config.length;j++){
		flag = 0;
		if(interface_obj.name == if_nat_config[j][0]) {
			flag = 1;
			break;
		}
	}
	if(flag == 0) {
		interface_obj.nat_pos = 0;
	} else {
		//nat_pos: 0: none 1: inside 2: outside
		interface_obj.nat_pos = if_nat_config[j][1];
	}
	interface_obj_list.push(interface_obj);
}

var nat = new webGrid();

nat.dataToView = function(data)
{
	var action;
	var con_src;
	if(data[0] == '0') {
		action = 'SNAT';
	} else if(data[0] == '1') {
		action = 'DNAT';
	} else if(data[0] == '2') {
		action = '1:1NAT';
	}	

	if(data[1] == -1) {
		conn_src = "--";
	} else if(data[1] == 0) {
		conn_src = "Inside";
	} else if(data[1] == 1) {
		conn_src = "Outside";
	}
//	return [action, (data[1] == '0')?'Inside':'Outside', data[2], data[3]];
	return [action, conn_src, data[2], data[3], data[4]];
}

nat.fieldValuesToData = function()
{
	var f = fields.getAll(row);

	return [f[0].value, f[1].value, f[2].value, f[3].value, f[4].value];
}

nat.setup = function() 
{
	var action, conn_src, trans_typ, proto, desc_info; 
//	var from_ip, from_mask, from_port, from_list, from_if;
//	var to_ip, to_mask, to_port, to_list, to_if;
	var trans_from, trans_to;

	this.init('nat-grid', ['sort', 'readonly','select'], 16,[
				{type: 'text', maxlen: 16},
				{type: 'text', maxlen: 16},
				{type: 'text', maxlen: 32},
				{type: 'text', maxlen: 32},
				{type: 'text', maxlen: 100}]);
	this.headerSet([ui.nat_action, ui.nat_conn_src, ui.nat_untrans, ui.nat_trans, ui.nat_desc]);
	for(var i = 0; i < nat_rule_config.length; i++) {
		action = nat_rule_config[i][0];
		conn_src = nat_rule_config[i][1];
		trans_typ = nat_rule_config[i][2];
		proto = nat_rule_config[i][3];
		desc_info = nat_rule_config[i][7];
		trans_from = "";
		trans_to = "";
		if(trans_typ == '0') {	//IP to IP
			trans_from = nat_rule_config[i][4][0];	//ip
			trans_to = nat_rule_config[i][5][0];	//ip
		} else if(trans_typ == '1') {	//IP to INTERFACE
			trans_from = nat_rule_config[i][4][0];	//ip
			trans_to = nat_rule_config[i][5][4];		//interface
		} else if(trans_typ == '2') {	//INTERFACE to IP
			trans_from = nat_rule_config[i][4][4];	//interface
			trans_to = nat_rule_config[i][5][0];	//ip
		} else if(trans_typ == '3') {	//IP Port to IP Port
			trans_from = nat_rule_config[i][4][0]+":"+(nat_rule_config[i][3] == "1"?"TCP ":"UDP ")+nat_rule_config[i][4][2];
			trans_to = nat_rule_config[i][5][0]+":"+nat_rule_config[i][5][2];
		} else if(trans_typ == '4') {	//Network to Network
			trans_from = nat_rule_config[i][4][0]+"/"+nat_rule_config[i][4][1];
			trans_to = nat_rule_config[i][5][0]+"/"+nat_rule_config[i][5][1];
		} else if(trans_typ == '5') {	//ACL to INTERFACE
			trans_from = 'ACL:'+nat_rule_config[i][4][3];	//acl list
			trans_to = nat_rule_config[i][5][4];		//interface
		} else if(trans_typ == '6') {//Interface Port to IP Port
			trans_from = nat_rule_config[i][4][4]+":"+(nat_rule_config[i][3] == "1"?"TCP ":"UDP ")+nat_rule_config[i][4][2];	
			trans_to = nat_rule_config[i][5][0]+":"+nat_rule_config[i][5][2];
		} else if (trans_typ == '7') {  // ACL to IP
			trans_from = 'ACL:'+nat_rule_config[i][4][3]; //acl list 	
			trans_to = nat_rule_config[i][5][0];	//ip
		} else if (trans_typ == '8') {  // ACL to IP PORT
			trans_from = 'ACL:'+nat_rule_config[i][4][3]; //acl list 	
			trans_to = nat_rule_config[i][5][0]+":"+nat_rule_config[i][5][2];
		} else if (trans_typ == '9') {  // VIP
			trans_from = nat_rule_config[i][4][0];	//ip
			trans_to = nat_rule_config[i][5][0]+"/"+nat_rule_config[i][5][1];
		} else if (trans_typ == '10') {  // VIP2IP
			trans_from = nat_rule_config[i][4][0] + "/" + nat_rule_config[i][5][0];
			trans_to = nat_rule_config[i][6][0] + "/" + nat_rule_config[i][6][1];
		}
		this.insertData(-1, [action, conn_src, trans_from,
							trans_to, desc_info]);
	}
	if (user_info.priv >= operator_priv)
		nat.footerButtonsSet(0);
}

nat.jump = function() 
{
	document.location = 'setup-nat-detail.jsp';
}

nat.footerAdd = function() 
{
	cookie.unset('nat-modify');
	nat.jump();
}
	
nat.footerModify = function()
{
	var keyVar = [];
	var f = nat.getAllData();
	if (nat.selectedRowIndex < 0 || nat.selectedColIndex < 0)
		return;

	for(var i = 0; i < 4; i++) {
		keyVar.push(f[nat.selectedRowIndex - 1][i]);
	}

	cookie.set('nat-modify', keyVar);
	nat.jump();
}
	
nat.footerDel = function()
{
	var send_cmd = [];
	var keyVar = [];

	var att=confirm("Will you remove the nat item?");
	if(att==true) {
	var action_json, conn_src_json, trans_typ_json, proto_json, desc_json;
	var from_ip_json, from_mask_json, from_port_json, from_list_json, from_if_json;
	var to_ip_json, to_mask_json, to_port_json, to_list_json, to_if_json, range_ip_json, range_mask_json;
	var tmp_action, tmp_conn_src, tmp_desc;

	var f = this.getAllData();
	if (nat.selectedRowIndex < 0 || this.selectedColIndex < 0)
		return;
	
	for(var i = 0; i < 4; i++) {
		keyVar.push(f[nat.selectedRowIndex - 1][i]);
	}
	var nat_act = f[nat.selectedRowIndex - 1][0];
	var nat_conn_src = f[nat.selectedRowIndex - 1][1];
	var nat_from = f[nat.selectedRowIndex - 1][2];
	var nat_to = f[nat.selectedRowIndex - 1][3];

	for(var i = 0; i < nat_rule_config.length; i++) {
		action_json = nat_rule_config[i][0];
		conn_src_json = nat_rule_config[i][1];
		trans_typ_json = nat_rule_config[i][2];
		proto_json = nat_rule_config[i][3];
		from_ip_json = nat_rule_config[i][4][0];
		from_mask_json = nat_rule_config[i][4][1];
		from_port_json = nat_rule_config[i][4][2];
		from_list_json = nat_rule_config[i][4][3];
		from_if_json = nat_rule_config[i][4][4];
		to_ip_json = nat_rule_config[i][5][0];
		to_mask_json = nat_rule_config[i][5][1];
		to_port_json = nat_rule_config[i][5][2];
		to_list_json = nat_rule_config[i][5][3];
		to_if_json = nat_rule_config[i][5][4];
		range_ip_json = nat_rule_config[i][6][0];
		range_mask_json = nat_rule_config[i][6][1];

		desc_json = nat_rule_config[i][7];

		if(action_json == '0') {	//snat
			tmp_action = "snat";
		} else if(action_json == '1') {	//dnat
			tmp_action = "dnat";
		} else if(action_json == '2') {	//nat
			tmp_action = "nat";
		}

		if(conn_src_json == '0') {	//inside
			tmp_conn_src = "inside";
		} else if(conn_src_json == '1') {	//outside
			tmp_conn_src = "outside";
		}

		if(desc_json != '') { // description
			tmp_desc = "description " + desc_json;	
		} else {
			tmp_desc = '';	
		}

		if((nat_act == nat_rule_config[i][0]) &&
			(nat_conn_src == nat_rule_config[i][1])) {

			if(trans_typ_json == '0') {	//ip to ip
				if((nat_from == from_ip_json) &&
					(nat_to == to_ip_json)) {
					if(action_json == '2') {
						E('_fom')._web_cmd.value += "!" + "\n" + "no ip " + tmp_action + " static " + from_ip_json + " " + to_ip_json + " " + tmp_desc + "\n";
					
					} else {
						E('_fom')._web_cmd.value += "!"+"\n"+"no ip "+tmp_action+" "+tmp_conn_src+" static "+from_ip_json+" "+to_ip_json+ " " + tmp_desc + "\n";
					}
				}
			} else if(trans_typ_json == '1') {	//ip to interface
				if((nat_from == from_ip_json) &&
					(nat_to == to_if_json)) {
					if(action_json == '2') {
						E('_fom')._web_cmd.value += "!"+"\n"+"no ip "+tmp_action+" static "+from_ip_json+" interface "+to_if_json+ " " + tmp_desc + "\n";

					} else {
						E('_fom')._web_cmd.value += "!"+"\n"+"no ip "+tmp_action+" "+tmp_conn_src+" static "+from_ip_json+" interface "+to_if_json+ " " + tmp_desc + "\n";
					}
				}
			} else if(trans_typ_json == '2') {	//interface to ip
				if((nat_from == from_if_json) &&
					(nat_to == to_ip_json)) {
						E('_fom')._web_cmd.value += "!"+"\n"+"no ip "+tmp_action+" "+tmp_conn_src+" static interface "+from_if_json+" "+to_ip_json+ " " + tmp_desc + "\n";
					
				}

			} else if(trans_typ_json == '3') {	//ip port to ip port
				if((nat_from.indexOf((proto_json == "1"?"TCP":"UDP")) >= 0) && (nat_from.indexOf(from_ip_json) >= 0) && (nat_from.indexOf(from_port_json) >= 0)
						&& (nat_to.indexOf(to_ip_json) >= 0) && (nat_to.indexOf(to_port_json) >= 0)) {
					E('_fom')._web_cmd.value += "!"+"\n"+"no ip "+tmp_action+" "+tmp_conn_src+" static "+((proto_json == '1')?"tcp":"udp")+" "+from_ip_json+" "+from_port_json+" "+to_ip_json+" "+to_port_json+ " " + tmp_desc + "\n";
				}
			} else if(trans_typ_json == '4') {	//network to network
				if(nat_from.indexOf(from_ip_json) >= 0) {
					E('_fom')._web_cmd.value += "!"+"\n"+"no ip "+tmp_action+" "+tmp_conn_src+" static network "+from_ip_json+" "+to_ip_json+" "+from_mask_json+ " " + tmp_desc + "\n";
				}
			} else if(trans_typ_json == '5') {	//acl to interface
				if((nat_from == 'ACL:'+from_list_json) &&
					(nat_to == to_if_json)) { E('_fom')._web_cmd.value += "!"+"\n"+"no ip "+tmp_action+" "+tmp_conn_src+" list "+from_list_json+" interface "+to_if_json+ " " + tmp_desc + "\n";
				}
			} else if (trans_typ_json == '6') { //interface port to ip port
				if((nat_from.indexOf((proto_json == "1"?"TCP":"UDP")) >= 0) && (nat_from.indexOf(from_if_json) >= 0)&& (nat_from.indexOf(from_port_json) >= 0) && (nat_to.indexOf(to_ip_json) >= 0) && (nat_to.indexOf(to_port_json) >= 0)) {
					E('_fom')._web_cmd.value += "!"+"\n"+"no ip "+tmp_action+" "+tmp_conn_src+" static "+((proto_json == '1')?"tcp":"udp")+" "+ "interface" + " " + from_if_json+" "+from_port_json+" "+to_ip_json+" "+to_port_json+ " " + tmp_desc + "\n";
				} 
			} else if (trans_typ_json == '7') {
				if ((nat_from == 'ACL:'+from_list_json) && (nat_to.indexOf(to_ip_json) >= 0)) {
					E('_fom')._web_cmd.value += "!" + "\n" + "no ip " + tmp_action + " " + tmp_conn_src + " list " + from_list_json + " " + to_ip_json + " " + tmp_desc + "\n";
				}
			} else if (trans_typ_json == '8') {
				if ((nat_from == 'ACL:'+from_list_json) && (nat_to.indexOf(to_ip_json) >= 0) 
						&& (nat_to.indexOf(to_port_json) >= 0)) {
					E('_fom')._web_cmd.value += "!" + "\n" + "no ip " + tmp_action + " " + tmp_conn_src + " list " + from_list_json + " " + to_ip_json + " " + to_port_json + " " +  tmp_desc + "\n";
				}
			} else if (trans_typ_json == '9') {
				if ((nat_from == from_ip_json) && (nat_to.indexOf(to_ip_json) >= 0)) {
					E('_fom')._web_cmd.value += "!"+"\n"+"no ip "+tmp_action+" static "+from_ip_json+" network "+to_ip_json+ " " + to_mask_json + " " +  tmp_desc + "\n";
				}
			} else if (trans_typ_json == '10') {
				if (nat_from.indexOf(from_ip_json) >=0 && nat_from.indexOf(to_ip_json) >= 0 
						&& nat_to.indexOf(range_ip_json) >= 0 && nat_to.indexOf(range_mask_json) >= 0) {
					E('_fom')._web_cmd.value += "!" + "\n" + "no ip " + tmp_action + " static " + from_ip_json + " vip " + to_ip_json + " " + range_ip_json + " " + range_mask_json + " " +  tmp_desc + "\n";
				}
			} 
		}
	}	


	if((E('_fom')._web_cmd.value != '')&&(cookie.get('autosave') == 1)){
		E('_fom')._web_cmd.value += "!"+"\n"+"copy running-config startup-config"+"\n";	
	}

	form.submit('_fom', 1);
	}
}

//////////////////////////////////////////////////////////////////////
//NAT Position Inside grid

var in_idx;

natposin.safeUpdateEditorField = function(i, editorField) 
{	
	var f = fields.getAll(this.newEditor);
	var data = [];	
	var j, e;	
	var f_disabled = [];	//get old datas of the row	
	for (j = 0; j < f.length; j++){
		data.push(f[j].value);
		f_disabled.push(f[j].disabled);
	}
	//update
	natposin.updateEditorField(i, editorField);
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
natposin.onClick = function(cell)
{
	var q = PR(cell);
	var data = this.getAllData();
	var thisData = data[q.rowIndex -1];
	natposin.safeUpdateEditorField(1, { type: 'select', maxlen: 15, options: [[thisData[1], thisData[1]]]} );
	
	if(this.canEdit) {
		if (this.moving) {
			var p = this.moving.parentNode;
			var q = PR(cell);
			if (this.moving != q) {
				var v = this.moving.rowIndex > q.rowIndex;
				p.removeChild(this.moving);
				if (v) p.insertBefore(this.moving, q);
					else p.insertBefore(this.moving, q.nextSibling);
				this.recolor();
			}
			this.moving = null;
			this.rpHide();
			this.onDataChanged();
			return;
		}
		this.edit(cell);		
	}
	var f = fields.getAll(this.editor);
	f[0].disabled = true;
	f[1].disabled = true;
}

natposin.resetNewEditor = function()
{
	var f = fields.getAll(this.newEditor);
	f[0].value = in_idx;
	f[0].disabled = true;
	in_idx++;
	ferror.clearAll(fields.getAll(this.newEditor));	
	
}

natposin.verifyFields = function(row, quiet) {
    
	var f = fields.getAll(row);

	grid_vif_opts_sub(now_vifs_options, f[1].value);
	if(f[1].value == '') {
		return 0;
	}
	return 1;
}


natposin.verifyDelete = function(data) {
	grid_vif_opts_add(now_vifs_options, data[1]);
	return true;
}

natposin.onDataChanged = function() {
	natposin.safeUpdateEditorField(1, { type: 'select', maxlen: 15, options: now_vifs_options} );
	natposout.safeUpdateEditorField(1, { type: 'select', maxlen: 15, options: now_vifs_options} );
	verifyFields(null, 1);
}
natposin.setup = function() 
{
//	var idx;
	this.init('natposin-grid', 'move', 100, [
		{ type: 'text', maxlen: 32 }, 
		{ type: 'select',  options: now_vifs_options}
	]);
	this.headerSet([ui.id, ui.iface]);

	in_idx = 1;
	for(var i = 0; i < if_nat_config.length; i++) {
		if(if_nat_config[i][1] == 1) {	//inside
			this.insertData(-1, [in_idx, if_nat_config[i][0]]);
			grid_vif_opts_sub(now_vifs_options, if_nat_config[i][0]);
			in_idx++;
		}
	}

	this.showNewEditor();
	this.resetNewEditor();
	
	natposin.safeUpdateEditorField(1, { type: 'select', maxlen: 15, options: now_vifs_options} );
//	natposout.safeUpdateEditorField(1, { type: 'select', maxlen: 15, options: now_vifs_options} );
}

//////////////////////////////////////////////////////////////////
//NAT Position Outside
var out_idx;

natposout.safeUpdateEditorField = function(i, editorField) {

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
	natposout.updateEditorField(i, editorField);

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

natposout.verifyFields = function(row, quiet) {
    
	var f = fields.getAll(row);

	grid_vif_opts_sub(now_vifs_options, f[1].value);
	if(f[1].value == '') {
		return 0;
	}
	return 1;
}


natposout.verifyDelete = function(data) {
	grid_vif_opts_add(now_vifs_options, data[1]);
	return true;
}

natposout.onDataChanged = function() {
	natposin.safeUpdateEditorField(1, { type: 'select', maxlen: 15, options: now_vifs_options} );
	natposout.safeUpdateEditorField(1, { type: 'select', maxlen: 15, options: now_vifs_options} );
	verifyFields(null, 1);
}
/*
natposout.createControls = function(which, rowIndex) {
	var r, c;

	r = this.tb.insertRow(rowIndex);
	r.className = 'controls';

	c = r.insertCell(0);
	c.colSpan = this.header.cells.length;
	if (which == 'edit') {
		c.innerHTML =
			'<input type=button id="del_row_button" value=' + ui.del + ' onclick="TGO(this).onDelete()"> &nbsp; ' +
			'<input type=button id="ok_row_button" value=' + ui.ok + ' onclick="TGO(this).onOK()"> ' +
			'<input type=button id="cancel_row_button" value=' + ui.cancel + ' onclick="TGO(this).onCancel()">';
	}
	else {
		c.innerHTML =
			'<input type=button id="add_new_row_button" value=' + ui.add + ' onclick="TGO(this).onAdd()">';
	}
	return r;
}
*/
natposout.onClick = function(cell)
{

	var q = PR(cell);
	var data = this.getAllData();
	var thisData = data[q.rowIndex -1];
	natposout.safeUpdateEditorField(1, { type: 'select', maxlen: 15, options: [[thisData[1], thisData[1]]]} );
	
	if(this.canEdit) {
		if (this.moving) {
			var p = this.moving.parentNode;
			var q = PR(cell);
			if (this.moving != q) {
				var v = this.moving.rowIndex > q.rowIndex;
				p.removeChild(this.moving);
				if (v) p.insertBefore(this.moving, q);
					else p.insertBefore(this.moving, q.nextSibling);
				this.recolor();
			}
			this.moving = null;
			this.rpHide();
			this.onDataChanged();
			return;
		}
		this.edit(cell);		
	}
	var f = fields.getAll(this.editor);
	f[0].disabled = true;
	f[1].disabled = true;
}

natposout.resetNewEditor = function()
{
	var f = fields.getAll(this.newEditor);
	f[0].value = out_idx;
	f[0].disabled = true;
	out_idx++;

	ferror.clearAll(fields.getAll(this.newEditor));	
}

natposout.setup = function() 
{
//	var idx;
	this.init('natposout-grid', 'move', 100, [
		{ type: 'text', maxlen: 32 }, 
		{ type: 'select',  options: now_vifs_options}
	]);
	this.headerSet([ui.id, ui.iface]);

	out_idx = 1;
	for(var i = 0; i < if_nat_config.length; i++) {
		if(if_nat_config[i][1] == 2) {	//outside
			this.insertData(-1, [out_idx, if_nat_config[i][0]]);
			grid_vif_opts_sub(now_vifs_options, if_nat_config[i][0]);
			out_idx++;
		}
	}
	this.showNewEditor();
	this.resetNewEditor();

	natposin.safeUpdateEditorField(1, { type: 'select', maxlen: 15, options: now_vifs_options} );
	natposout.safeUpdateEditorField(1, { type: 'select', maxlen: 15, options: now_vifs_options} );	
}

function verifyFields(focused, quiet)
{
	var cmd = "";
	var fom = E('_fom');

	E('save-button').disabled = true;

	var data_found = 0;
	var iface_name_old;

	/* verify for the natposin grid */
	var datai = natposin.getAllData();
	var minsides = if_nat_config;

	//delete the nat inside iface from json which have been deleted from web
	for(var i = 0; i < minsides.length; i++) {
		data_found = 0;
		iface_name_old = "";

		iface_name_old = minsides[i][0];
		for (var j = 0; j < datai.length; j++) {
			if(minsides[i][1] == 1) {	//inside
				if(iface_name_old == datai[j][1]) {
					data_found = 1;
					break;
				}
			}
		}
		if(!data_found) {
			if(minsides[i][1] == 1) {
				cmd += "!\n";
				cmd += "interface " + iface_name_old + "\n";
				cmd += "no ip nat inside\n";
			}
		}
	}

	/* verify for the natposout grid */
	var datao = natposout.getAllData();
	var moutsides = if_nat_config;

	//delete the nat outside iface from json which have been deleted from web
	for(var i = 0; i < moutsides.length; i++) {
		data_found = 0;
		iface_name_old = "";

		iface_name_old = moutsides[i][0];
		for (var j = 0; j < datao.length; j++) {
			if(moutsides[i][1] == 2) {	//outside
				if(iface_name_old == datao[j][1]) {
					data_found = 1;
					break;
				}
			}
		}
		if(!data_found) {
			if(moutsides[i][1] == 2) {
				cmd += "!\n";
				cmd += "interface " + iface_name_old + "\n";
				cmd += "no ip nat outside\n";
			}
		}
	}	

	//add the nat inside iface into json which have been added or changed by the web
	for(var i = 0; i < datai.length; i++) {
		data_found = 0;

		for(var j = 0; j < minsides.length; j++) {
			if(minsides[j][1] == 1) {
				if(datai[i][1] == minsides[j][0]) {
					data_found = 1;
					break;
				}
			}
		}
		if(!data_found) {
			cmd += "!\n";
			cmd += "interface " + datai[i][1] + "\n";
			cmd += "ip nat inside\n";
		}

	}

	//add the nat outside iface into json which have been added or changed by the web
	for(var i = 0; i < datao.length; i++) {
		data_found = 0;

		for(var j = 0; j < moutsides.length; j++) {
			if(moutsides[j][1] == 2) {
				if(datao[i][1] == moutsides[j][0]) {
					data_found = 1;
					break;
				}
			}
		}
		if(!data_found) {
			cmd += "!\n";
			cmd += "interface " + datao[i][1] + "\n";
			cmd += "ip nat outside\n";
		}

	}
/*	
	for(var i=0 ; i< interface_obj_list.length;i++){
		var interface_name_now = interface_obj_list[i].name;
		var nat_pos_now = E('_' + (interface_name_now).replace(' ','_') + '_natpos').value;
        
		var nat_pos_old = interface_obj_list[i].nat_pos;

		if( nat_pos_now != nat_pos_old) {
			cmd += "!\n";
			cmd += "interface " + interface_name_now + "\n";

			if(nat_pos_old != "none")
				cmd += "no ip nat "+ nat_pos_old +"\n";
			if(nat_pos_now != "none") {
				cmd += "ip nat " + nat_pos_now + "\n";
			} 
		}

	}
*/	

//	alert(cmd);
	if (user_info.priv < operator_priv) {
		elem.display('save-button', 'cancel-button', false);
	} else {
		elem.display('save-button', 'cancel-button', true);
		fom._web_cmd.value = cmd;
		E('save-button').disabled = (cmd=="");	
	}
	return 1;
}

function save()
{			
	if (!verifyFields(null, false)) return;		

	if((E('_fom')._web_cmd.value != '')&&(cookie.get('autosave') == 1)){
		E('_fom')._web_cmd.value += "!"+"\n"+"copy running-config startup-config"+"\n";	
	}
	form.submit('_fom', 1);
}


function earlyInit()
{
	nat.setup();
	natposin.setup();
	natposout.setup();
	verifyFields(null, 1);
}

function init()
{
	nat.recolor();
}

</script>

</head>
<body onload='init()'>
<form id='_fom' method='post' action='apply.cgi'>
<input type='hidden' name='_web_cmd' value=''>

<div class='section-title'>
<script type='text/javascript'>
	GetText(ui.nat_list);
</script>
</div>
<div class='section'>
	<table class='web-grid' id='nat-grid'></table>
</div>

<div class='section-title'>
<script type='text/javascript'>
	GetText(ui.nat_pos_in);
</script>
</div>
<div class='section'>
	<table class='web-grid' id='natposin-grid'></table>
</div>

<div class='section-title'>
<script type='text/javascript'>
	GetText(ui.nat_pos_out);
</script>
</div>
<!---->
<div class='section'>
	<table class='web-grid' id='natposout-grid'></table>
</div>
<!---->

<script type='text/javascript'>
if(cookie.get('autosave') == 1)
	ui.aply=ui.aply_save;
genStdFooter("");
</script>
</form>
<script type='text/javascript'>earlyInit()</script>

</body>
</html>
