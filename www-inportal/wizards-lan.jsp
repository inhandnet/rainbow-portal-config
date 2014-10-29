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

var operator_priv = 12;

var eth_opts = [];
for (var i = 0; i < eth_config.length; i++){
	eth_opts.push([eth_config[i][0], eth_config[i][0]]);
}

function verifyFields(focused, quiet)
{
	var cmd = "";
	var fom = E('_fom');
	var view_flag = 0;
	var founded = 0;
	var iface = "";
	
	E('save-button').disabled = true;

	elem.display_and_enable(('_f_start'), ('_f_end'), ('_f_lease'), E('_f_dhcps').checked);	
	if (!v_info_host_ip('_f_ip', quiet, false)) return 0;
	if (E('_f_ip').value.length!=0 && E('_f_mask').value.length==0 ) 
		E('_f_mask').value = '255.255.255.0';
	if (!v_info_netmask('_f_mask', quiet, false)) return 0;
	if (E('_f_ip').value.length!=0 && E('_f_mask').value.length!=0 )
		if (!v_info_ip_netmask('_f_ip', '_f_mask', quiet)) return 0;	
	if (E('_f_dhcps').checked){
		if (E('_f_lease').value.length == 0) {
			E('_f_lease').value = 1440;
		}
		if (!v_info_host_ip('_f_start', quiet, false)) return 0;
		if (!v_info_host_ip('_f_end', quiet, false)) return 0;
		if (E('_f_lease').value != 0 && !v_info_num_range('_f_lease', quiet, false, 30, 10080)) return 0;
	}

	iface = E('_f_iface').value;	
	cmd += "!\nno interface dialer 10\n";
	cmd += "!\ninterface " + iface +"\n";
	cmd += "no ip address dhcp\n";
	cmd += "no pppoe-client dial-pool-number 10\n";	
	cmd += "no ip address\n";
	cmd += "ip address " + E('_f_ip').value + " " + E('_f_mask').value + "\n";
	
	cmd += 'no ip dhcp-server enable\n';   
	cmd += 'no ip dhcp-server range\n';   
	cmd += 'no ip dhcp-server lease\n';
	if (E('_f_dhcps').checked) {
		cmd += 'ip dhcp-server enable\n';
		cmd += 'ip dhcp-server range ' + E('_f_start').value + ' ' + E('_f_end').value + '\n';   
        if( E('_f_lease').value == 0)
            cmd += 'ip dhcp-server lease ' + 'infinite' + '\n';   
        else
            cmd += 'ip dhcp-server lease ' + E('_f_lease').value + '\n';   
	}

	//NAT
	cmd += "ip nat inside\n";
	if (user_info.priv < operator_priv) {
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
	{ title: ui.iface, name:'f_iface', type:'select', options:eth_opts, value:'fastethernet 0/2'},
	{ title: ui.primary_ip, name: 'f_ip', type: 'text', maxlen: 16, size: 15},
	{ title: ui.netmask, name: 'f_mask', type: 'text', maxlen: 16, size: 15, value:'255.255.255.0'},
	//{ title: ui.mtu, name: 'f_mtu', type: 'text', maxlen: 4, size: 15, value:'1500'},	
	//{ title: port.speed+'/'+port.duplex, name: 'f_speed_duplex', type: 'select', options:speed_duplex_options},
	//{ title: ui.tak_l2, name: 'f_track', type: 'checkbox'},
	//{ title: ui.desc, name: 'f_desc', type: 'text', maxlen: 127, size: 32},
	{ title: ui.interface_dhcp_enable, name: 'f_dhcps', type: 'checkbox'},
	{ title: ui.start, indent:2, name: 'f_start', type: 'text', maxlen: 16, size: 15},
	{ title: ui.end, indent:2, name: 'f_end', type: 'text', maxlen: 16, size: 15},
	{ title: ui.lease, indent:2, name: 'f_lease', type: 'text', maxlen: 6, size: 5, value:1440, suffix:ui.minutes},
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

