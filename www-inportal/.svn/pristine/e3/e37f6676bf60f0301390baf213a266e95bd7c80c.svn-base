<% pagehead(menu.dtu2) %>

<script type='text/javascript'>

<% ih_sysinfo() %>
<% ih_user_info() %>

dtu_config_tcpserver =  ['1', '2','2','1' , '60', '5', '0', '10002', '1024', '100', '4', '0', ''];

<% web_exec('show running-config dtu 2')%>
<% web_exec('show interface')%>

var proto_list = [['1',ui.dtu_tran], 
		['2', ui.dtu_tcpserver],
		['3', ui.dtu_rfc2217],
		['4', ui.dtu_iec]
		//['5', ui.dtu_mb_bridge]
		];

var vifs = [].concat(cellular_interface, eth_interface, sub_eth_interface, xdsl_interface, vp_interface, openvpn_interface);
var now_vifs_options = new Array();
now_vifs_options = grid_list_all_vif_opts(vifs);

var type_list = [['1',ui.dtu_tcp_long], 
		['2', ui.dtu_tcp_short]];

var buffer_list = [['1','1'], ['2','2'],['3','3'],['4','4']];

var dtu_enable_json = dtu_config_tcpserver[0];
var dtu_id_json = dtu_config_tcpserver[1];
var dtu_proto_json = dtu_config_tcpserver[2];
var dtu_type_json = dtu_config_tcpserver[3];
var dtu_interval_json = dtu_config_tcpserver[4];
var dtu_retry_json = dtu_config_tcpserver[5];
var dtu_idle_json = dtu_config_tcpserver[6];
var dtu_local_port_json = dtu_config_tcpserver[7];
var dtu_pack_len_json = dtu_config_tcpserver[8];
var dtu_pack_timeout_json = dtu_config_tcpserver[9];
var dtu_buffer_json  = dtu_config_tcpserver[10];
var dtu_debug_json= dtu_config_tcpserver[11];
var dtu_sourceif_json = dtu_config_tcpserver[12];


var dtu_enable_cookie=cookie.get('dtu-enable');
if(dtu_enable_cookie){
	var dtu_enable = dtu_enable_cookie;
	cookie.unset('dtu-enable');
} else {
	var dtu_enable = null;
}


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

