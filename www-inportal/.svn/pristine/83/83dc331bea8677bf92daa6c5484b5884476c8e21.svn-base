<% pagehead(menu.personal) %>

<script type='text/javascript'>

<% ih_sysinfo() %>
<% ih_user_info() %>
<% web_exec('show running-config nginx')%>

var nginx_enable_json = nginx_config[0];
var nginx_desc_json = nginx_config[2];
var nginx_conf = cookie.get('nginx_configuartion');

function verifyFields(focused, quiet)
{
	var cmd = "";
	var fom = E('_fom');

	E('save-button').disabled = true;

	var enable = E('_f_nginx_enable').checked;
/*
	var desc = E('_f_nginx_desc').value;
*/	
	//generate CMD
	if(!enable){
		if(enable != nginx_enable_json){
			cmd += "!\n";
			cmd += "no nginx enable\n";
		}
	}else {
		if(enable != nginx_enable_json){
			cmd += "!\n";
			cmd += "nginx enable\n";
		}
/*		
		if(nginx_conf =='1'){
			cmd += "!\n";
			cmd += "nginx import web configuration\n";
			nginx_conf!='0'
		}	
		if(desc != nginx_desc_json){
			cmd += "!\n";
			cmd += "nginx configuration description " + desc +"\n";
		}
*/
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
	var fom = E('nginx_form');
	var name, i;
	var cmd = "";

	name = fix(fom.filename.value);	
	name = name.toLowerCase();
	
	if ((name.length <= 4) || (name.substring(name.length - 4, name.length).toLowerCase() != suffix)) {
		alert(errmsg.invalid_fname);
		return;
	}
	if (!show_confirm(infomsg.confm)) return;
	cookie.set('nginx_configuartion', '1');
    	fom.submit();
	//document.location = 'setup-openvpn-clientN.jsp';
}
function earlyInit()
{	
//	cookie.unset('nginx_configuartion');
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
var nginx_tb1 = [
		{ title: ui.enable, name: 'f_nginx_enable', type:'checkbox', value: nginx_enable_json == '1' },
		//{ title: ui.conf_desc, name: 'f_nginx_desc', type: 'text', maxlen: 64, size: 16, value: nginx_desc_json }
		];
createFieldTable('', nginx_tb1);
</script>
</div>
</form>
<!--
<div class='section-title' id='nginx_section_title'><script type='text/javascript'>W(ui.import_config)</script></div>
<div class='section' id='nginx_section'>
	<form id='nginx_form' method='post' action='upload.cgi' encType='multipart/form-data'>
		<input type='hidden' name='type' value='config_nginx' />
		<input type='file' size='40' id='nginx_import' name='filename' value='nginx.conf'>
		<script type='text/javascript'>
			W("<input type='button' name='import_button' style='width:100px' value='" + ui.impt + "' onclick='importButton(\"conf\")' id='nginx-import-button'>");
			W("<input type='button' name='backup_button' onclick='backupButton(\"ca\", \".crt\")' style='width:100px' value='" + ui.expt  + "'>");
			E('nginx_form').backup_button.disabled = true;
		</script>
	</form>
</div>
-->

<script type='text/javascript'>
init();
if(cookie.get('autosave') == 1)
	ui.aply=ui.aply_save;
genStdFooter("");
</script>

<script type='text/javascript'>earlyInit()</script>
</body>
</html>
