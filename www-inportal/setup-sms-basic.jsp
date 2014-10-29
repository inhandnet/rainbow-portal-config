<% pagehead(menu.setup_sms_basic) %>

<style type='text/css'>
#smsacl-grid {
	text-align: center;	
	width: 500px;
}

#smsacl-grid .co1 {
	width: 80px;
}
#smsacl-grid .co2 {
	width: 140px;
}
</style>

<script type='text/javascript'>

<% ih_sysinfo(); %>
<% ih_user_info(); %>

<% web_exec('show running-config cellular'); %>

/*
sms_config = {
        enable: '1',
        mode: '1',
        interval: '120',
        sms_acl:[['1','0','13900010001']]
};
*/

var sms_config = cellular1_config.sms_config;
//define option list
acl_action_list = [['0',ui.deny],['1',ui.permit]];
sms_mode_list = [['0','PDU'],['1','TEXT']];

//define a web grid
var smsacls = new webGrid();

smsacls.exist = function(f, v)
{
	var data = this.getAllData();
	for (var i = 0; i < data.length; ++i) {
		if (data[i][f] == v) return true;
	}
	return false;
}

smsacls.existName = function(name)
{
	return this.exist(0, name);
}

smsacls.verifyFields = function(row, quiet) {
	var f = fields.getAll(row);

	ferror.clearAll(f);
	//id
	if(!v_info_num_range(f[0], quiet, 0, 1, 10)) {
		return 0;
	}
	if (this.existName(f[0].value)) {
		ferror.set(f[0], errmsg.bad_name4, quiet);
		return 0;
	}
	if (f[2].value=='') {
		ferror.set(f[2], '', quiet);
		return 0;
	}
	return 1;
}

smsacls.dataToView = function(data) {
	return [data[0],
	       acl_action_list[data[1]][1],
	       data[2]];
}

smsacls.fieldValuesToData = function(row) {
	var f = fields.getAll(row);
	return [f[0].value, f[1].value, f[2].value]; 
}

smsacls.onDataChanged = function() 
{
	verifyFields(null, 1);
}

smsacls.resetNewEditor = function() {
	var f = fields.getAll(this.newEditor);

	ferror.clearAll(f);

	//init value
	f[0].value = this.getAllData().length + 1;	
	f[1].value = '1';
	f[2].value = '';
}

smsacls.setup = function() {
	this.init('smsacl-grid', 'move', 10, [
		{ type: 'text', maxlen: 15 },
		{ type: 'select', options: acl_action_list },
		{ type: 'text', maxlen:20 }]);
	
	this.headerSet([ui.id, ui.acl_action, sms.phonenum]);

	var sms_acl = sms_config.sms_acl;	
	for (var i = 0; i < sms_acl.length; i++) {
		this.insertData(-1, [sms_acl[i][0], sms_acl[i][1],
					sms_acl[i][2]
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
	var acl_action = [['0','deny'],['1','permit']];
	var sms_mode = [['0','pdu'],['1','text']];

	E('save-button').disabled = true;

	var sms_acl = sms_config.sms_acl;	
	var enable = E('_f_sms_enable').checked;
	var mode = E('_sms_mode').value;
	var interval = E('_sms_interval').value;
	
	// --- visibility ---	
	elem.display_and_enable(('_sms_mode'), ('_sms_interval'), enable);

	// --- generate cmd ---
	if(sms_config.enable!=enable) {
		if(enable) {
			cmd += "cellular 1 sms enable\n";
		} else {
			cmd += "no cellular 1 sms enable\n";
		}
	}
	if(enable) {
		//TODO: verify

		if(sms_config.mode!=mode) {
			cmd += "cellular 1 sms mode " + sms_mode[mode][1] + "\n";
		}
		if(!v_info_num_range(E('_sms_interval'), quiet, 0, 0, 3600)) {
			return 0;
		}
		if(sms_config.interval!=interval) {
			cmd += "cellular 1 sms interval " + interval + "\n";
		}
	}

	var data = smsacls.getAllData();
	// delete
	for(var i = 0; i < sms_acl.length; i++) {
		var found = 0;
		for(var j = 0; j < data.length; j++) {
			if(data[j][0]==sms_acl[i][0]) {//id
				found = 1;
				break;
			}
		}
		if(!found) {
			cmd += "no cellular 1 sms access-list " + sms_acl[i][0] + "\n";
		}
	}

	// add or change
	for(var i = 0; i < data.length; i++) {
		var found = 0;
		var changed = 0;
		for(var j = 0; j < sms_acl.length; j++) {
			if(data[i][0]==sms_acl[j][0]) {//id 
				found = 1;
				if(data[i][1] != sms_acl[j][1]
				  || data[i][2] != sms_acl[j][2]) {
					changed = 1;
				}
				break;
			}
		}
		if(!found || changed) {
			cmd += "cellular 1 sms access-list " + data[i][0] + " " + acl_action[data[i][1]][1] + " " + data[i][2] + "\n";
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
	if (smsacls.isEditing()) return;

	var fom = E('_fom');

	if((E('_fom')._web_cmd.value != '')&&(cookie.get('autosave') == 1)){
		E('_fom')._web_cmd.value += "!"+"\n"+"copy running-config startup-config"+"\n";	
	}

	form.submit(fom, 1);
}

function earlyInit()
{
	smsacls.setup();
	verifyFields(null, 1);
}

function init()
{
	if((cookie.get('autosave')) == null){
		cookie.set('autosave', 1);
	}
	smsacls.recolor();
}
</script>
</head>

<body onload='init()'>
<form id='_fom' method='post' action='apply.cgi'>
<input type='hidden' name='_web_cmd' value=''>

<div class='section'>
<script type='text/javascript'>

createFieldTable('', [
	{ title: ui.enable, name: 'f_sms_enable', type: 'checkbox', value: sms_config.enable=='1'},
	{ title: sms.mode, name: 'sms_mode', type: 'select', options: sms_mode_list, value: sms_config.mode},
	{ title: sms.interval, name: 'sms_interval', type: 'text', maxlen: 5, size: 7, suffix: ui.seconds + infomsg.disable_msg, value: sms_config.interval }	
]);
</script>
</div>

<div class='section-title'>
<script type='text/javascript'>
	GetText(sms.acl);
</script>
</div>
<div class='section'>
	<table class='web-grid' id='smsacl-grid'></table>
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

