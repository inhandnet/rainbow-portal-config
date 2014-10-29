<% pagehead(menu.setup_if_backup) %>

<style type='text/css'>
#backup-grid {
	text-align: center;	
	width: 660px;
}

#backup-grid .co3 {
	width: 80px;
}
#backup-grid .co4 {
	width: 80px;
}
#backup-grid .co5, .co6 {
	width: 80px;
}
</style>

<script type='text/javascript'>

<% ih_sysinfo(); %>
<% ih_user_info(); %>

<% web_exec('show running-config backup'); %>

//backup_config = [['cellular 1','fastethernet 0/1','60','0','0','1']];

<% web_exec('show interface')%>

//define option list
var vifs = [].concat(cellular_interface, eth_interface, sub_eth_interface, svi_interface,xdsl_interface, gre_interface, vp_interface, openvpn_interface);
var now_vifs_options = new Array();
now_vifs_options = grid_list_all_vif_opts(vifs);

//define a web grid
var backupifaces = new webGrid();

backupifaces.exist = function(f, v)
{
	var data = this.getAllData();
	for (var i = 0; i < data.length; ++i) {
		if (data[i][f] == v) return true;
	}
	return false;
}

backupifaces.existName = function(name)
{
	return this.exist(0, name) || this.exist(1, name);
}

backupifaces.verifyFields = function(row, quiet) {
	var f = fields.getAll(row);
	
	ferror.clearAll(f);

	if (f[0].value==f[1].value) {
		ferror.set(f[0], '', quiet);
		return 0;
	}

	if (this.existName(f[0].value)) {
		ferror.set(f[0], errmsg.bad_name4, quiet);
		return 0;
	}
	
	if (this.existName(f[1].value)) {
		ferror.set(f[1], errmsg.bad_name4, quiet);
		return 0;
	}
	//startup delay
	if(!v_info_num_range(f[2], quiet, false, 0, 300)) {
		return 0;
	}
	//up delay
	if(!v_info_num_range(f[3], quiet, false, 0, 180)) {
		return 0;
	}
	//down delay
	if(!v_info_num_range(f[4], quiet, false, 0, 180)) {
		return 0;
	}
	//track id
	if( f[5].value != ''){
		if(!v_range(f[5],quiet,1,10)) return 0;
	}

	return 1;
}

backupifaces.dataToView = function(data) {
	return [data[0],
	       data[1],
	       data[2],
	       data[3],
	       data[4],
	       data[5]!='0'?data[5]:''];
}

backupifaces.fieldValuesToData = function(row) {
	var f = fields.getAll(row);
	return [f[0].value, f[1].value, f[2].value, f[3].value, 
	       f[4].value, f[5].value];
}

backupifaces.onDataChanged = function() 
{
	verifyFields(null, 1);
}

backupifaces.resetNewEditor = function() {
	var f = fields.getAll(this.newEditor);

	ferror.clearAll(f);

	//init value
	f[2].value = '60';
	f[3].value = '0';
	f[4].value = '0';
}

backupifaces.setup = function() {
	this.init('backup-grid', 'move', 10, [
		{ type: 'select', options: now_vifs_options },			
		{ type: 'select', options: now_vifs_options },			
		{ type:'text', maxlen:8 },
		{ type:'text', maxlen:8 },
		{ type:'text', maxlen:8 },
		{ type:'text', maxlen:8 }]);
	
	this.headerSet([backup.main, backup.backup, backup.startup_delay, backup.up_delay, backup.down_delay, ui.track]);

	for (var i = 0; i < backup_config.length; i++) {
		if(backup_config[i][5] == '0') {
			backup_config[i][5] = '';
		}
		this.insertData(-1, [backup_config[i][0], backup_config[i][1],
					backup_config[i][2], backup_config[i][3],
					backup_config[i][4], backup_config[i][5]
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
	var data = backupifaces.getAllData();
	// delete
	for(var i = 0; i < backup_config.length; i++) {
		var found = 0;
		for(var j = 0; j < data.length; j++) {
			if(data[j][1]==backup_config[i][1]) {
				found = 1;
				break;
			}
		}
		if(!found) {
			cmd += "interface " + backup_config[i][0] + "\n";
			cmd += "  no backup interface " + backup_config[i][1] + "\n";
			cmd += "!\n";
		}
	}

	// add or change
	for(var i = 0; i < data.length; i++) {
		var found = 0;
		var changed = 0;
		for(var j = 0; j < backup_config.length; j++) {
			if(data[i][1]==backup_config[j][1]) {
				found = 1;
				if(data[i][0] != backup_config[j][0]
					|| data[i][2] != backup_config[j][2]
					|| data[i][3] != backup_config[j][3]
					|| data[i][4] != backup_config[j][4]
					|| data[i][5] != backup_config[j][5]) {
					changed = 1;
				}
				break;
			}
		}
		if(!found || changed) {
			cmd += "interface " + data[i][0] + "\n";
			cmd += "  backup interface " + data[i][1] + "\n";
			cmd += "  backup startup " + data[i][2] + "\n";
			cmd += "  backup delay " + data[i][3] +" " + data[i][4] + "\n";
			if(data[i][5]!='') {
				cmd += "  backup track " + data[i][5] + "\n";
			} else {
				if (changed){
					if(backup_config[j][5]!='') {
						cmd += "  no backup track " + backup_config[j][5] + "\n";
					}
				}
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
	if (backupifaces.isEditing()) return;

	var fom = E('_fom');

	if((E('_fom')._web_cmd.value != '')&&(cookie.get('autosave') == 1)){
		E('_fom')._web_cmd.value += "!"+"\n"+"copy running-config startup-config"+"\n";	
	}

	form.submit(fom, 1);
}

function earlyInit()
{
	backupifaces.setup();
	verifyFields(null, 1);
}

function init()
{
	if((cookie.get('autosave')) == null){
		cookie.set('autosave', 1);
	}
	backupifaces.recolor();
}
</script>
</head>

<body onload='init()'>
<form id='_fom' method='post' action='apply.cgi'>
<input type='hidden' name='_web_cmd' value=''>

<div class='section'>
	<table class='web-grid' id='backup-grid'></table>
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

