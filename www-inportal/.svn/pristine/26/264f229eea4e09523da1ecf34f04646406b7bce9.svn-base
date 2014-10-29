<% pagehead(menu.cert_mgr) %>

<script type='text/javascript'>

<% ih_sysinfo() %>
<% ih_user_info() %>
<% web_exec('show running-config openvpn')%>
//var openvpn_client_config=[[1,'2','10.5.3.199', '1194', '2','192.168.0.1','192.168.0.2','1','1', '0', 1, '10','60','topology p2p;dev-type tun1;','first client', '1', 'asdasdfdavdvcdcascawed','cisco','hxd']];
<% web_exec('show interface')%>

//define option list
//var vifs = [].concat(cellular_interface, eth_interface, sub_eth_interface, svi_interface, xdsl_interface, vp_interface);
var vifs = [].concat(cellular_interface, eth_interface, sub_eth_interface, svi_interface, xdsl_interface, vp_interface);
var now_vifs_options = new Array();
now_vifs_options = grid_list_all_vif_opts(vifs);

var tls_start="-----BEGIN OpenVPN Static key V1-----";
var tls_end="-----END OpenVPN Static key V1-----";
var auth_type = [['0',openvpn.auth_none],
		['1', openvpn.auth_userpass],
		['2', openvpn.auth_statickey],
		['3', openvpn.auth_psk],
		['4', openvpn.auth_psk_tls],
		['5', openvpn.auth_psk_tls_up]];
var cipher_key= [['0','Default'],
	['1','DES-CFB'],
	['2','DES-CBC'],
	['3','RC2-CBC'],
	['4','RC2-CFB'],
	['5','RC2-OFB'],
	['6','DES-EDE-CBC'],
	['7','DES-EDE3-CBC'],
	['8','DES-OFB'],
	['9','DES-EDE-CFB'],
	['10','DES-EDE3-CFB'],
	['11','DES-EDE-OFB'],
	['12','DES-EDE3-OFB'],
	['13','DESX-CBC'],	
	['14','BF-CBC'],	
	['15','BF-CFB'],	
	['16','BF-OFB'],	
	['17','RC2-40-CBC'],	
	['18','CAST5-CBC'],
	['19','CAST5-CFB'],	
	['20','CAST5-OFB'],
	['21','RC2-64-CBC'],	
	['22','AES-128-CBC'],	
	['23','AES-128-OFB'],
	['24','AES-128-CFB'],
	['25','AES-192-CBC'],
	['26','AES-192-OFB'],
	['27','AES-192-CFB'],
	['28','AES-256-CBC'],
	['29','AES-256-OFB'],
	['30','AES-256-CFB'],
	['31','AES-128-CFB1'],	
	['32','AES-192-CFB1'],	
	['33','AES_256_CFB1'],
	['34','AES-128-CFB8'],
	['35','AES-192-CFB8'],	
	['36','AES-256-CFB8'],	
	['37','DES-CFB1'],	
	['38','DES-CFB8']];
var iftype=[['1','tun'], ['2','tap']];
var prototype=[['1','udp'],['2','tcp']];
var modetype=[['1','net30'],['2','p2p'],['3','subnet']];

