<% pagehead(menu.setup_pppoe) %>

<style type='text/css'>
#dialpool-grid {
	text-align: center;	
	width: 500px;
}

#dialpool-grid .co1 {
	width: 150px;
}

#dialerif-grid {
	text-align: center;	
	width: 680px;
}

#dialerif-grid .co1 {
	width: 40px;
}
#dialerif-grid .co2 {
	width: 40px;
}
#dialerif-grid .co3 {
	width: 50px;
}
#dialerif-grid .co4 {
	width: 60px;
}
#dialerif-grid .co5 {
	width: 80px;
}
#dialerif-grid .co9 {
	width: 80px;
}
#dialerif-grid .co10 {
	width: 80px;
}
#dialerif-grid .co11 {
	width: 40px;
}
</style>

<script type='text/javascript'>

<% ih_sysinfo(); %>
<% ih_user_info(); %>

<% web_exec('show running-config dialer'); %>

//dialpool_config = [['1','fastethernet 0/1']];
//dialer_config = [['1','1','1','0','test','123456','1.1.1.1','1.1.1.2','1']];

<% web_exec('show interface')%>

//define option list
var vifs = [].concat(eth_interface, svi_interface);
var now_vifs_options = new Array();
now_vifs_options = grid_list_all_vif_opts(vifs);

var auth_type_list = [['0', 'Auto'],['1','PAP'],['2','CHAP']];

//define a web grid
var dialpool = new webGrid();

dialpool.exist = function(f, v)
{
	var data = this.getAllData();
	for (var i = 0; i < data.length; ++i) {
		if (data[i][f] == v) return true;
	}
	return false;
}

dialpool.existName = function(name)
{
	return this.exist(0, name);
}

dialpool.verifyFields = function(row, quiet) {
	var f = fields.getAll(row);
	ferror.clearAll(f);
	//pool id
	if(!v_info_num_range(f[0], quiet, false, 1, 10)) return 0;
	if (this.existName(f[0].value)) {
		ferror.set(f[0], errmsg.bad_name4, quiet);
		return 0;
	}
	return 1;
}

dialpool.dataToView = function(data) {
	return [data[0],
	       data[1]];
}

dialpool.fieldValuesToData = function(row) {
	var f = fields.getAll(row);
	return [f[0].value, f[1].value];
}

dialpool.onDataChanged = function() 
{
	verifyFields(null, 1);
}

dialpool.resetNewEditor = function() {
	var f = fields.getAll(this.newEditor);

	ferror.clearAll(f);

	//init value
	f[0].value = this.getAllData().length + 1;
}

dialpool.setup = function() {
	this.init('dialpool-grid', 'move', 10, [
		{ type: 'text', maxlen: 8 }, 
		{ type: 'select', options: now_vifs_options }]);		
	
	this.headerSet([dialer.poolid,ui.iface]);

	for (var i = 0; i < dialpool_config.length; i++) {
		this.insertData(-1, [dialpool_config[i][0], dialpool_config[i][1]
					]);
	}
	
	this.showNewEditor();
	this.resetNewEditor();
	
}

var dialerifs = new webGrid();

dialerifs.exist = function(f, v)
{
	var data = this.getAllData();
	for (var i = 0; i < data.length; ++i) {
		if (data[i][f] == v) return true;
	}
	return false;
}

dialerifs.existName = function(name)
{
	return this.exist(1, name);
}

