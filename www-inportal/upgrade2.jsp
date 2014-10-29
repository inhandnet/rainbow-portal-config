<% pagehead(menu.upgrd) %>

<style type='text/css'>
#afu-progress {
	text-align: center;
	padding: 200px 0;
	width: 890px;
}
#afu-time {
	font-size: 26px;
}
</style>

<script type='text/javascript'>

<% ih_user_info(); %>

<% nvram("_bootloader_version"); %>

function clock()
{
	var t = ((new Date()).getTime() - startTime) / 1000;
	elem.setInnerHTML('afu-time', Math.floor(t / 60) + ':' + Number(Math.floor(t % 60)).pad(2));
}

function upgrade()
{
	var name;
	var i;
	var fom = document.form_upgrade;
	var upgrade_boot = document.form_options.upgrade_boot.checked;
//	var upgrade_firmware = document.form_options.upgrade_firmware.checked;
	var ext;

	name = fom.file.value;
	if (name.search(/\.(bin)$/i) == -1) {
		alert(infomsg.upgrade1);
		return;
	}
	if (!show_confirm(infomsg.confm)) return;

	E('afu-upgrade-button').disabled = true;

	elem.display('afu-input', false);
	elem.display('afu-progress', true);

	startTime = (new Date()).getTime();
	setInterval('clock()', 1000);
	var act = "upgrade.cgi?upgrade_boot=";
	act += (upgrade_boot ? "1" : "0");
	act += "&upgrade_firmware=1";
//	act += (upgrade_firmware ? "1" : "0");
	fom.action += act;
	fom.submit();
	//form.submit(fom, 1);
}

function init()
{
	if (user_info.priv < admin_priv) {
		E('afu-upgrade-button').disabled  = 1;
	}else{
		E('afu-upgrade-button').disabled  = 0;
	}
}

function unload()
{
}
</script>

</head>
<body onload="init()" onunload="unload()">

<div id='afu-input'>
	<div class='section'>
		<form name='form_options' method='post' action='' encType='multipart/form-data'>
		<div id='box-input'>
<script type='text/javascript'>
			W("<input type='checkbox' name='upgrade_boot' checked> "  + ui.upgrd + " " + " Bootloader</input><br>");
			//W("<input type='checkbox' name='upgrade_firmware' checked> " + infomsg.reset_default + "</input><br>");
</script>
		</div>			
		</form>		
		<form name='form_upgrade' method='post' action='' encType='multipart/form-data'>
		<div id='box-input'>
<script type='text/javascript'>
			W("			<input type='file' name='file' size='50'>");
			W("		  <input type='button' value='" + ui.upgrd + "' id='afu-upgrade-button' onclick='upgrade()'>");
			W("		</div>");
			W("		</form>");
			W("<br>");
			W(infomsg.cur_version + " : <% version(1); %>");
			W("<br>");
			W(infomsg.cur_bootloader_version + " : " + nvram._bootloader_version);
</script>
	</div>
</div>

<div id='afu-progress' style='display:none;margin:auto'>
	<img src='images/spin.gif' style='vertical-align:baseline'> <span id='afu-time'>0:00</span><br>
	<br><b><script type='text/javascript'>GetText(infomsg.upgrade3)</script></b><br>
	
</div>

<!-- / / / -->

<div id='footer'>&nbsp;</div>
</body>
</html>