var ovpn_id = cookie.get('openvpn-autoconfig');
var openvpn_cookie = cookie.get('openvpn-modify');
var openvpn_client_instance_config =[1,'','', '1194', '1','','','1','1', '0', 0, '60', '300','', '','0', '','','','','1500','0'];
if (openvpn_cookie == null){
	openvpn_cookie = 0;
}	
if (openvpn_cookie){
	for (var i = 0; i < openvpn_client_config.length; i++){
		if ( openvpn_cookie == openvpn_client_config[i][1]){
			openvpn_client_instance_config = openvpn_client_config[i];
			break;
		}
	}	
}
if(ovpn_id){
	openvpn_client_instance_config[1]=ovpn_id;
}
var openvpn_enable_json = openvpn_client_instance_config[0];
var openvpn_index_json = openvpn_client_instance_config[1];
var openvpn_serverip_json = openvpn_client_instance_config[2];
var openvpn_port_json = openvpn_client_instance_config[3];
var openvpn_mode_json = openvpn_client_instance_config[4];
var openvpn_localip_json = openvpn_client_instance_config[5];
var openvpn_remoteip_json = openvpn_client_instance_config[6];
var openvpn_iftype_json= openvpn_client_instance_config[7];
var openvpn_proto_json= openvpn_client_instance_config[8];
var openvpn_cipher_json= openvpn_client_instance_config[9];
var openvpn_compression_json = openvpn_client_instance_config[10];
var openvpn_interval_json = openvpn_client_instance_config[11];
var openvpn_timeout_json = openvpn_client_instance_config[12];
var openvpn_config_json = openvpn_client_instance_config[13].replace(/\#/g, "\n");
var openvpn_descr_json = openvpn_client_instance_config[14];
var openvpn_auth_json = openvpn_client_instance_config[15];
var openvpn_tls_json = openvpn_client_instance_config[16];
var openvpn_user_json = openvpn_client_instance_config[17];
var openvpn_passwd_json = openvpn_client_instance_config[18];
var openvpn_sourceif_json= openvpn_client_instance_config[19];
var openvpn_mtu_json= openvpn_client_instance_config[20];
var openvpn_debug_json= openvpn_client_instance_config[21];

var new_tls_key=changeTLSKey();

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

//if the index exist
function existTunnel(new_gid)
{
	for (var i = 0; i < openvpn_client_config.length; i++){
		if (new_gid == openvpn_client_config[i][1])	
			return 1;
	}

	return 0;
}


function back()
{
	document.location = 'setup-openvpn-client-intro.jsp';	
}

//if the index exist
function changeTLSKey()
{
	return openvpn_tls_json.replace(/\#/g, "\n");
}

function verifyFields(focused, quiet)
{
	var cmd = "";
	var fom = E('_fom');

	E('save-button').disabled = true;

	var enable = E('_f_openvpn_enable').checked;
	var advance = E('_f_openvpn_advanced').checked;
	var index = E('_f_openvpn_index').value;
	var serverip=E('_f_openvpn_serverip').value;
	var port=E('_f_openvpn_port').value;
	var mode=E('_f_openvpn_mode').value;
	var localip=E('_f_openvpn_localip').value;
	var remoteip=E('_f_openvpn_remoteip').value;
	var if_type=E('_f_openvpn_if').value;
	var proto=E('_f_openvpn_proto').value;
	var cipher=E('_f_openvpn_cipher').value;
	var com_lzo=E('_f_openvpn_compression').checked;
	var interval=E('_f_openvpn_interval').value;
	var timeout=E('_f_openvpn_timeout').value;
	var config=E('_f_openvpn_config').value;
	var descr=E('_f_openvpn_descr').value;
	var auth=E('_f_openvpn_auth').value;
	var tls=E('_f_openvpn_tls').value;
	var user=E('_f_openvpn_user').value;
	var passwd=E('_f_openvpn_passwd').value;
	var sourceif =E('_f_openvpn_sourceif').value;
	var user2=E('_f_openvpn_user2').value;
	var passwd2=E('_f_openvpn_passwd2').value;
	var debug = E('_f_openvpn_debug').checked; 
	var mtu = E('_f_openvpn_mtu').value;

	if((tls.indexOf(tls_start)>0) && (tls.indexOf(tls_end)>0)){
		ferror.set('_f_openvpn_tls', errmsg.bad_name4, quiet);
		return 0;
	}else {
		var tls_key_content = tls.replace(tls_start, "");
		var tls_content=  tls_key_content.replace(tls_end, "");
	}

	elem.display2(('_f_openvpn_enable'),1);
	elem.display2(('_f_openvpn_index'),enable);
	if(ovpn_id){
		elem.display2(('_f_openvpn_serverip'),('_f_openvpn_port'),('_f_openvpn_auth'), ('_f_openvpn_advanced'),('_f_openvpn_descr'),('_f_openvpn_mode'), ('_f_openvpn_if'), ('_f_openvpn_proto'),('_f_openvpn_cipher'),('_f_openvpn_compression'),('_f_openvpn_interval'),('_f_openvpn_timeout'),('_f_openvpn_sourceif'), ('_f_openvpn_config'),('_f_openvpn_localip'), ('_f_openvpn_remoteip'),('_f_openvpn_tls'),('_f_openvpn_user'),('_f_openvpn_passwd'), ('_f_openvpn_mtu'), ('_f_openvpn_debug'), 0);
		//cache username/passwd
		elem.display2(('_f_openvpn_user2'),1);
		elem.display2(('_f_openvpn_passwd2'),1);
		//check para
		if(!v_range('_f_openvpn_index', quiet, 1, 10)) {
			return 0;
		}
	}else {	
		elem.display2(('_f_openvpn_serverip'),('_f_openvpn_port'),('_f_openvpn_auth'), ('_f_openvpn_advanced'),('_f_openvpn_descr'),enable);	
		if(advance){
			cookie.set('f_openvpn_advanced', 1);
		}else{
			cookie.set('f_openvpn_advanced', 0);
		}
		elem.display2( ('_f_openvpn_mode'), ('_f_openvpn_if'), ('_f_openvpn_proto'),('_f_openvpn_cipher'),('_f_openvpn_compression'),('_f_openvpn_interval'),('_f_openvpn_timeout'),('_f_openvpn_sourceif'), ('_f_openvpn_config'), ('_f_openvpn_debug'), ('_f_openvpn_mtu'), (enable & advance));
		if( enable & advance){
			if(mode == '2'){//p2p
				elem.display2(('_f_openvpn_localip'), ('_f_openvpn_remoteip'),1);
				if(!v_ip('_f_openvpn_localip', quiet)) return 0;
				if(!v_ip('_f_openvpn_remoteip', quiet)) return 0;
			}else {
				elem.display2(('_f_openvpn_localip'), ('_f_openvpn_remoteip'),0);
			}	
		}else {
			elem.display2(('_f_openvpn_localip'), ('_f_openvpn_remoteip'),0);
		}
		if(enable){
			if(auth == '1'){
				elem.display2(('_f_openvpn_tls'),0);
				elem.display2(('_f_openvpn_user'),1);
				elem.display2(('_f_openvpn_passwd'),1);
			}else if(auth == '2'){
				elem.display2(('_f_openvpn_tls'),1);
				elem.display2(('_f_openvpn_user'),0);
				elem.display2(('_f_openvpn_passwd'),0);
			}else if(auth == '3'){
				elem.display2(('_f_openvpn_tls'),0);
				elem.display2(('_f_openvpn_user'),0);
				elem.display2(('_f_openvpn_passwd'),0);
			}else if(auth == '4'){
				elem.display2(('_f_openvpn_tls'),1);
				elem.display2(('_f_openvpn_user'),0);
				elem.display2(('_f_openvpn_passwd'),0);
			}else if(auth == '5'){
				elem.display2(('_f_openvpn_tls'),1);
				elem.display2(('_f_openvpn_user'),1);
				elem.display2(('_f_openvpn_passwd'),1);
			}else {
				elem.display2(('_f_openvpn_tls'),0);
				elem.display2(('_f_openvpn_user'),0);
				elem.display2(('_f_openvpn_passwd'),0);
			}
		}else {
			elem.display2(('_f_openvpn_tls'),0);
			elem.display2(('_f_openvpn_user'),0);
			elem.display2(('_f_openvpn_passwd'),0);
		}
		//cache username/passwd
		elem.display2(('_f_openvpn_user2'),0);
		elem.display2(('_f_openvpn_passwd2'),0);
		//check para
		if(!v_range('_f_openvpn_index', quiet, 1, 10)) {
			return 0;
		}
		if(!v_ip('_f_openvpn_serverip', quiet)) return 0;
		if(!v_range('_f_openvpn_port', quiet, 1, 65535)) {
			return 0;
		}
		if(interval){
			if(!v_range('_f_openvpn_interval', quiet, 10, 1800)) {
				return 0;
			}	
		}
		if(timeout){
			if(!v_range('_f_openvpn_timeout', quiet, 60, 3600)) {
				return 0;
			}
		}
		if(mtu){
			if(!v_range('_f_openvpn_mtu', quiet, 128, 1500)) {
				return 0;
			}
		}
	}
	
	//generate CMD
	if(!enable){
		if(index){
			if(enable != openvpn_enable_json){
				cmd += "!\n";
				cmd += "interface openvpn " + index +"\n";
				cmd += "shutdown\n";
			}
		}
	}else {
		if(ovpn_id){
			cmd += "!\n";
			cmd += "interface openvpn " + ovpn_id +"\n";
			cmd += "auto-configuration import web\n";
			if(descr!=openvpn_descr_json){
				cmd += "!\n";
				cmd += "interface openvpn " + index +"\n";
				if(descr){
					cmd += "description "+ descr +"\n";
				}else {
					cmd += "no description\n";
				}
			}
			if(user2 !=openvpn_user_json || passwd2 != openvpn_passwd_json){
				if(user2 && passwd2){
					cmd += "!\n";
					cmd += "interface openvpn " + index +"\n";
					cmd += "username "+ user2 + " password " + passwd2 +"\n";
				}else {
					cmd += "!\n";
					cmd += "interface openvpn " + index +"\n";
					cmd += "no username\n";
				}
			}
		}else {
			if(index){
				if(!openvpn_cookie){
					if(existTunnel(index)) {
						ferror.set('_f_openvpn_index', errmsg.bad_name4, quiet);
						return 0;
					} else {
						ferror.clear('_f_openvpn_index');
					}
				}
				if(enable != openvpn_enable_json){
					cmd += "!\n";
					cmd += "interface openvpn " + index +"\n";
					cmd += "no shutdown\n";
				}
				if(serverip != openvpn_serverip_json || port !=openvpn_port_json){
					if(serverip && port){
						cmd += "!\n";
						cmd += "interface openvpn " + index +"\n";
						cmd += "ip remote-server "+serverip+" port "+port+"\n";
					}
				}
				if(proto != openvpn_proto_json){
					cmd += "!\n";
					cmd += "interface openvpn " + index +"\n";
					cmd += "protocol "+prototype[proto-1][1]+"\n";		
				}
				switch(mode){
					case '1':{
						if(mode != openvpn_mode_json){
							cmd += "!\n";
							cmd += "interface openvpn " + index +"\n";
							cmd += "mode p2p topology "+modetype[mode-1][1]+"\n";	
							if(localip && remoteip){
								cmd += "no ip address static local "+ localip +" peer "+ remoteip +"\n";	
							}
						}
						break;
					}
					case '2':{
						if(mode != openvpn_mode_json){
							cmd += "!\n";
							cmd += "interface openvpn " + index +"\n";
							cmd += "mode p2p topology "+modetype[mode-1][1]+"\n";	
						}
						if(localip != openvpn_localip_json || remoteip != openvpn_remoteip_json){
							if(localip && remoteip){
								cmd += "!\n";
								cmd += "interface openvpn " + index +"\n";
								cmd += "ip address static local "+ localip +" peer "+ remoteip +"\n";	
							}
						}
						break;
					}
					case '3':{
						if(mode != openvpn_mode_json){
							cmd += "!\n";
							cmd += "interface openvpn " + index +"\n";
							cmd += "mode server topology "+modetype[mode-1][1]+"\n";
							if(localip && remoteip){
								cmd += "no ip address static local "+ localip +" peer "+ remoteip +"\n";	
							}
						}	
						break;
					}
					
				}
				if(sourceif != openvpn_sourceif_json){
					if(sourceif){
						cmd += "!\n";
						cmd += "interface openvpn " + index +"\n";
						cmd += "ip local interface "+ sourceif +"\n";
					}else {
						cmd += "!\n";
						cmd += "interface openvpn " + index +"\n";
						cmd += "no ip local interface " +"\n";
					}
				}
				if(if_type != openvpn_iftype_json){
					cmd += "!\n";
					cmd += "interface openvpn " + index +"\n";
					cmd += "interface-type "+iftype[if_type-1][1]+"\n";
				}		
				if(cipher != openvpn_cipher_json){
					cmd += "!\n";
					cmd += "interface openvpn " + index +"\n";
					if(cipher!='0'){
						cmd += "cipher "+cipher_key[cipher][1]+"\n";
					}else {
						cmd += "no cipher\n";
					}
				}
				if(com_lzo != openvpn_compression_json){
					cmd += "!\n";
					cmd += "interface openvpn " + index +"\n";
					if(com_lzo ){
						cmd += "compression lzo\n";
					}else {
						cmd += "no compression\n";
					}
				}
				if(interval !=  openvpn_interval_json || timeout !=  openvpn_timeout_json){
					cmd += "!\n";
					cmd += "interface openvpn " + index +"\n";
					if(interval &&  timeout){
						cmd += "keepalive "+interval+" "+timeout+"\n";
					}else {
						cmd += "no keepalive\n";
					}
				}
				if(config != openvpn_config_json){
					cmd += "!\n";
					cmd += "interface openvpn " + index +"\n";
					if(config){
						var config_cmd= config.replace(/[' ']/g,"+");
						cmd += "expert-option import web "+ config_cmd.replace(/[\n]/g,"#")+"\n";
					}else {
						cmd += "no expert-option\n";
					}
				}
				if(descr!=openvpn_descr_json){
					cmd += "!\n";
					cmd += "interface openvpn " + index +"\n";
					if(descr){
						cmd += "description "+ descr +"\n";
					}else {
						cmd += "no description\n";
					}
				}
				if(debug != openvpn_debug_json){
					if(debug){
						cmd += "!\ninterface openvpn " + index +"\n";	
						cmd += " debug\n";

					}else {
						cmd += "\ninterface openvpn " + index +"\n";	
						cmd += " no debug\n";
					}
				}
				if(mtu != openvpn_mtu_json){
					if(mtu !=1500){
						cmd += "!\ninterface openvpn " + index +"\n";	
						cmd += " ip mtu "+ mtu + "\n";

					}else {
						cmd += "\ninterface openvpn " + index +"\n";	
						cmd += " no ip mtu\n";
					}
				}
				switch(auth){
					case '0':{
						if(auth != openvpn_auth_json){
							cmd += "!\n";
							cmd += "interface openvpn " + index +"\n";
							cmd += "no authentication\n";
						}
						if(user !=openvpn_user_json){
							if(!user){
								cmd += "!\n";
								cmd += "interface openvpn " + index +"\n";
								cmd += "no username\n";
							}
						}
						break;
					}
					case '1':{
					
						if(auth != openvpn_auth_json){
							cmd += "!\n";
							cmd += "interface openvpn " + index +"\n";
							cmd += "authentication username-password\n";
						}
						if(user !=openvpn_user_json || passwd != openvpn_passwd_json){
							if(user && passwd){
								cmd += "!\n";
								cmd += "interface openvpn " + index +"\n";
								cmd += "username "+ user + " password " + passwd +"\n";
							}else {
								cmd += "!\n";
								cmd += "interface openvpn " + index +"\n";
								cmd += "no username\n";
							}
						}
						break;
					}
					case '2':{
						if(auth != openvpn_auth_json){
							cmd += "!\n";
							cmd += "interface openvpn " + index +"\n";
							cmd += "authentication preshared-key\n";
						}
						if(tls != new_tls_key){
							if(tls_content){
								cmd += "!\n";
								cmd += "interface openvpn " + index +"\n";
								cmd+="tls-authentication import web "+ tls_content.replace(/[\n]/g,"#")+"\n";
							}
						}
						break;
					}
					case '3':{
						if(auth != openvpn_auth_json){
							cmd += "!\n";
							cmd += "interface openvpn " + index +"\n";
							cmd += "authentication x509-cert\n";
						}
						break;
					}
					case '4':{
						if(auth != openvpn_auth_json){
							cmd += "!\n";
							cmd += "interface openvpn " + index +"\n";
							cmd += "authentication  x509-tls-cert\n";
						}
						if(tls != new_tls_key){
							if(tls_content){
								cmd += "!\n";
								cmd += "interface openvpn " + index +"\n";
								cmd+="tls-authentication import web "+ tls_content.replace(/[\n]/g,"#")+"\n";
							}
						}
						break;
					}
					case '5':{
						if(auth != openvpn_auth_json){
							cmd += "!\n";
							cmd += "interface openvpn " + index +"\n";
							cmd += "authentication  x509-tls-username-password\n";
						}
						if(tls != new_tls_key){
							if(tls_content){
								cmd += "!\n";
								cmd += "interface openvpn " + index +"\n";
								cmd+="tls-authentication import web "+ tls_content.replace(/[\n]/g,"#")+"\n";
							}
						}
						if(user !=openvpn_user_json || passwd != openvpn_passwd_json){
							if(user && passwd){
								cmd += "!\n";
								cmd += "interface openvpn " + index +"\n";
								cmd += "username "+ user + " password " + passwd +"\n";
							}else {
								cmd += "!\n";
								cmd += "interface openvpn " + index +"\n";
								cmd += "no username\n";
							}
						}
						break;
					}				
				}
			}
		}
	}
	//alert(cmd);
	if (user_info.priv < admin_priv) {
		elem.display('save-button', false);
	}else{
		elem.display('save-button', true);
		fom._web_cmd.value = cmd;
		E('save-button').disabled = (cmd=="");	
	}
	return 1;
}

function fix(name)
{
	var i;
	if (((i = name.lastIndexOf('/')) > 0) || ((i = name.lastIndexOf('\\')) > 0))
		name = name.substring(i + 1, name.length);
	return name;
}

function importButton(suffix)
{
	var fom = E('ovpn_form');
	var id = E('_f_openvpn_index').value;
	var name, i;
	var cmd = "";

	name = fix(fom.filename.value);	
	name = name.toLowerCase();
	if(id<1 || id >10){
		alert(errmsg.badopenvpnid);
		return;
	}
	if ((name.length <= 4) || (name.substring(name.length - 4, name.length).toLowerCase() != suffix)) {
		alert(errmsg.invalid_fname);
		return;
	}
	if (!show_confirm(infomsg.confm)) return;
    	fom.submit();
	cookie.set('openvpn-id', id);
	//document.location = 'setup-openvpn-clientN.jsp';
}
function earlyInit()
{	
	if(cookie.get('f_openvpn_advanced') == null) {
		cookie.set('f_openvpn_advanced', 0);
	}
	cookie.unset('openvpn-autoconfig');
	cookie.unset('openvpn-id');
	verifyFields(null, true);
}

function init()
{
	if((cookie.get('autosave')) == null){
		cookie.set('autosave', 1);
	}
}

function save()
{
	if (!verifyFields(null, false)) return;	
	
	if ((cookie.get('debugcmd') == 1))
		alert(E('_fom')._web_cmd.value);
	
	if((E('_fom')._web_cmd.value != '')&&(cookie.get('autosave') == 1)){
		E('_fom')._web_cmd.value += "!"+"\n"+"copy running-config startup-config"+"\n";	
	}

	form.submit('_fom', 1);
}

</script>
</head>

<body onload='init()'>
<form id='_fom' method='post' action='apply.cgi'>
<input type='hidden' name='_web_cmd' value=''>
<div class='section'>
<script type='text/javascript'>
grid_vif_opts_add(now_vifs_options, "");
var openvpn_tb = [
		{ title: openvpn.enable, name: 'f_openvpn_enable', type:'checkbox', value: openvpn_enable_json },
		{ title: openvpn.index, name: 'f_openvpn_index', type: 'text', maxlen: 8, size: 10, value: openvpn_index_json },
		{ title: openvpn.serverip, name: 'f_openvpn_serverip', type: 'text', maxlen: 16, size: 10, value: openvpn_serverip_json },
		{ title: openvpn.port, name: 'f_openvpn_port', type: 'text', maxlen: 8, size: 10, value: openvpn_port_json },
		{ title: openvpn.auth_type, name: 'f_openvpn_auth', type: 'select', options: auth_type, value: openvpn_auth_json},		
		{ title: openvpn.tls_key, name: 'f_openvpn_tls', type: 'textarea', cols: 20, rows:10, value: new_tls_key },
		{ title: openvpn.username, name: 'f_openvpn_user', type: 'text', maxlen: 16, size: 16, value: openvpn_user_json },
		{ title: openvpn.passwd, name: 'f_openvpn_passwd', type: 'password', maxlen: 16, size: 16, value: openvpn_passwd_json },
		{ title: openvpn.description, name: 'f_openvpn_descr', type: 'text', maxlen: 16, size: 16, value: openvpn_descr_json },
{ title: '<b>' + ui.advanced + '</b>', indent: 0, name: 'f_openvpn_advanced', type: 'checkbox', value :cookie.get('f_openvpn_advanced')==1},		
		{ title: openvpn.sourceif, name: 'f_openvpn_sourceif', type: 'select', options:now_vifs_options, value: openvpn_sourceif_json},
		{ title: ui.network, name: 'f_openvpn_mode', type: 'select', options:modetype, value: openvpn_mode_json},
		{ title: openvpn.localip, name: 'f_openvpn_localip', type: 'text', maxlen: 16, size: 16, value: openvpn_localip_json },
		{ title: openvpn.remoteip, name: 'f_openvpn_remoteip', type: 'text', maxlen: 16, size: 16, value: openvpn_remoteip_json },
		{ title: openvpn.iftype, name: 'f_openvpn_if', type: 'select', options: iftype, value: openvpn_iftype_json},
		{ title: openvpn.prototype, name: 'f_openvpn_proto', type: 'select', options: prototype, value: openvpn_proto_json},
		{ title: openvpn.cipher, name: 'f_openvpn_cipher', type: 'select', options: cipher_key, value:openvpn_cipher_json},
		{ title: openvpn.compression, name: 'f_openvpn_compression', type:'checkbox', value: openvpn_compression_json },
		{ title: openvpn.interval, name: 'f_openvpn_interval', type: 'text', maxlen: 16, size: 16, suffix: ui.second, value: openvpn_interval_json },
		{ title: openvpn.timeout, name: 'f_openvpn_timeout', type: 'text', maxlen: 16, size: 16, suffix: ui.second, value: openvpn_timeout_json },
		{ title: ui.mtu, name: 'f_openvpn_mtu', type: 'text', maxlen: 16, size: 16, value: openvpn_mtu_json },
		{ title: ui.dtu_debug, name: 'f_openvpn_debug', type:'checkbox', value: openvpn_debug_json == '1'},
		{ title: openvpn.exception, name: 'f_openvpn_config', type: 'textarea', cols: 20, rows:10, value:openvpn_config_json }
		];
createFieldTable('', openvpn_tb);
</script>
</div>
</form>

<div class='section-title' id='router_section_title'><script type='text/javascript'>W(ui.import_config)</script></div>
<div class='section' id='ovpn_section'>
	<form id='ovpn_form' method='post' action='upload.cgi' encType='multipart/form-data'>
		<input type='hidden' name='type' value='config_ovpn' />
		<input type='file' size='40' id='ovpn_import' name='filename' value='default.ovpn'>
		<script type='text/javascript'>
			W("<input type='button' name='import_button' style='width:100px' value='" + ui.impt + "' onclick='importButton(\"ovpn\")' id='ovpn-import-button'>");
			W("<input type='button' name='backup_button' onclick='backupButton(\"ca\", \".crt\")' style='width:100px' value='" + ui.expt  + "'>");
			if(ovpn_id) E('ovpn_form').import_button.disabled = true;
			E('ovpn_form').backup_button.disabled = true;
		</script>
	</form>
</div>

<form id='_basic_fom' method='post' action='apply.cgi'>
<input type='hidden' name='_web_cmd' value=''>
<div class='section'>
<script type='text/javascript'>
var openvpn_basic=[
		{ title: openvpn.username, name: 'f_openvpn_user2', type: 'text', maxlen: 16, size: 16, value: openvpn_user_json },
		{ title: openvpn.passwd, name: 'f_openvpn_passwd2', type: 'password', maxlen: 16, size: 16, value: openvpn_passwd_json },
];
createFieldTable('', openvpn_basic);
if(openvpn_cookie) E('_f_openvpn_index').disabled = true;
</script>
</div>
</form>

<script type='text/javascript'>
init();
if(cookie.get('autosave') == 1)
	ui.aply=ui.aply_save;
genStdFooter("");
</script>

<script type='text/javascript'>earlyInit()</script>
</body>
</html>