dialerifs.verifyFields = function(row, quiet) {
	var f = fields.getAll(row);

	ferror.clearAll(f);
	//index
	if(!v_info_num_range(f[1], quiet, false, 1, 10)) return 0;
	if (this.existName(f[1].value)) {
		ferror.set(f[1], errmsg.bad_name4, quiet);
		return 0;
	}
	//pool id
	if(!v_info_num_range(f[2], quiet, false, 1, 10)) return 0;
	//username
	if (f[4].value=='') {
		ferror.set(f[4], '', quiet);
		return 0;
	}
	//password
	if (f[5].value=='') {
		ferror.set(f[5], '', quiet);
		return 0;
	}
	//local ip
	if(!v_info_ip(f[6], quiet, true)) return 0;

	//remote ip
	if(!v_info_ip(f[7], quiet, true)) return 0;

	//LCP Interval
	if (!v_info_num_range(f[8],quiet,false,0,640800)) return 0;

	if (f[8].value == '0') {
		f[9].disabled = true;
		f[9].value = 0;
	}else {
		f[9].disabled = false;
	}
	//LCP Retry
	if (!v_info_num_range(f[9],quiet,false,0,100)) return 0;

	return 1;
}

dialerifs.dataToView = function(data) {
	return [(data[0] != '0') ? ui.yes : ui.no,
	       data[1],
	       data[2],
	       auth_type_list[data[3]][1],	       
	       data[4],
	       data[5]==''?'':'******',
	       data[6],
	       data[7],
	       data[8],
	       data[9],
	       (data[10] != '0') ? ui.yes : ui.no];
}

dialerifs.fieldValuesToData = function(row) {
	var f = fields.getAll(row);
	return [f[0].checked ? 1 : 0,f[1].value,f[2].value,f[3].value,f[4].value,f[5].value,f[6].value,f[7].value,f[8].value,f[9].value,f[10].checked ? 1 : 0];
}

dialerifs.onDataChanged = function() 
{
	verifyFields(null, 1);
}

dialerifs.resetNewEditor = function() {
	var f = fields.getAll(this.newEditor);

	ferror.clearAll(f);

	//init value
	f[0].checked = 1;
	f[1].value = this.getAllData().length + 1;
	f[8].value = 120;
	f[9].value = 3;
}

