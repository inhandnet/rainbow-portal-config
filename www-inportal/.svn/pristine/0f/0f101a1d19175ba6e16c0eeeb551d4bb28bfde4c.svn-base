<% pagehead(menu.wizard_ipsec) %>

<script type='text/javascript'>

<% ih_sysinfo(); %>
<% ih_user_info(); %>
<% web_exec('show interface')%>
var vifs = [].concat(cellular_interface, eth_interface, sub_eth_interface, svi_interface, xdsl_interface, gre_interface,openvpn_interface,vp_interface);
var now_vifs_options = new Array();
now_vifs_options = grid_list_all_vif_opts(vifs);

var ike_policies = [['3des-md5-modp768', '3DES-MD5-DH1'], ['3des-md5-modp1024', '3DES-MD5-DH2'], ['3des-md5-modp1536', '3DES-MD5-DH5'], ['3des-sha1-modp768', '3DES-SHA1-DH1'], ['3des-sha1-modp1024', '3DES-SHA1-DH2'], ['3des-sha1-modp1536', '3DES-SHA1-DH5'], ['aes128-md5-modp768', 'AES128-MD5-DH1'], ['aes128-md5-modp1024', 'AES128-MD5-DH2'], ['aes128-md5-modp1536', 'AES128-MD5-DH5'], ['aes128-sha1-modp768', 'AES128-SHA1-DH1'], ['aes128-sha1-modp1024', 'AES128-SHA1-DH2'], ['aes128-sha1-modp1536', 'AES128-SHA1-DH5'], ['des-md5-modp768', 'DES-MD5-DH1'], ['des-md5-modp1024', 'DES-MD5-DH2'], ['des-md5-modp1536', 'DES-MD5-DH5'], ['des-sha1-modp768', 'DES-SHA1-DH1'], ['des-sha1-modp1024', 'DES-SHA1-DH2'], ['des-sha1-modp1536', 'DES-SHA1-DH5'], ['aes192-md5-modp768', 'AES192-MD5-DH1'], ['aes192-md5-modp1024', 'AES192-MD5-DH2'], ['aes192-md5-modp1536', 'AES192-MD5-DH5'], ['aes192-sha1-modp768', 'AES192-SHA1-DH1'], ['aes192-sha1-modp1024', 'AES192-SHA1-DH2'], ['aes192-sha1-modp1536', 'AES192-SHA1-DH5'], ['aes256-md5-modp768', 'AES256-MD5-DH1'], ['aes256-md5-modp1024', 'AES256-MD5-DH2'], ['aes256-md5-modp1536', 'AES256-MD5-DH5'], ['aes256-sha1-modp768', 'AES256-SHA1-DH1'], ['aes256-sha1-modp1024', 'AES256-SHA1-DH2'], ['aes256-sha1-modp1536', 'AES256-SHA1-DH5']];
var ipsec_policies = [['3des-md5-96', '3DES-MD5-96'], ['3des-sha1-96', '3DES-SHA1-96'], ['aes128-md5-96', 'AES128-MD5-96'], ['aes128-sha1-96', 'AES128-SHA1-96'], ['des-md5-96', 'DES-MD5-96'], ['des-sha1-96', 'DES-SHA1-96'], ['aes192-md5-96', 'AES192-MD5-96'], ['aes192-sha1-96', 'AES192-SHA1-96'], ['aes256-md5-96', 'AES256-MD5-96'], ['aes256-sha1-96', 'AES256-SHA1-96'], ['md5-96', 'AH-MD5-96'], ['sha1-96', 'AH-SHA1-96']];
var ipsec_auth_types = [['0', ipsec.shared_key],['1', ipsec.cert]];
var ipsec_id_types = [['0', ui.ip],['1', 'User FQDN'], ['2', 'FQDN']];
var ipsec_startup_modes = [['0', ipsec.auto],['1', ipsec.dod],['2', ipsec.passive],['3', ipsec.manual]];
var ipsec_neg_modes = [['0', ipsec.main_mode],['1', ipsec.agg_mode]];
var ipsec_ipsec_protos = [['0', 'ESP'],['1', 'AH']];
var ipsec_ipsec_modes = [['0', ipsec.tunnel_mode],['1', ipsec.transport_mode]];
var ipsec_tunnel_types = [['0', ipsec.host_host],['1', ipsec.host_net],['2', ipsec.net_host],['3', ipsec.net_net]];
var ipsec_tunnel_pfs = [['0', ipsec.none],['1', 'Group 1'],['2','Group 2'],['5','Group 5']];


var ipsec_tunnelid_list = [];
for (i=1; i<=10; i++) ipsec_tunnelid_list.push([i, i]);

