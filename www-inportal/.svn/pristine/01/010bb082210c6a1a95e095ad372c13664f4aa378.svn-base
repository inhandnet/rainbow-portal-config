<% pagehead(menu.setup_dyn_rib) %>

<style type='text/css'>
#acl-grid {
	text-align: center;
	width: 450px;
}

#acl-grid .co1{
	width: 100px;
}
#acl-grid .co2{
	width: 80px;
}
#acl-grid .co3 {
	width: 30px;
}
#acl-grid .co4 {
	width: 120px;
}
#acl-grid .co5 {
	width: 120px;
}

#prefix-grid {
	text-align: center;
	width: 710px;
}
#prefix-grid .co1{
	width: 100px;
} 
#prefix-grid .co2{
	width: 80px;
}
#prefix-grid .co3 {
	width: 80px;
}
#prefix-grid .co4 {
	width: 50px;
}
#prefix-grid .co5 {
	width: 100px;
}
#prefix-grid .co6 {
	width: 100px;
}
#prefix-grid .co7 {
	width: 100px;
}
#prefix-grid .co8 {
	width: 100px;
}
/*
#key-grid {
	text-align: center;
	width: 380px;
}
#key-grid .co1{
	width: 150px;
} 
#key-grid .co2{
	width: 80px;
}
#key-grid .co3 {
	width: 150px;
}
*/
</style>

<script type='text/javascript'>

<% ih_sysinfo(); %>
<% ih_user_info(); %>

/*quagga_config = [ 
[['acl-name1','1','1','',''], ['acl-name2','2','0','1.1.1.1','255.255.0.0']],   
[['prefix-name1','7','1','1','','','',''], ['prefix-name2','','2','0','1.1.1.1','255.255.0.0','17','18']],
[['key-chain-name', '6', 'key-string6'],['key-chain-name', '2', 'key-string2']]
];*/
<% web_exec('show running-config quagga'); %>

var filter_mode = [['1', 'permit'],
			['2', 'deny']];

var acl_json=quagga_config[1];
var prefix_json=quagga_config[0];
//var key_json=quagga_config[2];

var acl = new webGrid();
acl.exist = function(f, v)
{
	var data = this.getAllData();
	for (var i = 0; i < data.length; ++i) {
		if (data[i][f] == v) return true;
	}
	return false;
}
acl.existName = function(name)
{
	return this.exist(0, name);
}
acl.verifyFields = function(row, quiet) 
{
	var f = fields.getAll(row);
	ferror.clearAll(f);
	if(this.existName(f[0].value)) {
		ferror.set(f[0], errmsg.bad_addr2, quiet);
		return 0;
	} else if(f[0].value.length == 0) {
		ferror.set(f[0], errmsg.adm3, quiet);
		return 0;
	} else {
		ferror.clear(f[0]);
	}
	if(f[2].checked == '1'){
		f[3].disabled = true;
		f[4].disabled = true;
	}else {
		f[3].disabled = false;
		f[4].disabled = false;
		if( !v_ip(f[3],quiet) ) return 0;
		if( !v_netmask(f[4],quiet) ) return 0;
	}	
	return 1;
}
acl.dataToView = function(data) 
{	
	return [data[0], filter_mode[data[1]-1][1], (data[2] != '0') ? ui.yes : ui.no, data[3], data[4]];   
}
acl.fieldValuesToData = function(row) 
{
	var f = fields.getAll(row);
	return [f[0].value, f[1].value, f[2].checked ? 1 : 0, f[3].value, f[4].value];
}

acl.resetNewEditor = function() 
{
	var f, c;
	f = fields.getAll(this.newEditor);
	ferror.clearAll(f);
	
	f[0].value = '';
	f[1].value = '';
	f[2].value = '';
	f[3].value = '';
	f[4].value = '';
}

acl.setup = function() {
	this.init('acl-grid', 'move', 64, [
		{ type: 'text', maxlen: 32 },
		{ type: 'select', options: filter_mode},
		{ type: 'checkbox' },
		{ type: 'text', maxlen:16},
		{ type: 'text', maxlen:16}]);
	this.headerSet([rip.acl, rip.filter_type, rip.any, ui.ip, ui.netmask]);
	
	for (var i = 0; i < acl_json.length; ++i) {
		this.insertData(-1, [acl_json[i][0], acl_json[i][1], acl_json[i][2], acl_json[i][3],acl_json[i][4]]);
	}

	this.showNewEditor();
	this.resetNewEditor();
}
acl.onDataChanged = function() 
{
	verifyFields(null, true);
}


