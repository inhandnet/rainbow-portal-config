<% pagehead(menu.tools_speed) %>

<script type='text/javascript'>

function fix(name)
{
	var i;
	if (((i = name.lastIndexOf('/')) > 0) || ((i = name.lastIndexOf('\\')) > 0))
		name = name.substring(i + 1, name.length);
	return name;
}

function jump()
{
	window.location.replace("info.jsp");
}

function speeddownButton(typ, suffix)
{
	var fom = E(typ + '_form');
	var name;	
	
	name = fix(fom.filename.value);	
	if (name.length == 0) {
		//alert(errmsg.invalid_fname);
		//return;
		name = typ;
	}
	
	location.href = name + suffix + '?type=' + typ;
	//setTimeout(jump, 5*1000);
}

function speedupButton(typ, suffix)
{
	var fom = E(typ + '_form');
	var name, i;
	
	name = fix(fom.filename.value);	
	name = name.toLowerCase();
	
	//if ((name.length <= 4) || (name.substring(name.length - 4, name.length).toLowerCase() != suffix)) {
		//alert(errmsg.invalid_fname);
		//return;
	//}
	fom.speedup_button.disabled = 1;
	fom.submit();
}

</script>
</head>
<body>
<div class='section-title'></div>
<div class='section'>
	<form id='test_form' method='post' action='speedup.cgi' encType='multipart/form-data'>
		<input type='hidden' name='type' value='test' />
		<input type='file' size='40' id='speedup_file' name='filename' value='test.bin'>
		<script type='text/javascript'>
			W("<input type='button' name='speedup_button' style='width:100px' value='" + ui.upload  + "' onclick='speedupButton(\"test\", \".bin\")' id='speed-up-button'>");
			W("<input type='button' name='speeddown_button' onclick='speeddownButton(\"test\", \".bin\")' style='width:100px' value='" + ui.dnload + "'>");
		</script>
	</form>
</div>

<div id='footer'>&nbsp;</div>
</table>
<br><br>
</body>
</html>