if(ih_sysinfo.product_number.indexOf('EN00') < 0)
	var ipsec_config = {
		tunnel_id: '1',
		tunnel_iface: 'cellular 1',
		tunnel_dst: '',
		tunnel_neg_mode: '0',
		tunnel_src_net: '',
		tunnel_src_mask: '255.255.255.0',
		tunnel_dst_net: '',
		tunnel_dst_mask: '255.255.255.0',
		tunnel_ike_policy: ike_policies[1][0],
		tunnel_ike_lifetime: '86400',
		tunnel_src_id_type: '0',
		tunnel_src_id: '',
		tunnel_dst_id_type: '0',
		tunnel_dst_id: '',
		tunnel_auth_type: '0',
		tunnel_auth_key: '',
		tunnel_ipsec_policy: ipsec_policies[0][0],
		tunnel_ipsec_lifetime: '3600'
	};
else
	var ipsec_config = {
		tunnel_id: '1',
		tunnel_iface: 'fastethernet 0/1',
		tunnel_dst: '',
		tunnel_neg_mode: '0',
		tunnel_src_net: '',
		tunnel_src_mask: '255.255.255.0',
		tunnel_dst_net: '',
		tunnel_dst_mask: '255.255.255.0',
		tunnel_ike_policy: ike_policies[1][0],
		tunnel_ike_lifetime: '86400',
		tunnel_src_id_type: '0',
		tunnel_src_id: '',
		tunnel_dst_id_type: '0',
		tunnel_dst_id: '',
		tunnel_auth_type: '0',
		tunnel_auth_key: '',
		tunnel_ipsec_policy: ipsec_policies[0][0],
		tunnel_ipsec_lifetime: '3600'
	};
function netmask_to_wildcard(netmask)
{
	var a, n, i;

	a = netmask.split('.');
	for (i = 0; i < 4; i++) {
		n = a[i] * 1;
		n = 255-n;
		a[i] = n;
	}
	
	return a.join('.');
}

function v_ipsec_id(v, quiet)
{
	var id_type = E(v + '_type').value;
	var x = E(v).value;
	
	elem.display(PR(v), id_type!='0');
	
	if(id_type!='0'){
		ferror.clear(v);
		if(x=="@") E(v).value="";
		if(!v_length(v, quiet, 1, 64)){
			return 0;
		}else{
			if(id_type=='2'){//FQDN
				if(x.substr(0,1)!='@'){
					E(v).value = '@' + x;
				}
			}else{//User FQDN
				x = x.split('@');
				if(x.length!=2 || x[0]=='' || x[1]==''){
					ferror.set(v, errmsg.bad_ufqdn, quiet);
					return 0;
				}
			}
		}
	}
	
	return 1;
}

