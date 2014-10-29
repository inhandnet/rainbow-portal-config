<% pagehead(menu.dtu2) %>

<style type='text/css'>
#network-grid {
	width: 400px;
}
#network-grid .co1 {
	width: 200px;
	text-align: center;
}
#network-grid .co2 {
	width: 200px;
	text-align: center;
}
</style>

<script type='text/javascript'>

<% ih_sysinfo() %>
<% ih_user_info() %>

dtu_config = ['0', '2','1','1' ,'1', '60', '5', '0', '15', '180', '', '', '1024', '100', '4','2', '3', '0', '', []];
dtu_config_rfc2217=[];
dtu_config_iec = [];
dtu_config_tcpserver = [];

<% web_exec('show running-config dtu 2')%>
<% web_exec('show interface')%>

var dtu_enable_cookie=cookie.get('dtu-enable');
if(dtu_enable_cookie){
	dtu_enable = dtu_enable_cookie;
	cookie.unset('dtu-enable');
}else {
	if(dtu_config_rfc2217[0]){
		document.location = 'setup-dtu2-rfc2217.jsp';
	}else if(dtu_config_iec[0]){
		document.location = 'setup-dtu2-iec.jsp';
	}else if(dtu_config_tcpserver[0]){
		document.location = 'setup-dtu2-tcpserver.jsp';
	}
}

var proto_list = [['1',ui.dtu_tran], 
		['2', ui.dtu_tcpserver],
		['3', ui.dtu_rfc2217],
		['4', ui.dtu_iec]
		//['5', ui.dtu_mb_bridge]
		];

var connect_proto_list = [['1', ui.dtu_tcp],
			['2', ui.dtu_udp]];

var type_list = [['1',ui.dtu_tcp_long], 
		['2', ui.dtu_tcp_short]];

var peer_list = [ ['1',ui.dtu_polling],
		['2',ui.dtu_parallel]		
		];
var buffer_list = [['1','1'], ['2','2'],['3','3'],['4','4']];

var vifs = [].concat(cellular_interface, eth_interface, sub_eth_interface, svi_interface, xdsl_interface, vp_interface, openvpn_interface);
var now_vifs_options = new Array();
now_vifs_options = grid_list_all_vif_opts(vifs);

var dtu_enable_json = dtu_config[0];
var dtu_id_json = dtu_config[1];
var dtu_proto_json = dtu_config[2];
var dtu_connect_proto_json = dtu_config[3];
var dtu_type_json = dtu_config[4];
var dtu_interval_json = dtu_config[5];
var dtu_retry_json = dtu_config[6];
var dtu_idle_json = dtu_config[7];
var dtu_min_json = dtu_config[8];
var dtu_max_json = dtu_config[9];
var dtu_local_ip_json = dtu_config[10];
var dtu_local_port_json = dtu_config[11];
var dtu_pack_len_json = dtu_config[12];
var dtu_pack_timeout_json = dtu_config[13];
var dtu_buffer_json  = dtu_config[14];
var dtu_peer_json = dtu_config[15];
var dtu_polling_retry_json= dtu_config[16];
var dtu_debug_json= dtu_config[17];
var dtu_sourceif_json = dtu_config[18];
var dtu_network_json = dtu_config[19];

function v_range(e, quiet, min, max, name)
{
	var v;

	if ((e = E(e)) == null) return 0;
	v = e.value * 1;
	if ((isNaN(v)) || (v < min) || (v > max)) {
		ferror.set(e, ui.invalid + '. ' + ui.valid_range + ': ' + min + '-' + max, quiet);
		return 0;
	}
	ferror.clear(e);
	return 1;
}

var destip = new webGrid();
function display_disable_network(e)
{	
	var x = e?"":"none";
	
	E('network-grid').style.display = x;
	E('network_title').style.display = x;
	E('network_body').style.display = x;

	E('network-grid').disabled = !e;
	E('network_title').disabled = !e;
	E('network_body').disabled = !e;
	return 1;
}

destip.exist = function(f, v)
{
	var data = this.getAllData();
	for (var i = 0; i < data.length; ++i) {
		if (data[i][f] == v) return true;
	}
	return false;
}

destip.existName = function(name)
{
	return this.exist(0, name);
}

destip.onDataChanged = function() {
	verifyFields(null, 1);
}

