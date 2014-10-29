<% pagehead(menu.setup_l2tpc) %>

<style type='text/css'>
#l2tpclass-grid {
	text-align: center;	
	width: 600px;
}

#l2tpclass-grid .co1 {
	width: 120px;
}
#l2tpclass-grid .co2 {
	width: 100px;
}

#pwclass-grid {
	text-align: center;	
	width: 600px;
}

#pwclass-grid .co1 {
	width: 120px;
}
#pwclass-grid .co2 {
	width: 120px;
}

#l2tpctunnel-grid {
	text-align: center;	
	width: 680px;
}

#l2tpctunnel-grid .co1 {
	width: 40px;
}
#l2tpctunnel-grid .co2 {
	width: 40px;
}
#l2tpctunnel-grid .co3 {
	width: 100px;
}
#l2tpctunnel-grid .co5 {
	width: 60px;
}
#l2tpctunnel-grid .co4, .co6, .co7 {
	width: 80px;
}
</style>

<script type='text/javascript'>

<% ih_sysinfo(); %>
<% ih_user_info(); %>

<% web_exec('show running-config l2tp'); %>

//l2tpclass_config = [['l2tpclass','0','test','123456']];
//pwclass_config = [['pwclass','l2tpclass','cellular 1']];
//l2tpc_config = [['1','1','1.1.1.1','pwclass','0','test','123456','','']];

<% web_exec('show interface')%>

//define option list
var vifs = [].concat(cellular_interface, eth_interface, sub_eth_interface, svi_interface, xdsl_interface, gre_interface);
var now_vifs_options = new Array();
now_vifs_options = grid_list_all_vif_opts(vifs);

var auth_type_list = [['0', 'Auto'],['1','PAP'],['2','CHAP']];

//define a web grid
var l2tpclasses = new webGrid();

l2tpclasses.exist = function(f, v)
{
	var data = this.getAllData();
	for (var i = 0; i < data.length; ++i) {
		if (data[i][f] == v) return true;
	}
	return false;
}

l2tpclasses.existName = function(name)
{
	return this.exist(0, name);
}

l2tpclasses.verifyFields = function(row, quiet) {
	var f = fields.getAll(row);

	ferror.clearAll(f);	
	//name
	if (f[0].value=='') {
		ferror.set(f[0], '', quiet);
		return 0;
	}
	return 1;
}

l2tpclasses.dataToView = function(data) {
	return [data[0],
	       (data[1] != '0') ? ui.yes : ui.no,
	       data[2],
	       data[3]==''?'':'******'];
}

l2tpclasses.fieldValuesToData = function(row) {
	var f = fields.getAll(row);
	return [f[0].value, f[1].checked ? 1 : 0, f[2].value, f[3].value];
}

l2tpclasses.onDataChanged = function() 
{
	verifyFields(null, 1);
}

l2tpclasses.resetNewEditor = function() {
	var f = fields.getAll(this.newEditor);

	ferror.clearAll(f);

	//init value
}

l2tpclasses.setup = function() {
	this.init('l2tpclass-grid', 'move', 10, [
		{ type: 'text', maxlen: 31 }, 
		{ type: 'checkbox' },
		{ type:'text', maxlen:63 },
		{ type:'password', maxlen:63 }]);
	
	this.headerSet([ui.nam,l2tpc.auth,l2tpc.hostname,l2tpc.challenge_secret]);

	for (var i = 0; i < l2tpclass_config.length; i++) {
		this.insertData(-1, [l2tpclass_config[i][0], l2tpclass_config[i][1],
					l2tpclass_config[i][2], l2tpclass_config[i][3]
					]);
	}
	
	this.showNewEditor();
	this.resetNewEditor();
	
}

var pwclasses = new webGrid();

pwclasses.exist = function(f, v)
{
	var data = this.getAllData();
	for (var i = 0; i < data.length; ++i) {
		if (data[i][f] == v) return true;
	}
	return false;
}

pwclasses.existName = function(name)
{
	return this.exist(0, name);
}

