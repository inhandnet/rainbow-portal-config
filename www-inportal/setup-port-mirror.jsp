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

//var monitor_config=[destination=[1,1,2],source=[[1,1,3,2]]];
//var port_config=[['1','1','1',1,3,2,1,0,0,0,0,0,0,0,0,0,1,0,0,0,'abc1,23'],['1','1','2',1,3,2,1,0,0,0,0,0,0,0,0,0,1,0,0,0,'abc1,23'],['1','1','3',1,3,2,1,0,0,0,0,0,0,0,0,0,1,0,0,0,'abc1,23'],['1','1','4',1,3,2,1,0,0,0,0,0,0,0,0,0,1,0,0,0,'abc1,23'],['1','1','5',1,3,2,1,0,0,0,0,0,0,0,0,0,1,0,0,0,'abc1,23'],['1','1','6',1,3,2,1,0,0,0,0,0,0,0,0,0,1,0,0,0,'abc1,23'],['1','1','7',1,3,2,1,0,0,0,0,0,0,0,0,0,1,0,0,0,'abc1,23'],['1','1','8',1,3,2,1,0,0,0,0,0,64,0,128,0,1,0,0,0,'abc1,23'],['2','1','1',1,3,2,1,0,0,0,0,0,64,0,128,0,1,0,0,0,'abc1,23'],['2','1','2',1,3,2,1,0,0,0,0,0,64,0,128,0,1,0,0,0,'abc1,23']];

<% web_exec('show running-config monitor') %>
<% web_exec('show running-config interface') %>

/*workaround*/
var port_config2 = [];
for(var j=0;j<port_config.length;++j){
	if (port_config[j][1] != 0)
		port_config2.push(port_config[j]);
}
port_config = port_config2;

var src_config_old = [];
var monitor_enable;
if((monitor_config[0].length == 0)&&(monitor_config[1].length ==0)){
	monitor_enable = 0;
}else{
	monitor_enable = 1;
}

//destination port
var port_destination = port_config.length;

for(var j=0;j<port_config.length;++j){
	if(monitor_config[0].length  == 0)
		break;
	if((port_config[j][0] == monitor_config[0][0])
		&&(port_config[j][1] == monitor_config[0][1])
		&&(port_config[j][2] == monitor_config[0][2])){
		port_destination = j;
		break;
	}
	
	if(j == (port_config.length - 1))
		alert("Port Error!");	
}

for(var j=0;j<port_config.length;++j){
	var port_found = 0;

	for(var k=0; k<monitor_config[1].length;++k){
		if ((port_config[j][0] == monitor_config[1][k][0])
			&&(port_config[j][1] == monitor_config[1][k][1])
			&&(port_config[j][2] == monitor_config[1][k][2])){
			src_config_old.push(monitor_config[1][k][3]);
			port_found = 1;
			break;
		}
	}

	if (!port_found)
		src_config_old.push(0);
}

var port_type = ['undefine','FE','GE'];
var port_title_list = [];
var port_cmd_list = [];
var source_port_list = [];
var direction_options = ['none', 'ingress','egress','both'];
var switch_interface = [];


for(var i=0;i<port_config.length;++i){

	if(port_config[i][0] == 1){
		port_title_list.push("FE"+ port_config[i][1] + "/" + port_config[i][2]);
		port_cmd_list.push("fastethernet "+ port_config[i][1] + "/" + port_config[i][2]);
	}else if(port_config[i][0] == 2){
		port_title_list.push("GE"+ port_config[i][1] + "/" + port_config[i][2]);
		port_cmd_list.push("gigabitethernet "+ port_config[i][1] + "/" + port_config[i][2]);
	}
	switch_interface.push([i, port_title_list[i]]);
}

switch_interface.push([port_config.length, "none"]);

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
	var enable;
	var view_flag = 1;
	var cmd = "";
	var fom = E('_fom');
	
	E('save-button').disabled = true;

	enable = (E('_f_monitor_enable').checked);
	E('_mirror_destination').disabled = (!enable);

	for (var i = 0; i < port_config.length; i++){
		if (port_config[i][1] == 0) continue;
		E('_' + i + '_direction').disabled = (!enable);
		ferror.clear('_' + i + '_direction');
	}

