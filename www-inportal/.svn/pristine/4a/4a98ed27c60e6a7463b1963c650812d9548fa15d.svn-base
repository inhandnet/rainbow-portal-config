<% pagehead(menu.service_snmp) %>

<style type='text/css'>
#comman-grid {
	width: 700px;
}
#comman-grid .co1 {
	width: 150px;
	text-align: center;
}
#comman-grid .co2 {
	width: 100px;
	text-align: center;
}
#comman-grid .co3 {
	width: 100px;
	text-align: center;	
}

#groupman-grid {
	width: 700px;
}
#groupman-grid .co1 {
	width: 150px;
	text-align: center;
}
#groupman-grid .co2 {
	width: 100px;
	text-align: center;
}
#groupman-grid .co3 {
	width: 100px;
	text-align: center;	
}
#groupman-grid .co4 {
	width: 100px;
	text-align: center;
}
#groupman-grid .co5 {
	width: 100px;
	text-align: center;	
}

#usmman-grid {
	width: 700px;
}
#usmman-grid .co1 {
	width: 150px;
	text-align: center;
}
#usmman-grid .co2 {
	width: 100px;
	text-align: center;
}
#usmman-grid .co3 {
	width: 100px;
	text-align: center;	
}
#usmman-grid .co4 {
	width: 100px;
	text-align: center;
}
#usmman-grid .co5 {
	width: 100px;
	text-align: center;	
}
#usmman-grid .co6 {
	width: 100px;
	text-align: center;	
}

</style>

<script type='text/javascript'>

<% ih_sysinfo() %>
<% ih_user_info() %>

<% web_exec('show running-config snmp-server') %>

var groupman = new webGrid();

var usmman = new webGrid();

var options = [];	//global group options to update the usmman-grid

//verify snmp syslocation and syscontact
function isLegal_snmp_info(str)	
{
	var reg = /^[A-Za-z0-9@&.,_]+$/;
	return reg.test(str);
}

//verify snmp community,username,groupname,auth_pwd,priv_pwd,trap_sec_name
function isLegal_snmp_name(str)
{
	var reg = /^[A-Za-z0-9_]+$/;
	return reg.test(str);
}

function display_disable_groupman(e)
{	
	var x = e?"":"none";
	
	E('groupman-grid').style.display = x;
	E('groupman_title').style.display = x;
	E('groupman_body').style.display = x;

	E('groupman-grid').disabled = !e;
	E('groupman_title').disabled = !e;
	E('groupman_body').disabled = !e;
	return 1;
}

groupman.existg = function(f,v)
{
	var mydata = usmman.getAllData();
	for(var i = 0; i < mydata.length;++i){
		if(mydata[i][f] == v) return true;
	}
	return false;
}

groupman.existGroup = function(groupname)
{
	return this.existg(5,groupname);
}

groupman.exist = function(f, v)
{
	var data = this.getAllData();
	for (var i = 0; i < data.length; ++i) {
		if (data[i][f] == v) return true;
	}
	return false;
}

groupman.existName = function(name)
{
	return this.exist(0, name);
}


groupman.dataToView = function(data) {
	
	return [data[0] , (data[1] == '0') ? ui.snmp_noAuthNoPriv : ((data[1] == '1') ? ui.snmp_authNoPriv : ui.snmp_authPriv), 
	       (data[2] == '0') ? ui.snmp_defaultView : ui.snmp_newView, 
	       (data[3] == '0') ? ui.snmp_defaultView : ui.snmp_newView, 
	       (data[4] == '0') ? ui.snmp_defaultView : ui.snmp_newView]; 
}

groupman.fieldValuesToData = function(row) {
	var f = fields.getAll(row);
	return [f[0].value, f[1].value, f[2].value, f[3].value, f[4].value];
}

groupman.onDataChanged = function() {
	var data = groupman.getAllData();
//	var options = [];	//note:change to global varible
	options = [];		//clear the options
	verifyFields(null, 1);

	for (var i=0; i < data.length; i++) options.push([data[i][0], data[i][0]]);
	
	usmman.updateEditorField(1, 
			{ type: 'select', maxlen: 15, options: options});
}

groupman.verifyDelete = function(data) {

	var mydata = groupman.getAllData();
//	var options = [['none',ui.snmp_noGroupName]];
//	var options = [];	//note:change to global varible

	if (this.existGroup(data[0])){
//		alert(errmsg.bad_name5);
		show_alert(errmsg.bad_name5);	
		return 0;
	} 

	for (var i=0; i < mydata.length; i++){
		if(mydata[i][0] != (data[0]))	       	
			options.push([mydata[i][0], mydata[i][0]]);
	}
	usmman.updateEditorField(1, 
			{ type: 'select', maxlen: 15, options: options});

	return true;
}

