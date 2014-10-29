<% pagehead(menu.setup_radius) %>

<style type='text/css'>
#aaa-grid {
	text-align: center;	
	width: 550px;
}

#aaa-grid .co1 {
	width: 200px;
}
#aaa-grid .co2 {
	width: 100px;
}
</style>

<script type='text/javascript'>

<% ih_sysinfo(); %>
<% ih_user_info(); %>

<% web_exec('show running-config aaa'); %>

//radius_server = [['2.2.2.2','1812','1234'],['1.1.1.1','1812','8765'],['','0',''],['','0',''],['','0',''],['','0',''],['','0',''],['','0',''],['','0',''],['','0','']];

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
	//ip
	if (f[0].value=='' || !v_ip(f[0], 1)) {
		ferror.set(f[0], '', quiet);
		return 0;
	}
	if (this.existName(f[0].value)) {
		ferror.set(f[0], errmsg.bad_name4, quiet);
		return 0;
	}
	//port
	if (f[1].value=='' || !v_range(f[1], 1, 1, 65535)) {
		ferror.set(f[1], '', quiet);
		return 0;
	}
	return 1;
}

aaaentrys.fieldValuesToData = function(row) {
	var f = fields.getAll(row);
	return [f[0].value, f[1].value, f[2].value]; 
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
	f[1].value = '1812';
	f[2].value = '';
}

aaaentrys.setup = function() {
	this.init('aaa-grid', 'move', 10, [
		{ type: 'text', maxlen: 64 },
		{ type: 'text', maxlen: 5 }, 
		{ type: 'password', maxlen:64 }]);
	
	this.headerSet([ui.aaa_server, ui.aaa_port, ui.aaa_key]);

	for (var i = 0; i < radius_server.length; i++) {
		this.insertData(-1, [radius_server[i][0],radius_server[i][1],
					radius_server[i][2]
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
	for(var i = 0; i < radius_server.length; i++) {
		var found = 0;
		for(var j = 0; j < data.length; j++) {
			if(data[j][0]==radius_server[i][0]) {	//server
				found = 1;
				break;
			}
		}
		if(!found) {
			cmd += "no radius-server host " + radius_server[i][0] + " auth-port " + radius_server[i][1];
			if(radius_server[i][2] == '') cmd += "\n";
			else cmd += " key " + radius_server[i][2] + "\n";
		}
	}

	// add or change
	for(var i = 0; i < data.length; i++) {
		var found = 0;
		var changed = 0;
		for(var j = 0; j < radius_server.length; j++) {
			if(data[i][0]==radius_server[j][0]) {	//index
				found = 1;
				if(data[i][1] != radius_server[j][1]
					|| data[i][2] != radius_server[j][2]) {
					changed = 1;
				}
				break;
			}
		}
		if(!found || changed) {
			cmd += "radius-server host " + data[i][0] + " auth-port " + data[i][1];
			if(data[i][2] == '') cmd += "\n";
			else cmd += " key " + data[i][2] + "\n";
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

