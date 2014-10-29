<% pagehead(menu.dtu1) %>

<script type='text/javascript'>

<% ih_sysinfo() %>
<% ih_user_info() %>

dtu_config_iec = ['1', '1', '4', '1', '1', '1','1', '2', '2', '0', '2', '2404', '0', ''];

<% web_exec('show running-config dtu 1')%>
<% web_exec('show interface')%>

var proto_list = [['1',ui.dtu_tran], 
		['2', ui.dtu_tcpserver],
		['3', ui.dtu_rfc2217],
		['4', ui.dtu_iec]
		//['5', ui.dtu_mb_bridge]
		];

var iec_mode = [['0',ui.dtu_iec_unbal], 
		['1', ui.dtu_iec_bal]
		];

var iec_byte = [['1',ui.dtu_iec_one_byte], 
		['2', ui.dtu_iec_two_byte]
		];

var vifs = [].concat(cellular_interface, eth_interface, sub_eth_interface, xdsl_interface, vp_interface, openvpn_interface);
var now_vifs_options = new Array();
now_vifs_options = grid_list_all_vif_opts(vifs);

var dtu_enable_json = dtu_config_iec[0];
var dtu_id_json = dtu_config_iec[1];
var dtu_proto_json = dtu_config_iec[2];
var iec_101_mode_json = dtu_config_iec[3];
var iec_101_linkaddr_size_json = dtu_config_iec[4];
var iec_101_linkaddr_json = dtu_config_iec[5];
var iec_101_cot_size_json = dtu_config_iec[6];
var iec_101_asdu_size_json = dtu_config_iec[7];
var iec_101_ioa_size_json = dtu_config_iec[8];
var iec_101_poll_json = dtu_config_iec[9];
var iec_104_cot_size_json = dtu_config_iec[10];
var iec_104_port_json = dtu_config_iec[11];
var dtu_debug_json = dtu_config_iec[12];
var dtu_sourceif_json = dtu_config_iec[13];
if(dtu_config_iec[12] == '3'){
	 dtu_debug_json = '1';
}else {
	 dtu_debug_json = '0';
}

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
	var id =  dtu_id_json;
	dtu_enable = E('_f_dtu_enable').checked;
	var dtu_proto = E('_f_dtu_proto').value;	
	var iec_101_mode = E('_f_101_mode').value;
	var iec_101_linkaddr_len = E('_f_101_linkaddr_len').value;
	var iec_101_link_addr = E('_f_101_linkaddr').value;
	var iec_101_cot = E('_f_101_cot').value;
	var iec_101_asdu = E('_f_101_asdu').value;
	var iec_101_ioa = E('_f_101_ioa').value;
	var iec_101_poll = E('_f_101_poll').value;
	var iec_104_cot = E('_f_104_cot').value;
	var iec_104_port = E('_f_104_port').value;
	var dtu_debug = E('_f_dtu_debug').checked;
	var dtu_sourceif = E('_f_dtu_sourceif').value;

	if(dtu_enable_cookie){
		dtu_enable = E('_f_dtu_enable').checked = dtu_enable_cookie;
	}
	elem.display2(('_f_101_poll'),0);
	elem.display2(('_f_dtu_proto'), ('_f_101_mode'), ('_f_101_linkaddr_len'), ('_f_101_linkaddr'), ('_f_101_cot'), ('_f_101_asdu'),('_f_101_ioa'),  ('_f_104_cot'), ('_f_104_port'), ('_f_dtu_debug'), ('_f_dtu_sourceif'),  dtu_enable);
	if(iec_101_mode == '0'){
		elem.display2(('_f_101_poll'),dtu_enable);
	}
	if(iec_101_linkaddr_len == '1'){
		if(!v_range('_f_101_linkaddr', quiet, 0, 254)) return 0;
	}else{ 
		if(!v_range('_f_101_linkaddr', quiet, 0, 65534)) return 0;
	}
	if(!v_range('_f_101_poll', quiet, 0, 65535)) return 0;
	if(!v_range('_f_104_port', quiet, 1, 65535)) return 0;
	
	if(dtu_enable && (dtu_proto != dtu_proto_json)){
		switch(dtu_proto){
			case '1':{	
				cookie.set('dtu-enable', dtu_enable);
				document.location = 'setup-dtu1.jsp';
				break;			
			}
			case '2':{
				cookie.set('dtu-enable', dtu_enable);
				document.location = 'setup-dtu1-tcpserver.jsp';
				break;	
			}
			case '3':{
				cookie.set('dtu-enable', dtu_enable);
				document.location = 'setup-dtu1-rfc2217.jsp';
				break;	
			}
			case '4':{
				break;	
			}
			default :	
				break;	
		}
	}

	if(dtu_enable !=dtu_enable_json){
		if(!dtu_enable){
			cmd += "!\n no dtu "+id+"\n";
		}else {
			cmd += "!\ndtu "+id+" mode iec101-104\n";	
		}
	}
	if(dtu_enable && iec_101_mode != iec_101_mode_json){
		if(iec_101_mode == '0'){
			cmd += "!\ndtu "+id+" mode iec101-104\n";	
			cmd += " iec101 mode unbalance\n";
		}else {
			cmd += "!\ndtu "+id+" mode iec101-104\n";
			cmd += " iec101 mode balance\n";
			cmd += " no iec101 poll-interval\n";
		}
	}
	if(dtu_enable && 
		(iec_101_linkaddr_len != iec_101_linkaddr_size_json || 
		iec_101_link_addr != iec_101_linkaddr_json)){
		if(iec_101_linkaddr_len == '1'){
			cmd += "!\ndtu "+id+" mode iec101-104\n";	
			cmd += " iec101 link-address-size one-byte "+ iec_101_link_addr +"\n";
		}else {
			cmd += "!\ndtu "+id+" mode iec101-104\n";
			cmd += " iec101 link-address-size two-bytes "+ iec_101_link_addr +"\n";
		} 
	}
	if(dtu_enable && iec_101_cot != iec_101_cot_size_json){
		if(iec_101_cot == '1'){
			cmd += "!\ndtu "+id+" mode iec101-104\n";	
			cmd += " iec101 cot-size 1\n";
		}else {
			cmd += "!\ndtu "+id+" mode iec101-104\n";
			cmd += " iec101 cot-size 2\n";
		}
	}
	if(dtu_enable && iec_101_asdu != iec_101_asdu_size_json){
		if(iec_101_asdu == '1'){
			cmd += "!\ndtu "+id+" mode iec101-104\n";	
			cmd += " iec101 asdu-size 1\n";
		}else {
			cmd += "!\ndtu "+id+" mode iec101-104\n";
			cmd += " iec101 asdu-size 2\n";
		}
	}
	if(dtu_enable && iec_101_ioa != iec_101_ioa_size_json){
		if(iec_101_ioa == '1'){
			cmd += "!\ndtu "+id+" mode iec101-104\n";	
			cmd += " iec101 ioa-size 1\n";
		}else {
			cmd += "!\ndtu "+id+" mode iec101-104\n";
			cmd += " iec101 ioa-size 2\n";
		}
	}
	if(dtu_enable && iec_101_poll != iec_101_poll_json){
		cmd += "!\ndtu "+id+" mode iec101-104\n";	
		cmd += " iec101 poll-interval "+ iec_101_poll +"\n";
	}
	if(dtu_enable && iec_104_cot != iec_104_cot_size_json){
		if(iec_104_cot == '1'){
			cmd += "!\ndtu "+id+" mode iec101-104\n";	
			cmd += " iec104 cot-size 1\n";
		}else {
			cmd += "!\ndtu "+id+" mode iec101-104\n";
			cmd += " iec104 cot-size 2\n";
		}
	}
	if(dtu_enable && iec_104_port != iec_104_port_json){
		cmd += "!\ndtu "+id+" mode iec101-104\n";	
		cmd += " iec104 port "+ iec_104_port +"\n";
	}
	if(dtu_enable && dtu_debug != dtu_debug_json){
		if(dtu_debug){
			cmd += "!\ndtu "+id+" mode iec101-104\n";		
			cmd += " debug\n";

		}else {
			cmd += "!\ndtu "+id+" mode iec101-104\n";	
			cmd += " no debug\n";
		}
	}
	if(dtu_enable && dtu_sourceif != dtu_sourceif_json){
		if(dtu_sourceif){
			cmd += "!\ndtu 1 mode iec101-104\n";
			cmd += "local-interface "+ dtu_sourceif +"\n";
		}else {
			cmd += "!\ndtu 1 mode iec101-104\n";
			cmd += "no local-interface\n";
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
		{ title: ui.dtu_prt, name: 'f_dtu_proto', type: 'select', options: proto_list, value: dtu_proto_json },
		{ title: ui.dtu_iec_mode, name: 'f_101_mode', type: 'select', options: iec_mode, value: iec_101_mode_json },
		{ title: ui.dtu_iec_link_addr_len, name: 'f_101_linkaddr_len', type: 'select', options: iec_byte, value: iec_101_linkaddr_size_json },
		{ title: ui.dtu_iec_link_addr, name: 'f_101_linkaddr', type: 'text', maxlen: 16, size: 16, value: iec_101_linkaddr_json },
		{ title: ui.dtu_iec_cot_len, name: 'f_101_cot', type: 'select', options: iec_byte, value: iec_101_cot_size_json },
		{ title: ui.dtu_iec_asdu_addr_len, name: 'f_101_asdu', type: 'select', options: iec_byte, value: iec_101_asdu_size_json },
		{ title: ui.dtu_iec_ioa_len, name: 'f_101_ioa', type: 'select', options: iec_byte, value: iec_101_ioa_size_json },
		{ title: ui.dtu_iec_poll, name: 'f_101_poll', type: 'text', maxlen: 16, size: 16, suffix: ui.seconds+ infomsg.disable_msg, value: iec_101_poll_json },
		{ title: ui.dtu_104_cot, name: 'f_104_cot', type: 'select', options: iec_byte, value: iec_104_cot_size_json },
		{ title: ui.dtu_104_port, name: 'f_104_port', type: 'text', maxlen: 16, size: 16, value: iec_104_port_json },
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