pwclasses.verifyFields = function(row, quiet) {
	var f = fields.getAll(row);

	ferror.clearAll(f);	
	//name
	if (f[0].value=='') {
		ferror.set(f[0], '', quiet);
		return 0;
	}
	return 1;
}

pwclasses.dataToView = function(data) {
	return [data[0],
	       data[1],
	       data[2]];
}

pwclasses.fieldValuesToData = function(row) {
	var f = fields.getAll(row);
	return [f[0].value, f[1].value, f[2].value];
}

pwclasses.onDataChanged = function() 
{
	verifyFields(null, 1);
}

pwclasses.resetNewEditor = function() {
	var f = fields.getAll(this.newEditor);

	ferror.clearAll(f);

	//init value
}

pwclasses.setup = function() {
	this.init('pwclass-grid', 'move', 10, [
		{ type: 'text', maxlen: 31 }, 
		{ type: 'text', maxlen: 31 }, 
		{ type: 'select', options: now_vifs_options }]);		
	
	this.headerSet([ui.nam,l2tpc.l2tpclass,l2tpc.src_if]);

	for (var i = 0; i < pwclass_config.length; i++) {
		this.insertData(-1, [pwclass_config[i][0], pwclass_config[i][1],
					pwclass_config[i][2]
					]);
	}
	
	this.showNewEditor();
	this.resetNewEditor();
	
}

var l2tpctunnels = new webGrid();

l2tpctunnels.exist = function(f, v)
{
	var data = this.getAllData();
	for (var i = 0; i < data.length; ++i) {
		if (data[i][f] == v) return true;
	}
	return false;
}

l2tpctunnels.existName = function(name)
{
	return this.exist(1, name);
}

l2tpctunnels.verifyFields = function(row, quiet) {
	var f = fields.getAll(row);

	ferror.clearAll(f);
	//index
	if(!v_info_num_range(f[1], quiet, false, 1, 10)) {
		return 0;
	}
	if (this.existName(f[1].value)) {
		ferror.set(f[1], errmsg.bad_name4, quiet);
		return 0;
	}
	//ip
	if(!v_info_ip(f[2], quiet, false)) {
		return 0;
	}	
	//pw class
	if (f[3].value=='') {
		ferror.set(f[3], '', quiet);
		return 0;
	}
	//username
	if (f[5].value=='') {
		ferror.set(f[5], '', quiet);
		return 0;
	}
	//password
	if (f[6].value=='') {
		ferror.set(f[6], '', quiet);
		return 0;
	}
	//local ip
	if (f[7].value!='' && !v_ip(f[7], 1)) {
		return 0;
	}
	//remote ip
	if (f[8].value!='' && !v_ip(f[8], 1)) {
		return 0;
	}
	return 1;
}

l2tpctunnels.dataToView = function(data) {
	return [(data[0] != '0') ? ui.yes : ui.no,
	       data[1],
	       data[2],
	       data[3],
	       auth_type_list[data[4]][1],
	       data[5],
	       data[6]==''?'':'******',
	       data[7],
	       data[8]];
}

l2tpctunnels.fieldValuesToData = function(row) {
	var f = fields.getAll(row);
	return [f[0].checked ? 1 : 0, f[1].value, f[2].value, f[3].value, f[4].value, f[5].value, f[6].value, f[7].value, f[8].value];
}

l2tpctunnels.onDataChanged = function() 
{
	verifyFields(null, 1);
}

l2tpctunnels.resetNewEditor = function() {
	var f = fields.getAll(this.newEditor);

	ferror.clearAll(f);

	//init value
	f[0].checked = 1;
	f[1].value = this.getAllData().length + 1;
}

