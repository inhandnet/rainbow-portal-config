<% pagehead(menu.setup_sla) %>

<style type='text/css'>
#sla-grid {
	text-align: center;	
	width: 700px;
}

#sla-grid .co1 {
	width: 40px;
}
#sla-grid .co3 {
	width: 100px;
}
#sla-grid .co4, .co5, .co6, .co7 {
	width: 70px;
}
</style>

<script type='text/javascript'>

<% ih_sysinfo(); %>
<% ih_user_info(); %>

<% web_exec('show running-config sla'); %>

//sla_config = [['1','1','1.1.1.1','56','30','5000','5','0','1','','','','']];

//define option list
var type_list = [['0', ''],['1','icmp-echo']];
var life_list = [['0', 'forever']];
var starttime_list = [['0', ''],['1','now']];

//define a web grid
var slaentrys = new webGrid();

slaentrys.exist = function(f, v)
{
	var data = this.getAllData();
	for (var i = 0; i < data.length; ++i) {
		if (data[i][f] == v) return true;
	}
	return false;
}

slaentrys.existName = function(name)
{
	return this.exist(0, name);
}

slaentrys.verifyFields = function(row, quiet) {
	var f = fields.getAll(row);

	ferror.clearAll(f);
	
	//index
	if(!v_info_num_range(f[0], quiet, false, 1, 10)) {
		return 0;
	}
	if (this.existName(f[0].value)) {
		ferror.set(f[0], errmsg.bad_name4, quiet);
		return 0;
	}
	//ip
	if(!v_info_ip(f[2], quiet, false)) {
		return 0;
	}	
	//datasize
	if(!v_info_num_range(f[3], quiet, false, 0, 1000)) {
		return 0;
	}
	//frequency
	if(!v_info_num_range(f[4], quiet, false, 1, 608400)) {
		return 0;
	}
	//timeout
	if(!v_info_num_range(f[5], quiet, false, 1, 300000)) {
		return 0;
	}
	//consecutive
	if(!v_info_num_range(f[6], quiet, false, 1, 1000)) {
		return 0;
	}
	return 1;
}

slaentrys.dataToView = function(data) {
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

slaentrys.fieldValuesToData = function(row) {
	var f = fields.getAll(row);
	return [f[0].value, f[1].value, f[2].value, f[3].value, 
	       f[4].value, f[5].value, f[6].value, f[7].value, f[8].value];
}

slaentrys.onDataChanged = function() 
{
	verifyFields(null, 1);
}

slaentrys.resetNewEditor = function() {
	var f = fields.getAll(this.newEditor);

	ferror.clearAll(f);

	//init value
	f[0].value = this.getAllData().length + 1;
	f[1].value = '1';
	f[2].value = '';
	f[3].value = '56';
	f[4].value = '30';
	f[5].value = '5000';
	f[6].value = '5';
	f[7].value = '0';
	f[8].value = '1';
}

slaentrys.setup = function() {
	this.init('sla-grid', 'move', 10, [
		{ type: 'text', maxlen: 8 },
		{ type: 'select', options: type_list },
		{ type: 'text', maxlen: 15 }, 
		{ type:'text', maxlen:8 },
		{ type:'text', maxlen:8 },
		{ type:'text', maxlen:8 },
		{ type:'text', maxlen:8 },
		{ type: 'select', options: life_list },
		{ type: 'select', options: starttime_list }]);
	
	this.headerSet([sla.id, sla.type, sla.ip, sla.datasize, sla.interval, sla.timeout, sla.consecutive, sla.life, sla.starttime]);

	for (var i = 0; i < sla_config.length; i++) {
		this.insertData(-1, [sla_config[i][0], sla_config[i][1],
					sla_config[i][2], sla_config[i][3],
					sla_config[i][4], sla_config[i][5],
					sla_config[i][6], sla_config[i][7],
					sla_config[i][8]
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
	var data = slaentrys.getAllData();
	// delete
	for(var i = 0; i < sla_config.length; i++) {
		var found = 0;
		for(var j = 0; j < data.length; j++) {
			if(data[j][0]==sla_config[i][0]) {	//index
				found = 1;
				break;
			}
		}
		if(!found) {
			cmd += "no sla " + sla_config[i][0] + "\n";
		}
	}

	// add or change
	for(var i = 0; i < data.length; i++) {
		var found = 0;
		var changed = 0;
		for(var j = 0; j < sla_config.length; j++) {
			if(data[i][0]==sla_config[j][0]) {	//index
				found = 1;
				if(data[i][1] != sla_config[j][1]
					|| data[i][2] != sla_config[j][2]
					|| data[i][3] != sla_config[j][3]
					|| data[i][4] != sla_config[j][4]
					|| data[i][5] != sla_config[j][5]
					|| data[i][6] != sla_config[j][6]
					|| data[i][7] != sla_config[j][7]
					|| data[i][8] != sla_config[j][8]) {
					changed = 1;
				}
				break;
			}
		}
		if(!found || changed) {
			cmd += "sla " + data[i][0] + "\n";
			cmd += "icmp-echo " + data[i][2] + "\n";
    			cmd += "request-data-size " + data[i][3] + "\n";
    			cmd += "frequency " + data[i][4] + "\n";
    			cmd += "timeout " + data[i][5] + "\n";
    			cmd += "check-element probe-fail threshold-type consecutive " + data[i][6] + "\n";
			cmd += "!\n";
			if(data[i][8]!='0') {
    				cmd += "sla schedule " + data[i][0] + " life forever start-time now\n";
			} else {
    				cmd += "no sla schedule " + data[i][0] + "\n";
			}
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
	if (slaentrys.isEditing()) return;

	var fom = E('_fom');

	if((E('_fom')._web_cmd.value != '')&&(cookie.get('autosave') == 1)){
		E('_fom')._web_cmd.value += "!"+"\n"+"copy running-config startup-config"+"\n";	
	}

	form.submit(fom, 1);
}

function earlyInit()
{
	slaentrys.setup();
	verifyFields(null, 1);
}

function init()
{
	if((cookie.get('autosave')) == null){
		cookie.set('autosave', 1);
	}
	slaentrys.recolor();
}
</script>
</head>

<body onload='init()'>
<form id='_fom' method='post' action='apply.cgi'>
<input type='hidden' name='_web_cmd' value=''>

<div class='section-title'>
<script type='text/javascript'>
	GetText(sla.entry);
</script>
</div>
<div class='section'>
	<table class='web-grid' id='sla-grid'></table>
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

