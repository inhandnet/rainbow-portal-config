<% pagehead(menu.switch_service_snmptrap) %>

<style type='text/css'>

#trapman-grid {
	width: 400px;
}
#trapman-grid .co1 {
	width: 150px;
	text-align: center;
}
#trapman-grid .co2 {
	width: 100px;
	text-align: center;
}
#trapman-grid .co3 {
	width: 100px;
	text-align: center;
}

</style>

<script type='text/javascript'>

<% ih_sysinfo() %>
<% ih_user_info() %>

<% web_exec('show running-config snmp-server') %>

var trapman = new webGrid();

function display_disable_trapman(e)
{	
	var x = e?"":"none";
	
	E('trapman-grid').style.display = x;
	E('trapman_title').style.display = x;
	E('trapman_body').style.display = x;

	E('trapman-grid').disabled = !e;
	E('trapman_title').disabled = !e;
	E('trapman_body').disabled = !e;
	return 1;
}

//verify snmp community,username,groupname,auth_pwd,priv_pwd,trap_sec_name
function isLegal_snmp_name(str)
{
	var reg = /^[A-Za-z0-9_]+$/;
	return reg.test(str);
}

trapman.exist = function(f, v)
{
	var data = this.getAllData();
	for (var i = 0; i < data.length; ++i) {
		if (data[i][f] == v) return true;
	}
	return false;
}

trapman.existName = function(name)
{
	return this.exist(0, name);
}


trapman.dataToView = function(data) {
	
	return [data[0],
	       data[1],
	       data[2]]; 
//	       (data[2] == '1') ? ui.snmp_v1 : ((data[2] == '2') ?  ui.snmp_v2c : ui.snmp_v3)];
}

trapman.fieldValuesToData = function(row) {
	var f = fields.getAll(row);
	return [f[0].value, f[1].value, f[2].value];
}

trapman.onDataChanged = function() {
	verifyFields(null, 1);
}

trapman.verifyFields = function(row, quiet) {
	var f = fields.getAll(row);
	var port_num;

	if (this.existName(f[0].value)) {
		ferror.set(f[0], errmsg.bad_addr2, quiet);
		return 0;
	} else {
		ferror.clear(f[0]);		
	}

	if (!v_length(f[0], quiet,1,32))
		return 0;
	
	if (!v_ip(f[0], quiet))
		return 0;
		
	if(haveChineseChar(f[1].value)) {		//error when input chinese chars	
//		ferror.set(f[1], errmsg.snmp_secname, false);
		ferror.set(f[1], errmsg.cn_chars, false);
		return 0;		
	} else if(!v_length(f[1], quiet,1,32)) {
		return 0;
	} else if(f[1].value.indexOf(" ") >= 0) {
		ferror.set(f[1], errmsg.bad_description, quiet);
		return 0;		
	} else if(!isLegal_snmp_name(f[1].value)) {
		ferror.set(f[1], errmsg.snmp_name, quiet);
		return 0;
	} else {
		ferror.clear(f[1]);
	}

	if (!v_range(f[2], quiet,1,65535))
		return 0;

	return 1;
}

trapman.resetNewEditor = function() {
	var f = fields.getAll(this.newEditor);
	f[0].value = '';
	f[1].value = '';
	f[2].value = '162';
			
	ferror.clearAll(fields.getAll(this.newEditor));
}

trapman.setup = function() {

	var disable_grid = (snmps_config.enable == 0);
	
	var styles = [];
	
	if(snmps_config.enable == 0)
	{
		show_alert(errmsg.snmp_trap_enable_err);
	}

	if(!disable_grid) {
		styles.push('move');
	} else {
		styles.push('readonly');
	}

//	this.init('trapman-grid', 'move', 4, [
	this.init('trapman-grid', styles, 4, [
		{ type: 'text', maxlen: 32 }, 
		{ type: 'text', maxlen: 32 },
		{ type: 'text', maxlen: 32 } 
//		{ type: 'select', maxlen: 15, options:[
//			['1',ui.snmp_v1],
//			['2',ui.snmp_v2c],
//			['3',ui.snmp_v3]]},
		]
		);
	this.headerSet([snmptrap.snmptrap_des_ip, snmptrap.snmptrap_sec_name, snmptrap.snmptrap_port]);

	for (var i = 0; i < snmps_config.snmp_traps.length; i++)
		this.insertData(-1, [snmps_config.snmp_traps[i].host_ip, 
					snmps_config.snmp_traps[i].com,
					snmps_config.snmp_traps[i].port
//				     snmps_config.snmp_traps[i].version
				     ]);

	if(!disable_grid) {
		this.showNewEditor();
		this.resetNewEditor();
	}
}

function verifyFields(focused, quiet)
{
	var ok = 1;
	var cmd = "";
	var fom = E('_fom');

	E('save-button').disabled = true;

//	if(snmps_config.enable == 0)
//	{
//		display_disable_trapman(0);
//		show_alert("Please enable snmp-server first!");
//		return 0;
//	}

	var flag = 0;
	
	//verify for the trap grid
	var datat = trapman.getAllData();
	var mtraps = snmps_config.snmp_traps;

	//delete the trap host from json which have been deleted from web 
	for(var i = 0; i < mtraps.length; i++) {
		flag = 0;
		for (var j=0; j < datat.length; j++) {
			if((mtraps[i].host_ip == datat[j][0]) && (mtraps[i].com == datat[j][1]) && (mtraps[i].port == datat[j][2])) {
				flag = 1;	//The host is still in the web grid
				break;
			}
		}
		if(!flag)
			cmd += "no snmp-server host " + mtraps[i].host_ip + "\n";

	}

	//add the community into json which have been added by the web
	for(var i = 0; i < datat.length; i++) {
		flag = 0;
		for (var j=0; j < mtraps.length; j++) {
			if((datat[i][0] == mtraps[j].host_ip) && (datat[i][1] == mtraps[j].com) && (datat[i][2] == mtraps[j].port)) {
				flag = 1;
				break;
			}
		}
		if(!flag)
		{
			if(datat[i][2] == 162)	
				cmd += "snmp-server host " + datat[i][0] + " " + datat[i][1] + "\n";
			else
				cmd += "snmp-server host " + datat[i][0] + " " + datat[i][1] + " port " + datat[i][2] + "\n";
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
	if (!verifyFields(null, false)) return;

	if (trapman.isEditing()) return;

	if((E('_fom')._web_cmd.value != '')&&(cookie.get('autosave') == 1)){
		E('_fom')._web_cmd.value += "!"+"\n"+"copy running-config startup-config"+"\n";	
	}
	form.submit('_fom', 1);
}

function earlyInit()
{
	trapman.setup();
	verifyFields(null, 1);
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


<div id='trapman_title' class='section-title'>
<script type='text/javascript'>
	GetText(snmptrap.snmptrap_title);
</script>
</div>
<div id="trapman_body" class='section'>
	<table class='web-grid' id='trapman-grid'></table>	
</div>

<script type='text/javascript'>
init();
if(cookie.get('autosave') == 1)
	ui.aply=ui.aply_save;
genStdFooter("");
</script>
</form>
<script type='text/javascript'>earlyInit()</script>


</body>
</html>