dialerifs.setup = function() {
	this.init('dialerif-grid', 'move', 10, [
		{ type: 'checkbox' },
		{ type: 'text', maxlen: 8 }, 
		{ type: 'text', maxlen: 8 }, 
		{ type: 'select', options: auth_type_list }, 		
		{ type: 'text', maxlen: 63 }, 
		{ type: 'password', maxlen: 63 },
		{ type: 'text', maxlen: 15 }, 
		{ type: 'text', maxlen: 15 }, 
		{ type: 'text', maxlen: 6 }, 
		{ type: 'text', maxlen: 3 },
		{ type: 'checkbox' }]);
	
	this.headerSet([dialer.enable,dialer.id,dialer.poolid,ui.ppp_authen_type,dialer.username,dialer.passwd,
		dialer.localip,dialer.remoteip,dialer.heartInt,dialer.heartTime,dialer.debug]);

	for (var i = 0; i < dialer_config.length; i++) {
		if(dialer_config[i][2]=='0') {
			dialer_config[i][2]='';
		}
		this.insertData(-1, [dialer_config[i][0], dialer_config[i][1],
					dialer_config[i][2], dialer_config[i][3],
					dialer_config[i][4], dialer_config[i][5],
					dialer_config[i][6], dialer_config[i][7],
					dialer_config[i][9], dialer_config[i][10], 
					dialer_config[i][8]
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
	var data = dialpool.getAllData();
	// delete
	for(var i = 0; i < dialpool_config.length; i++) {
		var found = 0;
		for(var j = 0; j < data.length; j++) {
			if(data[j][0]==dialpool_config[i][0]) {//pool id
				found = 1;
				break;
			}
		}
		if(!found) {
			cmd += "interface " + dialpool_config[i][1] + "\n";
			cmd += "no pppoe-client dial-pool-number " + dialpool_config[i][0] + "\n";
			cmd += "!\n";
		}
	}

	// add or change
	for(var i = 0; i < data.length; i++) {
		var found = 0;
		var changed = 0;
		for(var j = 0; j < dialpool_config.length; j++) {
			if(data[i][0]==dialpool_config[j][0]) {//pool id
				found = 1;
				if(data[i][1] != dialpool_config[j][1]) {
					changed = 1;
				}
				break;
			}
		}
		if(!found || changed) {
			cmd += "interface " + data[i][1] + "\n";
			cmd += "pppoe-client dial-pool-number " + data[i][0] + "\n";
			cmd += "!\n";
		}
	}

	var data = dialerifs.getAllData();
	// delete
	for(var i = 0; i < dialer_config.length; i++) {
		var found = 0;
		for(var j = 0; j < data.length; j++) {
			if(data[j][1]==dialer_config[i][1]) {//id
				found = 1;
				break;
			}
		}
		if(!found) {
			cmd += "no interface dialer " + dialer_config[i][1] + "\n";
		}
	}

	// add or change
	for(var i = 0; i < data.length; i++) {
		var found = 0;
		var changed = 0;
		for(var j = 0; j < dialer_config.length; j++) {
			if(data[i][1]==dialer_config[j][1]) {//id
				found = 1;
				if(data[i][0] != dialer_config[j][0]
					|| data[i][2] != dialer_config[j][2]
					|| data[i][3] != dialer_config[j][3]
					|| data[i][4] != dialer_config[j][4]
					|| data[i][5] != dialer_config[j][5]
					|| data[i][6] != dialer_config[j][6]
					|| data[i][7] != dialer_config[j][7]
					|| data[i][8] != dialer_config[j][9]
					|| data[i][9] != dialer_config[j][10]
					|| data[i][10] != dialer_config[j][8]) {
					changed = 1;
				}
				break;
			}
		}
		if(!found || changed) {
			var auth_type = [['0', 'auto'],['1', 'pap'],['2', 'chap']];
			cmd += "interface dialer " + data[i][1] + "\n";
			if(data[i][0]=='1') {
    				cmd += "no shutdown\n";
			} else {
    				cmd += "shutdown\n";
			}
			cmd += "dialer pool " + data[i][2] +"\n";
			cmd += "ppp authentication " + auth_type[data[i][3]][1] + " " + data[i][4] + " " + data[i][5] +"\n";
			if(data[i][6]!='' && data[i][7]!='') {
    				cmd += "ip address static local " + data[i][6] + " peer " + data[i][7] + "\n";
			} else if(data[i][6]!='') {
    				cmd += "ip address static local " + data[i][6] + "\n";
			} else if(data[i][7]!='') {
    				cmd += "ip address static peer " + data[i][7] + "\n";
			} else {
    				cmd += "ip address negotiated\n";
			}
			if (data[i][8] != '0') {
					cmd += "ppp keepalive "+data[i][8]+" "+data[i][9]+"\n";
			}else {
					cmd += "ppp keepalive 0 0\n";
			}
			if(data[i][10]=='1') {
    				cmd += "ppp debug\n";
			} else {
    				cmd += "no ppp debug\n";
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
	if (dialpool.isEditing()) return;
	if (dialerifs.isEditing()) return;

	var fom = E('_fom');

	if((E('_fom')._web_cmd.value != '')&&(cookie.get('autosave') == 1)){
		E('_fom')._web_cmd.value += "!"+"\n"+"copy running-config startup-config"+"\n";	
	}

	form.submit(fom, 1);
}

function earlyInit()
{
	dialpool.setup();
	dialerifs.setup();
	verifyFields(null, 1);
}

function init()
{
	if((cookie.get('autosave')) == null){
		cookie.set('autosave', 1);
	}
	dialpool.recolor();
	dialerifs.recolor();
}
</script>
</head>

<body onload='init()'>
<form id='_fom' method='post' action='apply.cgi'>
<input type='hidden' name='_web_cmd' value=''>

<div class='section-title'>
<script type='text/javascript'>
	GetText(dialer.pool);
</script>
</div>
<div class='section'>
	<table class='web-grid' id='dialpool-grid'></table>
</div>

<div class='section-title'>
<script type='text/javascript'>
	GetText(dialer.pppoe);
</script>
</div>
<div class='section'>
	<table class='web-grid' id='dialerif-grid'></table>
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