l2tpctunnels.setup = function() {
	this.init('l2tpctunnel-grid', 'move', 10, [
		{ type: 'checkbox' },
		{ type: 'text', maxlen: 8 }, 
		{ type: 'text', maxlen: 15 }, 
		{ type: 'text', maxlen: 31 }, 
		{ type: 'select', options: auth_type_list }, 
		{ type: 'text', maxlen: 63 }, 
		{ type: 'password', maxlen: 63 }, 
		{ type: 'text', maxlen: 15 }, 
		{ type: 'text', maxlen: 15 }]); 
	
	this.headerSet([l2tpc.enable,l2tpc.tunnel_id,l2tpc.server,l2tpc.pwclass,ui.ppp_authen_type,l2tpc.username,l2tpc.passwd,l2tpc.localip,l2tpc.remoteip]);

	for (var i = 0; i < l2tpc_config.length; i++) {
		this.insertData(-1, [l2tpc_config[i][0], l2tpc_config[i][1],
					l2tpc_config[i][2], l2tpc_config[i][3],
					l2tpc_config[i][4], l2tpc_config[i][5],
					l2tpc_config[i][6], l2tpc_config[i][7],
					l2tpc_config[i][8]
					]);
	}
	
	this.showNewEditor();
	this.resetNewEditor();
	
}

