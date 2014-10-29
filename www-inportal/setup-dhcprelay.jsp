<% pagehead(menu.dhcprelay) %>

<script type='text/javascript'>

<% ih_sysinfo(); %>
<% ih_user_info(); %>

var dhcprelay_config={
	enable:1,
	server_1:'1.1.1.1',
	server_2:'1.1.1.2',
	server_3:'1.1.1.3',
	server_4:'1.1.1.4',
	srcip:'4.4.4.4'
};

<% web_exec('show running-config dhcp-relay'); %>
<% web_exec('show running-config dhcp-server') %>

var first_cmd = '';
function verifyFields(focused, quiet)
{
    var enable;
    var cmd = '';
    var flag = 1;

    cmd += 'no ip dhcp-relay server\n';
	cmd +='no ip dhcp-relay source\n';
    
    E('save-button').disabled = 1;
    
	if(E('_f_dhcprelay_enable').checked == 0){
		elem.display_and_enable(('_dhcprelay_server_1'),('_dhcprelay_server_2'),('_dhcprelay_server_3'),('_dhcprelay_server_4'),('_dhcprelay_src'),false);
        if(dhcprelay_config.enable == 1)
            E('save-button').disabled = 0;
    }else{
        elem.display_and_enable(('_dhcprelay_server_1'),('_dhcprelay_server_2'),('_dhcprelay_server_3'),('_dhcprelay_server_4'),('_dhcprelay_src'),true);
        
	    if(E('_dhcprelay_server_1').value!= ''){
		    if(v_ip(E('_dhcprelay_server_1') , quiet)){
			    cmd += 'ip dhcp-relay server 1 ' + E('_dhcprelay_server_1').value + '\n'; 
		    }else
			    flag = 0;
	    }

	    if(E('_dhcprelay_server_2').value!= ''){
		    if(v_ip(E('_dhcprelay_server_2') , quiet)){
			    cmd += 'ip dhcp-relay server 2 ' + E('_dhcprelay_server_2').value + '\n'; 
		    }else
			    flag = 0;
	    }

	    if(E('_dhcprelay_server_3').value!= ''){
		    if(v_ip(E('_dhcprelay_server_3') , quiet)){
			    cmd += 'ip dhcp-relay server 3 ' + E('_dhcprelay_server_3').value + '\n'; 
		    }else
			    flag = 0;
	    }

	    if(E('_dhcprelay_server_4').value!= ''){
		    if(v_ip(E('_dhcprelay_server_4') , quiet)){
			    cmd += 'ip dhcp-relay server 4 ' + E('_dhcprelay_server_4').value + '\n'; 
		    }else
			    flag = 0;
	    }

	    if(E('_dhcprelay_src').value!= ''){
		    if(v_ip(E('_dhcprelay_src') , quiet)){
			    cmd += 'ip dhcp-relay source ' + E('_dhcprelay_src').value + '\n'; 
		    }else
			    flag = 0;
	    }
        
        //check if the DHCP and DHCP-relay has been enable at the some time
        var i,dhcpserver_flag;
        for(i=0,dhcpserver_flag=0;i<interface_config.length;i++){
            dhcpserver_flag = dhcpserver_flag || (interface_config[i][0] == '1');
        }

        if(dhcpserver_flag && (!quiet)){
            show_alert(ui.dhcp_dhcprelay_conflict);
			flag = 0;
        }
    
    }
    if(first_cmd == ''){
        first_cmd = cmd;
        //console.log('set first_cmd =' + first_cmd);
    }
    
    E('save-button').disabled = 1;
    if( cmd != first_cmd ){
        //console.log('111')
        E('save-button').disabled = 0;
		E('_fom')._web_cmd.value = cmd;
    } 

	if (user_info.priv < admin_priv) {
		elem.display('save-button', 'cancel-button', false);
	}else{
		elem.display('save-button', 'cancel-button', true);
	}

	return flag;
}

function save()
{
	if (!verifyFields(null, false)) return;
	
	var fom = E('_fom');
	
//	fom.dhcprelay_enable.value = E('_f_dhcprelay_enable').checked ? '1' : '0';

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
<!--
<input type='hidden' name='_nextwait' value='10'>
<input type='hidden' name='_service' value='dhcprelay-restart'>
<input type='hidden' name='dhcprelay_enable'>
-->

<div class='section'>
<script type='text/javascript'>

createFieldTable('', [
	{ title: ui.enable, name: 'f_dhcprelay_enable', type: 'checkbox', value: dhcprelay_config.enable == '1' },
	{ title: ui.dhcp_server + ' 1', name: 'dhcprelay_server_1', type: 'text', maxlen: 15, size: 15, value: dhcprelay_config.server_1 },
	{ title: ui.dhcp_server + ' 2', name: 'dhcprelay_server_2', type: 'text', maxlen: 15, size: 15, value: dhcprelay_config.server_2 },
	{ title: ui.dhcp_server + ' 3', name: 'dhcprelay_server_3', type: 'text', maxlen: 15, size: 15, value: dhcprelay_config.server_3 },
	{ title: ui.dhcp_server + ' 4', name: 'dhcprelay_server_4', type: 'text', maxlen: 15, size: 15, value: dhcprelay_config.server_4 },
	{ title: ui.dhcp_src, name: 'dhcprelay_src', type: 'text', maxlen: 15, size: 15, value: dhcprelay_config.srcip }
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