function verifyFields(focused, quiet)
{
	var cmd = "";
	var fom = E('_fom');
	E('save-button').disabled = true;
	dtu_enable = E('_f_dtu_enable').checked;
	var dtu_id = E('_f_dtu_id').value;
	var dtu_proto = E('_f_dtu_proto').value;	
	var dtu_type = E('_f_dtu_type').value;
	var dtu_interval=E('_f_interval').value;
	var dtu_retry=E('_f_retry').value;
	var dtu_idle=E('_f_idle').value;
	var dtu_local_port=E('_f_local_port').value;
	var dtu_pack_len=E('_f_pack_len').value;
	var dtu_pack_timeout=E('_f_pack_timeout').value;
	var dtu_buf_nb = E('_f_buf').value;
	var dtu_debug = E('_f_dtu_debug').checked;
	var dtu_sourceif = E('_f_dtu_sourceif').value;
	var dtu_mode_str = "tcp-server";
	if(dtu_enable_cookie){
		dtu_enable = E('_f_dtu_enable').checked = dtu_enable_cookie;
	}		
	elem.display2(('_f_dtu_id'), 0);
	elem.display2(('_f_dtu_proto'),('_f_dtu_type'), ('_f_local_port'), ('_f_interval'), ('_f_retry'), ('_f_idle') , ('_f_pack_len'), ('_f_pack_timeout'), ('_f_buf'), ('_f_dtu_debug'), ('_f_dtu_sourceif'),dtu_enable);

	if(dtu_type == '1'){
		elem.display2(('_f_idle'), 0);
	}
	if(dtu_interval && dtu_retry){
		if(!v_range('_f_interval', quiet, 60, 180) || !v_range('_f_retry', quiet, 5, 10)) 
			return 0;
	}
	if(!v_range('_f_idle', quiet, 0, 65535)) return 0;
	if(!v_range('_f_local_port', quiet, 1, 65535)) return 0;
	if(!v_range('_f_pack_len', quiet, 1, 1024)) return 0;
	if(!v_range('_f_pack_timeout', quiet, 10, 65535)) return 0;
	
	if(dtu_enable && dtu_proto != dtu_proto_json){
		switch(dtu_proto){
			case '1':{	
				cookie.set('dtu-enable', dtu_enable);
				document.location = 'setup-dtu2.jsp';
				break;			
			}
			case '2':{
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
	if(dtu_enable !=dtu_enable_json){
		if(!dtu_enable){
			cmd = "!\n no dtu "+ dtu_id +"\n";
		}else {
			cmd += "!\ndtu "+ dtu_id + " mode tcp-server\n";
		}
	}
	if(dtu_enable){
		if(dtu_type != dtu_type_json){
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
		if(dtu_interval != dtu_interval_json || dtu_retry != dtu_retry_json){
			if(dtu_interval && dtu_retry){
				cmd += "!\n dtu "+ dtu_id + " mode "+dtu_mode_str+"\n";	
				cmd += " keepalive "+ dtu_interval + " retry "+ dtu_retry + "\n";
			}else {
				cmd += "!\n dtu "+ dtu_id + " mode "+dtu_mode_str+"\n";	
				cmd += "no keepalive\n";
			}
		}
		if(dtu_idle != dtu_idle_json ){
			if(dtu_idle == ''){
				cmd += "!\n dtu "+ dtu_id + " mode "+dtu_mode_str+"\n";	
				cmd += " no idle-time\n";
			}else {
				cmd += "!\n dtu "+ dtu_id + " mode "+dtu_mode_str+"\n";	
				cmd += " idle-time "+ dtu_idle + "\n";
			}
		}
		if( dtu_local_port != dtu_local_port_json) {	
			cmd += "!\ndtu "+ dtu_id + " mode "+ dtu_mode_str+ "\n";	
			cmd += "port "+ dtu_local_port+ "\n";
			
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
			if(dtu_sourceif){
				cmd += "!\ndtu "+ dtu_id + " mode "+ dtu_mode_str+ "\n";
				cmd += "local-interface "+ dtu_sourceif +"\n";
			}else {
				cmd += "!\ndtu "+ dtu_id + " mode "+ dtu_mode_str+ "\n";
				cmd += "no local-interface\n";
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
	verifyFields(null, true);
}

function save()
{
	if (!verifyFields(null, false)) return;	
	
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
grid_vif_opts_add(now_vifs_options, "");

var dtu_tb = [
		{ title: ui.enable, name: 'f_dtu_enable', type:'checkbox', value: dtu_enable_json == '1'},
		{ title: ui.dtu_id, name: 'f_dtu_id', type: 'text', maxlen: 8, size: 10, value: dtu_id_json },
		{ title: ui.dtu_prt, name: 'f_dtu_proto', type: 'select', options: proto_list, value: dtu_proto_json },
		{ title: ui.dtu_type, name: 'f_dtu_type', type: 'select', options: type_list, value: dtu_type_json },
		{ title: ui.dtu_keepalive_interval, name: 'f_interval', type: 'text', maxlen: 16, size: 16, suffix: ui.seconds, value: dtu_interval_json },
		{ title: ui.dtu_keepalive_retry, name: 'f_retry', type: 'text', maxlen: 16, size: 16, value: dtu_retry_json },
		{ title: ui.dtu_idle, name: 'f_idle', type: 'text', maxlen: 16, size: 16, suffix: ui.seconds+ infomsg.disable_msg, value: dtu_idle_json },	
		{ title: ui.dtu_local_port, name: 'f_local_port', type: 'text', maxlen: 16, size: 16, value: dtu_local_port_json },
		{ title: ui.dtu_buffer_nb, name: 'f_buf', type: 'select',options: buffer_list, value: dtu_buffer_json },
		{ title: ui.dtu_pack_len, name: 'f_pack_len', type: 'text', maxlen: 16, size: 16, value: dtu_pack_len_json },
		{ title: ui.dtu_pack_timeout, name: 'f_pack_timeout', type: 'text', maxlen: 16, size: 16, suffix: ui.mseconds, value: dtu_pack_timeout_json },
		{ title: openvpn.sourceif, name: 'f_dtu_sourceif', type: 'select', options:now_vifs_options, value: dtu_sourceif_json},
		{ title: ui.dtu_debug, name: 'f_dtu_debug', type:'checkbox', value: dtu_debug_json == '1'},
	];
createFieldTable('', dtu_tb);
</script>
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