groupman.getAuthPriv = function(groupName) 
{
	var data = groupman.getAllData();

	for (var i = 0; i < data.length; i++){
		if (data[i][0] == groupName) {
			return data[i][1];
		}
	}
	return 0;
}

groupman.verifyFields = function(row, quiet) {
	var f = fields.getAll(row);
	var data = groupman.getAllData();

	if(haveChineseChar(f[0].value)) {		//error when input chinese chars
//		ferror.set(f[0], errmsg.snmp_groupname, false);
		ferror.set(f[0], errmsg.cn_chars, quiet);
		return 0;		
	} else if(!v_length(f[0], quiet,1,32)) {
		return 0;		
	} else if(f[0].value.indexOf(" ") >= 0) {
		ferror.set(f[0], errmsg.bad_description, quiet);
		return 0;		
	} else if(!isLegal_snmp_name(f[0].value)) {
		ferror.set(f[0], errmsg.snmp_name, quiet);
		return 0;
	} else if (this.existName(f[0].value)) {
		ferror.set(f[0], errmsg.bad_name4, quiet);
		return 0;
	} else {
		ferror.clear(f[0]);		
	}
	
//	for (var i=0; i < data.length; i++) options.push([data[i][0], data[i][0]]);
//	options.push([f[0].value, f[0].value]);
	
//	usmman.updateEditorField(5, 
//			{ type: 'select', maxlen: 15, options: options});

	return 1;
}

