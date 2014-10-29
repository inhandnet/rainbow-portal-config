<% pagehead(menu.switch_qos_interface) %>

<style type='text/css'>
#adm-head{
	//Text-align: center;
	background: #e7e7e7;
}
#adm_grid{
	Text-align: center;
	width: 780px;
} 

#adm_grid .co1 {
	width: 40px;
	Text-align: left;
}


</style>

<script type='text/javascript'>

<% ih_sysinfo() %>
<% ih_user_info(); %>

var qos_config=[pri2tc=[[0,0],[1,0],[2,1],[3,1],[4,2],[5,2],[6,3],[7,3]],dscp2tc=[[0,0],[1,0],[2,0],[3,0],[4,0],[5,0],[6,0],[7,0],[8,0],[9,0],[10,0],[11,0],[12,0],[13,0],[14,0],[15,0],[16,0],[17,0],[18,0],[19,0],[20,0],[21,0],[22,0],[23,0],[24,0],[25,0],[26,0],[27,0],[28,0],[29,0],[30,0],[31,0],[32,0],[33,0],[34,0],[35,0],[36,0],[37,0],[38,0],[39,0],[40,0],[41,0],[42,0],[43,0],[44,0],[45,0],[46,0],[47,0],[48,0],[49,0],[50,0],[51,0],[52,0],[53,0],[54,0],[55,0],[56,0],[57,0],[58,0],[59,0],[60,0],[61,0],[62,0],[63,0]],portqos=[[1,1,1,2,0,0,0,0,remap=[[0,0],[1,1],[2,2],[3,3],[4,4],[5,5],[6,6],[7,7]]],[1,1,2,2,0,0,0,0,remap=[[0,0],[1,1],[2,2],[3,3],[4,4],[5,5],[6,6],[7,7]]],[1,1,3,2,0,0,0,0,remap=[[0,0],[1,1],[2,2],[3,3],[4,4],[5,5],[6,6],[7,7]]],[1,1,4,2,0,0,0,0,remap=[[0,0],[1,1],[2,2],[3,3],[4,4],[5,5],[6,6],[7,7]]],[1,1,5,2,0,0,0,0,remap=[[0,0],[1,1],[2,2],[3,3],[4,4],[5,5],[6,6],[7,7]]],[1,1,6,2,0,0,0,0,remap=[[0,0],[1,1],[2,2],[3,3],[4,4],[5,5],[6,6],[7,7]]],[1,1,7,2,0,0,0,0,remap=[[0,0],[1,1],[2,2],[3,3],[4,4],[5,5],[6,6],[7,7]]],[1,1,8,2,0,0,0,0,remap=[[0,0],[1,1],[2,2],[3,3],[4,4],[5,5],[6,6],[7,7]]],[2,1,1,2,0,0,0,0,remap=[[0,0],[1,1],[2,2],[3,3],[4,4],[5,5],[6,6],[7,7]]],[2,1,2,2,0,0,0,0,remap=[[0,0],[1,1],[2,2],[3,3],[4,4],[5,5],[6,6],[7,7]]],[2,1,3,2,0,0,0,0,remap=[[0,0],[1,1],[2,2],[3,3],[4,4],[5,5],[6,6],[7,7]]]]];
var port_config=[['1','1','1',1,3,2,1,0,0,0,0,0,0,1,0,0,0,'abc1,23'],['1','1','2',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],['1','1','3',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],['1','1','4',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],['1','1','5',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],['1','1','6',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],['1','1','7',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],['1','1','8',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],['2','1','1',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],['2','1','2',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],['2','1','3',1,3,2,1,0,0,0,0,0,0,1,0,0,0,'']];

<% web_exec('show running-config qos') %>
<% web_exec('show running-config interface') %>


var port_type = ['undefine','FE','GE'];
var port_cmd_list = [];
var select_policy = ['default','wrr','sp'];
var select_queue = ['0','1','2','3'];
//var select_vid_sada = ['none','priority'];
var select_vid_sada = ['-','override'];
//var select_priority = ['0','1','2','3','4','5','6','7','Default'];
var select_priority = ['0','1','2','3','4','5','6','7'];

