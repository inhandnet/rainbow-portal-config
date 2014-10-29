<% pagehead(menu.ipsec_p1) %>

<style type='text/css'>

#keyring-grid {
	width: 800px;
}
#keyring-grid .co1 {
	width: 150px;
	text-align: center;
}
#keyring-grid .co2 {
	width: 100px;
	text-align: center;
}
#keyring-grid .co3 {
	width: 100px;
	text-align: center;	
}
#keyring-grid .co4 {
	width: 100px;
	text-align: center;	
}

#policy-grid {
	width: 800px;
}
#policy-grid .co1 {
	width: 50px;
	text-align: center;
}
#policy-grid .co2 {
	width: 100px;
	text-align: center;
}
#policy-grid .co3 {
	width: 100px;
	text-align: center;	
}
#policy-grid .co4 {
	width: 100px;
	text-align: center;	
}
#policy-grid .co5 {
	width: 150px;
	text-align: center;	
}
#policy-grid .co6 {
	width: 100px;
	text-align: center;	
}

#profile-grid {
	width: 800px;
}
#profile-grid .co1 {
	width: 100px;
	text-align: center;
}
#profile-grid .co2 {
	width: 80px;
	text-align: center;
}
#profile-grid .co3 {
	width: 80px;
	text-align: center;
}
#profile-grid .co4 {
	width: 80px;
	text-align: center;
}
#profile-grid .co5 {
	width: 80px;
	text-align: center;
}
#profile-grid .co6 {
	width: 80px;
	text-align: center;
}
#profile-grid .co7 {
	width: 80px;
	text-align: center;
}
#profile-grid .co8 {
	width: 80px;
	text-align: center;
}
#profile-grid .co9 {
	width: 80px;
	text-align: center;
}
#profile-grid .co10 {
	width: 80px;
	text-align: center;
}
		
</style>

<script type='text/javascript'>

<% ih_sysinfo() %>
<% ih_user_info() %>

//var keyring_config = [['test1','1.1.1.1','255.255.255.0','abc123'],['test2','1.1.1.2','','123456']];
var keyring_config = [];
//var policy_config = [['1', 0, 0, 2, 1, '300'],['2', 1, 1, 0, 0, '60']];
//var policy_config = [['1', '0', '0', '2', '1', '300'],['2', '1', '1', '0', '5', '60']];
var policy_config = [];
//var isa_prof_config = [['test1', '0', '1', '0', 'abc', '1.1.1.1', 'test1', '1', '60', '60']];
var isa_prof_config = [];

<% web_exec('show running-config crypto') %>

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

var keyring = new webGrid();

var profile = new webGrid();

var kr_options = [['', '']];
var pl_options = [];

keyring.existkr = function(f,v)
{
	var data = profile.getAllData();
	for(var i = 0; i < data.length;++i){
		if(data[i][f] == v) return true;
	}
	return false;
}

keyring.existKeyring = function(keyringname)
{
	return this.existkr(7,keyringname);
}

keyring.exist = function(f, v)
{
	var data = this.getAllData();
	for (var i = 0; i < data.length; ++i) {
		if (data[i][f] == v) return true;
	}
	return false;
}

keyring.existName = function(name)
{
	return this.exist(0, name);
}


keyring.fieldValuesToData = function(row) {
	var f = fields.getAll(row);
	return [f[0].value, f[1].value, f[2].value, f[3].value];
}

keyring.onDataChanged = function() 
{
	var data = keyring.getAllData();
	kr_options = [['', '']];

	verifyFields(null, 1);

	for(var i=0; i<data.length; i++) kr_options.push([data[i][0], data[i][0]]);

	profile.updateEditorField(7,
			{ type: 'select', maxlen: 15, options: kr_options});

}

keyring.verifyDelete = function(data) 
{
	var mydata = keyring.getAllData();

	if (this.existKeyring(data[0])) {
		show_alert("Keyring "+data[0]+" is in used by ISAKMP Profile!");		
		return 0;
	}

	for (var i=0; i < mydata.length; i++) {
		if(mydata[i][0] != (data[0]))	
			kr_options.push([mydata[i][0], mydata[i][0]]);
	}
	profile.updateEditorField(7, 
			{ type: 'select', maxlen: 15, options: kr_options});

	return true;
}