var prefix = new webGrid();
prefix.exist = function(f, v)
{
	var data = this.getAllData();
	for (var i = 0; i < data.length; ++i) {
		if (data[i][f] == v) return true;
	}
	return false;
}
prefix.existName = function(name)
{
	return this.exist(0, name);
}
prefix.verifyFields = function(row, quiet) 
{
	var f = fields.getAll(row);
	ferror.clearAll(f);
	if(this.existName(f[0].value)) {
		ferror.set(f[0], errmsg.bad_addr2, quiet);
		return 0;
	}else if(f[0].value.length == 0) {
		ferror.set(f[0], errmsg.adm3, quiet);
		return 0;
	} else {
		ferror.clear(f[0]);
	}
	if( f[1].value != ''){
		if(!v_range(f[1],quiet,1,4284967695)) return 0;
	}
	if(f[3].checked == '1'){
		f[4].disabled = true;
		f[5].disabled = true;
		f[6].disabled = true;
		f[7].disabled = true;
	}else {
		f[4].disabled = false;
		f[5].disabled = false;
		f[6].disabled = false;
		f[7].disabled = false;
		if( !v_ip(f[4],quiet) ) return 0;
		if( !v_netmask(f[5],quiet) ) return 0;
	
		if(f[6].value != ''){
			if(!v_range(f[6],quiet,0,32)) return 0;
		}
		if(f[7].value != ''){
			if(!v_range(f[7],quiet,0,32)) return 0;
		}
	}
	return 1;
}
prefix.dataToView = function(data) 
{	
	 return [data[0], data[1], filter_mode[data[2]-1][1], (data[3] != '0') ? ui.yes : ui.no, data[4], data[5], data[6], data[7]];   
}
prefix.fieldValuesToData = function(row) 
{
	var f = fields.getAll(row);
	return [f[0].value, f[1].value, f[2].value, f[3].checked ? 1 : 0, f[4].value, f[5].value, f[6].value, f[7].value];
}
prefix.resetNewEditor = function() 
{
	var f, c;
	f = fields.getAll(this.newEditor);
	ferror.clearAll(f);
	f[0].value = '';
	f[1].value = '';
	f[2].value = '';
	f[3].value = '';
	f[4].value = '';
	f[5].value = '';
	f[6].value = '';
	f[7].value = '';
}
prefix.setup = function() {
	this.init('prefix-grid', 'move', 64, [
		{ type: 'text', maxlen: 32 },
		{ type: 'text', maxlen: 32 },
		{ type: 'select', options: filter_mode},
		{ type: 'checkbox' },
		{ type: 'text', maxlen:16},
		{ type: 'text', maxlen:16},
		{ type: 'text', maxlen:16},
		{ type: 'text', maxlen:16}]);

	this.headerSet([rip.prefix, rip.seq, rip.filter_type, rip.any, ui.ip, ui.netmask, rip.ge, rip.le]);
    
	for (var i = 0; i < prefix_json.length; ++i) {
		this.insertData(-1, [prefix_json[i][0], prefix_json[i][1], prefix_json[i][2], prefix_json[i][3],prefix_json[i][4],prefix_json[i][5],prefix_json[i][6],prefix_json[i][7]]);
	}

	this.showNewEditor();
	this.resetNewEditor();
}
prefix.onDataChanged = function() {
	verifyFields(null, true);
}

