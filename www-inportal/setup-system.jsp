<% pagehead(menu.setup_system) %>

<script type='text/javascript'>
//ih_sysinfo()获取语言种类
<% ih_sysinfo(); %>
<% ih_user_info(); %>

//verify hostname
function isLegal_hostname(str)	
{
	var reg = /^[A-Za-z0-9@&.,_-]+$/;
	return reg.test(str);
}

function verifyFields(focused, quiet)
{

	E('save-button').disabled = true;	


//	if (!v_f_text(E('_f_hostname'), quiet, 1, 31)) return 0;

	var fom = E('_fom');
	var cmd = "";
	var s;
	
	s = E('_f_language').value;	
	if (s!=ih_sysinfo.lang) cmd += "language " + s + "\n";
//	alert("from "+web_lang+" to "+s);
//	if (s!= web_lang ) fom._set_lang.value = s;
//	else fom._set_lang.value = "";
	
	s = E('_f_hostname').value;
	if (!v_info_word(E('_f_hostname'), quiet, false)) {		
		return 0;
	} else if(!isLegal_hostname(s)) {
		ferror.set('_f_hostname', errmsg.snmp_sysinfo, quiet);
		return 0;	
	} else {
		ferror.clear('_f_hostname');
	}
	
	if (s!=ih_sysinfo.hostname) cmd += "hostname " + s + "\n";

	if (user_info.priv < admin_priv) {
		elem.display('save-button', 'cancel-button', false);
	}else{
		elem.display('save-button', 'cancel-button', true);
		fom._web_cmd.value = cmd;
//		E('save-button').disabled = (cmd=="" && fom._set_lang.value == "");	
		E('save-button').disabled = (cmd=="");
	}

	return 1;
}


function reloadIndex()
{
	top.Dialog.closeInfo();
	var oem = "/www/products/"+ih_sysinfo.oem_name + "/index.jsp";		
	top.document.location.replace(oem);
}

function save()
{	
	if (!verifyFields(null, false)) return;

	if((E('_fom')._web_cmd.value != '')&&(cookie.get('autosave') == 1)){
		E('_fom')._web_cmd.value += "!"+"\n"+"copy running-config startup-config"+"\n";	
	}
		
	form.submit('_fom', 1);	

	setTimeout(reloadIndex, 10000);
//	top.Dialog.closeInfo();
//	top.document.location.replace('index.jsp');
}

function debugcmd()
{
	cookie.set('debugcmd', ((E('debugcmd').checked)?(1):(0)));
}
</script>
</head>
<body>
<form id='_fom' method='post' action='apply.cgi'>
<input type='hidden' name='_web_cmd' value=''>
<!--
<input type='hidden' name='_set_lang' value=''>
-->
<div class='section'>
<script type='text/javascript'>
createFieldTable('', [
	{ title: ui.langu, name: 'f_language', type: 'select', options: 
		(ih_sysinfo.oem_name!='inhand')?[['English','English']]:[['auto', ui.auto],['English',ui.English],['Chinese',ui.Chinese]],
		value: ih_sysinfo.lang || 'Chinese' },
/*
	{ title: ui.langu, name: 'f_language', type: 'select', options: 
		(ih_sysinfo.oem_name=='blank')?[['English','English']]:[['auto', 'Auto (' + ui.auto + ')'],['English',ui.English],['Chinese',ui.Chinese]],
		value: web_lang || 'Chinese' },
*/
	{ title: ui.hname, name: 'f_hostname', type: 'text', maxlen: 31, size: 34, value: ih_sysinfo.hostname }
]);
</script>
</div>

</form>

<!-- Open cmd debug windows
<script type='text/javascript'>
W("<div class='section'>");
W("<br/>");
W("<input type='checkbox' onchange='debugcmd()' id='debugcmd'  "+ ((cookie.get('debugcmd') == 1) ? 'checked' : '') +  ">");
W("<td>" + " " +ui.debugcmd + "</td>");
W("<br/>");
W("</div>");
</script>
debug code end -->

<script type='text/javascript'>
if(cookie.get('autosave') == 1)
	ui.aply=ui.aply_save;
genStdFooter("");
</script>
<script type='text/javascript'>verifyFields(null, true);</script>
</body>
</html>
