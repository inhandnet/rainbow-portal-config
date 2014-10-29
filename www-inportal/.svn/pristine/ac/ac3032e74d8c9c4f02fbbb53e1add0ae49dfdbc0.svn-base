<% pagehead(menu.setup_ddns) %>

<style type='text/css'>

#method-grid {
	width: 700px;
}

#method-grid .co1 {
	width: 110px;
}

#method-grid .co2{
	width: 180px;
}

#method-grid .co3{
	width: 70px;
}

#method-grid .co4{
	width: 70px;
}


#if_method-grid {
	width: 400px;
}

#if_method-grid .co1 {
	width: 200px;
}

#if_method-grid .co2{
	width: 200px;
}

</style>

<script type='text/javascript'>

<% ih_sysinfo(); %>
<% ih_user_info(); %>
<% web_exec('show running-config ddns') %>

<% web_exec('show interface')%>
var vifs = [].concat(cellular_interface, eth_interface, sub_eth_interface, svi_interface, xdsl_interface, gre_interface, vp_interface, dot11radio_interface);
var now_vifs_options = new Array();
now_vifs_options = grid_list_all_vif_opts(vifs);

function option_convert(a){
    ret = [];
    for(var i = 0; i < a.length; i++) {
        ret.push([a[i],a[i]]);
    }

    return ret;
}
function list_contain(list,obj)
{
    for(var i=0;i<list.length;i++){
        if(list[i] == obj)
            return true;
    }

    return false;
}

var method_all = [];
var method_used = [];

function list_reduce(list1,list2)
{
    var ret = [];
    for(var i=0;i<list1.length;i++){
        if(!list_contain(list2,list1[i]))
            ret.push(list1[i]);
    }
    //console.log(ret)
    return ret;
}

function getAllMethod()
{
	var data = method.getAllData();
	method_all = [];
	
	for(var i = 0; i<data.length; i++) 
		method_all.push(data[i][0]);

	//console.log('method all');
	//console.log(method_all);

	return method_all;
} 

function getusedMethod()
{
	method_used = [];
	var data = if_method.getAllData();
	for(var i = 0; i<data.length; i++) method_used.push(data[i][1]);
	
	//console.log('getusedMethod:method_used');
	//console.log(method_used);
	
	return method_used;

}

function isMethodUsed(method_name)
{
	if(list_contain(method_used,method_name))
		return true;
	else
		return false;
}



var provider_options = [['0', 'Disable'], ['1', 'DynAccess'], ['2', 'QDNS(3322) - Dynamic'], 
			['3', 'QDNS(3322) - Static'],['4', 'DynDNS - Dynamic'],['5', 'DynDNS - Static'],
			['6', 'NoIP']];

var method = new webGrid();
method.exist = function(f, v)
{
	var data = this.getAllData();
	for (var i = 0; i < data.length; ++i) {
		if (data[i][f] == v) return true;
	}
	return false;
}

method.existName = function(name)
{
	return this.exist(0, name);
}

method.dataToView = function(data){
	var provider;
	if(data[1] == '0') {
		provider = 'Disable';

	} else if(data[1] == '1') {
		provider = 'DynAccess';
	
	} else if(data[1] == '2') {
		provider = 'QDNS(3322) - Dynamic';
	
	} else if(data[1] == '3') {
		provider = 'QDNS(3322) - Static';

	} else if(data[1] == '4') {
		provider = 'DynDNS - Dynamic';

	} else if(data[1] == '5') {
		provider = 'DynDNS - Static';

	} else if(data[1] == '6') {
		provider = 'NoIP';

	}

	var passwd = '';

	for(var i =0; i<data[3].length;i++) {
		passwd += '*';
	}

	return [data[0],
	       provider,
	       data[2],
	       passwd,
	       data[4]];
}




var tmp_func = method.onClick;
method.onClick = function(cell){
    if (user_info.priv < admin_priv) {
		return;
	}

	if(if_method.isEditing())
		return;

    tmp_func.apply(method,arguments);
}

method.onDataChanged = function()
{
	getAllMethod();

	var unused_method = list_reduce(method_all,method_used);
	if_method.updateEditorField(1, { type: 'select', maxlen: 15, options: option_convert(unused_method) } );

	verifyFields(null, 1);

	//console.log(method_all);
}

method.verifyDelete = function(data)
{
	//console.log('verifyDelete'+data);
	
	if(list_contain(method_used,data[0])){
		show_alert(ui.ddns_method_used);
		return 0;
	}else
		return 1;
}

