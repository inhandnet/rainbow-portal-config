<% pagehead(menu.dtu1) %>

<script type='text/javascript'>

<% ih_sysinfo() %>
<% ih_user_info() %>

dtu_config_rfc2217 = ['1', '1', '3','3696', '6', ''];

<% web_exec('show running-config dtu 1')%>
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

var dtu_enable_cookie=cookie.get('dtu-enable');
if(dtu_enable_cookie){
	var dtu_enable = dtu_enable_cookie;
	cookie.unset('dtu-enable');
} else {
	var dtu_enable = null;
}

var dtu_enable_json = dtu_config_rfc2217[0];
var dtu_id_json = dtu_config_rfc2217[1];
var dtu_proto_json = dtu_config_rfc2217[2];
var dtu_rfc2217_port_json = dtu_config_rfc2217[3];
var dtu_debug_json = dtu_config_rfc2217[4];
var dtu_sourceif_json = dtu_config_rfc2217[5];

if(dtu_config_rfc2217[4] == '7'){	
	var dtu_debug_json= '1';
}else {
	var dtu_debug_json= '0';
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
	var dtu_proto = E('_f_dtu_proto').value;	
	var dtu_rfc2217_port = E('_f_dtu_rfc2217_port').value;	
	var dtu_debug = E('_f_dtu_debug').checked;
	var dtu_sourceif = E('_f_dtu_sourceif').value;
	if(dtu_enable_cookie){
		dtu_enable = E('_f_dtu_enable').checked = dtu_enable_cookie;
	}
	elem.display2(('_f_dtu_proto'), ('_f_dtu_rfc2217_port'), ('_f_dtu_debug'), ('_f_dtu_sourceif'),dtu_enable);
	
	if(!v_range('_f_dtu_rfc2217_port', quiet, 1, 65535)) return 0;
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
				break;	
			}
			case '4':{
				cookie.set('dtu-enable', dtu_enable);
				document.location = 'setup-dtu1-iec.jsp';
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
			cmd += "!\n no dtu 1\n";
		}else {
			cmd += "!\ndtu 1 mode rfc2217\n";	
		}
	}
	if(dtu_enable && dtu_rfc2217_port != dtu_rfc2217_port_json){
		cmd += "!\ndtu 1 mode rfc2217\n";
		cmd += " port " + dtu_rfc2217_port + "\n";
	}
	if(dtu_enable && dtu_debug != dtu_debug_json){
		if(dtu_debug){
			cmd += "!\ndtu 1 mode rfc2217\n";	
			cmd += " debug\n";

		}else {
			cmd += "!\ndtu 1 mode rfc2217\n";	
			cmd += " no debug\n";
		}
	}
	if(dtu_enable && dtu_sourceif != dtu_sourceif_json){
		if(dtu_sourceif){
			cmd += "!\ndtu 1 mode rfc2217\n";
			cmd += " local-interface "+ dtu_sourceif +"\n";
		}else {
			cmd += "!\ndtu 1 mode rfc2217\n";
			cmd += " no local-interface\n";
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
		{ title: ui.dtu_local_port, name: 'f_dtu_rfc2217_port', type: 'text', maxlen: 16, size: 16, value: dtu_rfc2217_port_json },	
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

