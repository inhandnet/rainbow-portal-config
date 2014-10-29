<% pagehead(menu.setup_dns) %>

<script type='text/javascript'>

<% ih_sysinfo(); %>
<% ih_user_info(); %>

var dns_server= {
	dns_1:'1.8.8.8',
	dns_2:'1.8.4.4'
};

<% web_exec('show running-config name-server'); %>

var first_cmd = '';
function verifyFields(focused, quiet)
{
	var i;
	var cmd = '';
	var server_ip = '';

    cmd += 'no ip name-server\n';
	
	if(E('_f_dns_1').value!= ''){
    	if(v_ip(E('_f_dns_1') , quiet)){
				server_ip += ' ' + E('_f_dns_1').value; 
		}else
			return 0;
	}

	if(E('_f_dns_2').value!= ''){
    	if(v_ip(E('_f_dns_2') , quiet)){
				server_ip += ' ' + E('_f_dns_2').value; 
		}else
			return 0;
	}

	if(server_ip != ''){
		cmd += 'ip name-server ' + server_ip + '\n';
	}
    
    var changed = 0;
    if( (E('_f_dns_1').value != dns_server.dns_1) || (E('_f_dns_2').value != dns_server.dns_2)){
        changed = 1;
    }

    E('save-button').disabled = 1;
    if( (changed  == 1) ){
        E('save-button').disabled = 0;
		E('_fom')._web_cmd.value = cmd;
		//alert(cmd);
    } 

	if (user_info.priv < admin_priv) {
		elem.display('save-button', 'cancel-button', false);
	}else{
		elem.display('save-button', 'cancel-button', true);
	}

	return 1;
}


function save()
{
	var i;

	if (!verifyFields(null, false)) return;
	
	if((E('_fom')._web_cmd.value != '')&&(cookie.get('autosave') == 1)){
		E('_fom')._web_cmd.value += "!"+"\n"+"copy running-config startup-config"+"\n";	
	}

	form.submit('_fom', 1);
}
</script>

</head>
<body>
<form id='_fom' method='post' action='apply.cgi'>
<input type='hidden' name='_web_cmd' value=''>

<!--
<input type='hidden' name='_nextwait' value='10'>
<input type='hidden' name='_service' value='dnsmasq-restart'>
-->

<input type='hidden' name='dns_static'>

<div class='section'>
<script type='text/javascript'>

createFieldTable('', [
	{ title: ui.dns1, name: 'f_dns_1', type: 'text', maxlen: 15, size: 17, value: dns_server.dns_1  },
	{ title: ui.dns2, name: 'f_dns_2', type: 'text', maxlen: 15, size: 17, value: dns_server.dns_2  }
]);
</script>
</div>

</form>

<script type='text/javascript'>
if(cookie.get('autosave') == 1)
	ui.aply=ui.aply_save;
genStdFooter("");
</script>
<script type='text/javascript'>verifyFields(null, 1);</script>
</body>
</html>