function verifyFields(focused, quiet)
{
	var ok = 1;
	var cmd = "";
	var fom = E('_fom');

	E('save-button').disabled = true;

	// --- visibility ---	

	// --- generate cmd ---	
	var data = l2tpclasses.getAllData();
	// delete
	for(var i = 0; i < l2tpclass_config.length; i++) {
		var found = 0;
		for(var j = 0; j < data.length; j++) {
			if(data[j][0]==l2tpclass_config[i][0]) {//name
				found = 1;
				break;
			}
		}
		if(!found) {
			cmd += "no l2tp-class " + l2tpclass_config[i][0] + "\n";
		}
	}

	// add or change
	for(var i = 0; i < data.length; i++) {
		var found = 0;
		var changed = 0;
		for(var j = 0; j < l2tpclass_config.length; j++) {
			if(data[i][0]==l2tpclass_config[j][0]) {//name
				found = 1;
				if(data[i][1] != l2tpclass_config[j][1]
					|| data[i][2] != l2tpclass_config[j][2]
					|| data[i][3] != l2tpclass_config[j][3]) {
					changed = 1;
				}
				break;
			}
		}
		if(!found || changed) {
			cmd += "l2tp-class " + data[i][0] + "\n";
			if(data[i][1]!='0') {
				cmd += "authentication\n";
			} else {
				cmd += "no authentication\n";
			}
			if(data[i][2]!='') {
    				cmd += "hostname " + data[i][2] + "\n";
			} else {
    				cmd += "no hostname\n";
			}
			if(data[i][3]!='') {
    				cmd += "password " + data[i][3] + "\n";
			} else {
    				cmd += "no password\n";
			}
			cmd += "!\n";			
		}
	}

	var data = pwclasses.getAllData();
	// delete
	for(var i = 0; i < pwclass_config.length; i++) {
		var found = 0;
		for(var j = 0; j < data.length; j++) {
			if(data[j][0]==pwclass_config[i][0]) {//name
				found = 1;
				break;
			}
		}
		if(!found) {
			cmd += "no pseudowire-class " + pwclass_config[i][0] + "\n";
		}
	}

	// add or change
	for(var i = 0; i < data.length; i++) {
		var found = 0;
		var changed = 0;
		for(var j = 0; j < pwclass_config.length; j++) {
			if(data[i][0]==pwclass_config[j][0]) {//name
				found = 1;
				if(data[i][1] != pwclass_config[j][1]
					|| data[i][2] != pwclass_config[j][2]) {
					changed = 1;
				}
				break;
			}
		}
		if(!found || changed) {
			cmd += "pseudowire-class " + data[i][0] + "\n";
			if(data[i][1]!='') {
				cmd += "protocol l2tpv2 " + data[i][1] + "\n";
			} else {
				cmd += "no protocol\n";
			}
			if(data[i][2]!='') {
    				cmd += "ip local interface " + data[i][2] + "\n";
			} else {
    				cmd += "no ip local\n";
			}
			cmd += "!\n";			
		}
	}

	var data = l2tpctunnels.getAllData();
	// delete
	for(var i = 0; i < l2tpc_config.length; i++) {
		var found = 0;
		for(var j = 0; j < data.length; j++) {
			if(data[j][1]==l2tpc_config[i][1]) {//id
				found = 1;
				break;
			}
		}
		if(!found) {
			cmd += "no interface virtual-ppp " + l2tpc_config[i][1] + "\n";
		}
	}

	// add or change
	for(var i = 0; i < data.length; i++) {
		var found = 0;
		var changed = 0;
		for(var j = 0; j < l2tpc_config.length; j++) {
			if(data[i][1]==l2tpc_config[j][1]) {//id
				found = 1;
				if(data[i][0] != l2tpc_config[j][0]
					|| data[i][2] != l2tpc_config[j][2]
					|| data[i][3] != l2tpc_config[j][3]
					|| data[i][4] != l2tpc_config[j][4]
					|| data[i][5] != l2tpc_config[j][5]
					|| data[i][6] != l2tpc_config[j][6]
					|| data[i][7] != l2tpc_config[j][7]
					|| data[i][8] != l2tpc_config[j][8]) {
					changed = 1;
				}
				break;
			}
		}
		if(!found || changed) {
			var auth_type = [['0', 'auto'],['1', 'pap'],['2', 'chap']];
			cmd += "interface virtual-ppp " + data[i][1] + "\n";
			if(data[i][0]=='1') {
    				cmd += "no shutdown\n";
			} else {
    				cmd += "shutdown\n";
			}
			cmd += "pseudowire " + data[i][2] + " " + data[i][1] + " pw-class " + data[i][3] +"\n";
			cmd += "ppp authentication " + auth_type[data[i][4]][1] + " " + data[i][5] + " " + data[i][6] +"\n";
			if(data[i][7]!='' && data[i][8]!='') {
    				cmd += "ip address static local " + data[i][7] + " peer " + data[i][8] + "\n";
			} else if(data[i][7]!='') {
    				cmd += "ip address static local " + data[i][7] + "\n";
			} else if(data[i][8]!='') {
    				cmd += "ip address static peer " + data[i][8] + "\n";
			} else {
    				cmd += "ip address negotiated\n";
			}
			cmd += "!\n";			
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
	
	return ok;
}

function save()
{
	if (l2tpclasses.isEditing()) return;
	if (pwclasses.isEditing()) return;
	if (l2tpctunnels.isEditing()) return;

	var fom = E('_fom');

	if((E('_fom')._web_cmd.value != '')&&(cookie.get('autosave') == 1)){
		E('_fom')._web_cmd.value += "!"+"\n"+"copy running-config startup-config"+"\n";	
	}

	form.submit(fom, 1);
}

function earlyInit()
{
	l2tpclasses.setup();
	pwclasses.setup();
	l2tpctunnels.setup();
	verifyFields(null, 1);
}

function init()
{
	if((cookie.get('autosave')) == null){
		cookie.set('autosave', 1);
	}
	l2tpclasses.recolor();
	pwclasses.recolor();
	l2tpctunnels.recolor();
}
</script>
</head>

<body onload='init()'>
<form id='_fom' method='post' action='apply.cgi'>
<input type='hidden' name='_web_cmd' value=''>

<div class='section-title'>
<script type='text/javascript'>
	GetText(l2tpc.l2tpclass);
</script>
</div>
<div class='section'>
	<table class='web-grid' id='l2tpclass-grid'></table>
</div>

<div class='section-title'>
<script type='text/javascript'>
	GetText(l2tpc.pwclass);
</script>
</div>
<div class='section'>
	<table class='web-grid' id='pwclass-grid'></table>
</div>

<div class='section-title'>
<script type='text/javascript'>
	GetText(l2tpc.tunnel);
</script>
</div>
<div class='section'>
	<table class='web-grid' id='l2tpctunnel-grid'></table>
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