keyring.verifyFields = function(row, quiet) {
	var f = fields.getAll(row);

	if(haveChineseChar(f[0].value)) {		//error when input chinese chars
		ferror.set(f[0], errmsg.cn_chars, quiet);
		return 0;
	} else if(!v_length(f[0], quiet, 1, 32)) {
		return 0;
	} else if(f[0].value.indexOf(" ") >= 0) {
		ferror.set(f[0], errmsg.bad_description, quiet);
		return 0;
	} else if(this.existName(f[0].value)) {
		ferror.set(f[0], errmsg.bad_addr2, quiet);
		return 0;	
	} else {
		ferror.clear(f[0]);
	}

	if(!v_ip(f[1], quiet)) {
		return 0;
	} else {
		ferror.clear(f[1]);
	}

	if((f[2].value != "") && (!v_netmask(f[2], quiet))) {
		return 0;
	} else {
		ferror.clear(f[2]);
	}

	if(!v_length(f[3], quiet, 1, 128)) {
		return 0;
	} else {
		ferror.clear(f[3]);
	}

	return 1;
}

keyring.createControls = function(which, rowIndex) {
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

keyring.onClick = function(cell) {

	if (this.canEdit) {
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
			onDataChanged();
			return;
		}
		this.edit(cell);
	}
	var f = fields.getAll(this.editor);
	if (this.existKeyring(f[0].value)){
		E('del_row_button').disabled = true;
//		E('ok_row_button').disabled = true;
//		for(var i = 0;i < f.length;i++)
//			f[i].disabled = true;
		f[0].disabled = true;
	}

}


keyring.resetNewEditor = function() {
	var f = fields.getAll(this.newEditor);
	
	for(var i = 0;i < f.length;++i) {
		f[i].value = '';
	}
			
	ferror.clearAll(fields.getAll(this.newEditor));
}

keyring.setup = function() {

	this.init('keyring-grid', 'move', 10, [
		{ type: 'text', maxlen: 32 }, 
		{ type: 'text', maxlen: 32 }, 
		{ type: 'text', maxlen: 32 }, 
		{ type: 'password', maxlen: 32 }]);
	this.headerSet([ui.nam, ui.ip, ui.netmask, ipsec.auth_key]);
	for (var i = 0; i < keyring_config.length; i++)
		this.insertData(-1, [keyring_config[i][0], keyring_config[i][1],keyring_config[i][2],keyring_config[i][3]]);
	this.showNewEditor();
	this.resetNewEditor();

}

var policy = new webGrid();

policy.existpl = function(f,v)
{
	var mydata = profile.getAllData();
	for(var i = 0; i < mydata.length;++i){
		if(mydata[i][f] == v) return true;
	}
	return false;
}

policy.existPolicy = function(groupname)
{
	return this.existpl(7,groupname);
}

policy.exist = function(f, v)
{
	var data = this.getAllData();
	for (var i = 0; i < data.length; ++i) {
		if (data[i][f] == v) return true;
	}
	return false;
}

policy.existID = function(id)
{
	return this.exist(0, id);
}

policy.dataToView = function(data) {
	
	var encrypt, group;
	if(data[2] == '0') {
		encrypt = "3des";
	} else if(data[2] == '1') {
		encrypt = "des";
	} else if(data[2] == '2') {
		encrypt = "aes128";
	} else if(data[2] == '3') {
		encrypt = "aes192";
	} else if(data[2] == '4') {
		encrypt = "aes256";
	}

	if(data[4] == '1') {
		group = "Group 1";
	} else if(data[4] == '2') {
		group = "Group 2";
	} else if(data[4] == '5') {
		group = "Group 5";
	}
	return [data[0], 
		   (data[1] == '0')?ipsec.shared_key:ipsec.cert, 
		   encrypt,
		   (data[3] == '0')?"md5":"sha",
		   group,
		   data[5]];

}

policy.fieldValuesToData = function(row) {
	var f = fields.getAll(row);
	return [f[0].value, f[1].value, f[2].value, f[3].value, f[4].value, f[5].value];
}

