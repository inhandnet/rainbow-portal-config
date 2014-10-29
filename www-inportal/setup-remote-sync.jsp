<% pagehead(menu.setup_sla) %>

<style type='text/css'>
#rsync-grid {
	text-align: center;	
	width: 900px;
}

#rsync-grid .co1 {
	width: 60px;
}
#rsync-grid .co2 {
	width: 160px;
}
#rsync-grid .co3 {
	width: 160px;
}
#rsync-grid .co4 {
	width: 160px;
}
#rsync-grid .co5 {
	width: 100px;
}
#rsync-grid .co6 {
	width: 100px;
}
#rsync-grid .co7 {
	width: 100px;
}
#rsync-grid .co8 {
	width: 70px;
}
#rsync-grid .co9 {
	width: 120px;
}

</style>

<script type='text/javascript'>

<% ih_sysinfo(); %>
<% ih_user_info(); %>

<% web_exec('show running-config remote-sync'); %>

//remote_sync_config = [['name', 'host', 'remote', 'local', 'username', 'password'], ...];

//define a web grid
var rsynctasks = new webGrid();

rsynctasks.exist = function(f, v)
{
	var data = this.getAllData();
	for (var i = 0; i < data.length; ++i) {
		if (data[i][f] == v) return true;
	}
	return false;
}

rsynctasks.existName = function(name)
{
	return this.exist(0, name);
}

rsynctasks.verifyFields = function(row, quiet) {
	var f = fields.getAll(row);

	ferror.clearAll(f);

	//task name
	if (!v_info_word(f[0], quiet, false)) return 0;
	if (this.existName(f[0].value)){
		ferror.set(f[0], errmsg.bad_name4, quiet);
		return 0;
	}
	//host
	if (f[8].value!=0)
		if (!v_info_url(f[1], quiet, false)) return 0;
	//remote
	if (f[8].value!=0)
		if (!v_info_directory(f[2], quiet, false)) return 0;
	//local
	if (!v_info_directory(f[3], quiet, false)) return 0;
	//username
	if (!v_info_word(f[4], quiet, true)) return 0; 
	//password
	if (!v_info_passwd(f[5], quiet, true, 1, 128))  return 0; 

	return 1;
}
/*
rsynctasks.dataToView = function(data) {
	return [data[0],
	       type_list[data[1]][1],
	       data[2],
	       data[3],
	       data[4],
	       data[5],
	       data[6],
	       life_list[data[7]][1],
	       starttime_list[data[8]][1]];
}


rsynctasks.fieldValuesToData = function(row) {
	var f = fields.getAll(row);
	return [f[0].value, f[1].value, f[2].value, f[3].value, 
	       f[4].value, f[5].value, f[6].value, f[7].value, f[8].value];
}



rsynctasks.resetNewEditor = function() {
	var f = fields.getAll(this.newEditor);

	ferror.clearAll(f);

	//init value
}
*/

rsynctasks.dataToView = function(data) 
{
	var v = [];
	var p = '';

	v.push(data[0]);
	v.push(data[1]);
	v.push(data[2]);
	v.push(data[3]);
	v.push(data[4]);
	if (data[5])
		v.push("******");
	else
		v.push("");
	v.push( mode_option[ data[6]][1]);
	v.push( fifo_option[ data[7]][1]);
	v.push( server_option[ data[8]][1]);

	return v;
}

rsynctasks.onDataChanged = function() 
{
	verifyFields(null, 1);
}

mode_option = [[0, rsync.nor], [1, rsync.bak]];
fifo_option = [[0, rsync.low], [1, rsync.med], [2, rsync.high]];
fifo_cmd =['low',  'medium', 'high'];
server_option = [[0, rsync.rb], [1, rsync.third]];