for(var i=0;i<port_config.length;++i){

	if(port_config[i][0] == 1){
		port_cmd_list.push("fastethernet "+ port_config[i][1] + "/" + port_config[i][2]);
	}else if(port_config[i][0] == 2){
		port_cmd_list.push("gigabitethernet "+ port_config[i][1] + "/" + port_config[i][2]);
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

	for(var i = 0;i < qos_config[2].length;i++){
		var interface_view_flag = 1;
		
		//check policy
		if(E('_'+i+'_policy').value != select_policy[qos_config[2][i][3]]){
			if(interface_view_flag){
				cmd += "!" + "\n";
				cmd += "interface " + port_cmd_list[i] + "\n";
				interface_view_flag = 0;
			}
			if(E('_'+i+'_policy').value == 'default'){
				cmd += "no qos scheduler policy" + "\n";
			}else{
				cmd += "qos scheduler policy " + E('_'+i+'_policy').value + "\n";
			}			
		}

		//check queue
		if(E('_'+i+'_priority').value != select_priority[qos_config[2][i][4]]){
			if(interface_view_flag){
				cmd += "!" + "\n";
				cmd += "interface " + port_cmd_list[i] + "\n";
				interface_view_flag = 0;
			}
			if(E('_'+i+'_priority').value == 'Default'){
				cmd += "no qos priority" + "\n";
			}else{
				cmd += "qos priority " + E('_'+i+'_priority').value + "\n";			
			}
			
		}

		//check vid override 
		if(E('_'+i+'_vid').value != select_vid_sada[qos_config[2][i][5]]){
			if(interface_view_flag){
				cmd += "!" + "\n";
				cmd += "interface " + port_cmd_list[i] + "\n";
				interface_view_flag = 0;
			}
			if(E('_'+i+'_vid').value == select_vid_sada[0]){
				cmd += "no qos override vid" + "\n";
			}else{
				cmd += "qos override vid priority\n";
			}
		}

		//check sa override
		if(E('_' + i + '_sa').value != select_vid_sada[qos_config[2][i][6]]){
			if(interface_view_flag){
				cmd += "!" + "\n";
				cmd += "interface " + port_cmd_list[i] + "\n";
				interface_view_flag = 0;
			}
			if(E('_'+i+'_sa').value == select_vid_sada[0]){
				cmd += "no qos override sa" + "\n";
			}else{
				cmd += "qos override sa priority\n";
			}
			
		}

		//check da override
		if(E('_' + i + '_da').value != select_vid_sada[qos_config[2][i][7]]){
			if(interface_view_flag){
				cmd += "!" + "\n";
				cmd += "interface " + port_cmd_list[i] + "\n";
				interface_view_flag = 0;
			}
			if(E('_'+i+'_da').value == select_vid_sada[0]){
				cmd += "no qos override da" + "\n";
			}else{
				cmd += "qos override da priority\n";
			}
			
		}

		//check priority to priority
		for(var j=0;j< qos_config[2][i][8].length;++j){
			if (E('_'+ i + '_priority' + j).value == '-') {
				if (select_priority[qos_config[2][i][8][j][0]]
					!= select_priority[qos_config[2][i][8][j][1]]){
					if(interface_view_flag){
						cmd += "!" + "\n";
						cmd += "interface " + port_cmd_list[i] + "\n";
						interface_view_flag = 0;
					}
					
					cmd += "no qos remap priority\n";
				}			
			}else{
				if (E('_'+ i + '_priority' + j).value != select_priority[qos_config[2][i][8][j][1]]){
					if(interface_view_flag){
						cmd += "!" + "\n";
						cmd += "interface " + port_cmd_list[i] + "\n";
						interface_view_flag = 0;
					}

					cmd += "qos remap priority " + qos_config[2][i][8][j][0] +" priority " + E('_'+ i + '_priority' + j).value + "\n";					
				}
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

	if (cookie.get('debugcmd') == 1)
		alert(E('_fom')._web_cmd.value);
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


<div class='section'>
	<table class='web-grid' cellspacing=1 id='adm_grid'>
<script type='text/javascript'>
		W("<tr id='adm-head'>");
			W("<td rowSpan=2 width=40>" + port.port + "</td>");
			W("<td rowSpan=2 width=80>" + qos.policy + "</td>");	
			W("<td colspan=3 width=240>" + qos.prio_override + "</td>");
			W("<td colspan=8 width=320>" + qos.prio_remap + "</td>");
			W("<td rowSpan=2 width=80>" + qos.priority + "</td>");			
		W("</tr>");
		W("<tr id='adm-head'>");
			W("<td width=80>" + qos.da + "</td>");
			W("<td width=80>" + qos.sa + "</td>");
			W("<td width=80>" + qos.vid + "</td>");			
			for(var j=0;j<qos_config[2][0][8].length;++j){
				W("<td width=40>" + qos.pri2pri + qos_config[2][0][8][j][0] + "</td>");
			}
		W("</tr>");
		
		var i;
		var storm_type;
		var select_priority_tmp;
		for( i = 0; i < qos_config[2].length; i++){
			
			W("<td>" + port_type[qos_config[2][i][0]] + qos_config[2][i][1] + "/" + qos_config[2][i][2] + "</td>"); 
			W(creatSelect(select_policy,select_policy[qos_config[2][i][3]],i,'_policy'));
			W(creatSelect(select_vid_sada,select_vid_sada[qos_config[2][i][7]],i,'_da'));	
			W(creatSelect(select_vid_sada,select_vid_sada[qos_config[2][i][6]],i,'_sa'));
			W(creatSelect(select_vid_sada,select_vid_sada[qos_config[2][i][5]],i,'_vid'));
			for(var j=0;j<qos_config[2][i][8].length;++j){
				select_priority_tmp = select_priority;
				select_priority_tmp[j] = '-';
				W(creatSelect(select_priority,select_priority[qos_config[2][i][8][j][1]],i,'_priority'+j));
				select_priority_tmp[j] = j;
			}
			W(creatSelect(select_priority,select_priority[qos_config[2][i][4]],i,'_priority'));
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