policy.onDataChanged = function() {
	var data = policy.getAllData();

	pl_options = [];
	verifyFields(null, 1);

	for(var i=0; i<data.length; i++) pl_options.push([data[i][0], data[i][0]]);

	profile.updateEditorField(6, 
			{ type: 'select', maxlen: 15, options: pl_options});
}

policy.verifyDelete = function(data) {

	var mydata = policy.getAllData();

	if (this.existPolicy(data[0])){
		show_alert("Policy "+data[0]+" is in used by ISAKMP Profile!");		
		return 0;
	} 

	for (var i=0; i < mydata.length; i++){
		if(mydata[i][0] != (data[0]))	       	
			pl_options.push([mydata[i][0], mydata[i][0]]);
	}
	profile.updateEditorField(6, 
			{ type: 'select', maxlen: 15, options: pl_options});

	return true;
}


policy.verifyFields = function(row, quiet)
{
	var f = fields.getAll(row);
	if(this.existID(f[0].value)) {
		ferror.set(f[0], errmsg.bad_name4, quiet);
		return 0;
	} else if(!v_range(f[0], quiet, 1, 10)) {
		return 0;
	} else {
		ferror.clear(f[0]);
	}

	if(!v_range(f[5], quiet, 1200, 86400))
		return 0;

	return 1;
}

policy.createControls = function(which, rowIndex) 
{
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

policy.onClick = function(cell) {
	if (user_info.priv < admin_priv) {
		return;
	}	
	if (this.canEdit) {
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
			onDataChanged();
			return;
		}
		this.edit(cell);
	}
	var f = fields.getAll(this.editor);
	if (this.existPolicy(f[0].value)){
		E('del_row_button').disabled = true;
//		E('ok_row_button').disabled = true;
//		for(var i = 0;i < f.length;i++)
//			f[i].disabled = true;
		f[0].disabled = true;
	}
}


policy.resetNewEditor = function() {
	var f = fields.getAll(this.newEditor);
	f[0].value = '';

	for(var i = 1;i < f.length-2;++i){
		f[i].value = 0;
	}
	f[4].value = 2;	//group 2
	f[5].value = '86400';
			
	ferror.clearAll(fields.getAll(this.newEditor));
}

policy.setup = function() {
	this.init('policy-grid', 'move', 10, [
		{ type: 'text', maxlen: 16 },
		{ type: 'select', options:[
			['0', ipsec.shared_key],
			['1', ipsec.cert]
		]},
		{ type: 'select', options:[
			['0', '3des'],
			['1', 'des'],
			['2', 'aes128'],
			['3', 'aes192'],
			['4', 'aes256']
		]},
		{ type: 'select', options:[
			['0', 'md5'],
			['1', 'sha']
		]},
		{ type: 'select', options:[
			['1', 'Group 1'],
			['2', 'Group 2'],
			['5', 'Group 5']
		]},
		{ type: 'text', maxlen: 16}]);
	this.headerSet([ipsec.id, ipsec.auth, ipsec.encrypt, ipsec.policy_hash, ipsec.policy_group, ipsec.lifetime]);
	for (var i = 0; i < policy_config.length; i++)
		this.insertData(-1, [policy_config[i][0], policy_config[i][1],policy_config[i][2],policy_config[i][3],
							policy_config[i][4],policy_config[i][5]]);

	this.showNewEditor();
	this.resetNewEditor();
}

function isPolicyRSA(policy_id)
{
	var data = policy.getAllData();
	var isRSA = 0;

	for(var i = 0; i<data.length; i++) {
		if(data[i][0] == policy_id) {
			if(data[i][1] == '1') {	//authentication: 0: pre-share 1: rsa-sig
				isRSA = 1;
			} else {
				isRSA = 0;
			}
			break;
		}
	}
	return isRSA;
}

//test if the isakmp profile name is in the ipsec profile grid
profile.existProf1 = function(prof1)
{
//	var data = this.getAllData();
	for(var i = 0; i < ipsec_prof_config.length; i++) {
		//isakmp profile name in the ipsec_prof_config
		if(prof1 == ipsec_prof_config[i][1]) return true;
	}
	return false;
}

//test if the isakmp profile name is in the map grid
profile.existProf2 = function(prof2)
{
	for(var i = 0; i < map_config.length; i++) {
		//isakmp profile name in the map_config
		if(prof2 == map_config[i][4]) return true;
	}
	return false;
}