groupman.createControls = function(which, rowIndex) {
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

groupman.onClick = function(cell) {
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
	if (this.existGroup(f[0].value)){
		E('del_row_button').disabled = true;
		E('ok_row_button').disabled = true;
		for(var i = 0;i < f.length;i++)
			f[i].disabled = true;
	} 

}



groupman.resetNewEditor = function() {
	var f = fields.getAll(this.newEditor);
	f[0].value = '';
	
	for(var i = 1;i < f.length;++i){
		f[i].value = 0;
	}
			
	ferror.clearAll(fields.getAll(this.newEditor));
}

groupman.setup = function() {
	this.init('groupman-grid', 'move', 4, [
		{ type: 'text', maxlen: 32 }, 
		{ type: 'select', maxlen: 15, options:[
			['0',ui.snmp_noAuthNoPriv],
			['1',ui.snmp_authNoPriv],
			['2',ui.snmp_authPriv]
		]},
		{ type: 'select', maxlen: 15, options:[
			['0',ui.snmp_defaultView]]},
		{ type: 'select', maxlen: 15, options:[
			['0',ui.snmp_defaultView]]},
		{ type: 'select', maxlen: 15, options:[
			['0',ui.snmp_defaultView]]}]);
	this.headerSet([ui.snmp_groupname_title,ui.snmp_sec_level_title, ui.snmp_ro_view_title,ui.snmp_rw_view_title,ui.snmp_trap_view_title]);

	for (var i = 0; i < snmps_config.snmp_groups.length; i++)
		this.insertData(-1, [snmps_config.snmp_groups[i].groupname, 
				     snmps_config.snmp_groups[i].sec_level, 
				     snmps_config.snmp_groups[i].ro_view, 
				     snmps_config.snmp_groups[i].ro_view, 
				     snmps_config.snmp_groups[i].notify_view]);

	this.showNewEditor();
	this.resetNewEditor();
}

function findGroupSecLev(groupname)
{
	var exist_group = groupman.getAllData();
	for(var i=0; i < exist_group.length; i++) {
		if(exist_group[i][0] == groupname) {
			return exist_group[i][1];
		} else {
			continue;
		}
	}
}

//var usmman = new webGrid();
/*
 *user:
 *auth(f[1].value):0-sha, 1-md5, 2-none
 *priv(f[3].value):0-des, 1-none
 *group:
 *sec_level:0-noAuthNoPriv, 1-authNoPriv, 2-authPriv
 *
*/
function generatesnmpGroupOptions(auth, priv)
{
	var group_options = [];
	var group_sec_level;

//	alert("Bone:sec_level"+findGroupSecLev(options[0][0])+"options:"+options[0][0]);

	if((auth == '2') && (priv == '1')) {	//noAuthNoPriv
		group_sec_level = 0;
	} else if((auth != '2') && (priv == '1')) {	//authNoPriv
		group_sec_level = 1;
	} else if((auth != '2') && (priv == '0')) {	//authPriv
		group_sec_level = 2;
	}
	
	for (var i=0; i < options.length; i++) {
		if(group_sec_level == 0) {
			if(findGroupSecLev(options[i][0]) == '0') 
				group_options.push([options[i][0], options[i][0]]);
			else 
				continue;
		} else if(group_sec_level == 1) {
			if(findGroupSecLev(options[i][0]) == '1') 
				group_options.push([options[i][0], options[i][0]]);
			else 
				continue;
		} else if(group_sec_level == 2) {
			if(findGroupSecLev(options[i][0]) == '2') 
				group_options.push([options[i][0], options[i][0]]);
			else
				continue;
		}		
	}
//	alert("group_len"+group_options.length);
	return group_options;
	
}

usmman.exist = function(f, v)
{
	var data = this.getAllData();
	for (var i = 0; i < data.length; ++i) {
		if (data[i][f] == v) return true;
	}
	return false;
}

usmman.existName = function(name)
{
	return this.exist(0, name);
}

usmman.dataToView = function(data) {
	var data_auth_pwd = "";
	var data_priv_pwd = "";
	
	if(data[3].length == 0) {
		data_auth_pwd = "";
	} else if(data[3].length >= 8) {
		for(var i = 0;i < data[3].length;i++) {
			data_auth_pwd += "*";
		}
	}

	if(data[5].length == 0) {
		data_priv_pwd = "";
	} else if(data[5].length >= 8) {
		for(var i = 0;i < data[5].length;i++) {
			data_priv_pwd += "*";
		}
	}

//	return [data[0], 
//	       (data[1] == '0') ? ui.snmp_auth_sha : ((data[1] == '1') ? ui.snmp_auth_md5 : ui.snmp_auth_none), 
//	       data[2], (data[3] == '0') ? ui.snmp_priv_des : ui.snmp_priv_none,
//	       data[4],
//	       data[5]];
	return [data[0],
	       data[1], 
	       (data[2] == '0') ? ui.snmp_auth_sha : ((data[2] == '1') ? ui.snmp_auth_md5 : ui.snmp_auth_none), 
	       data_auth_pwd, 
	       (data[4] == '0') ? ui.snmp_priv_des : ui.snmp_priv_none,
	       data_priv_pwd];
}

usmman.fieldValuesToData = function(row) {
	var f = fields.getAll(row);
	return [f[0].value, f[1].value, f[2].value, f[3].value, f[4].value, f[5].value];
}

usmman.onDataChanged = function() {
	verifyFields(null, 1);
}

usmman.safeUpdateEditorField = function(i, editorField) {
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
	usmman.updateEditorField(i, editorField);

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

usmman.safeUpdateRowEditorField = function(row, i, editorField, group_options) {
	var f = fields.getAll(row);
	var f_value = [];
	var f_disabled = [];
	for (var j = 0; j < f.length; j++){
		f_value.push(f[j].value);
		f_disabled.push(f[j].disabled);
	}
	
	if (row == this.newEditor){
		this.updateEditorField(i, editorField);
		row = this.newEditor;
	}else if(row == this.editor){//this.editor
		//change field
		this.editorFields[i] = editorField;
		var rowIndex = this.editor.rowIndex;
		//remove old editor
		elem.remove(this.editor);
		this.editor = null;
		//create new editor
		r = this.createEditor('edit', rowIndex, null);
		row = this.editor = r;
		
	}

	f = fields.getAll(row);
	for (var j = 0; j < f.length; ++j) {
		if(j != i) {	//the "i" row don't update to the stored value 
			if (f[j].selectedIndex ) {
				f[j].selectedIndex = f_value[j];
			} else {
				f[j].value = f_value[j];
			}
			f[j].disabled = f_disabled[j];
		} else {	//the "i" row update to keep the original value
			for(var n = 0; n < group_options.length; n++) {

				if(f_value[j] == group_options[n][1]) {					
					f[j].value = f_value[j];
				} 
			}
			
		}
	}
}

usmman.verifyFields = function(row, quiet) {
	var f = fields.getAll(row);
	var group_options = [];

	if(haveChineseChar(f[0].value)) {		//error when input chinese chars
//		ferror.set(f[0], errmsg.snmp_username, false);
		ferror.set(f[0], errmsg.cn_chars, quiet);
		return 0;		
	} else if(!v_length(f[0], quiet,1,32)) {
		return 0;		
	} else if(f[0].value.indexOf(" ") >= 0) {
		ferror.set(f[0], errmsg.bad_description, quiet);
		return 0;		
	} else if(!isLegal_snmp_name(f[0].value)) {
		ferror.set(f[0], errmsg.snmp_name, quiet);
		return 0;
	} else if (this.existName(f[0].value)) {
		ferror.set(f[0], errmsg.bad_name4, quiet);
		return 0;
	} else {
		ferror.clear(f[0]);
	}

	if(f[1].value.length == 0) {
		ferror.set(f[1], errmsg.snmp_groupname_err, quiet);
		return 0;	
	} else {
		ferror.clear(f[1]);
	}

	var groupAuthPriv = groupman.getAuthPriv(f[1].value);
	if (groupAuthPriv == 0) {
		//NoAuth-NoPriv
		f[2].value = '2';
		f[4].value = '1';
	}else if (groupAuthPriv == 1) {
		//Auth-NoPriv
		if (f[2].value == '2') {
			f[2].value = '0';
		}
		f[4].value = '1';
	}else if (groupAuthPriv == 2) {
		//Auth-Priv
		if (f[2].value == '2') {
			f[2].value = '0';
		}
		if (f[4].value == '1') {
			f[4].value = '0';
		}
	}

	f[5].disabled = (f[4].value == '1'); //f[3]:priv
	f[3].disabled = (f[2].value == '2'); //f[1]:auth
	ferror.clear(f[3]);
	ferror.clear(f[5]);
	if(f[4].value == '1') //f[4].value=1:none
	{
		if(f[2].value == '2') //f[2].value=2:none
		{	 
			if(!v_length(f[0], quiet,1,32))
				return 0;
		}
		else	//authNoPriv
		{
			if(!v_length(f[0], quiet,1,32))
				return 0;			
//			if(!v_length(f[2],quiet,8,32))
//				return 0;
			if(haveChineseChar(f[3].value)) {		//error when input chinese chars
				ferror.set(f[3], errmsg.cn_chars, quiet);
				return 0;		
			} else if(!v_length(f[3], quiet,8,32)) {
				return 0;		
			} else if(f[3].value.indexOf(" ") >= 0) {
				ferror.set(f[3], errmsg.bad_description, quiet);
				return 0;		
			} else {
				ferror.clear(f[3]);
			}
		}
		
	}
	else //f[4].value=0:DES
	{
		if(f[2].value == '2') //f[2].value=2:none(authmode) Error:noAuthPriv
		{
			ferror.set(f[2], errmsg.bad_name6, quiet);
			return 0;
		}
		else	//authPriv
		{
			if(!v_length(f[0], quiet,1,32))
				return 0;
//			if(!v_length(f[2],quiet,8,32))
//				return 0;
//			if(!v_length(f[4],quiet,8,32))
//				return 0;
			if(haveChineseChar(f[3].value)) {		//error when input chinese chars
				ferror.set(f[3], errmsg.cn_chars, quiet);
				return 0;		
			}  else if(!v_length(f[3], quiet,8,32)) {
				return 0;		
			} else if(f[3].value.indexOf(" ") >= 0) {
				ferror.set(f[3], errmsg.bad_description, quiet);
				return 0;		
			} else {
				ferror.clear(f[3]);
			}

			if(haveChineseChar(f[5].value)) {		//error when input chinese chars
				ferror.set(f[5], errmsg.cn_chars, quiet);
				return 0;		
			}  else if(!v_length(f[5], quiet,8,32)) {
				return 0;		
			} else if(f[5].value.indexOf(" ") >= 0) {
				ferror.set(f[5], errmsg.bad_description, quiet);
				return 0;		
			} else {
				ferror.clear(f[5]);
			}	
		}
	
	}
/*
	group_options = generatesnmpGroupOptions(f[2].value, f[4].value);

//	usmman.safeUpdateEditorField(5, 
//			{ type: 'select', maxlen: 15, options: group_options});

	usmman.safeUpdateRowEditorField(row,5, 
			{ type: 'select', maxlen: 15, options: group_options},
			group_options);
*/

	return 1;
}

usmman.onClick = function(cell) {
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
}

usmman.resetNewEditor = function() {
	var f = fields.getAll(this.newEditor);
	f[0].value = '';
	f[2].value = 2;
	f[3].value = '';
	f[4].value = 1;
	f[5].value = '';
//	f[5].value = '';
			
	ferror.clearAll(fields.getAll(this.newEditor));
}

usmman.setup = function() {
	var data = groupman.getAllData();
//	var options = [['none',ui.snmp_noGroupName]];
//	var options = [];
	options = [];	//clear the options

	for (var i=0; i < data.length; i++) options.push([data[i][0], data[i][0]]);

	this.init('usmman-grid', 'move', 16, [
		{ type: 'text', maxlen: 32 },
		{ type: 'select', maxlen: 15, options:options}, 
		{ type: 'select', maxlen: 15, options:[
			['0',ui.snmp_auth_sha],
			['1',ui.snmp_auth_md5],
			['2',ui.snmp_auth_none]]},
		//{ type: 'text', maxlen: 32 },
		{ type: 'password', maxlen: 32 },
		{ type: 'select', maxlen: 15, options:[
			['0',ui.snmp_priv_des],
			['1',ui.snmp_priv_none]]},
		//{ type: 'text', maxlen: 32 },
		{ type: 'password', maxlen: 32 }]);
	this.headerSet([ui.snmp_usm_title,ui.snmp_groupname_title, ui.snmp_auth_title,ui.snmp_authpwd_title,ui.snmp_priv_title,ui.snmp_privpwd_title]);
	//this.headerSet([ui.snmp_usm_title, ui.snmp_auth_title,ui.snmp_authpwd_title,ui.snmp_priv_title,ui.snmp_privpwd_title,ui.snmp_limit_title,ui.snmp_groupname_title]);

	for (var i = 0; i < snmps_config.snmp_users.length; i++)
		this.insertData(-1, [snmps_config.snmp_users[i].username,
				     snmps_config.snmp_users[i].groupname, 
				     snmps_config.snmp_users[i].auth, 
				     snmps_config.snmp_users[i].auth_pwd, 
				     snmps_config.snmp_users[i].priv, 
				     snmps_config.snmp_users[i].priv_pwd]);
	this.showNewEditor();
	this.resetNewEditor();
}


function display_disable_usmman(e)
{	
	var x = e?"":"none";
	
	E('usmman-grid').style.display = x;
	E('usmman_title').style.display = x;
	E('usmman_body').style.display = x;

	E('usmman-grid').disabled = !e;
	E('usmman_title').disabled = !e;
	E('usmman_body').disabled = !e;
	return 1;
}

var comman = new webGrid();

function display_disable_comman(e)
{	
	var x = e?"":"none";
	
	E('comman-grid').style.display = x;
	E('comman_title').style.display = x;
	E('comman_body').style.display = x;

	E('comman-grid').disabled = !e;
	E('comman_title').disabled = !e;
	E('comman_body').disabled = !e;
	return 1;
}

comman.exist = function(f, v)
{
	var data = this.getAllData();
	for (var i = 0; i < data.length; ++i) {
		if (data[i][f] == v) return true;
	}
	return false;
}

comman.existName = function(name)
{
	return this.exist(0, name);
}


comman.dataToView = function(data) {
	
	return [data[0],
	       (data[1] == '0') ? ui.snmp_com_ro : ui.snmp_com_rw, 
	       (data[2] == '0') ? ui.snmp_defaultView : ui.snmp_defaultView];
//	       (data[2] == '0') ? ui.snmp_defaultView : ui.snmp_newView];
}

comman.fieldValuesToData = function(row) {
	var f = fields.getAll(row);
	return [f[0].value, f[1].value, f[2].value];
}

comman.onDataChanged = function() {
	verifyFields(null, 1);
}

comman.verifyFields = function(row, quiet) {
	var f = fields.getAll(row);

//	alert("alert value:"+isLegal_snmp(f[0].value));

	if(haveChineseChar(f[0].value)) {		//error when input chinese chars
//		ferror.set(f[0], errmsg.snmp_community, false);
		ferror.set(f[0], errmsg.cn_chars, quiet);
		return 0;
	} else if (!v_length(f[0], quiet,1,32)) {
		return 0;		
	} else if(f[0].value.indexOf(" ") >= 0) {
		ferror.set(f[0], errmsg.bad_description, quiet);
		return 0;
	} else if(!isLegal_snmp_name(f[0].value)) {
		ferror.set(f[0], errmsg.snmp_name, quiet);
		return 0;
	} else if (this.existName(f[0].value)) {
		ferror.set(f[0], errmsg.bad_name4, quiet);
		return 0;
	} else {
		ferror.clear(f[0]);
	}

	return 1;
}

comman.resetNewEditor = function() {
	var f = fields.getAll(this.newEditor);
	f[0].value = '';
	
	for(var i = 1;i < f.length;++i){
		f[i].value = 0;
	}
			
	ferror.clearAll(fields.getAll(this.newEditor));
}

comman.setup = function() {

	this.init('comman-grid', 'move', 4, [
		{ type: 'text', maxlen: 32 }, 
		{ type: 'select', maxlen: 15, options:[
			['0',ui.snmp_com_ro],
			['1',ui.snmp_com_rw]]},
		{ type: 'select', maxlen: 15, options:[
			['0',ui.snmp_defaultView]]}]);
	this.headerSet([ui.snmp_com_community_title,ui.snmp_com_access_title,ui.snmp_com_view_title]);
	for (var i = 0; i < snmps_config.snmp_coms.length; i++)
		this.insertData(-1, [snmps_config.snmp_coms[i].community, 
				     snmps_config.snmp_coms[i].rw, 
				     snmps_config.snmp_coms[i].view]);
	this.showNewEditor();
	this.resetNewEditor();

}


function verifyFields(focused, quiet)
{
	var ok = 1;
	var cmd = "";
	var fom = E('_fom');

	E('save-button').disabled = true;
	var snmp_version = E('_f_snmpd_version').value;
	var syscontact = E('_f_snmpd_syscontact').value;
	var syslocation = E('_f_snmpd_syslocation').value;
//	var ro_com = E('_f_snmpd_ro_community').value;
//	var rw_com = E('_f_snmpd_rw_community').value;

	var enable;
	enable = E('_f_snmpd_enable').checked;

	if (!enable) 
	{
//		elem.display_and_enable(('_f_snmpd_version'),('_f_snmpd_ro_community'), ('_f_snmpd_rw_community'),('_f_snmpd_syscontact'),('_f_snmpd_syslocation'),false);
		elem.display_and_enable(('_f_snmpd_version'),('_f_snmpd_syscontact'),('_f_snmpd_syslocation'),false);
		display_disable_usmman(0);
		display_disable_groupman(0);
		display_disable_comman(0)
		if(snmps_config.enable) cmd += "no snmp-server\n";
//		return 1;
	}
	else
	{
		elem.display_and_enable(('_f_snmpd_version'),('_f_snmpd_syscontact'),('_f_snmpd_syslocation'),true);

//		if( (syscontact != "") && (!v_length('_f_snmpd_syscontact',quiet,1,64)) ) return 0;
//		if( (syslocation != "") && (!v_length('_f_snmpd_syslocation',quiet,1,64)) ) return 0;

		if(!snmps_config.enable) cmd += "snmp-server\n";
		if(syscontact != snmps_config.syscontact) 
		{
			if(syscontact != "") 
			{
				if(haveChineseChar(syscontact)) {
//					ferror.set('_f_snmpd_syscontact', errmsg.snmp_contact, false);
					ferror.set('_f_snmpd_syscontact', errmsg.cn_chars, quiet);
					return 0;
				} else if(E('_f_snmpd_syscontact').value.indexOf(" ") >= 0) {
					ferror.set('_f_snmpd_syscontact', errmsg.bad_description, quiet);
					return 0;
				} else if(!v_length('_f_snmpd_syscontact',quiet,1,64)) {
					return 0;
				} else if(!isLegal_snmp_info(syscontact)) {
					ferror.set('_f_snmpd_syscontact', errmsg.snmp_sysinfo, quiet);
					return 0;
				} else {
					cmd += "snmp-server contact " + syscontact + "\n";
					ferror.clear('_f_snmpd_syscontact');
				}
			}
			else if(syscontact == "")
				cmd += "no snmp-server contact\n";				
		}
		if(syslocation != snmps_config.syslocation) 
		{	
			if(syslocation != "")
			{
				if(haveChineseChar(syslocation)) {
					ferror.set('_f_snmpd_syslocation', errmsg.cn_chars, quiet);
					return 0;
				} else if(E('_f_snmpd_syslocation').value.indexOf(" ") >= 0) {
					ferror.set('_f_snmpd_syslocation', errmsg.bad_description, quiet);
					return 0;
				} else if(!v_length('_f_snmpd_syslocation',quiet,1,64)) {
					return 0;
				} else if(!isLegal_snmp_info(syslocation)) {
					ferror.set('_f_snmpd_syslocation', errmsg.snmp_sysinfo, quiet);
					return 0;
				} else {
					cmd += "snmp-server location " + syslocation + "\n";
					ferror.clear('_f_snmpd_syslocation');	
				}
			}
			else if(syslocation == "") 
				cmd += "no snmp-server location\n";
		}
		if(snmp_version != snmps_config.version) cmd += "snmp-server version " + snmp_version + "\n";


		if( E('_f_snmpd_version').value == '1'||E('_f_snmpd_version').value == '2')
		{
			var flag = 0;
			display_disable_usmman(0);
			display_disable_groupman(0);
			display_disable_comman(1);
			
			//verify for the com grid
			var datac = comman.getAllData();
			var mcoms = snmps_config.snmp_coms;

			//delete the community from json which have been deleted from web 
			for(var i = 0; i < mcoms.length; i++) {
				flag = 0;
				for (var j=0; j < datac.length; j++) {
					if((mcoms[i].community == datac[j][0]) && (mcoms[i].rw == datac[j][1])) {
						flag = 1;	//The community is still in the web grid
						break;
					}
				}
				if(!flag)
					cmd += "no snmp-server community " + mcoms[i].community + "\n";

			}

			//add the community into json which have been added by the web
			for(var i = 0; i < datac.length; i++) {
				flag = 0;
				for (var j=0; j < mcoms.length; j++) {
					if((datac[i][0] == mcoms[j].community) && (datac[i][1] == mcoms[j].rw)) {
						flag = 1;
						break;
					}
				}
				if(!flag)
					cmd += "snmp-server community " + datac[i][0] + " " + ((datac[i][1] == '0') ? "ro" : "rw") + "\n";

			}			
		} 
		else 
		{
			display_disable_usmman(1);
			display_disable_groupman(1);
			display_disable_comman(0);

			//verify for the group grid(v3)
			var datag = groupman.getAllData();
			var mgroups = snmps_config.snmp_groups;

			//verify for the user grid(v3)
			var datau = usmman.getAllData();
			var musers = snmps_config.snmp_users;

			//delete the user from json which have been deleted from web 
			for(var i = 0; i < musers.length; i++) {
				flag = 0;
				for (var j=0; j < datau.length; j++) {
					if((musers[i].username == datau[j][0]) &&
						(musers[i].groupname == datau[j][1])&& 
						(musers[i].auth == datau[j][2]) &&
						(musers[i].auth_pwd == datau[j][3]) &&
						(musers[i].priv == datau[j][4]) &&
						(musers[i].priv_pwd == datau[j][5]) ) {
						flag = 1;
						break;
					}
				}
				if(!flag)
					cmd += "no snmp-server user " + musers[i].username + "\n";
			}
		
			//delete the group from json which have been deleted from web 
			for(var i = 0; i < mgroups.length; i++) {
				flag = 0;
				for (var j=0; j < datag.length; j++) {
					if((mgroups[i].groupname == datag[j][0]) && (mgroups[i].sec_level == datag[j][1])) {
						flag = 1;
						break;
					}
				}
				if(!flag)
					cmd += "no snmp-server group " + mgroups[i].groupname + "\n";
			}

			//add the groupname into json which have been added by the web
			for(var i = 0; i < datag.length; i++) {
				flag = 0;
				for (var j=0; j < mgroups.length; j++) {
					if((mgroups[j].groupname == datag[i][0]) && (mgroups[j].sec_level == datag[i][1])) {
						flag = 1;
						break;
					}
				}
				if(!flag)
					cmd += "snmp-server group " + datag[i][0] + " " + ((datag[i][1] == '0') ? "noauth" : ((datag[i][1] == '1') ? "auth" : "priv")) + "\n";
			}
/*
			//verify for the user grid(v3)
			var datau = usmman.getAllData();
			var musers = snmps_config.snmp_users;

			//delete the user from json which have been deleted from web 
			for(var i = 0; i < musers.length; i++) {
				flag = 0;
				for (var j=0; j < datau.length; j++) {
					if((musers[i].username == datau[j][0]) && 
						(musers[i].auth == datau[j][1]) &&
						(musers[i].auth_pwd == datau[j][2]) &&
						(musers[i].priv == datau[j][3]) &&
						(musers[i].priv_pwd == datau[j][4]) &&
						(musers[i].groupname == datau[j][5])) {
						flag = 1;
						break;
					}
				}
				if(!flag)
					cmd += "no snmp-server user " + musers[i].username + "\n";
			}
*/
	
			//add the username into json which have been added by the web
			for(var i = 0; i < datau.length; i++) {
				flag = 0;
				for (var j=0; j < musers.length; j++) {
					if((musers[j].username == datau[i][0]) &&
						(musers[j].groupname == datau[i][1])&&
						(musers[j].auth == datau[i][2]) &&
						(musers[j].auth_pwd == datau[i][3]) &&
						(musers[j].priv == datau[i][4]) &&
						(musers[j].priv_pwd == datau[i][5]) ) {
						flag = 1;
						break;
					}
				}
				if(!flag)
					cmd += "snmp-server user " + datau[i][0] + " " + datau[i][1] + 
							((datau[i][4] == '0') ? (" priv des " + datau[i][5]) : "") +
							((datau[i][2] == '0') ? (" auth sha " + datau[i][3]) : ((datau[i][2] == '1') ? (" auth md5 " + datau[i][3]) : "")) +
							 "\n";
			}										
		}
	}

	/*
	//verify for the group grid
	var datag = groupman.getAllData();
	var mgroups = snmps_config.snmp_groups;
	for (var i=0; i < datag.length; i++) {
//		alert("datag: " +datag[i][0]);
		for (var j=0; j < mgroups.length; j++) {
//			alert("mgroups: " +mgroups[j].sec_level);
			if((mgroups[j].groupname == datag[i][0]) && (mgroups[j].sec_level == datag[i][1])) {
//				mgroups[j].groupname = "";
//				mgroups[j].sec_level = 3;
//				datag[i][0] = "";
//				datag[i][1] = 3;
				break;
			} 
		}
//		cmd += "snmp-server group " + datag[i][0] + " " + "auth" + "\n";
	}

	for (j = 0; j < mgroups.length; j++) {
		if ((mgroups[j].groupname != "") || (mgroups[j].sec_level != 3)) {
			cmd += "no snmp-server group " + mgroups[j].groupname + "\n";
		}
	}

	for (i = 0;i < datag.length; i++) {
		if ((datag[i][0] == "") && (datag[i][1] == 3)) continue;
		cmd += "snmp-server group " + datag[i][0] + " " + ((datag[i][1] == 0) ? "noauth" : ((datag[i][1] == 1) ? "auth" : "priv" )) + "\n";
	}
*/
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


	if( snmps_config.version == '3'){
		if (groupman.isEditing()) return;	
		if (usmman.isEditing()) return;		
	} else {
		if (comman.isEditing()) return;
	}
//	var fom = E('_fom');
//	if( E('_snmpd_version').value == '3'){
//		var datag = groupman.getAllData();
//		var s = [];
//		for (var j = 0; j < datag.length; ++j) s.push(datag[j].join(','));
//		fom.snmpd_grouplist.value = s.join(';');

//		var data = usmman.getAllData();
//		var r = [];
//		for (var i = 0; i < data.length; ++i) r.push(data[i].join(','));
//		fom.snmpd_userlist.value = r.join(';');
//	}
//	fom.snmpd_enable.value = E('_f_snmpd_enable').checked ? '1' : '0';
//	alert(E('_fom')._web_cmd.value);
	if((E('_fom')._web_cmd.value != '')&&(cookie.get('autosave') == 1)){
		E('_fom')._web_cmd.value += "!"+"\n"+"copy running-config startup-config"+"\n";	
	}
	form.submit('_fom', 1);
}

function earlyInit()
{
	groupman.setup();
	usmman.setup();
	comman.setup();
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

<input type='hidden' name='snmpd_userlist'>
<input type='hidden' name='snmpd_grouplist'>

<div class='section'>
<script type='text/javascript'>

createFieldTable('', [
	{ title: ui.snmp_enable, name: 'f_snmpd_enable', type: 'checkbox', value: snmps_config.enable },
	{ title: ui.snmp_version, name: 'f_snmpd_version', type: 'select', options: [
		['1',ui.snmp_v1], 
		['2',ui.snmp_v2c],
		['3',ui.snmp_v3]], 
		value: snmps_config.version},
	{ title: ui.snmp_syscontact, name: 'f_snmpd_syscontact', type: 'text', maxlen: 64, size: 20, value: snmps_config.syscontact},
	{ title: ui.snmp_syslocation, name: 'f_snmpd_syslocation', type: 'text', maxlen: 64, size: 20, value: snmps_config.syslocation},
//	{ title: ui.snmp_ro_community, name: 'f_snmpd_ro_community', type: 'text', maxlen: 48, size: 20, value: snmps_config.ro_community},
//	{ title: ui.snmp_rw_community, name: 'f_snmpd_rw_community', type: 'text', maxlen: 48, size: 20, value: snmps_config.rw_community}
]);
</script>
</div>

<div id='comman_title' class='section-title'>
<script type='text/javascript'>
	GetText(ui.snmp_com_title);
</script>
</div>
<div id="comman_body" class='section'>
	<table class='web-grid' id='comman-grid'></table>	
</div>

<div id='groupman_title' class='section-title'>
<script type='text/javascript'>
	GetText(ui.snmp_group_title);
</script>
</div>
<div id="groupman_body" class='section'>
	<table class='web-grid' id='groupman-grid'></table>	
</div>

<div id='usmman_title' class='section-title'>
<script type='text/javascript'>
	GetText(ui.snmp_v3_title);
</script>
</div>
<div id="usmman_body" class='section'>
	<table class='web-grid' id='usmman-grid'></table>	
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

