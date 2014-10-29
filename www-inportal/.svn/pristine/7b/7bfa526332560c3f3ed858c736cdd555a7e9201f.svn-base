<% pagehead(menu.switch_vlan) %>

<style type='text/css'>
#vlan_grid  {
	width: 1130px;
	text-align: center;
}

</style>

<script type='text/javascript'>

<% ih_sysinfo() %>
<% ih_user_info() %>

<% web_exec('show running-config gre')%>
<% web_exec('show running-config crypto')%>

//var gre_config=[[1, 1, '1.1.1.1','1.2.3.4','1.1.1.2', 'abc123', '192.168.2.134', 'desc', 1, 1]];
//var gre_config = [[1, '2', '1.1.1.1', '255.255.255.0', '192.168.5.2', '1.1.1.2','123456', '1500', '192.168.5.1', 'abcd', 1,'1.1.1.2', 'abc123', 123, ''],
//	[1, '1', '1.1.1.1', '255.255.255.0', '192.168.5.2', '','123456', '1460', '192.168.5.1', 'abcd', 1,'1.1.1.2', 'abcdef', 123, 'test']];

<% web_exec('show interface')%>

//define option list
var vifs = [].concat(cellular_interface, eth_interface, sub_eth_interface, svi_interface, xdsl_interface, vp_interface);
var now_vifs_options = new Array();
now_vifs_options = grid_list_all_vif_opts(vifs);

var ipsecprof_options=[['', ui.disable]];
for(var i=0; i < ipsec_prof_config.length; i++) {
	ipsecprof_options.push([ipsec_prof_config[i][0], ipsec_prof_config[i][0]]);
}

var gre_cookie = cookie.get('gre-modify');
if (gre_cookie == null){
	gre_cookie = 0;
}
//else{
//	cookie.unset('gre-modify');
//}

var dest_gre = gre_cookie;
var dest_gre_config = [];
if (dest_gre){
	for (var i = 0; i < gre_config.length; i++){
		if (dest_gre == gre_config[i][1]){	//gre index
			dest_gre_config = gre_config[i];
			break;
		}
	}
} else {
	dest_gre_config = [0,'','','','','','','','','',0,'','',,'',0,0];
}

var gre_enable_json = dest_gre_config[0];
var gre_index_json = dest_gre_config[1];
var gre_local_vip_json = dest_gre_config[2];
var gre_local_netmask_json = dest_gre_config[3];
var gre_peer_ip_json = dest_gre_config[4];
var gre_peer_vip_json = dest_gre_config[5];
var gre_key_json = dest_gre_config[6];
var gre_mtu_json = dest_gre_config[7];
var gre_local_ip_json = dest_gre_config[8];
var gre_descr_json = dest_gre_config[9];
var nhrp_enable_json = dest_gre_config[10];
var nhs_ip_json = dest_gre_config[11];
var nhrp_auth_json = dest_gre_config[12];
var nhrp_holdtime_json = dest_gre_config[13];
//var ipsec_protection_json = (dest_gre_config[12]=='')?0:1;
var ipsec_profile_json = dest_gre_config[14];
var gre_if_type_json = dest_gre_config[15];
//var nhrp_cisco_json = dest_gre_config[16];
var nhrp_purge_json = dest_gre_config[16];

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
	for (var i = 0; i < gre_config.length; i++){
		if (new_gid == gre_config[i][1])	
			return 1;
	}

	return 0;
}


function back()
{
	document.location = 'setup-gre-tunnel.jsp';	
}

