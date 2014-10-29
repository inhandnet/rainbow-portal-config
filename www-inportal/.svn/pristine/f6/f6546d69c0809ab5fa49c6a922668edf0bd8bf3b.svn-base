<% pagehead(menu.eth1) %>

<style type='text/css'>
#mip-grid  {
	width: 600px;
}
#mip-grid .co1 {
	width: 300px;
}
#mip-grid .co2 {
	width: 300px;
}
</style>
<script type='text/javascript'>

<% ih_sysinfo() %>
<% ih_user_info() %>
<% web_exec('show running-config fastethernet') %>

var eth_opts = [];
for (var i = 0; i < eth_config.length; i++){
	eth_opts.push([eth_config[i][0], eth_config[i][0]]);
}

var conn_type = [[0,ui.statc], [1, ui.DHCP], [2, ui.pppoe]];

function verifyFields(focused, quiet)
{
	var cmd = "";
	var fom = E('_fom');
	var view_flag = 0;
	var founded = 0;
	var iface = "";
	var route_iface = "";
	
	E('save-button').disabled = true;

	elem.display_and_enable(('_f_ip'), ('_f_mask'), ('_f_gw'), (E('_f_conn').value == 0));	
	elem.display_and_enable(('_f_ppp_username'), ('_f_ppp_passwd'), (E('_f_conn').value == 2));	

	iface = E('_f_iface').value;	
	if (E('_f_conn').value == 0) {
		if (!v_info_host_ip('_f_ip', quiet, false)) return 0;
		if (E('_f_ip').value.length!=0 && E('_f_mask').value.length==0 ) 
			E('_f_mask').value = '255.255.255.0';
		if (!v_info_netmask('_f_mask', quiet, false)) return 0;
		
		if (E('_f_ip').value.length!=0 && E('_f_mask').value.length!=0 )
			if (!v_info_ip_netmask('_f_ip', '_f_mask', quiet)) return 0;	
		if (!v_info_host_ip('_f_gw', quiet, true)) return 0;
		cmd += "!\nno interface dialer 10\n";
		cmd += "!\ninterface " + iface +"\n";
		cmd += 'no ip dhcp-server enable\n';   
		cmd += 'no ip dhcp-server range\n';   
		cmd += 'no ip dhcp-server lease\n';		
		cmd += "no ip address dhcp\n";
		cmd += "no pppoe-client dial-pool-number 10\n";
		cmd += "no ip address\n";
		cmd += "ip address " + E('_f_ip').value + " " + E('_f_mask').value + "\n";
		//Gateway
		if (E('_f_gw').value != '') {
			cmd += "!\nip route 0.0.0.0 0.0.0.0 "+ iface +" "+ E('_f_gw').value +"\n";
		}else {
			cmd += "!\nip route 0.0.0.0 0.0.0.0 "+ iface + "\n";
		}		
	}else if (E('_f_conn').value == 1) {//DHCP Client
		cmd += "!\nno interface dialer 10\n";
		cmd += "!\ninterface " + iface + "\n";
		cmd += 'no ip dhcp-server enable\n';   
		cmd += 'no ip dhcp-server range\n';   
		cmd += 'no ip dhcp-server lease\n';		
		cmd += "no ip address\n";
		cmd += "no pppoe-client dial-pool-number 10\n";
		cmd += "ip address dhcp\n";
		cmd += "!\nip route 0.0.0.0 0.0.0.0 "+ iface + "\n";
	}else if (E('_f_conn').value == 2) {//ADSL
		if (E('_f_ppp_username').value == ''){
			ferror.set('_f_ppp_username', '', quiet);
			return 0;
		}else {
			ferror.clear('_f_ppp_username');
		}
		if (E('_f_ppp_passwd').value == ''){
			ferror.set('_f_ppp_passwd', '', quiet);
			return 0;
		}else {
			ferror.clear('_f_ppp_passwd');
		}		
		cmd += "!\nno interface dialer 10\n";
		cmd += "interface dialer 10\n";
		cmd += "ppp authentication auto "+E('_f_ppp_username').value+" "+E('_f_ppp_passwd').value+"\n";
		cmd += "dialer pool 10\n";
		cmd += "!\ninterface " + iface +"\n";
		cmd += 'no ip dhcp-server enable\n';   
		cmd += 'no ip dhcp-server range\n';   
		cmd += 'no ip dhcp-server lease\n';		
		cmd += "no ip address dhcp\n";
		cmd += "no ip address\n";		
		cmd += "no ip nat inside\n";
		cmd += "no ip nat outside\n";
		cmd += "no pppoe-client dial-pool-number 10\n";
		cmd += "pppoe-client dial-pool-number 10\n";
		iface = "dialer 10";
		cmd += "!\nip route 0.0.0.0 0.0.0.0 "+ iface + "\n";
	}

	//NAT
	if (E('_f_nat').checked) {
		cmd += "!\n";
		cmd += "no access-list 179\n";
		cmd += "access-list 179 permit ip any any\n";
		cmd += "ip snat inside list 179 interface "+iface+"\n"
	}
	cmd += "!\ninterface " + iface +"\n";
	cmd += "ip nat outside\n";
	
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

	var fom = E('_fom');

	if((E('_fom')._web_cmd.value != '')&&(cookie.get('autosave') == 1)){
		E('_fom')._web_cmd.value += "!"+"\n"+"copy running-config startup-config"+"\n";	
	}


	form.submit(fom, 1);
}

function earlyInit()
{
	verifyFields(null, true);
}
</script>
</head>
<body>
<form id='_fom' method='post' action='apply.cgi'>
<input type='hidden' name='_web_cmd' value=''>


<div class='section'>
<script type='text/javascript'>

createFieldTable('', [
	{ title: ui.iface, name:'f_iface', type:'select', options:eth_opts},
	{ title: ui.typ, name:"f_conn", type:'select', options:conn_type, value:0},
	{ title: ui.primary_ip, name: 'f_ip', type: 'text', maxlen: 16, size: 15},
	{ title: ui.netmask, name: 'f_mask', type: 'text', maxlen: 16, size: 15, value:'255.255.255.0'},
	{ title: ui.gateway, name: 'f_gw', type: 'text', maxlen: 16, size: 15},
	{ title: ui.username, name: 'f_ppp_username', type: 'text', maxlen: 63, size: 15},
	{ title: ui.password, name: 'f_ppp_passwd', type: 'password', maxlen: 63, size: 15},
	{ title: menu.fw_nat, name: 'f_nat', type: 'checkbox', value: 0}		
	
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