method.verifyFields = function(row, quiet)
{
	var f = fields.getAll(row);
	var s;
	
	ferror.clearAll(f);

	if(f[0].value.length == 0) {
		ferror.set(f[0], "Method name can't be empty", quiet);
		return 0;
	}

	var this_name = f[0].value;
	var data = method.getAllData();
	for(var i = 0; i<data.length; i++){
		if(data[i][0] == this_name){
			ferror.set(f[0], ui.ddns_method_existed, quiet);
			return 0;
		}
	}

	

	if(f[2].value.length == 0) {
		ferror.set(f[2], "username can't be empty", quiet);
		return 0;
	}
	
	if(f[3].value.length == 0) {
		ferror.set(f[3], "password can't be empty", quiet);
		return 0;
	}

	if(f[4].value.length == 0) {
		ferror.set(f[4], "hostname can't be empty", quiet);
		return 0;
	}
	
	else if(!v_domain(f[4], 1)){
		ferror.set(f[4], "hostname must be domain name or valid ip address", quiet);
		return 0;
	}
	else if(f[4].value == '0.0.0.0'){
		ferror.set(f[4], "Invalid ip address!", quiet);
		return 0;
	}

	return 1;
}

method.setup = function() {
	this.init('method-grid', 'sort', 4, [
		{ type: 'text', maxlen: 15 }, 
		{ type: 'select', options: provider_options }, 
		{ type: 'text', maxlen: 64 }, 
		{ type: 'password', maxlen: 64 }, 
		{ type: 'text', maxlen: 64 }]);

	this.headerSet([ui.ddns_method_name,ui.ddns_server_type,ui.username,ui.password,ui.ddns_hostname]);
	
	for (var i = 0; i < method_config.length; i++) {
		this.insertData(-1, [method_config[i][0], method_config[i][1], method_config[i][2], 
							method_config[i][3], method_config[i][4]]);
	}
	//this.sort(0);
	this.showNewEditor();
	this.resetNewEditor();
	
	getAllMethod();

}

var if_method = new webGrid();
if_method.setup = function() {
	var meth_data = method.getAllData();
	
	this.init('if_method-grid', 'sort', now_vifs_options.length, [
			{ type: 'select', options: now_vifs_options }, 
			{ type: 'select', options: option_convert(method_all) }]);

	this.headerSet([ui.iface,ui.ddns_method]);
	
	for (var i = 0; i < if_method_config.length; i++) {
		this.insertData(-1, [if_method_config[i][0], if_method_config[i][1]]);
		grid_vif_opts_sub(now_vifs_options, if_method_config[i][0]);
	}
	
	getusedMethod();
	this.showNewEditor();
	this.resetNewEditor();
	if_method.safeUpdateEditorField(0, { type: 'select', maxlen: 15, options: now_vifs_options} );
}

if_method.safeUpdateEditorField = function(i, editorField) 
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
	if_method.updateEditorField(i, editorField);
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

if_method.resetNewEditor = function() {
	var f, c;
	getusedMethod();
	var unused_method = list_reduce(method_all,method_used);
	this.updateEditorField(1, { type: 'select', maxlen: 15, options: option_convert(unused_method) } );

}

var if_method_tmp = if_method.onClick;
if_method.onClick = function(cell){
	if (user_info.priv < admin_priv) {
		return;
	}
	
	if(method.isEditing())
		return;
	
	var q = PR(cell);
	var data = this.getAllData();
	var thisData = data[q.rowIndex -1];
	if_method.safeUpdateEditorField(0, { type: 'select', maxlen: 15, options: [[thisData[0], thisData[0]]]} );

	var now_method = PR(cell).childNodes[1].innerHTML;
	var unused_method = list_reduce(method_all,method_used);
	unused_method.push(now_method);
	//console.log('unused_method' + unused_method);//
	this.updateEditorField(1, { type: 'select', maxlen: 15, options: option_convert(unused_method) } );
	
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
}

if_method.onDataChanged = function() {
	if_method.safeUpdateEditorField(0, { type: 'select', maxlen: 15, options: now_vifs_options} );
		
	getusedMethod();
	var unused_method = list_reduce(method_all,method_used);
	this.updateEditorField(1, { type: 'select', maxlen: 15, options: option_convert(unused_method) } );
	verifyFields(null, 1);
}

if_method.verifyDelete = function(data) {
	grid_vif_opts_add(now_vifs_options, data[0]);
	return true;
}

if_method.verifyFields = function(row, quiet) {    
    var f = fields.getAll(row);
	grid_vif_opts_sub(now_vifs_options, f[0].value);
	return 1;
}