function verifyFields(focused, quiet)
{
	var ok = 1;	
	var cmd = "";
	var fom = E('_fom');
	var a;

	E('save-button').disabled = true;
	if (user_info.priv < admin_priv) 
		elem.display('save-button', 'cancel-button', false);
	
	//visual
	elem.display_and_enable(('_f_tunnel_auth_key'), E('_f_tunnel_auth_type').value=='0');

	//TODO: verify
	ferror.clearAll(fom);
	if (!v_info_host_ip('_f_tunnel_dst', quiet, false)) return 0;
	if (!v_info_ip('_f_tunnel_src_net', quiet, false)) return 0;
	if (!v_info_netmask('_f_tunnel_src_mask', quiet, false)) return 0;
	if (!v_info_ip('_f_tunnel_dst_net', quiet, false)) return 0;
	if (!v_info_netmask('_f_tunnel_dst_mask', quiet, false)) return 0;
	if (!v_info_num_range('_f_tunnel_ike_lifetime', quiet, false, 1200, 86400)) return 0;

	if(E('_f_tunnel_src_id_type').value=='2'
	    || E('_f_tunnel_src_id_type').value=='1'){
		if(!v_ipsec_id('_f_tunnel_src_id', quiet)){
			return 0;
		}
	}
	if(E('_f_tunnel_dst_id_type').value=='2'
	    || E('_f_tunnel_dst_id_type').value=='1'){
		if(!v_ipsec_id('_f_tunnel_dst_id', quiet)){
			return 0;
		}
	}
	if(E('_f_tunnel_auth_type').value=='0'
	    && E('_f_tunnel_auth_key').value==''){
		ferror.set('_f_tunnel_auth_key', '', quiet);		
		return 0;
	}
	if (!v_info_num_range('_f_tunnel_ipsec_lifetime', quiet, false, 1200, 86400)) return 0;

	//configure
	var tunnel_id = E('_f_tunnel_id').value 
	var tunnel_name = 'ipsecwz' + tunnel_id;
	var acl_num = 180 + parseInt(E('_f_tunnel_id').value);
	var tunnel_iface = E('_f_tunnel_iface').value;
	var tunnel_dst = E('_f_tunnel_dst').value;
	var tunnel_neg_mode = E('_f_tunnel_neg_mode').value;
	var tunnel_src_net = E('_f_tunnel_src_net').value;
	var tunnel_src_mask = E('_f_tunnel_src_mask').value;
	var tunnel_dst_net = E('_f_tunnel_dst_net').value;
	var tunnel_dst_mask = E('_f_tunnel_dst_mask').value;
	var tunnel_ike_policy = E('_f_tunnel_ike_policy').value;
	var tunnel_ike_lifetime = E('_f_tunnel_ike_lifetime').value;
	var tunnel_src_id_type = E('_f_tunnel_src_id_type').value;
	var tunnel_src_id = E('_f_tunnel_src_id').value;
	var tunnel_dst_id_type = E('_f_tunnel_dst_id_type').value;
	var tunnel_dst_id = E('_f_tunnel_dst_id').value;
	var tunnel_auth_type = E('_f_tunnel_auth_type').value;
	var tunnel_auth_key = E('_f_tunnel_auth_key').value;
	var tunnel_ipsec_policy = E('_f_tunnel_ipsec_policy').value;
	var tunnel_ipsec_lifetime = E('_f_tunnel_ipsec_lifetime').value;
	
	if(tunnel_auth_type=='0') {
		cmd += "crypto keyring " + tunnel_name + "\n";
		cmd += "  pre-shared-key address 0.0.0.0 key " + tunnel_auth_key + "\n";
		cmd += "!\n";
	}
	cmd += "crypto isakmp policy " + tunnel_id + "\n";
	if(tunnel_auth_type=='0') {
		cmd += "  authentication pre-share\n";
	} else {
		cmd += "  authentication rsa-sig\n";
	}
	a = tunnel_ike_policy.split('-');
	cmd += "  encryption " + a[0] + "\n";
	if(a[1]=="sha1"){		
		cmd += "  hash sha\n";

	}else {
		cmd += "  hash " + a[1] + "\n";
	}
	if(a[2]=='modp768') {
		cmd += "  group 1\n";
	} else if(a[2]=='modp1536') {
		cmd += "  group 5\n";
	} else {
		cmd += "  group 2\n";
	}
	cmd += "  lifetime " + tunnel_ike_lifetime + "\n";
	cmd += "!\n";

	cmd += "crypto isakmp profile " + tunnel_name + "\n";
	if(tunnel_src_id_type=='2'){ 
		cmd += "  self-identity fqdn " + tunnel_src_id + "\n";
	} else if(tunnel_src_id_type=='1'){ 
		cmd += "  self-identity user-fqdn " + tunnel_src_id + "\n";
	} else {
		if(tunnel_src_id!=''){
			cmd += "  self-identity address " + tunnel_src_id +"\n";
		}else{
			cmd += "  self-identity address\n";
		}
	}
	if(tunnel_dst_id_type=='2'){ 
		cmd += "  match identity fqdn " + tunnel_dst_id + "\n";
	} else if(tunnel_dst_id_type=='1'){ 
		cmd += "  match identity user-fqdn " + tunnel_dst_id + "\n";
	} else {
		if(tunnel_dst_id!=''){
			cmd += "  match identity address " + tunnel_dst_id +"\n";
		}else{
			cmd += "  match identity address\n";
		}
	}
	if(tunnel_auth_type=='0') {
		cmd += "  keyring " + tunnel_name + "\n";
	}
	cmd += "  policy " + tunnel_id + "\n";
	cmd += "!\n";

	a = tunnel_ipsec_policy.split('-');
	cmd += "crypto ipsec transform-set " + tunnel_name + " esp-" + a[0] + " esp-" + a[1] + "-hmac\n";
	cmd += "!\n";
	cmd += "crypto map ipsecwz " + tunnel_id + " ipsec-isakmp\n";
	cmd += "  set peer " + tunnel_dst + "\n";
	cmd += "  set isakmp-profile " + tunnel_name + "\n";
	cmd += "  set transform-set " + tunnel_name + "\n";
	cmd += "  match address " + acl_num + "\n";
	cmd += "  set security-association lifetime seconds " + tunnel_ipsec_lifetime + "\n";
	cmd += "!\n";

	cmd += "interface " + tunnel_iface + "\n";
	cmd += "  crypto map ipsecwz\n";
	cmd += "!\n";

	cmd += "no access-list " + acl_num + "\n";
	cmd += "access-list " + acl_num + " permit ip " + tunnel_src_net + " " + netmask_to_wildcard(tunnel_src_mask) + " " + tunnel_dst_net + " " + netmask_to_wildcard(tunnel_dst_mask) + "\n";
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

function earlyInit()
{
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
	var i;

	if (!verifyFields(null, false)) return;
	
	var fom = E('_fom');

	if((E('_fom')._web_cmd.value != '')&&(cookie.get('autosave') == 1)){
		E('_fom')._web_cmd.value += "!"+"\n"+"copy running-config startup-config"+"\n";	
	}

	form.submit(fom, 1);
}

</script>

</head>
<body>
<form id='_fom' method='post' action='apply.cgi'>
<input type='hidden' name='_web_cmd' value=''>

<div class='section'>
<script type='text/javascript'>
grid_vif_opts_add(now_vifs_options, "");
createFieldTable('', [
	{ title: '<b>' + ipsec.basic + '</b>'},
	{ title: ipsec.tunnelid, indent: 2, name: 'f_tunnel_id', type: 'select', options: ipsec_tunnelid_list, value: ipsec_config.tunnel_id },	
	{ title: ipsec.map_iface, indent: 2, name: 'f_tunnel_iface',  type: 'select', options: now_vifs_options, value: ipsec_config.tunnel_iface },	
	{ title: ipsec.dst, indent: 2, name: 'f_tunnel_dst', type: 'text', maxlen: 64, size: 17, value: ipsec_config.tunnel_dst },
	{ title: ipsec.neg_mode, indent: 2, name: 'f_tunnel_neg_mode', type: 'select', options: ipsec_neg_modes, value: ipsec_config.tunnel_neg_mode },
	{ title: ipsec.src_net, indent: 2, name: 'f_tunnel_src_net', type: 'text', maxlen: 15, size: 17, value: ipsec_config.tunnel_src_net },
	{ title: ipsec.src_mask, indent: 2, name: 'f_tunnel_src_mask', type: 'text', maxlen: 15, size: 17, value: ipsec_config.tunnel_src_mask },
	{ title: ipsec.dst_net, indent: 2, name: 'f_tunnel_dst_net', type: 'text', maxlen: 15, size: 17, value: ipsec_config.tunnel_dst_net },
	{ title: ipsec.dst_mask, indent: 2, name: 'f_tunnel_dst_mask', type: 'text', maxlen: 15, size: 17, value: ipsec_config.tunnel_dst_mask },
//Phase 1: ike_policy,ike_lifetime,src_id_type,src_id,dst_id_type,dst_id,auth_type,auth_key,
	{ title: ''},
	{ title: '<b>' + ipsec.p1 + '</b>'},
	{ title: 'IKE ' + ipsec.policy, indent: 2, name: 'f_tunnel_ike_policy', type: 'select', options: ike_policies, value: ipsec_config.tunnel_ike_policy },
	{ title: 'IKE ' + ipsec.lifetime, indent: 2, name: 'f_tunnel_ike_lifetime', type: 'text', maxlen: 15, size: 17, suffix: ui.seconds, value: ipsec_config.tunnel_ike_lifetime },
	{ title: ipsec.src_id_type, indent: 2, name: 'f_tunnel_src_id_type', type: 'select', options: ipsec_id_types, value: ipsec_config.tunnel_src_id_type },
	{ title: ipsec.src_id, indent: 2, name: 'f_tunnel_src_id', type: 'text', maxlen: 64, size: 17, value: ipsec_config.tunnel_src_id },
	{ title: ipsec.dst_id_type, indent: 2, name: 'f_tunnel_dst_id_type', type: 'select', options: ipsec_id_types, value: ipsec_config.tunnel_dst_id_type },
	{ title: ipsec.dst_id, indent: 2, name: 'f_tunnel_dst_id', type: 'text', maxlen: 64, size: 17, value: ipsec_config.tunnel_dst_id },				
	{ title: ipsec.auth_type, indent: 2, name: 'f_tunnel_auth_type', type: 'select', options: ipsec_auth_types, value: ipsec_config.tunnel_auth_type },
	{ title: ipsec.auth_key, indent: 2, name: 'f_tunnel_auth_key', type: 'password', maxlen: 64, size: 17, value: ipsec_config.tunnel_auth_key },
//Phase 2: ipsec_policy,ipsec_lifetime,pfs,
	{ title: ''},
	{ title: '<b>' + ipsec.p2 + '</b>'},
	{ title: 'IPSec ' + ipsec.policy, indent: 2, name: 'f_tunnel_ipsec_policy', type: 'select', options: ipsec_policies, value: ipsec_config.tunnel_ipsec_policy },
	{ title: 'IPSec ' + ipsec.lifetime, indent: 2, name: 'f_tunnel_ipsec_lifetime', type: 'text', maxlen: 15, size: 17, suffix: ui.seconds, value: ipsec_config.tunnel_ipsec_lifetime }	
]);
</script>
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
