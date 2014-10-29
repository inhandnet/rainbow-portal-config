<% pagehead(menu.switch_igmp) %>
<style tyle='text/css'>
#adm_grid{
	text-align: center;
}


#igmp_grid {
	width: 1130px;
	text-align: center;
}
</style>

<script type='text/javascript'>

<% ih_sysinfo() %>
<% ih_user_info(); %>

<% web_exec('show running-config interface') %>

//var port_config=[['1','1','1',1,3,2,1,0,0,0,0,0,0,1,0,0,0,'abc1,23'],['1','1','2',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],['1','1','3',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],['1','1','4',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],['1','1','5',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],['1','1','6',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],['1','1','7',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],['1','1','8',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],['2','1','1',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],['2','1','2',1,3,2,1,0,0,0,0,0,0,1,0,0,0,'']];


var port_type = ['undefine','FE','GE'];
var port_cmd_list =[];
var port_title_list = [];

for(var i=0;i<port_config.length;++i){
	if(port_config[i][0] == 1){
		port_cmd_list.push("fastethernet "+ port_config[i][1] + "/" + port_config[i][2]);
		port_title_list.push("FE"+ port_config[i][1] + "/" + port_config[i][2]);
	}else if(port_config[i][0] == 2){
		port_cmd_list.push("gigabitethernet "+ port_config[i][1] + "/" + port_config[i][2]);
		port_title_list.push("GE"+ port_config[i][1] + "/" + port_config[i][2]);
	}
}

function isDigit(str)
{ 
  var reg = /^\d*$/; 

  return reg.test(str); 
 }


function verifyFields(focused, quiet)
{
	if (user_info.priv < admin_priv) {
		elem.display('save-button', 'cancel-button', false);
	}else{
		elem.display('save-button', 'cancel-button', true);
    }
    
    var count = 0;

    for(var i=0;i<port_config.length;++i){
		if(E('_'+i+'_port').checked){
			count++;
		}
	}

    if(count > 0)
        E('save-button').disabled = 0;
    else
        E('save-button').disabled = 1;
	
	return 1;	
}


function save()
{
	var view_flag = 1;
	var cmd = "";
	var count = 0;
	
	for(var i=0;i<port_config.length;++i){
		
		if(E('_'+i+'_port').checked){
			if(view_flag){
				cmd += "!" + "\n";
				view_flag = 0;
			}			
			//cmd
			cmd += "clear interface " + port_cmd_list[i] + " statistics\n";
			count++;
		}
	}

	if (count >= (port_config.length)){		
		E('_fom')._web_cmd.value = "clear interface statistics\n";
	}else{
		E('_fom')._web_cmd.value = cmd;
	}

	if(cookie.get('debugcmd') == 1)
		alert(E('_fom')._web_cmd.value);

	form.submit('_fom', 1);
}

function init()
{
    //setInterval(function() {verifyFields(null,true);},500);
    return 1;
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
			for(var i=0;i<port_config.length;i++){
				W("<td>" + port_type[port_config[i][0]] + port_config[i][1] + "/" + port_config[i][2] + "</td>"); 
			}
		W("</tr>");
			for(var j=0;j<port_config.length;j++){
				W("<td><input type='checkbox' onclick='this.blur();' onchange='verifyFields()' id='_" + j + "_port' name='" + j + "_port' value=''></td>");
			}
			W("</tr>");			
	
</script>
	</table>
</div>



<script type='text/javascript'>
init();

genStdFooter("");
</script>
</form>
<script type='text/javascript'>verifyFields(null, 1);</script>
</body>
</html>