function verifyFields(focused, quiet)
{
	var cmd = "";
	var fom = E('_fom');

	var gre_enable = E('_f_gre_enable').checked;
	var nhrp_enable = E('_f_nhrp_enable').checked;

	var network_type = E('_f_network_type').value;
	var gre_local_vip=E('_f_local_vip').value;
	var gre_local_netmask=E('_f_local_netmask').value;
	var gre_peer_vip=E('_f_peer_vip').value;
	var gre_peer_ip=E('_f_peer_ip').value;
	var gre_key=E('_f_key').value;
	var gre_mtu=E('_f_mtu').value;
//	var gre_local_ip=E('_f_local_ip').value;
	var gre_local_type=E('_f_local_typ').value;
	var gre_local_addr=E('_f_local_addr').value;
	var gre_local_if=E('_f_local_if').value;
	var gre_descr=E('_f_descr').value;
	var nhrp_auth=E('_f_nhrp_auth').value;
	var nhrp_nhs_ip=E('_f_nhs_ip').value;
	var nhrp_holdtime=E('_f_hold_time').value;
	var ipsec_profile=E('_f_ipsec_profile').value;
//	var nhrp_cisco=E('_f_nhrp_cisco').checked;
	var nhrp_purge=E('_f_nhrp_purge').checked;

	elem.display2(('_f_gre_index'), ('_f_network_type'), ('_f_local_vip'), ('_f_peer_ip'), ('_f_peer_vip'),
					('_f_key'), ('_f_mtu'), ('_f_local_typ'), ('_f_local_addr'), ('_f_local_if'), ('_f_descr'), ('_f_nhrp_enable'), 
					('_f_ipsec_profile'), gre_enable);

//	elem.display_and_enable(('_f_nhrp_auth'), ('_f_nhs_ip'), ('_f_hold_time'), gre_enable & nhrp_enable);
	elem.display2(('_f_nhrp_auth'), ('_f_nhs_ip'), ('_f_hold_time'),('_f_nhrp_purge'), gre_enable & nhrp_enable);

//	if(E('_f_network_type').value == '1') {
	if(network_type == '1') {
//		elem.display2(('_f_peer_vip'), 1);
		elem.display2(('_f_peer_vip'), gre_enable);
		elem.display2(('_f_local_netmask'), 0);
	} else {
		elem.display2(('_f_peer_vip'), 0);
//		elem.display2(('_f_local_netmask'), 1);
		elem.display2(('_f_local_netmask'), gre_enable);
	}

	if(gre_local_type == '0') {		//IP
//		cookie.set('src_type', '0');
		elem.display2(('_f_local_addr'), gre_enable);
		elem.display2(('_f_local_if'), 0);
	} else if(gre_local_type == '1') {	//INTERFACE
//		cookie.set('src_type', '1');
		elem.display2(('_f_local_if'), gre_enable);
		elem.display2(('_f_local_addr'), 0);
	}

	if(gre_enable_json!=gre_enable) {
		cmd += "!\n";
		cmd += "interface tunnel " +E('_f_gre_index').value+"\n";
		if(gre_enable) {
			cmd += "no shutdown\n";
		}else {
			cmd += "shutdown\n";
		}
	}
	if(E('_f_gre_index').disabled == false) {
		if(existTunnel(E('_f_gre_index').value)) {
			ferror.set('_f_gre_index', errmsg.bad_name4, quiet);
			return 0;
		} else if(!v_range('_f_gre_index', quiet, 1, 100)) {
			return 0;
		} else {
			ferror.clear('_f_gre_index');
		}
		cmd += "!\n";
		cmd += "interface tunnel "+E('_f_gre_index').value + "\n";
	}

//		if(E('_f_network_type').value == '1') {	//point to point
	if(network_type == '1') {	//point to point
		if(!v_ip('_f_local_vip', quiet)) return 0; 
		if(!v_ip('_f_peer_vip', quiet)) return 0;
		if((gre_local_vip != gre_local_vip_json) || (gre_peer_vip != gre_peer_vip_json)) {

			cmd += "!\n";
			cmd += "interface tunnel "+E('_f_gre_index').value+"\n";
			cmd += "ip address local "+gre_local_vip+" peer "+gre_peer_vip+"\n";
		}
		
	} else {	//subnet
		if(!v_ip('_f_local_vip', quiet)) return 0; 
		if(!v_netmask('_f_local_netmask', quiet)) return 0;
		if((gre_local_vip != gre_local_vip_json) || (gre_local_netmask != gre_local_netmask_json)) {

			cmd += "!\n";
			cmd += "interface tunnel "+E('_f_gre_index').value+"\n";
			cmd += "ip address "+gre_local_vip+" "+gre_local_netmask+"\n";

		}
	}

	if(!v_ip('_f_peer_ip', quiet)) return 0;
	if(gre_peer_ip != gre_peer_ip_json) {
		cmd += "!\n";
		cmd += "interface tunnel "+E('_f_gre_index').value+"\n";
		cmd += "tunnel destination "+gre_peer_ip+"\n";
	}

	if(gre_key != gre_key_json) {
		if(gre_key == "") {
			cmd += "!\n";
			cmd += "interface tunnel "+E('_f_gre_index').value+"\n";
			cmd += "no tunnel key\n";
		} else {
			if(!v_range('_f_key', quiet, 0, 2147483646)) {
				return 0;	
			} else {
				cmd += "!\n";
				cmd += "interface tunnel "+E('_f_gre_index').value+"\n";
				cmd += "tunnel key "+gre_key+"\n";
			}
		}			
	}

	if (!v_info_num_range('_f_mtu', quiet, true, 64, 1524)) return 0;
	if(gre_mtu != gre_mtu_json) {
		if(gre_mtu == "") {
			cmd += "!\n";
			cmd += "interface tunnel "+E('_f_gre_index').value+"\n";
			cmd += "no ip mtu\n";			
		} else {
				cmd += "!\n";
				cmd += "interface tunnel "+E('_f_gre_index').value+"\n";
				cmd += "ip mtu "+gre_mtu+"\n";
		}			
	}
/*
	if(gre_local_ip != gre_local_ip_json) {
		if(!v_ip('_f_local_ip', quiet)) {
			return 0;
		} else {
			cmd += "!\n";
			cmd += "interface tunnel "+E('_f_gre_index').value+"\n";
			cmd += "tunnel source "+gre_local_ip+"\n";
		}
	}
*/
	if(gre_local_type == '0') {
		if(!v_ip('_f_local_addr', quiet)) return 0;
		if(gre_local_addr != gre_local_ip_json) {
			cmd += "!\n";
			cmd += "interface tunnel "+E('_f_gre_index').value+"\n";
			cmd += "tunnel source "+gre_local_addr+"\n";
		}
	} else if(gre_local_type == '1') {
		if(gre_local_if != gre_local_ip_json) {
			cmd += "!\n";
			cmd += "interface tunnel "+E('_f_gre_index').value+"\n";
			cmd += "tunnel source "+gre_local_if+"\n";
		}
	}

	if (!v_info_description('_f_descr', quiet, true)) return 0;
	if(gre_descr != gre_descr_json) {
			cmd += "!\n";
			cmd += "interface tunnel "+E('_f_gre_index').value+"\n";
			if(gre_descr != '') {
				cmd += "description "+gre_descr+"\n";
			} else {
				cmd += "no description\n";
			}
	}
	if(!nhrp_enable) {
		if(nhrp_enable_json) {
			cmd += "!\n";
			cmd += "interface tunnel "+E('_f_gre_index').value+"\n";
			cmd += "no ip nhrp nhs\n";
			cmd += "no ip nhrp map\n";
			cmd += "no ip nhrp registration\n";
			cmd += "no ip nhrp authentication\n";
		}
	} else {
		if(!v_ip('_f_nhs_ip', quiet)) return 0;
//			if(!v_range('_f_hold_time', quiet, 1, 65535)) return 0;
/*
		if(network_type == '1') {	//point to point
			if(gre_peer_vip != nhrp_nhs_ip) {
				show_alert('The nhs ip address must be same with peer virtual ip');
//					ferror.set('_f_nhs_ip', 'The nhs ip address must be same with peer virtual ip', quiet);	
				return 0;
			}
		}
*/

		if(nhrp_nhs_ip != nhs_ip_json) {
			cmd += "!\n";
			cmd += "interface tunnel "+E('_f_gre_index').value+"\n";
			cmd += "no ip nhrp nhs\n";
			cmd += "no ip nhrp map\n";
			cmd += "ip nhrp nhs "+nhrp_nhs_ip+"\n";
			cmd += "ip nhrp map "+nhrp_nhs_ip+" "+gre_peer_ip+"\n";
		}else if(gre_peer_ip != gre_peer_ip_json){
			cmd += "!\n";
			cmd += "interface tunnel "+E('_f_gre_index').value+"\n";
			cmd += "no ip nhrp map\n";
			cmd += "ip nhrp map "+nhrp_nhs_ip+" "+gre_peer_ip+"\n";
		} 

		if(nhrp_holdtime != nhrp_holdtime_json) {
			if(nhrp_holdtime == "") {
				cmd += "!\n";
				cmd += "interface tunnel "+E('_f_gre_index').value+"\n";
				cmd += "no ip nhrp holdtime\n";
			} else {
				if(!v_range('_f_hold_time', quiet, 1, 65535)) { 
					return 0;
				} else {
					cmd += "!\n";
					cmd += "interface tunnel "+E('_f_gre_index').value+"\n";
					cmd += "ip nhrp holdtime "+nhrp_holdtime+"\n";
				}
			}
		}

		if(nhrp_auth != nhrp_auth_json) {
			if(nhrp_auth == "") {
				cmd += "!\n";
				cmd += "interface tunnel "+E('_f_gre_index').value+"\n";
				cmd += "no ip nhrp authentication\n";
			} else {
				if(!v_length('_f_nhrp_auth', quiet, 1, 128)) {
					return 0;
				} else {
					cmd += "!\n";
					cmd += "interface tunnel "+E('_f_gre_index').value+"\n";
					cmd += "ip nhrp authentication "+ nhrp_auth +"\n";
				}
			}
		}
		
		if(!nhrp_enable_json) {
			cmd += "!\n";
			cmd += "interface tunnel "+E('_f_gre_index').value+"\n";
			cmd += "ip nhrp registration\n";
		}
		/*
		if(nhrp_cisco != nhrp_cisco_json){
			if(!nhrp_cisco){
				cmd += "!\n";
				cmd += "interface tunnel "+E('_f_gre_index').value+"\n";
				cmd += "no ip nhrp cisco-compatibility\n";
			}else {
				cmd += "!\n";
				cmd += "interface tunnel "+E('_f_gre_index').value+"\n";
				cmd += "ip nhrp cisco-compatibility\n";
			}
		}
		*/
		if(nhrp_purge != nhrp_purge_json){
			if(!nhrp_purge){
				cmd += "!\n";
				cmd += "interface tunnel "+E('_f_gre_index').value+"\n";
				cmd += "no ip nhrp purge forbid\n";
			}else {
				cmd += "!\n";
				cmd += "interface tunnel "+E('_f_gre_index').value+"\n";
				cmd += "ip nhrp purge forbid\n";
			}
		}	
	}
	
	if(ipsec_profile != ipsec_profile_json) {
		cmd += "!\n";
		cmd += "interface tunnel "+E('_f_gre_index').value+"\n";
		if(ipsec_profile == '') {
			cmd += "no tunnel protection\n";
		} else {
			cmd += "tunnel protection ipsec profile "+ipsec_profile+"\n";
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

function earlyInit()
{
/*
	if((cookie.get('src_type')) == null) {
		if(gre_if_type_json == '0') {	//IP
			cookie.set('src_type', '0');
		} else {	//INTERFACE
			cookie.set('src_type', '1');
		
		}
	}
*/	
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

var gre_tb = [
					{ title: ui.enable, name: 'f_gre_enable', type:'checkbox', value: gre_enable_json },
					{ title: gre_tun.index, name: 'f_gre_index', type: 'text', maxlen: 8, size: 10, value: gre_index_json },
					{ title: gre_tun.network_type, name: 'f_network_type', type: 'select', options: [
						['1', gre_tun.point_to_point], 
						['2', gre_tun.subnet]], 
						value: cookie.get('gre-network-type')},
					{ title: gre_tun.local_v_ip, name: 'f_local_vip', type: 'text', maxlen: 16, size: 16, value: gre_local_vip_json },
					{ title: gre_tun.peer_v_ip, name: 'f_peer_vip', type: 'text', maxlen: 16, size: 16, value: gre_peer_vip_json },
					{ title: gre_tun.local_netmask, name: 'f_local_netmask', type: 'text', maxlen: 16, size: 16, value: gre_local_netmask_json },
//					{ title: 'Local IP', name: 'f_local_ip', type: 'text', maxlen: 16, size: 16, value: gre_local_ip_json },
//					{ title: 'Source Type', name: 'f_local_typ', type: 'select', options:[['0', 'IP'], ['1', 'INTERFACE']], value: cookie.get('src_type')},
					{ title: gre_tun.source_type, name: 'f_local_typ', type: 'select', options:[['0', 'IP'], ['1', ui.iface]], value: (gre_if_type_json == '0')?'0':'1'},
					{ title: gre_tun.local_ip, indent: 2, name: 'f_local_addr', type: 'text', maxlen: 16, size: 16, value: gre_local_ip_json },
					{ title: gre_tun.local_interface, indent: 2, name: 'f_local_if', type: 'select', options: now_vifs_options, value: gre_local_ip_json },
//TODO:interface or IP test
//					{ title: 'Local IP', name: 'f_local_address', type: 'text', maxlen: 16, size: 16, value: gre_local_ip_json },
					{ title: gre_tun.peer_ip, name: 'f_peer_ip', type: 'text', maxlen: 16, size: 16, value: gre_peer_ip_json },
					{ title: gre_tun.key, name: 'f_key', type: 'password', maxlen: 16, size: 16, value: gre_key_json },
					{ title: gre_tun.mtu, name: 'f_mtu', type: 'text', maxlen: 16, size: 16, value: gre_mtu_json },
					{ title: gre_tun.nhrp_enable, name: 'f_nhrp_enable', type:'checkbox', value: nhrp_enable_json==1 },
					{ title: gre_tun.nhs_ip_address, indent: 2, name: 'f_nhs_ip', type:'text', maxlen: 16, size: 16, value: nhs_ip_json },
					{ title: gre_tun.authentic, indent: 2, name: 'f_nhrp_auth', type:'password', maxlen: 16, size: 16, value: nhrp_auth_json },
					{ title: gre_tun.hold_time, indent: 2, name: 'f_hold_time', type:'text', maxlen: 16, size: 16, value: (nhrp_holdtime_json=='0')?"":nhrp_holdtime_json },
					//{ title: gre_tun.cisco, indent: 2, name: 'f_nhrp_cisco', type:'checkbox', value: nhrp_cisco_json==1},
					{ title: gre_tun.purge, indent: 2, name: 'f_nhrp_purge', type:'checkbox', value: nhrp_purge_json==1},
//					{ title: 'IPsec Protection', name: 'f_ipsec_protect', type:'checkbox', value: ipsec_protection_json },
//					{ title: 'IPsec Profile', name: 'f_ipsec_profile', type:'text', maxlen: 16, size: 16, value: ipsec_profile_json },
					{ title: gre_tun.ipsec_profile, name: 'f_ipsec_profile', type:'select', options: ipsecprof_options, value: ipsec_profile_json },
					{ title: gre_tun.description, name: 'f_descr', type: 'text', maxlen: 128, size: 16, value: gre_descr_json }
				];


createFieldTable('', gre_tb);

if(dest_gre) E('_f_gre_index').disabled = true;

</script>
</div>

<script type='text/javascript'>
init();
if(cookie.get('autosave') == 1)
	ui.aply=ui.aply_save;
genStdFooterWithBack("");
</script>

<script type='text/javascript'>earlyInit()</script>
</form>
</body>
</html>