//	if (E('_mirror_destination').value < port_config.length){
//		E('_' + E('_mirror_destination').value + '_direction').value = direction_options[0];
//		E('_' + E('_mirror_destination').value + '_direction').disabled = true;
//	}

	if (enable){
		if (E('_mirror_destination').value == port_config.length){//必须设置目的端口
			ferror.set('_mirror_destination', errmsg.non_dir, quiet);
			return 0;
		}else{
			ferror.clear('_mirror_destination');
		//	E('_' + E('_mirror_destination').value + '_direction').disabled = true;
//			E('_' + E('_mirror_destination').value + '_direction').value = 0;//none
			if (E('_' + E('_mirror_destination').value + '_direction').value != direction_options[0]){
				ferror.set('_' + E('_mirror_destination').value + '_direction', errmsg.direction_used, quiet);
				return 0;
			}else
				ferror.clear('_' + E('_mirror_destination').value + '_direction');
		}
	}
	
	//check monitor enable	
	if(enable != monitor_enable){
		if((E('_f_monitor_enable').checked ? 1 : 0) == 0){
			if (view_flag){
				cmd += "!" + "\n";
				view_flag = 0;
			}
			cmd += "no monitor" + "\n";			
		}
	}

	/////////////////////no  monitor...////////////////////////////////////
	//dest port
	if(enable && E('_mirror_destination').value != port_destination
		&& (E('_mirror_destination').value == port_config.length)){
		if (view_flag){
			cmd += "!" + "\n";
			view_flag = 0;
		}
		cmd += "no monitor destination" + "\n";
	}

	//check source port
	if (enable){
		for(var i = 0; i <  port_config.length; i++){
			if (port_config[i][1] == 0) continue;
			if (E('_' + i + '_direction').value != direction_options[src_config_old[i]]
				&& E('_' + i + '_direction').value == direction_options[0]){
				if (view_flag){
					cmd += "!" + "\n";
					view_flag = 0;
				}
				cmd += "no monitor source " + port_cmd_list[i] + "\n";
				
			}
		}
	}

	////////////////////////////monitor dest/source ...////////////////////////////
	if(enable && E('_mirror_destination').value != port_destination
		&& (E('_mirror_destination').value != port_config.length)){
			if (view_flag){
				cmd += "!" + "\n";
				view_flag = 0;
			}
			cmd += "monitor destination " + port_cmd_list[E('_mirror_destination').value] + "\n";
	}

	//check source port
	if (enable){
		for(var i = 0; i <  port_config.length; i++){
			if (port_config[i][1] == 0) continue;
			if (E('_' + i + '_direction').value != direction_options[src_config_old[i]]
				&& E('_' + i + '_direction').value != direction_options[0]){
				if (view_flag){
					cmd += "!" + "\n";
					view_flag = 0;
				}
				
				cmd += "monitor source " + port_cmd_list[i] + " " + E('_' + i + '_direction').value  + "\n";
			}
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
	{ title: ui.enable + ' monitor', name: 'f_monitor_enable', type: 'checkbox', value: monitor_enable},
	{ title: port.mirror_destination, indent: 2, name: 'mirror_destination', type: 'select',options: switch_interface,value: port_destination }
]);
</script>
</div>

<div class='section-title'><script type='text/javascript'>
	GetText(port.mirror_config);
</script></div>
<div class='section'>
	<table class='web-grid' cellspacing=1 id='adm_grid'>
<script type='text/javascript'>
		W("<tr id='adm-head'>");
			W("<td class='header'>" + port.port + "</td>");
			W("<td class='header'>" + port.mirror_direction + "</td>");			
		W("</tr>");

		for(var i=0;i<port_config.length;i++){
			if (port_config[i][1] == 0) continue;
			W("<td>" + port_type[port_config[i][0]] + port_config[i][1] + "/" + port_config[i][2] + "</td>"); 
			W(creatSelect(direction_options,direction_options[src_config_old[i]],i,'_direction'));
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