profile.exist = function(f, v)
{
	var data = this.getAllData();
	for (var i = 0; i < data.length; ++i) {
		if (data[i][f] == v) return true;
	}
	return false;
}

profile.existName = function(name)
{
	return this.exist(0, name);
}

profile.dataToView = function(data) {
	var local_id_typ, remote_id_typ;
	if(data[2] == '0') {
		local_id_typ = ui.ip;
	} else if(data[2] == '1') {
		local_id_typ = ipsec.fqdn;
	} else if(data[2] == '2') {
		local_id_typ = ipsec.ufqdn; 
	}

	if(data[4] == '0') {
		remote_id_typ = ui.ip;
	} else if(data[4] == '1') {
		remote_id_typ = ipsec.fqdn;
	} else if(data[4] == '2') {
		remote_id_typ = ipsec.ufqdn; 
	}

	return [data[0], 
			(data[1] == '0')?ipsec.main_mode:ipsec.agg_mode, 
			local_id_typ,
			data[3],
			remote_id_typ,
			data[5],
			data[6],
			(data[7]=='0')?"":data[7],
			data[8],
			data[9]
//			(data[8]=='0')?"":data[8],
//			(data[9]=='0')?"":data[9]
			];
}

profile.fieldValuesToData = function(row) {
	var f = fields.getAll(row);
	return [f[0].value, f[1].value, f[2].value, f[3].value, f[4].value, f[5].value,
			f[6].value, f[7].value, f[8].value, f[9].value];
}

profile.onDataChanged = function() {
	verifyFields(null, 1);
}

profile.verifyDelete = function(data)
{
	var mydata = profile.getAllData();

	if (this.existProf1(data[0])){
		show_alert("ISAKMP Profile "+data[0]+" is in used by IPSec Profile!");		
		return 0;
	} 

	if (this.existProf2(data[0])){
		show_alert("ISAKMP Profile "+data[0]+" is in used by IPSec Map!");
		return 0;
	} 
	return true;	
}

profile.verifyFields = function(row, quiet)
{
	var f = fields.getAll(row);

	if(haveChineseChar(f[0].value)) {		//error when input chinese chars
		ferror.set(f[0], errmsg.cn_chars, quiet);
		return 0;
	} else if(f[0].value.indexOf(" ") >= 0) {
		ferror.set(f[0], errmsg.bad_description, quiet);
		return 0;
	} else if(!v_length(f[0], quiet, 1, 64)) {
		return 0;
	} else if(this.existName(f[0].value)) {
		ferror.set(f[0], errmsg.bad_name4, quiet);		
		return 0;		
	} else {
		ferror.clear(f[0]);
	}


	//f[2]: local id type
	if((f[2].value == '0') && (f[3].value != '')) {	//ip address
		if(!v_ip(f[3], quiet)) {
			return 0;
		}
	}

	//f[4]: remote id type
	if((f[4].value == '0') && (f[5].value != '')) {	//ip address
		if(!v_ip(f[5], quiet)) {
			return 0;
		}
	}

	if(f[6].length == 0) {	//policy id
		ferror.set(f[6], "Invalid argument.Please configure the Policy first!", quiet);
		return 0;
	} else {
		ferror.clear(f[6]);
	}

	//judge the policy is pre-share or rsa-sig
	if(isPolicyRSA(f[6].value)) {	//rsa-sig
		ferror.clear(f[7]);
		f[7].value = '';
		f[7].disabled = 1;
	} else {	//pre-share
		f[7].disabled = 0;
//		if(f[7].length == 0) {	//keyring name
		if(f[7].value == '0') {	//keyring name
			ferror.set(f[7], "Invalid argument.Please configure the Keyring first!", quiet);
			return 0;
		} else {
			ferror.clear(f[7]);
		}
	}

	if((f[8].value != '') || (f[9].value != '')) {
		if(!v_range(f[8], quiet, 1, 3600)) {	//dpd time interval
			return 0;
		}
	
		if(!v_range(f[9], quiet, 1, 86400)) {	//dpd timeout
			return 0;
		}
	}


	return 1;
}