destip.verifyFields = function(row, quiet)
{
	var f = fields.getAll(row);

 	if(!v_ip(f[0], quiet)) {
		return 0;
	} else {
		ferror.clear(f[0]);
	}

	if(!v_range(f[1], quiet, 1, 65535)){
		return 0;
	} else {
		ferror.clear(f[1]);
	}

	return 1;	
}
destip.dataToView = function(data) {
	return [data[0],data[1]];
}

destip.fieldValuesToData = function(row) {
	var f = fields.getAll(row);
	return [f[0].value,f[1].value];
}
destip.resetNewEditor = function() {
	var f = fields.getAll(this.newEditor);

	f[0].value = '';
	f[1].value = '';
			
	ferror.clearAll(fields.getAll(this.newEditor));
}

destip.setup = function()
{
	this.init('network-grid', 'move', 10, [
		{ type: 'text', maxlen: 32 }, 
		{ type: 'text', maxlen: 32 } 
	]);
	this.headerSet([ui.dtu_ip_title, ui.dtu_port_title]);

	for (var i = 0; i < dtu_network_json.length; i++)
		this.insertData(-1, [dtu_network_json[i][0], dtu_network_json[i][1]]);
	this.showNewEditor();
	this.resetNewEditor();
}


function verifyFields(focused, quiet)
{
	var cmd = "";
	var fom = E('_fom');
	E('save-button').disabled = true;

	var dtu_enable = E('_f_dtu_enable').checked;
	var dtu_id = E('_f_dtu_id').value;
	var dtu_proto = E('_f_dtu_proto').value;	
	var dtu_connect = E('_f_dtu_connect_proto').value;
	var dtu_type = E('_f_dtu_type').value;
	var dtu_interval=E('_f_interval').value;
	var dtu_retry=E('_f_retry').value;
	var dtu_idle=E('_f_idle').value;
	var dtu_min=E('_f_min').value;
	var dtu_max=E('_f_max').value;
	var dtu_local_ip=E('_f_local_ip').value;
	var dtu_local_port=E('_f_local_port').value;
	var dtu_pack_len=E('_f_pack_len').value;
	var dtu_pack_timeout=E('_f_pack_timeout').value;
	var dtu_peer = E('_f_dtu_peer').value;
	var dtu_polling = E('_f_polling_retry').value;
	var dtu_buf_nb = E('_f_buf').value;
	var dtu_debug = E('_f_dtu_debug').checked;
	var dtu_sourceif = E('_f_dtu_sourceif').value;
	var dtu_mode_str = "transparent";
	if(dtu_enable_cookie){
		dtu_enable = E('_f_dtu_enable').checked = dtu_enable_cookie;
	}		
	elem.display2(('_f_dtu_id'), ('_f_local_ip'), ('_f_local_port'), 0);
	elem.display2(('_f_dtu_proto'), ('_f_dtu_connect_proto'),('_f_dtu_type'), ('_f_interval'), ('_f_retry'), ('_f_idle'),('_f_min'), ('_f_max'),('_f_pack_len'), ('_f_pack_timeout'),('_f_dtu_peer'), ('_f_polling_retry'), ('_f_buf'), ('_f_dtu_debug'), ('_f_dtu_sourceif'),dtu_enable);

	if(dtu_sourceif == "IP"){
		elem.display2(('_f_local_ip'), dtu_enable);
	}
	if(dtu_proto == '1'){		
		if(dtu_connect == '1'){
			if(dtu_type == '1'){
				elem.display2(('_f_idle'), 0);
			}
		}else {
			elem.display2(('_f_dtu_type'),('_f_idle'),('_f_interval'), ('_f_retry'), ('_f_min'), ('_f_max'), ('_f_dtu_peer'),('_f_polling_retry'), 0);
			if(dtu_sourceif == "IP"){			
				elem.display2(('_f_local_port'), dtu_enable);
			}
		}
		if(dtu_peer == '2'){
			elem.display2(('_f_polling_retry'), 0);
		}
		display_disable_network(dtu_enable);
	}
	if(dtu_interval && dtu_retry){
		if(!v_range('_f_interval', quiet, 60, 180) || !v_range('_f_retry', quiet, 5, 10)) 
			return 0;
	}
	if(!v_range('_f_idle', quiet, 0, 65535)) return 0;
	if(!v_range('_f_min', quiet, 15, 180) || !v_range('_f_max', quiet, 180, 3600)) {
		return 0;
	}
	if(!v_range('_f_pack_len', quiet, 1, 1024)) return 0;
	if(!v_range('_f_pack_timeout', quiet, 10, 65535)) return 0;
	if(dtu_local_ip && !v_ip('_f_local_ip', quiet)) return 0;
	if(dtu_local_port && !v_range('_f_local_port', quiet, 1, 65535)) return 0;
	if(dtu_peer == '1'){
		if(!v_range('_f_polling_retry', quiet, 3, 10)) return 0;
	}
	if(dtu_enable !=dtu_enable_json){
		if(!dtu_enable){
			cmd = "!\n no dtu "+ dtu_id +"\n";
		}else {
			cmd += "!\ndtu "+ dtu_id + " mode transparent\n";
		}
	}

	if(dtu_proto != dtu_proto_json){
		switch(dtu_proto){
			case '1':{	
				break;			
			}
			case '2':{
				cookie.set('dtu-enable', dtu_enable);
				document.location = 'setup-dtu2-tcpserver.jsp';
				break;	
			}
			case '3':{
				cookie.set('dtu-enable', dtu_enable);
				document.location = 'setup-dtu2-rfc2217.jsp';
				break;	
			}
			case '4':{
				cookie.set('dtu-enable', dtu_enable);
				document.location = 'setup-dtu2-iec.jsp';
				break;	
			}
			case '5':{
				break;	
			}
			default :	
				break;	
		}
	}
	if(dtu_enable && dtu_proto == '1'){
		if(dtu_connect != dtu_connect_proto_json){
			if(dtu_connect == '1'){
				cmd += "!\ndtu "+ dtu_id + " mode "+dtu_mode_str+"\n";	
				cmd += "protocol tcp \n";
				if(dtu_local_port && dtu_local_ip){
					cmd += "!\ndtu 1 mode "+ dtu_mode_str+ "\n";
					cmd += "no ip local\n";
					cmd += "ip local "+ dtu_local_ip +"\n";
				}
			}else {
				cmd += "!\n dtu "+ dtu_id + " mode "+dtu_mode_str+"\n";	
				cmd += "protocol udp \n";
			}
		}
		if(dtu_connect == '1' && dtu_type != dtu_type_json){
			switch(dtu_type){
				case '1':{
					cmd += "!\n dtu "+ dtu_id + " mode "+dtu_mode_str+"\n";	
					cmd += "connection-type long-lived \n";
					cmd += " no idle-time\n";
					break;	
				}
				case '2':{
					cmd += "!\n dtu "+ dtu_id + " mode "+dtu_mode_str+"\n";	
					cmd += "connection-type short-lived\n";
					break;	
				}
			}
		}
		if(dtu_connect == '1' && (dtu_interval != dtu_interval_json || dtu_retry != dtu_retry_json)){
			if(dtu_interval && dtu_retry){
				cmd += "!\n dtu "+ dtu_id + " mode "+dtu_mode_str+"\n";	
				cmd += " keepalive "+ dtu_interval + " retry "+ dtu_retry + "\n";
			}else {
				cmd += "!\n dtu "+ dtu_id + " mode "+dtu_mode_str+"\n";	
				cmd += "no keepalive\n";
			}
		}
		if(dtu_connect == '1' && (dtu_idle != dtu_idle_json)){
			if(dtu_idle == ''){
				cmd += "!\n dtu "+ dtu_id + " mode "+dtu_mode_str+"\n";	
				cmd += " no idle-time\n";
			}else {
				cmd += "!\n dtu "+ dtu_id + " mode "+dtu_mode_str+"\n";	
				cmd += " idle-time "+ dtu_idle + "\n";
			}
		}
		if(dtu_min != dtu_min_json || dtu_max != dtu_max_json){
			cmd += "!\ndtu "+ dtu_id + " mode "+ dtu_mode_str+ "\n";	
			cmd += " reconnection " + dtu_min + " " + dtu_max + "\n";
		}
		if(dtu_buf_nb != dtu_buffer_json){
			cmd += "!\ndtu "+ dtu_id + " mode "+dtu_mode_str+ "\n";	
			cmd += " buffer-number " + dtu_buf_nb + "\n";
		}
		if(dtu_pack_len != dtu_pack_len_json){
			cmd += "!\ndtu "+ dtu_id + " mode "+ dtu_mode_str+ "\n";	
			cmd += " packet-size " + dtu_pack_len + "\n";
		}
		if(dtu_pack_timeout != dtu_pack_timeout_json){
			cmd += "!\ndtu "+ dtu_id + " mode "+ dtu_mode_str+ "\n";	
			cmd += " force-transmit " + dtu_pack_timeout + "\n";
		}
		if(dtu_peer != dtu_peer_json){
			if(dtu_peer == '1'){
				cmd += "!\ndtu "+ dtu_id + " mode "+dtu_mode_str+ "\n";	
				cmd += " peer-connect-mode polling retry " + dtu_polling + "\n";
			}else {
				cmd += "!\ndtu "+ dtu_id + " mode "+ dtu_mode_str+ "\n";	
				cmd += " peer-connect-mode parallel\n";
			}
		}else {
			if(dtu_peer == '1' && dtu_polling != dtu_polling_retry_json){	
				cmd += "!\ndtu "+ dtu_id + " mode "+ dtu_mode_str+ "\n";	
				cmd += " peer-connect-mode polling retry " + dtu_polling + "\n";
			}
		}
		if(dtu_debug != dtu_debug_json){
			if(dtu_debug){
				cmd += "!\ndtu "+ dtu_id + " mode "+ dtu_mode_str+ "\n";	
				cmd += " debug\n";

			}else {
				cmd += "!\ndtu "+ dtu_id + " mode "+ dtu_mode_str+ "\n";	
				cmd += " no debug\n";
			}
		}

		if(dtu_sourceif != dtu_sourceif_json){
			if(dtu_sourceif == "IP"){
				cmd += "!\ndtu 2 mode "+ dtu_mode_str+ "\n";
				cmd += "no local-interface\n";
				if(dtu_local_ip != dtu_local_ip_json ){
					if(dtu_local_ip ){
						if(dtu_local_port){
							cmd += "!\ndtu 2 mode "+ dtu_mode_str+ "\n";
							cmd += "ip local "+ dtu_local_ip +" port " + dtu_local_port +"\n";
						}else {
							cmd += "!\ndtu 2 mode "+ dtu_mode_str+ "\n";
							cmd += "ip local "+ dtu_local_ip +"\n";
						}
					}else {
						cmd += "!\ndtu 2 mode "+ dtu_mode_str+ "\n";
						cmd += "no ip local\n";
					}
				} else {
					if(dtu_local_port != dtu_local_port_json && dtu_local_ip){
						if(dtu_local_port){
							cmd += "!\ndtu 2 mode "+ dtu_mode_str+ "\n";
							cmd += "ip local "+ dtu_local_ip +" port " + dtu_local_port +"\n";
						}else {
							cmd += "!\ndtu 2 mode "+ dtu_mode_str+ "\n";
							cmd += "ip local "+ dtu_local_ip +"\n";
						}
					}
				}
			}else {
				if(dtu_sourceif){
					cmd += "!\ndtu 2 mode "+ dtu_mode_str+ "\n";
					cmd += "local-interface "+ dtu_sourceif +"\n";
				}else {
					cmd += "!\ndtu 2 mode "+ dtu_mode_str+ "\n";
					cmd += "no local-interface\n";

				}
			}	
		}
		var data = destip.getAllData();
		// delete
		for(var i = 0; i < dtu_network_json.length; i++) {
			var found = 0;
			for(var j = 0; j < data.length; j++) {
				if((dtu_network_json[i][0] == data[j][0])&& (dtu_network_json[i][1] == data[j][1])){
					found = 1;
					break;
				}
			}
			if(!found) {
				cmd += "!\ndtu "+ dtu_id + " mode "+ dtu_mode_str+ "\n";	
				cmd += "no ip peer " + dtu_network_json[i][0] + " port "+ dtu_network_json[i][1]+"\n";
			}
		}
		//add
		for(var i = 0; i < data.length; i++) {
			var found = 0;
			for(var j = 0; j < dtu_network_json.length; j++) {
				if(data[i][0] ==dtu_network_json[j][0] && data[i][1] ==dtu_network_json[j][1] ){
					found = 1;
				}
			}
			if(!found) {
				cmd += "!\ndtu "+ dtu_id + " mode "+ dtu_mode_str+ "\n";	
				cmd += "ip peer " + data[i][0] +" port " + data[i][1]+"\n";
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
	return 1;
}

function earlyInit()
{	
	destip.setup();
	verifyFields(null, true);
}

function save()
{
	if (!verifyFields(null, false)) return;	
	if (destip.isEditing()) return;

	
	if((E('_fom')._web_cmd.value != '')&&(cookie.get('autosave') == 1)){
		E('_fom')._web_cmd.value += "!"+"\n"+"copy running-config startup-config"+"\n";	
	}

	form.submit('_fom', 1);
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


<div class='section'>
<script type='text/javascript'>
grid_vif_opts_add(now_vifs_options, "IP");

var dtu_tb = [
		{ title: ui.enable, name: 'f_dtu_enable', type:'checkbox', value: dtu_enable_json == '1'},
		{ title: ui.dtu_id, name: 'f_dtu_id', type: 'text', maxlen: 8, size: 10, value: dtu_id_json },
		{ title: ui.dtu_prt, name: 'f_dtu_proto', type: 'select', options: proto_list, value: dtu_proto_json },
		{ title: ui.proto, name: 'f_dtu_connect_proto', type: 'select', options: connect_proto_list, value: dtu_connect_proto_json },
		{ title: ui.dtu_type, name: 'f_dtu_type', type: 'select', options: type_list, value: dtu_type_json },
		{ title: ui.dtu_keepalive_interval, name: 'f_interval', type: 'text', maxlen: 16, size: 16, suffix: ui.seconds, value: dtu_interval_json },
		{ title: ui.dtu_keepalive_retry, name: 'f_retry', type: 'text', maxlen: 16, size: 16, value: dtu_retry_json },
		{ title: ui.dtu_idle, name: 'f_idle', type: 'text', maxlen: 16, size: 16, suffix: ui.seconds+ infomsg.disable_msg, value: dtu_idle_json },	
		{ title: ui.dtu_buffer_nb, name: 'f_buf', type: 'select',options: buffer_list, value: dtu_buffer_json },
		{ title: ui.dtu_pack_len, name: 'f_pack_len', type: 'text', maxlen: 16, size: 16, value: dtu_pack_len_json },
		{ title: ui.dtu_pack_timeout, name: 'f_pack_timeout', type: 'text', maxlen: 16, size: 16, suffix: ui.mseconds, value: dtu_pack_timeout_json },
		{ title: ui.dtu_reconnection_min, name: 'f_min', type: 'text', maxlen: 16, size: 16, suffix: ui.seconds,value: dtu_min_json },
		{ title: ui.dtu_reconnection_max, name: 'f_max', type: 'text', maxlen: 16, size: 16, suffix: ui.seconds, value: dtu_max_json },	
		{ title: ui.dtu_peer, name: 'f_dtu_peer', type: 'select',options: peer_list,  value: dtu_peer_json },		
		{ title: ui.dtu_polling_retry, name: 'f_polling_retry', type: 'text', maxlen: 16, size: 16,  value: dtu_polling_retry_json },	
		{ title: openvpn.sourceif, name: 'f_dtu_sourceif', type: 'select', options:now_vifs_options, value: dtu_sourceif_json},	
		{ title: ui.dtu_local_ip, name: 'f_local_ip', type: 'text', maxlen: 16, size: 16, value: dtu_local_ip_json },
		{ title: ui.dtu_local_port, name: 'f_local_port', type: 'text', maxlen: 16, size: 16, value: dtu_local_port_json },
		{ title: ui.dtu_debug, name: 'f_dtu_debug', type:'checkbox', value: dtu_debug_json == '1'},
	];
createFieldTable('', dtu_tb);
</script>
</div>

<div id='network_title' class='section-title'>
<script type="text/javascript">
	GetText(ui.dtu_dst_ip);
</script>
</div>
<div id='network_body' class='section'>
	<table class='web-grid' id='network-grid'></table>
</div>

<script type='text/javascript'>
init();
if(cookie.get('autosave') == 1)
	ui.aply=ui.aply_save;
genStdFooter("");
</script>

<script type='text/javascript'>earlyInit()</script>
</form>
</body>
</html>

