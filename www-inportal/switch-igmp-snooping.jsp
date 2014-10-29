<% pagehead(menu.switch_igmp) %>
<style tyle='text/css'>
#adm_grid{
	width: 800px;
	text-align: center;
}

#vlan-grid {
	width:200px;
	text-align: center;
}
#vlan-grid .co1 {
	width:20px;
	text-align: center;
}
#vlan-grid .co2 {
	width:100px;
	text-align: center;
}
#igmp_grid {
	width: 800px;
	text-align: center;
}

.web-grid input{
	width:auto;
}
</style>

<script type='text/javascript'>

<% ih_sysinfo()%>
<% ih_user_info(); %>

/*
var IGMP_snooping_config = {
	protocol_status:1,
	active:1,
       sta_mrouter_interfaces:[[1,1,2],[1,1,3],[2,1,1]],
       mrouter_forwarding:1, 
       RSTP_flooding:0,   
       query_interval:12,
       igmp_snooping_vlan:[1, 5],
       static_member:[[1,"0100.5e34.5678",[[1,1,2],[1,1,3]]],[5,"0100.5e34.0000",[[1,1,4],[1,1,5]]]]
    };
var vlan_config=[[1,0,0,'VLAN0001',untagged=[[1,1,2],[1,1,3],[1,1,5],[1,1,6],[1,1,7],[1,1,8],[2,1,1],[2,1,2],[2,1,3]],tagged=[]],[5,0,0,'VLAN0005',untagged=[[1,1,1],[1,1,4]],tagged=[[1,1,2],[1,1,3]]]];
var port_config=[['1','1','1',1,3,2,1,0,0,0,0,0,0,1,0,0,0,'abc1,23'],['1','1','2',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],['1','1','3',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],['1','1','4',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],['1','1','5',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],['1','1','6',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],['1','1','7',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],['1','1','8',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],['2','1','1',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],['2','1','2',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],['2','1','3',1,3,2,1,0,0,0,0,0,0,1,0,0,0,'']];
*/
	
<% web_exec('show running-config igmp-snooping') %>
<% web_exec('show running-config vlan') %>
<% web_exec('show running-config interface') %>


var port_type = ['undefine','FE','GE'];
var select_igmp_mode = ['passive','active'];
var select_state = ['off','on'];
var port_cmd_list =[];
var port_title_list = [];

var router_port_old = [];
var router_ports_disabled = [];
var static_mem_disabled = [];

for(var i=0;i<port_config.length;++i){
	router_port_old[i] = 0;
	static_mem_disabled.push(0);
	router_ports_disabled.push(0);
	
	if(port_config[i][0] == 1){
		port_cmd_list.push("fastethernet "+ port_config[i][1] + "/" + port_config[i][2]);
		port_title_list.push("FE"+ port_config[i][1] + "/" + port_config[i][2]);
	}else if(port_config[i][0] == 2){
		port_cmd_list.push("gigabitethernet "+ port_config[i][1] + "/" + port_config[i][2]);
		port_title_list.push("GE"+ port_config[i][1] + "/" + port_config[i][2]);
	}
	
	for(var j=0;j<IGMP_snooping_config.sta_mrouter_interfaces.length;j++){
		if((port_config[i][0] == IGMP_snooping_config.sta_mrouter_interfaces[j][0])
			&& (port_config[i][1] == IGMP_snooping_config.sta_mrouter_interfaces[j][1])
			&& (port_config[i][2] == IGMP_snooping_config.sta_mrouter_interfaces[j][2])){
			router_port_old[i] = 1;
			//static_mem_disabled[i] = 1;
			break;
		}
	}

	for (var j = 0; j < IGMP_snooping_config.static_member.length; j++){
		for (var k = 0; k < IGMP_snooping_config.static_member[j][2].length; k++){
			if((port_config[i][0] == IGMP_snooping_config.static_member[j][2][0])
				&& (port_config[i][1] == IGMP_snooping_config.static_member[j][2][1])
				&& (port_config[i][2] == IGMP_snooping_config.static_member[j][2][2])){
				router_ports_disabled[i] = 1;
				break;
			}
		}
	}
}



var vlan_igmp_old = [];
for(var i=0;i<vlan_config.length;++i){
	vlan_igmp_old[i] = 0;
	for(var j=0;j<IGMP_snooping_config.igmp_snooping_vlan.length;++j){
		if(IGMP_snooping_config.igmp_snooping_vlan[j] == vlan_config[i][0]){
			vlan_igmp_old[i] = 1;
			break;
		}
	}
}

var tmp_old_config = [];
var vlan_options = [];
var vlan_select = [];
var igmp_vlan_options = [];