profile.createControls = function(which, rowIndex) {
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

profile.onClick = function(cell)
{
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
			onDataChanged();
			return;
		}
		this.edit(cell);		
	}
	var f = fields.getAll(this.editor);
	//test if isakmp profile is in use
	if((this.existProf1(f[0].value)) || (this.existProf2(f[0].value))) {
		E('del_row_button').disabled = true;
//		E('ok_row_button').disabled = true;
//		for(var i = 0;i < f.length;i++)
//			f[i].disabled = true;
		f[0].disabled = true;	
	}
}

profile.resetNewEditor = function()
{
	var f = fields.getAll(this.newEditor);
	f[0].value = '';
	f[1].value = 0;
	f[2].value = 0; 
	f[3].value = '';
	f[4].value = 0;
	f[5].value = '';
//	f[6].value is controlled by policy 
//	f[7].value is controlled by keyring	
	f[8].value = '';
	f[9].value = '';
}

profile.setup = function() {
	var kr_data = keyring.getAllData();
	var pl_data = policy.getAllData();

	kr_options = [['', '']];	//clear the keyring options
	pl_options = [];	//clear the policy options

	for(var i=0; i<kr_data.length; i++) kr_options.push([kr_data[i][0], kr_data[i][0]]);
	for(var i=0; i<pl_data.length; i++) pl_options.push([pl_data[i][0], pl_data[i][0]]);

	this.init('profile-grid', 'move', 10, [
			{ type: 'text', maxlen: 32},
			{ type: 'select', options:[
				['0', ipsec.main_mode],
				['1', ipsec.agg_mode]
			]},
			{ type: 'select', options:[
				['0', ui.ip],
				['1', ipsec.fqdn],
				['2', ipsec.ufqdn]
			]},
			{ type: 'text', maxlen: 32},
			{ type: 'select', options:[
				['0', ui.ip],
				['1', ipsec.fqdn],
				['2', ipsec.ufqdn]
			]},
			{ type: 'text', maxlen: 32},
			{ type: 'select', options:pl_options},
			{ type: 'select', options:kr_options},
			{ type: 'text', maxlen: 16},
			{ type: 'text', maxlen: 16}
		]);
//	this.headerSet([ui.nam, ipsec.neg_mode, ipsec.src_id_type, ipsec.src_id, ipsec.dst_id_type, ipsec.dst_id, ipsec.keyring, ipsec.policy, ipsec.dpd_interval, ipsec.dpd_timeout]);
	this.headerSet([ui.nam, ipsec.neg_mode, ipsec.src_id_type, ipsec.src_id, ipsec.dst_id_type, ipsec.dst_id, ipsec.policy, ipsec.keyring, ipsec.dpd_interval, ipsec.dpd_timeout]);
/*	for (var i = 0; i < isa_prof_config.length; i++)
		this.insertData(-1, [isa_prof_config[i][0], isa_prof_config[i][1],isa_prof_config[i][2],isa_prof_config[i][3],
							isa_prof_config[i][4],isa_prof_config[i][5],isa_prof_config[i][6],
							(isa_prof_config[i][7]=='0')?"":isa_prof_config[i][7],
							(isa_prof_config[i][8]=='0')?"":isa_prof_config[i][8],
							(isa_prof_config[i][9]=='0')?"":isa_prof_config[i][9]]);
*/
	for (var i = 0; i < isa_prof_config.length; i++)
		this.insertData(-1, [isa_prof_config[i][0], isa_prof_config[i][1],isa_prof_config[i][2],isa_prof_config[i][3],
							isa_prof_config[i][4],isa_prof_config[i][5],isa_prof_config[i][6],isa_prof_config[i][7],
							(isa_prof_config[i][8]=='0')?"":isa_prof_config[i][8],
							(isa_prof_config[i][9]=='0')?"":isa_prof_config[i][9]]);


	this.showNewEditor();
	this.resetNewEditor();
}

