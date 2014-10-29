<% pagehead(menu.radius) %>

<style type='text/css'>
#adm-head{
	Text-align: left;
	background: #e7e7e7;
}

</style>

<script type='text/javascript'>

<% ih_sysinfo() %>
<% ih_user_info(); %>
<% web_exec('show running-config radius') %>

//radius_config=['192.168.0.100', 1812, ''];
var uv_passwd ="******";



var ip_idx = 0;
var udp_port_idx = 1;
var key_idx = 2;



function verifyFields(focused, quiet)
{
	var a, b, u;
	var cmd = "";
	var view_flag = 1;

	quiet = false;
	
	E('save-button').disabled = true;

	if (E('_f_ip').value != ''){
		//ip
		if (!v_host_ip(E('_f_ip'), quiet)) return 0;

		//port
		if (!v_port(E('_f_port'), quiet)) return 0;
		//password	
		if(!v_password(E('_f_passwd_1'), quiet, 1, 31)) return 0;
		if(!v_password(E('_f_passwd_2'), quiet, 1, 31)) return 0;
		if(E('_f_passwd_1').value != E('_f_passwd_2').value){
			ferror.set(E('_f_passwd_2'), errmsg.pw_match,quiet);
			return 0;
		}else{
			ferror.clear(E('_f_passwd_2'));
		}
	}


	if (E('_f_ip').value  == ''){
		if (view_flag){
			cmd += "!\n";
			view_flag = 0;
		}
		cmd += "no radius-server\n";		
	}else if ((E('_f_ip').value != radius_config[ip_idx])
		||(E('_f_port').value != radius_config[udp_port_idx])
		|| (E('_f_passwd_1').value != "")){
		if (view_flag){
			cmd += "!\n";
			view_flag = 0;
		}
		cmd += "radius-server host "+E('_f_ip').value+" auth-port "+E('_f_port').value+" key "+E('_f_passwd_1').value+"\n";
	}

	
	
//	E('_fom')._web_cmd.value
	
	if (user_info.priv < admin_priv) {
		elem.display('save-button', false);
	}else{
		elem.display('save-button', true);
		E('_fom')._web_cmd.value = cmd;
	
		E('save-button').disabled = (cmd == "");	
	}	

	return 1;
}



function save()
{
	var view_flag = 1;
	
	if (!verifyFields(null, false)) return;	

	if((E('_fom')._web_cmd.value != '')&&(cookie.get('autosave') == 1)){
		E('_fom')._web_cmd.value += "copy running-config startup-config"+"\n";	
	}

	if (cookie.get('debugcmd') == 1)
		alert(E('_fom')._web_cmd.value);

	form.submit('_fom', 1);
}

function earlyInit()
{
//	verifyFields(null, 1);
	E('save-button').disabled = true;

}

function init()
{

}
</script>
</head>
<body onload="init()">
<form id='_fom' method='post' action='apply.cgi'>
<input type='hidden' name='_web_cmd' value=''>

<div class='section'>
<script type='text/javascript'>
createFieldTable('', [
	{ title: ui.ip, name: 'f_ip', type: 'text', maxlen: 64, value:  radius_config[ip_idx]},
	{ title: "Auth UDP Port",name:'f_port', type:'text', maxlen:8, value:radius_config[udp_port_idx]},
	{ title: ui.password, name: 'f_passwd_1', type: 'password', maxlen: 31, value: radius_config[key_idx] },
	{ title: ui.confm + ui.sep + ui.password, name: 'f_passwd_2', type: 'password', maxlen: 31, value: radius_config[key_idx] }
]);
</script>
</div>

<script type='text/javascript'>
if(cookie.get('autosave') == 1)
	ui.aply=ui.aply_save;
genStdFooter("");
</script>


</form>

<script type='text/javascript'>earlyInit();</script>
</body>
</html>

