<% pagehead(menu.setup_ldap) %>

<style type='text/css'>
#aaa-grid {
	text-align: center;	
	width: 700px;
}

#aaa-grid .co1 {
	width: 80px;
}
#aaa-grid .co2 {
	width: 100px;
}
#aaa-grid .co3 {
	width: 50px;
}
#aaa-grid .co6 {
	width: 100px;
}
#aaa-grid .co7 {
	width: 60px;
}
#aaa-grid .co8 {
	width: 60px;
}
</style>

<script type='text/javascript'>

<% ih_sysinfo(); %>
<% ih_user_info(); %>

<% web_exec('show running-config aaa'); %>

//ldap_server = [['Server1','2.2.2.2','389','dc=example,dc=com','cn=admin,dc=example,dc=com','secret','0','0'],['Server2','2.2.2.3','389','dc=example,dc=com','','','1','0']];

var secure_type_list = [['0', 'None'],['1','SSL'],['2','StartTLS']];

//define a web grid
var aaaentrys = new webGrid();

aaaentrys.exist = function(f, v)
{
	var data = this.getAllData();
	for (var i = 0; i < data.length; ++i) {
		if (data[i][f] == v) return true;
	}
	return false;
}

aaaentrys.existName = function(name)
{
	return this.exist(0, name);
}

aaaentrys.verifyFields = function(row, quiet) {
	if (quiet) return 1;
	
	var f = fields.getAll(row);
	//name
	if (f[0].value=='') {
		ferror.set(f[0], '', quiet);
		return 0;
	}	
	if (this.existName(f[0].value)) {
		ferror.set(f[0], errmsg.bad_name4, quiet);
		return 0;
	}
	//ip
	if (f[1].value=='' || !v_ip(f[1], 1)) {
		ferror.set(f[1], '', quiet);
		return 0;
	}
	//port
	if (f[2].value!='' && !v_range(f[2], 1, 1, 65535)) {
		ferror.set(f[2], '', quiet);
		return 0;
	}
	//base dn
	if (f[3].value=='') {
		ferror.set(f[3], '', quiet);
		return 0;
	}	
	//username & password
	if (f[4].value!='' && f[5].value=='') {
		ferror.set(f[5], '', quiet);
		return 0;
	}	
	return 1;
}

aaaentrys.dataToView = function(data) {
	return [data[0],
	       data[1],
	       data[2],
	       data[3],
	       data[4],
	       data[5]?'******':'',
	       secure_type_list[data[6]][1],
	       (data[7] != '0') ? ui.yes : ui.no];
}

aaaentrys.fieldValuesToData = function(row) {
	var f = fields.getAll(row);
	return [f[0].value, f[1].value, f[2].value, f[3].value, f[4].value, f[5].value, f[6].value, f[7].checked ? 1 : 0]; 
}

aaaentrys.onDataChanged = function() 
{
	verifyFields(null, 1);
}

aaaentrys.resetNewEditor = function() {
	var f = fields.getAll(this.newEditor);

	ferror.clearAll(f);

	//init value
	f[0].value = '';
	f[1].value = '';
	f[2].value = '';
	f[3].value = '';
	f[4].value = '';
	f[5].value = '';
	f[6].value = '0';
}

aaaentrys.setup = function() {
	this.init('aaa-grid', 'move', 10, [
		{ type: 'text', maxlen: 64 },
		{ type: 'text', maxlen: 64 }, 
		{ type: 'text', maxlen: 5 }, 
		{ type: 'text', maxlen: 64 }, 
		{ type: 'text', maxlen: 64 }, 
		{ type: 'password', maxlen:64 },
		{ type: 'select', options: secure_type_list },		
		{ type: 'checkbox' }]);		
	
	
	this.headerSet([ui.nam, ui.aaa_server, ui.aaa_port, ui.aaa_basedn, ui.username, ui.password, ui.aaa_secure, ui.aaa_neg]);

	for (var i = 0; i < ldap_server.length; i++) {
		this.insertData(-1, [ldap_server[i][0],ldap_server[i][1],
					ldap_server[i][2],ldap_server[i][3],
					ldap_server[i][4],ldap_server[i][5],
					ldap_server[i][6],ldap_server[i][7]
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
	var data = aaaentrys.getAllData();
	// delete
	for(var i = 0; i < ldap_server.length; i++) {
		var found = 0;
		for(var j = 0; j < data.length; j++) {
			if(data[j][0]==ldap_server[i][0]) {	//name
				found = 1;
				break;
			}
		}
		if(!found) {
			cmd += "no ldap server " + ldap_server[i][0] + "\n";
		}
	}

	// add or change
	for(var i = 0; i < data.length; i++) {
		var found = 0;
		var changed = 0;
		for(var j = 0; j < ldap_server.length; j++) {
			if(data[i][0]==ldap_server[j][0]) {	//name
				found = 1;
				if(data[i][1] != ldap_server[j][1]
					|| data[i][2] != ldap_server[j][2]
					|| data[i][3] != ldap_server[j][3]
					|| data[i][4] != ldap_server[j][4]
					|| data[i][5] != ldap_server[j][5]
					|| data[i][6] != ldap_server[j][6]
					|| data[i][7] != ldap_server[j][7]) {
					changed = 1;
				}
				break;
			}
		}
		if(!found || changed) {
			cmd += "ldap server " + data[i][0] + "\n";
			cmd += "ipv4 " + data[i][1] + "\n";
			if(data[i][2]!='') {
				cmd += "transport port " + data[i][2] + "\n";
			} else {
				cmd += "no transport port\n";
			}
			cmd += "base-dn " + data[i][3] + "\n";
			if(data[i][4]!='') {
				cmd += "bind authenticate root-dn " + data[i][4] + " password " + data[i][5] + "\n";
			} else {
				cmd += "no bind authenticate\n";
			}
			if(data[i][6]=='2') {
				cmd += "mode secure starttls";
				if(data[i][7]=='1') {
					cmd += "\n";
				} else {
					cmd += " no-negotiation\n";
				}
			} else if(data[i][6]=='1') {
				cmd += "mode secure ssl";
				if(data[i][7]=='1') {
					cmd += "\n";
				} else {
					cmd += " no-negotiation\n";
				}
			} else {
				cmd += "no mode secure\n";
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
	if (aaaentrys.isEditing()) return;

	var fom = E('_fom');

	if((E('_fom')._web_cmd.value != '')&&(cookie.get('autosave') == 1)){
		E('_fom')._web_cmd.value += "!"+"\n"+"copy running-config startup-config"+"\n";	
	}

	form.submit(fom, 1);
}

function earlyInit()
{
	aaaentrys.setup();
	verifyFields(null, 1);
}

function init()
{
	if((cookie.get('autosave')) == null){
		cookie.set('autosave', 1);
	}
	aaaentrys.recolor();
}
</script>
</head>

<body onload='init()'>
<form id='_fom' method='post' action='apply.cgi'>
<input type='hidden' name='_web_cmd' value=''>

<div class='section-title'>
<script type='text/javascript'>
	GetText(ui.aaa_server_list);
</script>
</div>
<div class='section'>
	<table class='web-grid' id='aaa-grid'></table>
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