function verifyFields(focused, quiet)
{
	var ok = 1;
	var cmd = "";
	var fom = E('_fom');

	E('save-button').disabled = true;

	var data_found = 0;
	var data_changed = 0;

	/* verify for the profile grid */
	var datapf = profile.getAllData();
	var mprofiles = isa_prof_config;

	//delete the profile from json which have been deleted from web	
	for(var i = 0; i < mprofiles.length; i++) {
		data_found = 0;
		data_changed = 0;

		for(var j = 0; j < datapf.length; j++) {
			if(mprofiles[i][0] == datapf[j][0]) {
				data_found = 1;
				break;
			}
		}
		if(!data_found) {
			cmd += "no crypto isakmp profile " + mprofiles[i][0] + "\n";
		}
	}

	/*verify for the keyring grid*/
	var datak = keyring.getAllData();
	var mkeyrings = keyring_config;

	//delete the keyring from json which have been deleted from web
	for(var i = 0; i < mkeyrings.length; i++) {
		data_found = 0;
		data_changed = 0;

		for(var j = 0; j < datak.length; j++) {
			if(mkeyrings[i][0] == datak[j][0]) {
				data_found = 1;
				break;
			}
		}
		if(!data_found) {
			cmd += "no crypto keyring " + mkeyrings[i][0] + "\n";
		}		
	}

	//add the  keyring into json which have been added or changed by the web
	for(var i = 0; i < datak.length; i++) {
		data_found = 0;
		data_changed = 0;

		for(var j = 0; j < mkeyrings.length; j++) {
			if(datak[i][0] == mkeyrings[j][0]) {
				data_found = 1;
				if((datak[i][1] != mkeyrings[j][1]) ||
					(datak[i][2] != mkeyrings[j][2]) ||
					(datak[i][3] != mkeyrings[j][3])) {
					data_changed = 1;
				}
				break;
			}
		}

		if(!data_found || data_changed) {
			cmd += "!\n";
			cmd += "crypto keyring " + datak[i][0] + "\n";
			if(datak[i][2] == "")
				cmd += "pre-shared-key address " + datak[i][1] + " key " + datak[i][3] + "\n";
			else
				cmd += "pre-shared-key address " + datak[i][1] + " " + datak[i][2] +" key " + datak[i][3] + "\n";				
		}
	}

	/* verify for the policy grid */
	var datapl = policy.getAllData();
	var mpolicys = policy_config;

	//delete the policy from json which have been deleted from web
	for(var i = 0; i < mpolicys.length; i++) {
		data_found = 0;
		data_changed = 0;

		for(var j = 0; j < datapl.length; j++) {
			if(mpolicys[i][0] == datapl[j][0]) {
				data_found = 1;
				break;	
			}
		}
		if(!data_found) {
			cmd += "no crypto isakmp policy " + mpolicys[i][0] +"\n";
		}
	}

	//add the policy into json which have been added or changed by the web	
	for(var i = 0; i < datapl.length; i++) {
		var encrypt, group;
		data_found = 0;
		data_changed = 0;

		if(datapl[i][2] == '0')
			encrypt = '3des';
		else if(datapl[i][2] == '1')
			encrypt = 'des';
		else if(datapl[i][2] == '2')
			encrypt = 'aes128';
		else if(datapl[i][2] == '3')
			encrypt = 'aes192';
		else if(datapl[i][2] == '4')
			encrypt = 'aes256';

		if(datapl[i][4] == '1')
			group = '1';
		else if(datapl[i][4] == '2')
			group = '2';
		else if(datapl[i][4] == '5')
			group = '5';

		for(var j = 0; j < mpolicys.length; j++) {
			if(datapl[i][0] == mpolicys[j][0]) {
				data_found = 1;	
				if((datapl[i][1] != mpolicys[j][1]) ||
					(datapl[i][2] != mpolicys[j][2]) ||
					(datapl[i][3] != mpolicys[j][3]) ||
					(datapl[i][4] != mpolicys[j][4]) ||
					(datapl[i][5] != mpolicys[j][5])) {
					data_changed = 1;
				}
				break;
			}
		}
		if(!data_found || data_changed) {
			cmd += "!\n";
			cmd += "crypto isakmp policy " + datapl[i][0] +"\n";	//policy index
			cmd += "authentication " + ((datapl[i][1]=='0') ? "pre-share":"rsa-sig") + "\n";	//policy authentication
			cmd += "encryption " + encrypt + "\n";
			cmd += "hash " + ((datapl[i][3]=='0')?"md5":"sha") + "\n";	//hash
			cmd += "group " + group + "\n";
			cmd += "lifetime " + datapl[i][5] +"\n";	
		}
		
	}

	//add the profile into json which have been added or changed by the web	
	for(var i = 0; i < datapf.length; i++) {
		var local_id_typ, remote_id_typ;
		data_found = 0;
		data_changed = 0;

		if(datapf[i][2] == '0') {
			local_id_typ = 'address';
		} else if(datapf[i][2] == '1') {
			local_id_typ = 'fqdn';
		} else if(datapf[i][2] == '2') {
			local_id_typ = 'user-fqdn';
		}

		if(datapf[i][4] == '0') {
			remote_id_typ = 'address';
		} else if(datapf[i][4] == '1') {
			remote_id_typ = 'fqdn';
		} else if(datapf[i][4] == '2') {
			remote_id_typ = 'user-fqdn';
		}

		for(var j = 0; j < mprofiles.length; j++) {
			if(datapf[i][0] == mprofiles[j][0]) {
				data_found = 1;
				if((datapf[i][1] != mprofiles[j][1]) ||
					(datapf[i][2] != mprofiles[j][2]) ||
					(datapf[i][3] != mprofiles[j][3]) ||
					(datapf[i][4] != mprofiles[j][4]) ||
					(datapf[i][5] != mprofiles[j][5]) ||
					(datapf[i][6] != mprofiles[j][6]) ||
					(datapf[i][7] != mprofiles[j][7]) ||
					((datapf[i][8] != mprofiles[j][8]) &&
					 !((datapf[i][8] == '') &&
					 (mprofiles[j][8] == '0'))) ||
					((datapf[i][9] != mprofiles[j][9]) &&
					 !((datapf[i][9] == '') &&
					 (mprofiles[j][9] == '0')))) {
					data_changed = 1;
				}
				break;
			}
		}
		
		if(!data_found || data_changed) {
			cmd += "!\n";
			cmd += "crypto isakmp profile " + datapf[i][0] + "\n";	//profile name
			if(datapf[i][1] == '1')	//aggressive mode
				cmd += "initiate mode aggressive\n";
			else	//main mode
				cmd += "no initiate mode\n";
			cmd += "self-identity "+ local_id_typ + " " + datapf[i][3] +"\n";	//local identity
			cmd += "match identity "+ remote_id_typ + " " +datapf[i][5] + "\n";	//remote identity

			if(datapf[i][7] != "")
				cmd += "keyring "+datapf[i][7]+"\n";	//keyring name
			cmd += "policy "+datapf[i][6]+"\n";		//policy id
			if((datapf[i][8] != "") && (datapf[i][9] != "")) {
				cmd += "keepalive "+datapf[i][8]+" retry "+datapf[i][9]+"\n";	//dpd timeout	
			} else {
				cmd += "no keepalive\n";	//dpd timeout	
			}
		}
	}


//	alert(cmd);
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

	if (keyring.isEditing()) return;

	if((E('_fom')._web_cmd.value != '')&&(cookie.get('autosave') == 1)){
		E('_fom')._web_cmd.value += "!"+"\n"+"copy running-config startup-config"+"\n";	
	}
	form.submit('_fom', 1);
}

function earlyInit()
{
	keyring.setup();
	policy.setup();
	profile.setup();
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

<div id='keyring_title' class='section-title'>
<script type='text/javascript'>
	GetText(ipsec.keyring);
</script>
</div>
<div id="keyring_body" class='section'>
	<table class='web-grid' id='keyring-grid'></table>	
</div>

<div id='policy_title' class='section-title'>
<script type='text/javascript'>
	GetText(ipsec.policy);
</script>
</div>
<div id="policy_body" class='section'>
	<table class='web-grid' id='policy-grid'></table>	
</div>

<div id='profile_title' class='section-title'>
<script type='text/javascript'>
	GetText(ipsec.profile);
</script>
</div>
<div id="profile_body" class='section'>
	<table class='web-grid' id='profile-grid'></table>	
</div>
<script type='text/javascript'>
init();
if(cookie.get('autosave') == 1)
	ui.aply=ui.aply_save;
genStdFooter("");
</script>
</form>
<script type='text/javascript'>earlyInit()</script>


</body>
</html>

