<% pagehead(menu.switch_vlan) %>

<style type='text/css'>


</style>

<script type='text/javascript'>

<% ih_sysinfo() %>
<% ih_user_info() %>

<% web_exec('show running-config vlan') %>
<% web_exec('show running-config interface') %>

<% web_exec('show running-config multicast') %>


var vid_cookie = cookie.get('mcast-modify-vid');
var mac_cookie = cookie.get('mcast-modify-mac');
if (vid_cookie == null){
	vid_cookie = 0;
}
if (mac_cookie == null)
{
	mac_cookie = "";
}

var dest_group_config = 	{
								vlan_id: "",
								mac_addr: "",
								pri: 7,
								member_ports: []
							};


if (mac_cookie != ""){
	for (var i = 0; i < Static_groups_config.length; i++){
		if (Static_groups_config[i].vlan_id == vid_cookie
			&& Static_groups_config[i].mac_addr == mac_cookie){
			dest_group_config = Static_groups_config[i];
		}
	}
}




var port_title_list = [];
var port_cmd_list = [];
var port_id = [];
var vlan_options = [];

for(var i=0;i<port_config.length;++i){	
	if(port_config[i][0] == 1){
		port_title_list.push("FE"+ port_config[i][1] + "/" + port_config[i][2]);
		port_cmd_list.push("fastethernet "+ port_config[i][1] + "/" + port_config[i][2]);		
	}else if(port_config[i][0] == 2){
		port_title_list.push("GE"+ port_config[i][1] + "/" + port_config[i][2]);
		port_cmd_list.push("gigabitethernet "+ port_config[i][1] + "/" + port_config[i][2]);
	}

	port_id.push([port_config[i][0], port_config[i][1], port_config[i][2]]);
}

for (var i=0; i<vlan_config.length; i++) {
	vlan_options.push([i,vlan_config[i][0]]);
}

function groupInVlan(group_config)
{
	for (var i = 0; i < vlan_options.length; i++){
		if (group_config.vlan_id == vlan_options[i][1]){
			return i; 
		}
	}

	return 0;
}

function portInVlan(port_index, vid)
{
	for (var i=0; i<vlan_config.length; i++) {
		if (vlan_config[i][0] == vid){
			//untagged
			for (var j = 0; j < vlan_config[i][4].length; j++){
				if ((port_id[port_index][0] == vlan_config[i][4][j][0])
					&& (port_id[port_index][1] == vlan_config[i][4][j][1])
					&& (port_id[port_index][2] == vlan_config[i][4][j][2]))
					return 1;
			}
			//tagged
			for (var j = 0; j < vlan_config[i][5].length; j++){
				if ((port_id[port_index][0] == vlan_config[i][5][j][0])
					&& (port_id[port_index][1] == vlan_config[i][5][j][1])
					&& (port_id[port_index][2] == vlan_config[i][5][j][2]))
					return 1;
			}
			return 0;
		}
	}

	return 0;
}

function existGroup(mac, vid)
{
	for (var i = 0; i < Static_groups_config.length; i++){
		if (Static_groups_config[i].vlan_id == vid
			&& Static_groups_config[i].mac_addr == mac){
			return 1;
		}
	}

	return 0;
}


function port_mem_in_group(port_index, group_config)
{
	for (var i = 0; i < group_config.member_ports.length; i++){
		if(port_id[port_index][0] == group_config.member_ports[i][0]
			&& port_id[port_index][1] == group_config.member_ports[i][1]
			&& port_id[port_index][2] == group_config.member_ports[i][2]){
			return true;
		}
	}	

	return false;
}


function back()
{
	document.location = 'switch-multicast-groups.jsp';	
}






function verifyFields(focused, quiet)
{
	var cmd = "";
	var fom = E('_fom');

	E('save-button').disabled = true;

	if (mac_cookie == ""){
		//mac
		if (E('_f_mac').value == ''
			|| !v_mcast_nonigmp_mac(E('_f_mac').value)){
			ferror.set('_f_mac', errmsg.mac_multicast, quiet);
			return 0;
		}else{
			ferror.clear('_f_mac');
		}
		//vid
		if (existGroup(E('_f_mac').value ,vlan_options[E('_f_vid').value][1] )) {
				ferror.set('_f_mac', errmsg.duplicate_multicast_group, quiet);
				ferror.set('_f_vid', errmsg.duplicate_multicast_group, true);
				return 0;
		}else{
				ferror.clear('_f_vid');
				ferror.clear('_f_mac');
		}
		//pri
		cmd += "!\n"+"mac address-table multicast "+E('_f_mac').value + " vlan " + vlan_options[E('_f_vid').value][1] + " priority "+ E('_f_pri').value +"\n";

	}


	//ports
	//disabled??
	for (var i = 0; i < port_title_list.length; i++){
		if (!portInVlan(i,  vlan_options[E('_f_vid').value][1])){
			E('_f_port_'+i).checked = false;
			E('_f_port_'+i).disabled = true;
		}else
			E('_f_port_'+i).disabled = false;
	}
	
	for (var i = 0; i < port_title_list.length; i++){
		if (E('_f_port_'+i).disabled) continue;
		if (E('_f_port_'+i).checked != port_mem_in_group(i, dest_group_config)){
			cmd += (E('_f_port_'+i).checked == false?"no ":"")+"mac address-table multicast "+E('_f_mac').value + " vlan " + vlan_options[E('_f_vid').value][1] + " interface "+port_cmd_list[i]+"\n";
		}
	}
	
	if (user_info.priv < admin_priv) {
		elem.display('save-button', false);
	}else{
		elem.display('save-button', true);
		E('save-button').disabled = (cmd=="");
		fom._web_cmd.value = cmd;
	}

	return 1;
}

function save()
{
	if (!verifyFields(null, false)) return;	
	
	if ((cookie.get('debugcmd') == 1))
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
var members_cells = [];
var i = 0
var r = -1;
do{
	if (i % 4 != 0)
		members_cells[r].push({name: 'f_port_'+i, type: 'checkbox', prefix:port_title_list[i]+':  ', value: port_mem_in_group(i, dest_group_config)});
	else{
		members_cells.push([{name: 'f_port_'+i, type: 'checkbox', prefix:port_title_list[i]+':  ', value: port_mem_in_group(i, dest_group_config)}]);
		r++;
	}
	i++;
}while(i < port_title_list.length);

var group_tb = [
					{ title: ui.mac_address, name: 'f_mac', type: 'text', maxlen: 14, size: 16, value: dest_group_config.mac_addr},
					{ title: ui.vlan_id, name: 'f_vid', type: 'select', options: vlan_options, value: groupInVlan(dest_group_config) },					
					{ title: ui.priority, name: 'f_pri', type: 'select', 
						options: [[0,'0'],[1,'1'],[2,'2'],[3,'3'],[4,'4'],[5,'5'],[6,'6'],[7,'7']],
						value: dest_group_config.pri},
					{ title: igmp.join_ports, multitb: members_cells[0]}
				];

for (var i = 1; i < members_cells.length; i++){
	group_tb.push({ title: '', multitb: members_cells[i]});
}				

createFieldTable('', group_tb);

if (mac_cookie != "")	{
	E('_f_vid').disabled = true;
	E('_f_mac').disabled = true;
	E('_f_pri').disabled = true;
}


</script>
</div>

<script type='text/javascript'>
init();
if(cookie.get('autosave') == 1)
	ui.aply=ui.aply_save;
genStdFooterWithBack("");
</script>

<script type='text/javascript'>verifyFields(null, true);</script>
</form>
</body>
</html>
