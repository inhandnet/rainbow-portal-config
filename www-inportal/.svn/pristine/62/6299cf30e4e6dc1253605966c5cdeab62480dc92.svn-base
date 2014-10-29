<% pagehead(menu.switch_oam) %>

<style type='text/css'>
#adm-head{
	Text-align: left;
	background: #e7e7e7;
}
#adm_grid{
	width: 200px;
} 
#adm_grid .co1 {
	width: 100px;
}

</style>

<script type='text/javascript'>

<% ih_sysinfo() %>
<% ih_user_info(); %>

<% web_exec('show running-config oamd') %>

//var oam_config=[['1','1','1',1],['1','1','2',1],['1','1','3',1],['1','1','4',1],['1','1','5',1],['1','1','6',1],['1','1','7',1],['1','1','8',1],['2','1','1',1],['2','1','2',1],['2','1','3',1]];


var port_type = ['undefine','FE','GE'];
var select_enable = ['Disable','Enable'];
var port_cmd_list = [];

for(var i=0;i<oam_config.length;++i){

	if(oam_config[i][0] == 1){
		port_cmd_list.push("fastethernet "+ oam_config[i][1] + "/" + oam_config[i][2]);
	}else if(oam_config[i][0] == 2){
		port_cmd_list.push("gigabitethernet "+ oam_config[i][1] + "/" + oam_config[i][2]);
	}
}

function creatSelect(options,value,idex,name)
{
	var string = '<td><select onchange=verifyFields() id=_'+idex+''+name+'>';

	for(var i = 0;i < options.length;i++){
		if(value == options[i]){
			string +='<option value='+options[i]+' selected>'+options[i]+'</option>';
		}else{
			string +='<option value='+options[i]+'>'+options[i]+'</option>';
		}
	}
	string +="</select></td>";

	return string;
}

function verifyFields(focused, quiet)
{
	var cmd = "";
	var fom = E('_fom');

	E('save-button').disabled = true;	

	for(var i = 0;i < oam_config.length;i++){
		var interface_view_flag = 1;
				
		//check oam status
		if(E('_'+i+'_port_oam').value != select_enable[oam_config[i][3]]){
			if(interface_view_flag){
				cmd += "!" + "\n";
				cmd += "interface " + port_cmd_list[i]+ "\n";
				interface_view_flag = 0;
			}

			switch(E('_'+i+'_port_oam').value){
				case 'Disable': cmd += "no cfm cc"+ "\n";break;
				case 'Enable':	  cmd += "cfm cc" + "\n";break;
				default: break;
			}
			
		}
	
	}

	//alert(cmd);
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
	//alert(E('_fom')._web_cmd.value);
	if((E('_fom')._web_cmd.value != '')&&(cookie.get('autosave') == 1)){
		E('_fom')._web_cmd.value += "!"+"\n"+"copy running-config startup-config"+"\n";	
	}
	form.submit('_fom', 1);
}


function earlyInit()
{
	verifyFields(null,1);
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

<script type='text/javascript'>

</script>

<div class='section'>
	<table class='web-grid' cellspacing=1 id='adm_grid'>
<script type='text/javascript'>
		W("<tr id='adm-head'>");
			W("<td width=40>" + port.port + "</td>");
			W("<td width=80>" + port.oam_status + "</td>");
						
		W("</tr>");
				
		for( i = 0; i < oam_config.length; i++){
			W("<td>" + port_type[oam_config[i][0]] + oam_config[i][1] + "/" + oam_config[i][2] + "</td>"); 
			W(creatSelect(select_enable,select_enable[oam_config[i][3]],i,'_port_oam'));
			W("</tr>");			
		}
</script>
	</table>
</div>

<script type='text/javascript'>
init();
if(cookie.get('autosave') == 1)
	ui.aply=ui.aply_save;
genStdFooter("");
</script></form>
<script type='text/javascript'>earlyInit();</script>
</body>
</html>