rsynctasks.setup = function() {
	this.init('rsync-grid', 'move', 10, [
		{ type: 'text', maxlen: 128 },//task
		{ type: 'text', maxlen: 31 },//server
		{ type: 'text', maxlen: 64 },//server directory
		{ type: 'text', maxlen: 64 },//local
		{ type: 'text', maxlen: 32 },//username
		{ type: 'password', maxlen: 128 },//password
		{ type: 'select', options: mode_option},//mode
		{ type: 'select', options: fifo_option},//prio(FIFO)
		{ type: 'select', options: server_option},//prio(FIFO)
		]	
	);
	
	this.headerSet([rsync.task, rsync.host, rsync.remote, rsync.local,
			rsync.user, rsync.passwd, rsync.type, rsync.prio, rsync.svrTyp]);

	for (var i = 0; i < remote_sync_config.length; i++) {
		this.insertData(-1, [remote_sync_config[i][0], remote_sync_config[i][1],
					remote_sync_config[i][2], remote_sync_config[i][3],
					remote_sync_config[i][4], remote_sync_config[i][5],
					remote_sync_config[i][7],remote_sync_config[i][6],
					remote_sync_config[i][8]
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
	var data = rsynctasks.getAllData();
	// delete
	for(var i = 0; i < remote_sync_config.length; i++) {
		var found = 0;
		for(var j = 0; j < data.length; j++) {
			if(data[j][0]==remote_sync_config[i][0]) {	//index
				found = 1;
				break;
			}
		}
		if(!found) {
			cmd += "!\nno remote-sync " + remote_sync_config[i][0] + "\n";
		}
	}

	// add or change
	for(var i = 0; i < data.length; i++) {
		var found = 0;
		var changed = 0;
		for(var j = 0; j < remote_sync_config.length; j++) {
			if(data[i][0]==remote_sync_config[j][0]) {	//index
				found = 1;
				if(data[i][1] != remote_sync_config[j][1]
					|| data[i][2] != remote_sync_config[j][2]
					|| data[i][3] != remote_sync_config[j][3]
					|| data[i][4] != remote_sync_config[j][4]
					|| data[i][5] != remote_sync_config[j][5]
					|| data[i][6] != remote_sync_config[j][7]
					|| data[i][7] != remote_sync_config[j][6]
					|| data[i][8] != remote_sync_config[j][8]) {
					changed = 1;
				}
				break;
			}
		}
		if(!found || changed) {
			cmd += "!\nremote-sync " + data[i][0] + (data[i][8]==0?" flag rainbow":"") +"\n";
			if (data[i][1] == '')
				cmd += "  no remote\n";
			else
				cmd += "  remote host " + data[i][1] + " directory " + data[i][2] + "\n";
			if (data[i][3] == '')
				cmd += "  no local\n";
			else
				cmd += "  local directory " + data[i][3] + "\n";
			if (data[i][4] == '')
				cmd += "  no user\n";
			else
				cmd += "  user " + data[i][4] + " password " + data[i][5] + "\n";
			if (data[i][6] == 1)
				cmd += "  mode backup\n";
			else
				cmd += "  no mode\n";
			cmd += " priority "+fifo_cmd[data[i][7]]+"\n";
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
	if (rsynctasks.isEditing()) return;

	var fom = E('_fom');

	if((E('_fom')._web_cmd.value != '')&&(cookie.get('autosave') == 1)){
		E('_fom')._web_cmd.value += "!"+"\n"+"copy running-config startup-config"+"\n";	
	}

	form.submit(fom, 1);
}

function earlyInit()
{
	rsynctasks.setup();
	verifyFields(null, 1);
}

function init()
{
	if((cookie.get('autosave')) == null){
		cookie.set('autosave', 1);
	}
	rsynctasks.recolor();
}
</script>
</head>

<body onload='init()'>
<form id='_fom' method='post' action='apply.cgi'>
<input type='hidden' name='_web_cmd' value=''>

<div class='section-title'>
<script type='text/javascript'>
	GetText(rsync.task);
</script>
</div>
<div class='section'>
	<table class='web-grid' id='rsync-grid'></table>
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

