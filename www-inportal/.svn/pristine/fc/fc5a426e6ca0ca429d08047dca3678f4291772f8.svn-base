<% pagehead(menu.admin_config) %>

<script type='text/javascript'>
<% ih_user_info(); %>

function fix(name)
{
	var i;
	
	if (((i = name.lastIndexOf('/')) > 0) || ((i = name.lastIndexOf('\\')) > 0))
		name = name.substring(i + 1, name.length);
	return name;
}

function backupButton(typ, suffix)
{
	//var fom = E('config_form');
//	var name;	
	
	//alert(typ);
	//name = fix(fom.filename.value);	
	//if (name.length == 0) {
		//alert(errmsg.invalid_fname);
		//return;
	//	name = typ;
	//}

	location.href = typ + suffix + '?type=' + typ;
	//top.consoleWindow.showWindow(TRUE);
	//top.consoleWindow.setURL(name + suffix + '?type=' + typ);
}

function importButton(typ, suffix)
{
	var fom = E('config_form');
	var name,i,dot;
	
	name = fix(fom.filename.value);	
	dot = name.lastIndexOf('.');
	
	if (dot <= 0 || name.substring(dot,name.length) != suffix) {
		alert(errmsg.invalid_fname);
		return;
	}
	
	if (!show_confirm(infomsg.confm)) return;
	
	fom.import_button.disabled = 1;
	//fom.submit();
	form.submit('config_form', 0);
}

function writeButton(typ)
{
//	form.submit('write-fom', 1);	
	
//	var i;
	if(!confirm(infomsg.to_save + "?")) return;
	
//	form.submit('reset-form');
	E('write-form')._web_cmd.value = "!"+"\n"+ "copy running-config startup-config"+"\n";
	//E('write-form').submit();
	form.submit('write-form', 1);
}

function resetButton(typ)
{
	var fom = E('reset-form');

	if (!show_confirm(infomsg.reset_default + "?")) return;
	fom.reset_button.disabled = 1;
	//fom.submit();
	form.submit('reset-form', 0);
	
}

function autoSave()
{
	if(E('auto_save').checked){
		cookie.set('autosave', 1);
//		E('write-button').disabled = true;
	}else{
		cookie.set('autosave', 0);
//		E('write-button').disabled = false;
	}
	
}

function init()
{
	if((cookie.get('autosave')) == null){
		cookie.set('autosave', 1);
		E('auto_save').checked = true;
    }

    var disabled = 0;
    if (user_info.priv < admin_priv) {
        disabled = 1;
	}else{
        disabled = 0;
    }
    
    E('config-import-button').disabled = disabled;
    E('backup_button').disabled = disabled;
    E('backup_button2').disabled = disabled;
    E('reset-button').disabled = disabled;
    

	/*
	if((cookie.get('autosave')) == 1){
		E('write-button').disabled = true;
	}else{
		E('write-button').disabled = false;
	}
	*/
}

</script>
</head>
<body onload='init()'>
<div class='section-title' id='router_section_title'><script type='text/javascript'>W(ui.config)</script></div>
<div class='section' id='router_section'>
	<form id='config_form' method='post' action='upload.cgi' encType='multipart/form-data'>
		<input type='hidden' name='type' value='config' />
		<input type='file' size='40' id='config_import' name='filename' value=''>
		<script type='text/javascript'>
			W("<input type='button' name='import_button' id='config-import-button' style='width:100px' value='" + ui.impt + "' onclick='importButton(\"config\", \".cnf\")' >");
			W("<input type='button' name='backup_button' id='backup_button' onclick='backupButton(\"running-config\", \".cnf\")' style='width:160px' value='" + ui.backup + " running-config'>");
			W("<input type='button' name='backup_button2' id='backup_button2' onclick='backupButton(\"startup-config\", \".cnf\")' style='width:160px' value='" + ui.backup + " startup-config'>");
			//W("<input type='button' name='reset_button' onclick='resetButton(\"config\")' style='width:160px' value='" + infomsg.reset_default + "'>");
		</script>
	</form>
</div>

<script type='text/javascript'>
W("<div class='section'>");

W("<input type='checkbox' onchange='autoSave()' id='auto_save'  "+ ((cookie.get('autosave') == 1) ? 'checked' : '') +  ">");
W("<td>" + " " +ui.auto_save + "</td>");
W("<br/>");
W("<br/>");

W("	<form id='reset-form' method='post' action='reset-default.cgi'>");
W(" <input type='hidden' name='_web_cmd' value=''>");
W("<br/>");
W("	<input type='button' name='reset_button' style='width:250px' value='" + infomsg.reset_default + "' onclick='resetButton(\"system\")' id='reset-button'>");
W("	</form>");
W("<br/>");

/*
W("	<form id='write-form' method='post' action='apply.cgi'>");
W(" <input type='hidden' name='_web_cmd' value=''>");
W("<br/>");
W("	<input type='button' style='width:250px' value='" + ui.save_config + "' onclick='writeButton()' id='write-button'>");
W("	</form>");
W("</div>");
*/
</script>


<div id='footer'>&nbsp;</div>
<br><br>
</body>
</html>