for (i=0; i<vlan_config.length; i++) {
	vlan_options.push([i,vlan_config[i][0]]);
	vlan_select.push(vlan_config[i][0]);
}



function mRouterDisabled()
{
	var data = igmp_m.getAllData();
	for (var i= 0; i < router_ports_disabled.length; i++){
		router_ports_disabled[i] = 0;
		for (var j = 0; j < data.length; j++){//all line
			if (data[j][i+2]){
				router_ports_disabled[i] = 1;//mark disabled
				break;
			}
		}

		E('_'+i+'_port').disabled = (router_ports_disabled[i] == 1 ? true: false);
	}
}
function generateVlanOptions()
{
	igmp_vlan_options = [];
	
	for(var i = 0;i < vlan_config.length;++i){
		if (E('_'+i+'_vlan_igmp').value == 'Enable'){
			igmp_vlan_options.push(vlan_options[i]);
		}
	}
}


function isDigit(str)
{ 
  var reg = /^\d*$/; 

  return reg.test(str); 
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

var igmp_m = new webGrid();



function portIsVlanMember(port_index, vlan_id)
{
	//alert(switch_interface[port_option_id][1]+" is in vlan " + vlan_id +"?");
	for (var i =0; i < vlan_config.length; i++){
		if (vlan_id != vlan_config[i][0]) continue;		
		/*untagged*/
		for (var j = 0; j < vlan_config[i][4].length; j++){
			if ((vlan_config[i][4][j][0] == parseInt(port_config[port_index][0], 10))
				&& (vlan_config[i][4][j][1] == parseInt(port_config[port_index][1], 10))
				&& (vlan_config[i][4][j][2] == parseInt(port_config[port_index][2], 10)))
				return true;
		}
		/*tagged*/
		for (var j = 0; j < vlan_config[i][5].length; j++){
			if ((vlan_config[i][5][j][0] == parseInt(port_config[port_index][0], 10))
				&& (vlan_config[i][5][j][1] == parseInt(port_config[port_index][1], 10))
				&& (vlan_config[i][5][j][2] == parseInt(port_config[port_index][2], 10)))
				return true;
		}
	}
	return false;
}

igmp_m.setup = function() {
	var header_title = [ui.mac_address,'VLAN ID', ui.prt];
	var config_options = [
		{ type: 'text'},
		{ type: 'text'},
		{ type: 'text'}
	];
	var tmp_config = [];
	var ports_name = "";
	this.init('igmp_grid', ['sort', 'readonly','select'], 256,config_options );
	this.headerSet(header_title);

	for(var i = 0;i < IGMP_snooping_config.static_member.length;++i){
		 tmp_config = [];

		//mac
		tmp_config.push(IGMP_snooping_config.static_member[i][1].toString());
		//vlan id
		tmp_config.push(IGMP_snooping_config.static_member[i][0].toString());
		//ports
		ports_name = "";
		for(var k=0;k<IGMP_snooping_config.static_member[i][2].length;++k){
			ports_name += (k==0?"":",")+(IGMP_snooping_config.static_member[i][2][k][0] == 1?"FE":"GE")+IGMP_snooping_config.static_member[i][2][k][1]+"/"+IGMP_snooping_config.static_member[i][2][k][2];
		}
		tmp_config.push(ports_name);		
		

		
		igmp_m.insertData(-1,tmp_config);
	}
	
	if (user_info.priv >= admin_priv)
		igmp_m.footerButtonsSet(0);
}

igmp_m.jump = function(){
	document.location = 'switch-igmp-groupN.jsp';	
}

igmp_m.footerAdd = function(){
	cookie.unset('igmp-modify-mac');
	cookie.unset('igmp-modify-vid');
	igmp_m.jump();		
}
	
igmp_m.footerModify = function(){
	var f = igmp_m.getAllData();
	if (igmp_m.selectedRowIndex < 0 || igmp_m.selectedColIndex < 0)
		return;

	var mac = f[igmp_m.selectedRowIndex - 1][0];
	var vid = f[igmp_m.selectedRowIndex - 1][1];
	
	cookie.set('igmp-modify-mac', mac);
	cookie.set('igmp-modify-vid', vid);

	igmp_m.jump();
}
	
igmp_m.footerDel = function(){
	var send_cmd = "";
	var f = igmp_m.getAllData();
	if (igmp_m.selectedRowIndex < 0 || this.selectedColIndex < 0)
		return;
	var mac = f[igmp_m.selectedRowIndex - 1][0];
	var vid = f[igmp_m.selectedRowIndex - 1][1];

	for(var j=0; j < IGMP_snooping_config.static_member.length; j++){
		if (mac == IGMP_snooping_config.static_member[j][1]
			&& vid == IGMP_snooping_config.static_member[j][0]){
			for (var i = 0; i < IGMP_snooping_config.static_member[j][2].length; i++){
				send_cmd += "no ip igmp snooping vlan "+vid+" static "+mac+" interface "
							+(IGMP_snooping_config.static_member[j][2][i][0] == 1?"fastethernet ":"gigabitethernet ")
							+IGMP_snooping_config.static_member[j][2][i][1]+"/"+IGMP_snooping_config.static_member[j][2][i][2]
							+"\n";	
			}
		}
	}

	if (send_cmd != "")
		E('_fom')._web_cmd.value += "!"+"\n"+send_cmd;
	
	if((E('_fom')._web_cmd.value != '')&&(cookie.get('autosave') == 1)){
		E('_fom')._web_cmd.value += "!"+"\n"+"copy running-config startup-config"+"\n";	
	}

	form.submit('_fom', 1);
}






function verifyFields(focused, quiet)
{
	var cmd = "";
	var fom = E('_fom');
	var view_flag = 1;
	var dis;
	
	E('save-button').disabled = true;	

	//verify
	if (!v_f_number(E('_query_interval'), quiet, false, 10, 3600)) return 0;
	/*
	if((E('_query_interval').value < 10) ||(E('_query_interval').value > 3600)||(!isDigit(E('_query_interval').value))){
		ferror.set(E('_query_interval'), errmsg.invalid, false);
		return 0;
	}else{
		ferror.clear(E('_query_interval'));
	}
	*/

	dis = !(E('_f_igmp_enable').checked);

//	E('_port_parameters_title').style.display = dis ? 'none' : 'block';
//	E('vlan-grid').style.display = dis ? 'none' : 'block';
//	E('_static_member').style.display = dis ? 'none' : 'block';
//	E('igmp_grid').style.display = dis ? 'none' : 'block';
	E('_port_parameters_title').style.display = dis ? 'none' : '';
	E('vlan-grid').style.display = dis ? 'none' : '';
	E('_static_member').style.display = dis ? 'none' : '';
	E('igmp_grid').style.display = dis ? 'none' : '';


	
	
	//igmp enable
	if((E('_f_igmp_enable').checked ? 1:0) != IGMP_snooping_config.protocol_status){
		if(view_flag){
			cmd += "!" + "\n";
			view_flag = 0;
		}
		if((E('_f_igmp_enable').checked ? 1:0) == 1){
			cmd += "ip igmp snooping" + "\n";
		}else{
			cmd += "no ip igmp snooping" + "\n";
		}
	}
	
	//check igmp mode
	if(E('_igmp_mode').value != IGMP_snooping_config.active){
		if(view_flag){
			cmd += "!" + "\n";
			view_flag = 0;
		}
		
		if(E('_igmp_mode').value == 0){
			cmd += "no ip igmp snooping active " + "\n";
		}else{
			cmd += "ip igmp snooping active " + "\n";
		}
	}
	//check query interval
	if(E('_query_interval').value != IGMP_snooping_config.query_interval){
		if(E('_query_interval').value == ''){
			if(view_flag){
				cmd += "!" + "\n";
				view_flag = 0;
			}
			cmd += "no ip igmp snooping query-interval " + "\n";
		}else{
			if(view_flag){
				cmd += "!" + "\n";
				view_flag = 0;
			}
			cmd += "ip igmp snooping query-interval " + E('_query_interval').value + "\n";
			
		}
	}

	//check router forwarding
	if(E('_router_forwarding').value != IGMP_snooping_config.mrouter_forwarding){
		if(view_flag){
			cmd += "!" + "\n";
			view_flag = 0;
		}
		if(E('_router_forwarding').value == 0){
			cmd += "no ip igmp snooping mrouter forwarding" + "\n";
		}else{
			cmd += "ip igmp snooping mrouter forwarding" + "\n";
		}
	}
	
	//check rstp flooding
	if(E('_rstp_flooding').value != IGMP_snooping_config.RSTP_flooding){
		if(view_flag){
			cmd += "!" + "\n";
			view_flag = 0;
		}
		
		if(E('_rstp_flooding').value == 0){
			cmd += "no ip igmp snooping tcn flood" + "\n";
		}else{
			cmd += "ip igmp snooping tcn flood" + "\n";
		}
		
	}
	
	//check router ports
	for(var i=0;i<port_config.length;++i){
		
		if((E('_'+i+'_port').checked ? 1:0) != router_port_old[i]){
			if(view_flag){
				cmd += "!" + "\n";
				view_flag = 0;
			}
			if(E('_'+i+'_port').checked ? 1:0 == 1){ //add port
				cmd += "ip igmp snooping mrouter interface " + port_cmd_list[i] + "\n";		
			}else{//delete port
				cmd += "no ip igmp snooping mrouter interface " + port_cmd_list[i] + "\n";
			}
		}
		//static_mem_disabled[i] = (E('_'+i+'_port').checked ? 1:0);
	}
//	igmp_m.resetNewEditor();
	if (E('_f_igmp_enable').checked){
		//check vlan's IGMP snooping 
		for(var i=0;i<vlan_config.length;++i){
			
			if((E('_'+i+'_vlan_igmp').value) != ['Disable','Enable'][vlan_igmp_old[i]]){
				if(view_flag){
					cmd += "!" + "\n";
					view_flag = 0;
				}
				if(E('_'+i+'_vlan_igmp').value =='Disable'){//disable vlan's igmp
					cmd += "no ip igmp snooping vlan " + vlan_config[i][0] + "\n";		
				}else{//enable vlan's igmp
					cmd += "ip igmp snooping vlan " + vlan_config[i][0] + "\n";		
				}
			}
		}


		//check static member
	//	if (igmp_m.isEditing()) return 0;
	//	cmd += checkGrid();
	}


	//alert(cmd);
	if (user_info.priv < admin_priv) {
		elem.display('save-button', false);
	}else{
		elem.display('save-button', true);
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
	return 1;
}
</script>
</head>
<body onload='init()'>
<form id='_fom' method='post' action='apply.cgi'>
<input type='hidden' name='_web_cmd' value=''>

<div class='section'>
<script type='text/javascript'>

createFieldTable('', [
	{ title: ui.enable + ' IGMP Snooping', name: 'f_igmp_enable', type: 'checkbox', value: IGMP_snooping_config.protocol_status},
	{ title: igmp.mode, name: 'igmp_mode', type: 'select', options: [[0,'passive'],[1,'active']],value: IGMP_snooping_config.active },
	{ title: igmp.query_interval, name: 'query_interval', type: 'text',suffix: ' '+ui.seconds+' (10-3600)',size: 9,value: IGMP_snooping_config.query_interval},
	{ title: igmp.router_forwarding,name: 'router_forwarding', type: 'select',options: [[0,'off'],[1,'on']], value: IGMP_snooping_config.mrouter_forwarding},
	{ title: igmp.rstp_flooding,name: 'rstp_flooding', type: 'select',options: [[0,'off'],[1,'on']], value: IGMP_snooping_config.RSTP_flooding}
]);
</script>
</div>

<div class='section-title'><script type='text/javascript'>
	GetText(igmp.router_ports);
</script></div>
<div class='section'>
	<table class='web-grid' cellspacing=1 id='adm_grid'>
<script type='text/javascript'>
		W("<tr id='adm-head'>");
			for(var i=0;i<port_config.length;i++){
				W("<td>" + port_type[port_config[i][0]] + port_config[i][1] + "/" + port_config[i][2] + "</td>"); 
			}
		W("</tr>");
			for(var j=0;j<port_config.length;j++){
				W("<td><input type='checkbox' onchange='verifyFields()' id='_" + j + "_port' name='" + j + "_port' "+ ((router_port_old[j]== '1') ? 'checked' : '') +  "></td>");
			}
			W("</tr>");			
	
</script>
	</table>
</div>

<div class='section-title' id='_port_parameters_title'>
<script type='text/javascript'>
	GetText(igmp.vlan_igmp);
</script>
</div>
<div class='section'>
	<table class='web-grid' cellspacing=1 id='vlan-grid'>
<script type='text/javascript'>
		W("<tr id='adm-head'>");
			W("<td width=80>" + 'VID' + "</td>");
			W("<td width=100>" + 'IGMP Snooping'  + "</td>");
			
		W("</tr>");
		
			for(var i = 0;i < vlan_config.length;++i){
				W("<td>" + vlan_config[i][0] + "</td>"); 
				W(creatSelect(['Disable','Enable'],['Disable','Enable'][vlan_igmp_old[i]],i,'_vlan_igmp'));
				W("</tr>");
			}
						
	
</script>
	</table>
</div>




<div class='section'>
<script type='text/javascript'>
init();
if(cookie.get('autosave') == 1)
	ui.aply=ui.aply_save;
genStdFooter("");
</script>
</div>



<div class='section-title' id='_static_member'>
<script type='text/javascript'>
	GetText(igmp.multicast_group_member);
</script>
</div>
<div class='section'>
	<table class='web-grid' cellspacing=1 id='igmp_grid'></table>
	<script type='text/javascript'>igmp_m.setup();</script>
</div>
</form>
<script type='text/javascript'>/*mRouterDisabled();*/verifyFields(null, 1);</script>
</body>
</html>