/*
var key = new webGrid();
key.exist = function(f, v)
{
	var data = this.getAllData();
	for (var i = 0; i < data.length; ++i) {
		if (data[i][f] == v) return true;
	}
	return false;
}
key.existName = function(name)
{
	return this.exist(0, name);
}
key.verifyFields = function(row, quiet) 
{
	var f = fields.getAll(row);
	ferror.clearAll(f);
	if(this.existName(f[0].value)) {
		ferror.set(f[0], errmsg.bad_addr2, quiet);
		return 0;
	} else {
		ferror.clear(f[0]);
	}
	if(!v_range(f[1],quiet,1,2147483647)) return 0;	
	if(this.existName(f[2].value)) {
		ferror.set(f[2], errmsg.bad_addr2, quiet);
		return 0;
	} else {
		ferror.clear(f[2]);
	}
	return 1;
}

key.dataToView = function(data) 
{	
	 return [data[0], data[1], (data[2] != '') ? '******' : ''];   
}
key.fieldValuesToData = function(row) 
{
	var f = fields.getAll(row);
	return [f[0].value, f[1].value, f[2].value];
}
key.resetNewEditor = function() 
{
	var f = fields.getAll(this.newEditor);
	f[0].value = '';
	f[1].value = '';
	f[2].value = '';	
	ferror.clearAll(fields.getAll(this.newEditor));
}
key.setup = function() {
	this.init('key-grid', 'move', 64, [
		{ type: 'text', maxlen: 32 },
		{ type: 'text', maxlen: 32 },
		{ type: 'password', maxlen: 32 }]);

	this.headerSet([rip.key_chain, rip.key_id, rip.key_string]);
	for (var i = 0; i < key_json.length; ++i) {
		this.insertData(-1, [key_json[i][0], key_json[i][1], key_json[i][2]]);
	}

	this.showNewEditor();
	this.resetNewEditor();
}

key.onDataChanged = function() 
{
	verifyFields(null, true);
}
*/
function verifyFields(focused, quiet)
{
	var cmd = '';
	var fom = E('_fom');	
	E('save-button').disabled = true;
	var acl_data = acl.getAllData();
	// delete
	for(var i = 0; i < acl_json.length; i++) {
		var found = 0;
		for(var j = 0; j < acl_data.length; j++) {
			if((acl_json[i][0] == acl_data[j][0])){
				found = 1;
				break;
			}
		}
		if(!found) {
			cmd += "no ip access-list " + acl_json[i][0] + " " + filter_mode[acl_json[i][1]-1][1]+ " ";
			if(acl_json[i][2] == '0'){
				cmd += acl_json[i][3]+ " " + acl_json[i][4] +"\n";
			}else {
				cmd += "any\n";
			}
		}
	}
	//add
	for(var i = 0; i < acl_data.length; i++) {
		var found = 0;
		var changed = 0;
		for(var j = 0; j < acl_json.length; j++) {
			if(acl_data[i][0]==acl_json[j][0]) {//id
				found = 1;
				if(acl_data[i][1] != acl_json[j][1]
					|| acl_data[i][2] != acl_json[j][2]
					|| acl_data[i][3] != acl_json[j][3]
					|| acl_data[i][4] != acl_json[j][4]) {
					changed = 1;
				}
				break;
			}
		}

		if(changed) {
			cmd += "no ip access-list " + acl_json[i][0] + " " + filter_mode[acl_json[i][1]-1][1]+ " ";
			if(acl_json[i][2] == '0'){
				cmd += acl_json[i][3]+ " " + acl_json[i][4] +"\n";
			} else {
				cmd += "any\n";
			}

			cmd += "ip access-list " + acl_data[i][0] + " " + filter_mode[acl_data[i][1]-1][1]+ " ";
			if(acl_data[i][2] == '0'){
				cmd += acl_data[i][3]+ " " + acl_data[i][4] +"\n";
			} else {
				cmd += "any\n";
			}
		} else if (found && !changed) {
			;
		} else {
			cmd += "ip access-list " + acl_data[i][0] + " " + filter_mode[acl_data[i][1]-1][1]+ " ";
			if(acl_data[i][2] == '0'){
				cmd += acl_data[i][3]+ " " + acl_data[i][4] +"\n";
			} else {
				cmd += "any\n";
			}
		}
	}

	var prefix_data = prefix.getAllData();
	// delete
	for(var i = 0; i < prefix_json.length; i++) {
		var found = 0;
		for(var j = 0; j < prefix_data.length; j++) {
			if((prefix_json[i][0] == prefix_data[j][0])){
				found = 1;
				break;
			}
		}
		if(!found) {
			cmd += "no ip prefix-list " + prefix_json[i][0]+ " ";	
			if(prefix_json[i][1]){
				cmd += "seq " + prefix_json[i][1] + " ";
			}
			cmd += filter_mode[prefix_json[i][2]-1][1]+ " ";
			if(prefix_json[i][3] == '0'){
				cmd += prefix_json[i][4]+ " " + prefix_json[i][5];
				if(prefix_json[i][6]){
					cmd += " ge "+ prefix_json[i][6]+ " le " + prefix_json[i][7];
				}
				cmd += "\n";
			}else {
				cmd += "any\n";
			}
		}
	}
	//add
	for(var i = 0; i < prefix_data.length; i++) {
		var found = 0;
		var changed = 0;
		for(var j = 0; j < prefix_json.length; j++) {
			if(prefix_data[i][0]==prefix_json[j][0]) {//id
				found = 1;
				if(prefix_data[i][1] != prefix_json[j][1]
					|| prefix_data[i][2] != prefix_json[j][2]
					|| prefix_data[i][3] != prefix_json[j][3]
					|| prefix_data[i][4] != prefix_json[j][4]
					|| prefix_data[i][5] != prefix_json[j][5]
					|| prefix_data[i][6] != prefix_json[j][6]
					|| prefix_data[i][7] != prefix_json[j][7]) {
					changed = 1;
				}
				break;
			}
		}
		if(!found || changed) {
			cmd += "ip prefix-list " + prefix_data[i][0]+ " ";	
			if(prefix_data[i][1]){
				cmd += "seq " + prefix_data[i][1] + " ";
			}
			cmd += filter_mode[prefix_data[i][2]-1][1]+ " ";
			if(prefix_data[i][3] == '0'){
				cmd += prefix_data[i][4]+ " " + prefix_data[i][5];
				if(prefix_data[i][6]){
					cmd += "  ge "+ prefix_data[i][6]+ " le " + prefix_data[i][7];
				}
				cmd += "\n";
			}else {
				cmd += "any\n";
			}
		}
	}
/*
	var key_data = key.getAllData();
	// delete
	for(var i = 0; i < key_json.length; i++) {
		var found = 0;
		for(var j = 0; j < key_data.length; j++) {
			if((key_json[i][0] == key_data[j][0]) && 
				(key_json[i][1] == key_data[j][1])){
				found = 1;
				break;
			}
		}
		if(!found) {
			cmd += "";
		}
	}
	//add
	for(var i = 0; i < key_data.length; i++) {
		var found = 0;
		var changed = 0;
		for(var j = 0; j < key_json.length; j++) {
			if(key_data[i][0]==key_json[j][0] &&
				key_data[i][1]==key_json[j][1]) {//id
				found = 1;
				if(key_data[i][2] != key_json[j][2]) {
					changed = 1;
				}
				break;
			}
		}
		if(!found || changed) {
			cmd += "";	
		}
	}
*/
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
	if (acl.isEditing()) return;
	if (prefix.isEditing()) return;
	//if (key.isEditing()) return;

	var fom = E('_fom');

	if((E('_fom')._web_cmd.value != '')&&(cookie.get('autosave') == 1)){
		E('_fom')._web_cmd.value += "!"+"\n"+"copy running-config startup-config"+"\n";	
	}

	form.submit(fom, 1);
}

function earlyInit()
{
	acl.setup();
	prefix.setup();
	//key.setup();
	verifyFields(null, true);
}

function init()
{
	if((cookie.get('autosave')) == null){
		cookie.set('autosave', 1);
	}
	acl.recolor();
	prefix.recolor();
	//key.recolor();
}
</script>
</head>
<body onload='init()'>
<form id='_fom' method='post' action='apply.cgi'>
<input type='hidden' name='_web_cmd' value=''>

<div id='acl_title' class='section-title'>
<script type="text/javascript">
	GetText(ui.acl_list);
</script>
</div>
<div class='section'>
	<table class='web-grid' id='acl-grid'></table>
</div>

<div id='prefix_title' class='section-title'>
<script type="text/javascript">
	GetText(rip.ip_prefix);
</script>
</div>
<div class='section'>
	<table class='web-grid' id='prefix-grid'></table>
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


