<% pagehead(menu.port_mirror) %>

<style tyle='text/css'>
#adm-head{
	Text-align: center;
	background: #e7e7e7;
}

#adm_grid{
	text-align: center;
	width:150px;	
}

#adm-grid .co1 {
	width:50px;	
	text-align: center;
}
#adm-grid .co2 {
	width:100px;	
	text-align: center;
}

</style>

<script type='text/javascript'>

<% ih_sysinfo() %>
<% ih_user_info(); %>
<% web_exec('show running-config storm-protect') %>
var port_type = ['undefine','FE','GE'];

function isChecked(conf_value)
{
	var str ="";

	if (conf_value)
		str = " checked='' ";

	return str;
}

function verifyFields(focused, quiet)
{
	var enable;
	var view_flag = 1;
	var cmd = "";
	var fom = E('_fom');
	
	E('save-button').disabled = true;

	if (!v_info_num_range(E('_f_storm_rate'), quiet, true, 1, 1000)) return 0;

	if (E('_f_storm_rate').value != storm_rate) {
		if (E('_f_storm_rate').value == '')
			cmd += "!\nno storm-protect rate\n";
		else
			cmd += "!\nstorm-protect rate "+E('_f_storm_rate').value+"\n";
	}
	
	for(var i=0;i<storm_ports.length;i++){
		if (storm_ports[i][1] == 0) continue;
		if (E("_"+i+"_storm_port").checked != storm_ports[i][3]){
			cmd += "!\ninterface fastethernet "+storm_ports[i][1]+"/"+storm_ports[i][2]+"\n";
			cmd += (E("_"+i+"_storm_port").checked?"":"no ")+"storm-protect\n";
		}
	}	

	if (cookie.get('debugcmd') == 1)
		alert(cmd);

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

	if (cookie.get('debugcmd') == 1)
		alert(E('_fom')._web_cmd.value);
	
	if((E('_fom')._web_cmd.value != '')&&(cookie.get('autosave') == 1)){
		E('_fom')._web_cmd.value += "!"+"\n"+"copy running-config startup-config"+"\n";	
	}
	
	form.submit('_fom', 1);
}

function init()
{
	if((cookie.get('autosave')) == null){
		cookie.set('autosave', 1);
	}
}
</script>
</head>
<body onload='init()'>
<form id='_fom' method='post' action='apply.cgi'>
<input type='hidden' name='_web_cmd' value=''>

<div class='section'>
<script type='text/javascript'>

createFieldTable('', [
	{ title: port.storm_rate, name: 'f_storm_rate', type: 'text', value: storm_rate}]);
</script>
</div>

<div class='section-title'><script type='text/javascript'>
	GetText(port.port);
</script></div>
<div class='section'>
	<table class='web-grid' cellspacing=1 id='adm_grid'>
<script type='text/javascript'>
		W("<tr id='adm-head'>");
			W("<td class='header'>" + port.port + "</td>");
			W("<td class='header'>" + ui.enable + port.storm_control + "</td>");			
		W("</tr>");

		for(var i=0;i<storm_ports.length;i++){
			if (storm_ports[i][1] == 0) continue;
			W("<td>" + port_type[storm_ports[i][0]] + storm_ports[i][1] + "/" + storm_ports[i][2] + "</td>"); 
			W("<td width=100>" + "<input id='_"+i
				+"_storm_port' type='checkbox' onchange='verifyFields()' onclick='verifyFields()' " 
				+  isChecked(storm_ports[i][3])+ "></td>");
			W("</tr>");			
		}
		W("</tr>");			
	
</script>
	</table>
</div>

<script type='text/javascript'>
init();
if(cookie.get('autosave') == 1)
	ui.aply=ui.aply_save;
genStdFooter("");
</script></form>
<script type='text/javascript'>verifyFields(null, 1);</script>
</body>
</html>

