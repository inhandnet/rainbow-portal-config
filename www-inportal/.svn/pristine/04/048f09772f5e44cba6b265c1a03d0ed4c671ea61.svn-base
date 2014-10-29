<% pagehead(menu.switch_qos_pri2tc) %>

<style type='text/css'>
#adm-head{
	Text-align: center;
	background: #e7e7e7;
}
#adm_grid{
	width: 200px;
	text-align: center;
} 
#adm_grid .co1 {
	width: 100px;
	text-align: center;
}
#adm_grid .co2 {
	width: 100px;
	text-align: center;
}

</style>

<script type='text/javascript'>

<% ih_sysinfo() %>
<% ih_user_info(); %>

<% web_exec('show running-config qos') %>
//var qos_config=[pri2tc=[[0,0],[1,0],[2,1],[3,1],[4,2],[5,2],[6,3],[7,3]],dscp2tc=[[0,0],[1,0],[2,0],[3,0],[4,0],[5,0],[6,0],[7,0],[8,0],[9,0],[10,0],[11,0],[12,0],[13,0],[14,0],[15,0],[16,0],[17,0],[18,0],[19,0],[20,0],[21,0],[22,0],[23,0],[24,0],[25,0],[26,0],[27,0],[28,0],[29,0],[30,0],[31,0],[32,0],[33,0],[34,0],[35,0],[36,0],[37,0],[38,0],[39,0],[40,0],[41,0],[42,0],[43,0],[44,0],[45,0],[46,0],[47,0],[48,0],[49,0],[50,0],[51,0],[52,0],[53,0],[54,0],[55,0],[56,0],[57,0],[58,0],[59,0],[60,0],[61,0],[62,0],[63,0]],portqos=[[1,1,1,2,0,0,0,0,remap=[[0,0],[1,1],[2,2],[3,3],[4,4],[5,5],[6,6],[7,7]]],[1,1,2,2,0,0,0,0,remap=[[0,0],[1,1],[2,2],[3,3],[4,4],[5,5],[6,6],[7,7]]],[1,1,3,2,0,0,0,0,remap=[[0,0],[1,1],[2,2],[3,3],[4,4],[5,5],[6,6],[7,7]]],[1,1,4,2,0,0,0,0,remap=[[0,0],[1,1],[2,2],[3,3],[4,4],[5,5],[6,6],[7,7]]],[1,1,5,2,0,0,0,0,remap=[[0,0],[1,1],[2,2],[3,3],[4,4],[5,5],[6,6],[7,7]]],[1,1,6,2,0,0,0,0,remap=[[0,0],[1,1],[2,2],[3,3],[4,4],[5,5],[6,6],[7,7]]],[1,1,7,2,0,0,0,0,remap=[[0,0],[1,1],[2,2],[3,3],[4,4],[5,5],[6,6],[7,7]]],[1,1,8,2,0,0,0,0,remap=[[0,0],[1,1],[2,2],[3,3],[4,4],[5,5],[6,6],[7,7]]],[2,1,1,2,0,0,0,0,remap=[[0,0],[1,1],[2,2],[3,3],[4,4],[5,5],[6,6],[7,7]]],[2,1,2,2,0,0,0,0,remap=[[0,0],[1,1],[2,2],[3,3],[4,4],[5,5],[6,6],[7,7]]],[2,1,3,2,0,0,0,0,remap=[[0,0],[1,1],[2,2],[3,3],[4,4],[5,5],[6,6],[7,7]]]]];


var priority_range = [];
for(var i=0;i<qos_config[0].length;++i){
	priority_range.push(qos_config[0][i][0]);
}

var cos_range = ['0','1','2','3','Default'];

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

	for(var i = 0;i < qos_config[0].length;i++){
		//check cos value
		if(E('_'+i+'_cos_value').value != cos_range[qos_config[0][i][1]]){
			cmd += "!" + "\n";
			if(E('_'+i+'_cos_value').value == 'Default'){
				cmd += "no qos map priority " + qos_config[0][i][0] + "\n";
			}else{
				cmd += "qos map priority " + qos_config[0][i][0] + " " + "queue" + " " + E('_'+i+'_cos_value').value + "\n";
			}
		}		
	}

	//alert(cmd);
	if (user_info.priv < admin_priv) {
		elem.display('save-button', 'cancel-button','default-button', false);
	}else{
		elem.display('save-button', 'cancel-button', 'default-button',true);
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

function defaultAll()
{
	E('_fom')._web_cmd.value = "!" + "\n" + "no qos map priority" + "\n";
	if(cookie.get('autosave') == 1){
		E('_fom')._web_cmd.value += "!"+"\n"+"copy running-config startup-config"+"\n";	
	}
	form.submit('_fom', 1);
}

function genStdFooter(args)
{
	W("<div id='footer'>");
	W("<span id='footer-msg'></span>");
	W("<input type='button' style='width:100px' value='" + ui.aply + "' id='save-button' onclick='save(" + args + ")'>");
	W("<input type='button' style='width:100px' value='" + ui.cancel + "' id='cancel-button' onclick='reloadPage();'>");	
	W("<input type='button' style='width:100px' value='" + ui.default_all + "' id='default-button' onclick='defaultAll();'>");	
	W("</div>");
}

</script>
</head>
<body onload='init()'>
<form id='_fom' method='post' action='apply.cgi'>
<input type='hidden' name='_web_cmd' value=''>


<div class='section'>
	<table class='web-grid' cellspacing=1 id='adm_grid'>
<script type='text/javascript'>
		W("<tr id='adm-head'>");
			W("<td width=80>" + qos.priority + "</td>");
			W("<td width=80>" + qos.queue + "</td>");
		W("</tr>");
		
		for( var i = 0; i < priority_range.length; i++){
												
			W("<td>" + i + "</td>"); 
			W(creatSelect(cos_range,cos_range[qos_config[0][i][1]],i,'_cos_value'));
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
