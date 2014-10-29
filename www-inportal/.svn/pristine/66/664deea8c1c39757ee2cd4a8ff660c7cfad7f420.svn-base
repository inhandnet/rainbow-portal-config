<% pagehead(menu.adm_log) %>

<style type='text/css'>
#server-grid {
	width: 400px;
	text-align: center;
}
#server-grid .co1 {
	width: 200px;
}
#server-grid .co2 {
	width: 200px;
}

</style>

<script type='text/javascript'>

<% ih_user_info(); %>
<% web_exec('show running log')%>

var operator_priv = 12;

var log_server_enable = false;
var log_server_json = log_config[0];
var log_console_enable = log_config[1];

for(var i = 0; i < log_config[0].length; i++) {
	var ip = log_config[0][i][0];
	if(ip != '') {
		log_server_enable = true;
	}
}

//server
var server = new webGrid();
function display_disable_server(e)
{	
	var x = e?"":"none";
	E('server-grid').style.display = x;
	E('server_body').style.display = x;

	E('server-grid').disabled = !e;
	E('server_body').disabled = !e;

	var tgRowPan = E('tg-row-panel');
	if('undefined' == tgRowPan || null == tgRowPan) {
		return true;
	}

	tgRowPan.style.display = x;

	return true;
}

server.exist = function(f, v)
{
	var data = this.getAllData();
	for (var i = 0; i < data.length; ++i) {
		if (data[i][f] == v) return true;
	}
	return false;
}

function v_syslogd_server(e)
{
	var svr = E(e).value;
	var tmp = [];
	
	//ip
	if(v_ipnz(e, true, 1)) 
		return 1;
	
	//domain
	if(!v_domain(e, true)) 
		return 0;
	tmp = svr.split('.');
	if (tmp.length < 2) 
		return 0;

	for (var i = 0; i < tmp.length; i++){
		if (tmp[i].length == 0) 
			return 0;
	}

	if (tmp[tmp.length - 1].length < 2) 
		return 0;

	return 1;
	
}

server.existName = function(name)
{
	return this.exist(0, name);
}

server.onDataChanged = function() {
	verifyFields(null, 1);
}

server.verifyFields = function(row, quiet)
{
	var f = fields.getAll(row);
	var tmp;
	ferror.clearAll(f);
	
	if(this.existName(f[0].value)) {
		ferror.set(f[0], errmsg.bad_addr2, quiet);
		return 0;
	} else if(!v_syslogd_server(f[0])) {
		ferror.set(f[0], errmsg.domain_name, quiet);
		return 0;
	} else {
		ferror.clear(f[0]);
	}

	if(!v_range(f[1], quiet, 1, 65535)) {
		return 0;
	} else {
		ferror.clear(f[1]);
	}

	return 1;	
}

server.dataToView = function(data)
{
	return [data[0],data[1]];
}

server.fieldValuesToData = function(row) 
{
	var f = fields.getAll(row);
	return [f[0].value,f[1].value];
}

server.resetNewEditor = function() 
{
	var f = fields.getAll(this.newEditor);
	f[0].value = '';
	f[1].value = '514';
			
	ferror.clearAll(fields.getAll(this.newEditor));
}

server.setup = function()
{
	this.init('server-grid', 'move', 64, [
		{ type: 'text', maxlen: 32 }, 
		{ type: 'text', maxlen: 32 } 
	]);
	this.headerSet([ui.syslogd_server_addr, ui.port]);

	for (var i = 0; i < log_server_json.length; i++) {
		if(log_server_json[i][0] != '') {
			this.insertData(-1, [log_server_json[i][0], log_server_json[i][1]]);
		}
	}

	this.showNewEditor();
	this.resetNewEditor();
}

function verifyFields()
{
	//verify for the server grid
	var cmd = "";
	var flag = 0;
	var fom = E('_fom');
	var server_enable = E('_f_log_remote').checked;
	var console_enable = E('_f_log_console').checked;
	E('save-button').disabled = true;	

	var server_data = server.getAllData();
	var server_json = log_server_json;

	var data = server.getAllData();
	if(data.length >= 4) {
		server.disableNewEditor(true);
	} else {
		server.disableNewEditor(false);
	}



	if(server_enable) {
		display_disable_server(1);
		//delete the server from json which have been deleted from web
		for(var i = 0; i < server_json.length; i++) {
			flag = 0;
			for (var j=0; j < server_data.length; j++) {
				if((server_json[i][0] == server_data[j][0])) {
					flag = 1;	//The server is still in the web grid
					break;
				}
			}
			if(!flag) {
				if(server_json[i][0] != '') {
					cmd += "no log server " + server_json[i][0] + "\n";
				}
			}
		}
		//add the server into json which have been added by the web
		for(var i = 0; i < server_data.length; i++) {
			flag = 0;
			for (var j=0; j < server_json.length; j++) {
				if((server_data[i][0] == server_json[j][0]) && (server_data[i][1] == server_json[j][1])) {
					flag = 1;
					break;
				}
			}
			if(!flag) {
				cmd += "log server " + server_data[i][0] + " " + "port" + " " + server_data[i][1] + "\n";			
			}
		}
	} else {
		display_disable_server(0);
		for(var i = 0; i < server_json.length; i++) {
				if (server_json[i][0] != '') {
					cmd += "no log server " + server_json[i][0] + "\n";
				}
		}
	}
	if (log_console_enable != console_enable) {
		if(console_enable) {
			cmd += "log console\n";
		} else {
			cmd += "no log console\n";
		}
	}

	if (user_info.priv < operator_priv) {
		elem.display('save-button', 'cancel-button', false);
	}else{
		elem.display('save-button', 'cancel-button', true);
		fom._web_cmd.value = cmd;
		E('save-button').disabled = (cmd=="");	
	}

	return true;
	
}

function save()
{
	if (!verifyFields(null, false)) return;
	
//	if (server.isEditing()) return;
	var fom = E('_fom');
	
	if((E('_fom')._web_cmd.value != '')&&(cookie.get('autosave') == 1)){
		E('_fom')._web_cmd.value += "!"+"\n"+"copy running-config startup-config"+"\n";	
	}

	form.submit(fom, 1);
}

function earlyInit()
{
	server.setup();
	verifyFields(null, 1);

}

function init()
{
	var i;

	return true;
}

</script>

</head>
<body onload='init()'>
<form id='_fom' method='post' action='apply.cgi'>
<input type='hidden' name='_web_cmd' value=''>

<div class='section'>
<script type='text/javascript'>
createFieldTable('', [
	{ title: ui.log_to_server, name: 'f_log_remote', type: 'checkbox', value: log_server_enable}
]);
</script>
</div>

<div id='server_body' class='section'>
	<table class='web-grid' id='server-grid'></table>
</div>

<div class='section'>
<script type='text/javascript'>
createFieldTable('', [
	{ title: ui.log_to_console, name: 'f_log_console', type: 'checkbox', value: log_console_enable == '1' }	
]);
</script>
</div>

</form>

<script type='text/javascript'>
if(cookie.get('autosave') == 1)
	ui.aply=ui.aply_save;
genStdFooter("");
</script>
<script type='text/javascript'>earlyInit();</script>
</body>
</html>