function verifyFields(focused, quiet)
{
	var ok = 1;
	var cmd = "";
	var fom = E('_fom');

	E('save-button').disabled = true;

	var data_found = 0;
	var data_changed = 0;

	/* verify for the method grid */
	var datam = method.getAllData();
	var mmethods = method_config;

	//delete the method from json which have been deleted from web
	for(var i = 0; i < mmethods.length; i++) {
		data_found = 0;
		data_changed = 0;

		for(var j = 0; j < datam.length; j++) {
			if(mmethods[i][0] == datam[j][0]) {
				data_found = 1;
				break;			
			}
		}
		if(!data_found) {
			cmd += "no ddns update method " + mmethods[i][0] + "\n";
		}
	}	

	//add the method into json which have been added or changed by the web
	for(var i = 0; i < datam.length; i++) {
		var provider;
		data_found = 0;
		data_changed = 0;

		if(datam[i][1] == '1') {
			provider = 'dynaccess';
	
		} else if(datam[i][1] == '2') {
			provider = 'qdns';
	
		} else if(datam[i][1] == '3') {
			provider = 'qdns-static';

		} else if(datam[i][1] == '4') {
			provider = 'dyndns';

		} else if(datam[i][1] == '5') {
			provider = 'dyndns-static';

		} else if(datam[i][1] == '6') {
			provider = 'noip';

		}

		for(var j = 0; j < mmethods.length; j++) {
			if(datam[i][0] == mmethods[j][0]) {
				data_found = 1;
				if((datam[i][1] != mmethods[j][1]) ||
					(datam[i][2] != mmethods[j][2]) ||
					(datam[i][3] != mmethods[j][3]) ||
					(datam[i][4] != mmethods[j][4])) {
					data_changed = 1;
				}
				break;
			}
		}
		
		if(!data_found || data_changed) {
			cmd += "!\n";
			cmd += "ddns update method "+datam[i][0]+"\n";
			if(datam[i][1] == '0') {	//disable provider
				cmd += "no provider\n";
			} else {
				cmd += "provider "+provider+"\n";
			}
			cmd += "username "+datam[i][2]+"\n";
			cmd += "password "+datam[i][3]+"\n";
			cmd += "hostname "+datam[i][4]+"\n";					
		}
	}

	/* verify for the if_method grid */
	var datai = if_method.getAllData();
	var mifmeths = if_method_config;

	//delete the if_method from json which have been deleted from web
	for(var i = 0; i < mifmeths.length; i++) {
		data_found = 0;
		data_changed = 0;

		for(var j = 0; j < datai.length; j++) {
			if(mifmeths[i][0] == datai[j][0]) {
				data_found = 1;
				break;			
			}
		}
		if(!data_found) {
			cmd += "!\n";
			cmd += "interface "+mifmeths[i][0] + "\n";
			cmd += "no ddns update\n";
		}
	}

	//add the if_method into json which have been added or changed by the web
	for(var i = 0; i < datai.length; i++) {
		var provider;
		data_found = 0;
		data_changed = 0;

		for(var j = 0; j < mifmeths.length; j++) {
			if(datai[i][0] == mifmeths[j][0]) {
				data_found = 1;
				if(datai[i][1] != mifmeths[j][1]) {
					data_changed = 1;
				}
				break;
			}
		}
		
		if(!data_found || data_changed) {
			cmd += "!\n";
			cmd += "interface "+datai[i][0]+"\n";
			cmd += "no ddns update "+"\n";
			cmd += "ddns update "+ datai[i][1]+"\n";
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
	if (method.isEditing()) return;
	if (if_method.isEditing()) return;

	var fom = E('_fom');

	if((E('_fom')._web_cmd.value != '')&&(cookie.get('autosave') == 1)){
		E('_fom')._web_cmd.value += "!"+"\n"+"copy running-config startup-config"+"\n";	
	}

	form.submit(fom, 1);
}

function earlyInit()
{
	method.setup();
	if_method.setup();
    
	verifyFields(null, true);
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

<div class='section-title' id='method-grid-title'>
<script type='text/javascript'>
W(ui.ddns_method_list);
</script>
</div>

<div class='section'>
	<table class='web-grid' id='method-grid'></table>
</div>

<div class='section-title' id='if_method-grid-title'>
<script type='text/javascript'>
W(ui.ddns_if_method);
</script>
</div>

<div class='section'>
	<table class='web-grid' id='if_method-grid'></table>
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

