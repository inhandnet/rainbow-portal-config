<% pagehead(menu.config_security) %>

<style type='text/css'>
#mac_list_grid {
	width: 300px;
	text-align: center;
}


</style>

<script type='text/javascript'>

<% ih_sysinfo() %>
<% ih_user_info(); %>


<% web_exec('show running-config vlan') %>

//var vlan_config=[[1,0,0,'VLAN0001',untagged=[[1,1,2],[1,1,3],[1,1,5],[1,1,6],[1,1,7],[1,1,8],[2,1,1],[2,1,2],[2,1,3]],tagged=[]],[5,0,0,'VLAN0005',untagged=[[1,1,1],[1,1,4]],tagged=[[1,1,2],[1,1,3]]]];


//var ports_security=[[1,1,1,1,3,maclist=[["0000.0000.0007",1],["0000.0000.0006",1]]],[1,1,2,0,0,maclist=[]],[1,1,3,0,0,maclist=[]],[1,1,4,0,0,maclist=[]],[1,1,5,0,0,maclist=[]],[1,1,6,0,0,maclist=[]],[1,1,7,0,0,maclist=[]],[1,1,8,0,0,maclist=[]],[2,1,1,0,0,maclist=[]],[2,1,2,0,0,maclist=[]]];
<% web_exec('show port-security') %>

var port_index = '<% cgi_get("port_security_index") %>';

var port_type = ['undefine','FE','GE'];


var port_cmd_list = [];
var port_title = [];

var last_enable_status = ports_security[port_index][3];

var vlan_options = [];
var now_vlan_options = [];

for (i=0; i<vlan_config.length; i++) {
	vlan_options.push([i,vlan_config[i][0]]);
}

for(var i=0;i<ports_security.length;++i){

	if(ports_security[i][0] == 1){
		port_cmd_list.push("fastethernet "+ ports_security[i][1] + "/" + ports_security[i][2]);
		port_title.push("FE"+ ports_security[i][1] + "/" + ports_security[i][2]);
	}else if(ports_security[i][0] == 2){
		port_cmd_list.push("gigabitethernet "+ ports_security[i][1] + "/" + ports_security[i][2]);
		port_title.push("GE "+ ports_security[i][1] + "/" + ports_security[i][2]);
	}
}

function portIsVlanMember(port_id, vlan_id)
{
	for (var i =0; i < vlan_config.length; i++){
		if (vlan_id != vlan_config[i][0]) continue;
		/*untagged*/
		for (var j = 0; j < vlan_config[i][4].length; j++){
			if ((vlan_config[i][4][j][0] == parseInt(ports_security[port_id][0], 10))
				&& (vlan_config[i][4][j][1] == parseInt(ports_security[port_id][1], 10))
				&& (vlan_config[i][4][j][2] == parseInt(ports_security[port_id][2], 10)))
				return true;
		}
		/*tagged*/
		for (var j = 0; j < vlan_config[i][5].length; j++){
			if ((vlan_config[i][5][j][0] == parseInt(ports_security[port_id][0], 10))
				&& (vlan_config[i][5][j][1] == parseInt(ports_security[port_id][1], 10))
				&& (vlan_config[i][5][j][2] == parseInt(ports_security[port_id][2], 10)))
				return true;
		}
	}
	//alert(switch_interface[port_option_id][1]+" is not in vlan " + vlan_id);
	return false;
}


for (i=0; i<vlan_options.length; i++) {
	if (!portIsVlanMember(port_index, vlan_options[i][1])) continue;		
	now_vlan_options.push(vlan_options[i]);
}

function vlanExist(vid)
{
	for (var i = 0; i < vlan_config.length; i++){
		if (vid == vlan_config[i][0]) return true;
	}
	return false;
}


function getVlanOptionId(vid)
{
	for (var i = 0; i < vlan_options.length; i++){
		if (vid == vlan_options[i][1])
			return i;
	}

	return -1;
}

var mac_list = new webGrid();
mac_list.onDataChanged = function(){
	verifyFields(-1, true);
}

mac_list.dataToView = function(data) {
	var ret_data =[vlan_options[data[0]][1].toString(), data[1]];


	return ret_data;
}


mac_list.verifyFields = function(row, quiet) {
	var f = fields.getAll(row);
	var all_data = mac_list.getAllData();

	if (f[1].value == ""){
		ferror.set(f[1], errmsg.adm3, quiet);
		return 0;	
	}else{
		ferror.clear(f[1]);
	}
	/*
	if (haveChineseChar(f[0].value)){
		ferror.set(f[0], errmsg.cn_chars, false);
		return 0;		
	}else{
		ferror.clear(f[0]);
	}

	if (!vlanExist(f[0].value)){
		ferror.set(f[0], errmsg.vlan_not_exist, false);
		return 0;		
	}else{
		ferror.clear(f[0]);
	}
	*/
	if (haveChineseChar(f[1].value)){
		ferror.set(f[1], errmsg.cn_chars, false);
		return 0;		
	}else{
		ferror.clear(f[1], errmsg.cn_chars, false);
	}

	if (!v_mac2(f[1].value)){
		ferror.set(f[1], errmsg.mac, false);
		return 0;	
	}else{
		ferror.clear(f[1], errmsg.mac, false);
	}
	//mac address exist on this port
	for (var i = 0; i < all_data.length; i++){
		if (all_data[i][0] == f[0].value
			&& all_data[i][1] == f[1].value){
			ferror.set(f[0], errmsg.exist_mac1, quiet);
			ferror.set(f[1], errmsg.exist_mac1, true);
			return 0;	
		}
	}
	ferror.clear(f[0], errmsg.exist_mac1, quiet);
	ferror.clear(f[1], errmsg.exist_mac1, true);

	//mac address exist on other port
	for (var i = 0; i < ports_security.length; i++){
		if (i == port_index) continue;
		if (!ports_security[i][3]) continue;
		for (var j = 0; j < ports_security[i][5].length; j++){
			if (ports_security[i][5][j][1] == vlan_options[f[0].value]
				&& ports_security[i][5][j][0] == f[1].value){
				ferror.set(f[0], errmsg.exist_mac2, quiet);
				ferror.set(f[1], errmsg.exist_mac2, true);
				return 0;	
			}			
		}
	}
	ferror.clear(f[0], errmsg.exist_mac2, quiet);
	ferror.clear(f[1], errmsg.exist_mac2, true);



	//generate_cmd();
	return 1;
}

mac_list.onClick = function(cell) {}

mac_list.resetNewEditor = function()
{
	var f = fields.getAll(this.newEditor);
	f[0].selected = 0;

	f[1].value = '0000.0000.0001';
			
	ferror.clearAll(fields.getAll(this.newEditor));
}

mac_list.setup = function(){
	var tmp_vlan = -1;
	this.init('mac_list_grid', 
		'sort', 
		80, 
		[{ type: 'select', options: now_vlan_options}, { type: 'text'}]);
	this.headerSet([ui.vlan_id, security.mac]);


	for (var i = 0; i < ports_security[port_index][5].length; ++i) {
		tmp_vlan = getVlanOptionId(ports_security[port_index][5][i][1]);

		if (tmp_vlan >= 0)
			this.insertData(-1, [tmp_vlan, ports_security[port_index][5][i][0]]);
	}

	mac_list.showNewEditor();
	mac_list.resetNewEditor();
}

function displayConfig()
{
	PR(E('_max_mac')).style.display = '';

	if (ports_security[port_index][3]){
		E('_max_mac').value = ports_security[port_index][4];
	}else{
		E('_max_mac').value = 1;
	}	

	E('mac_list_grid').style.display = '';
	(E('note_help1')).style.display = '';
	(E('note_help2')).style.display = '';
}

function noneDisplayConfig()
{
	PR(E('_max_mac')).style.display = 'none';
	E('_max_mac').value = 1;

	E('mac_list_grid').style.display = 'none';
	(E('note_help1')).style.display = 'none';
	(E('note_help2')).style.display = 'none';
}

function verifyFields(focused, quiet){

	if (v_f_number(E('_max_mac'), quiet, false, 1, 100) == 0)
		return 0;

	if (E('_security_enable').checked == true
		&& last_enable_status == 0){
		displayConfig();
		last_enable_status = 1;
	}else if (E('_security_enable').checked == false
		&& last_enable_status == 1){
		noneDisplayConfig();
		last_enable_status = 0;
	}

	if (E('_security_enable').checked == true){
		var newEditorField = fields.getAll(mac_list.newEditor);
		if (mac_list.getDataCount() >= E('_max_mac').value){
			E('add_new_row_button').disabled = true;
			newEditorField[0].disabled = true;
			newEditorField[1].disabled = true;
		}else{
			E('add_new_row_button').disabled = false;
			newEditorField[0].disabled = false;
			newEditorField[1].disabled = false;
		}
	}
	
	generate_cmd();

	if (user_info.priv < admin_priv) {
		elem.display('save-button', false);
	}else{
		elem.display('save-button', true);
	}
		
	return 1;
}



function generate_cmd()
{
	var cmd = "";
	var all_data = mac_list.getAllData();
	var mac_found = 0;
	var view_flag = 0;


	if (E('_security_enable').checked != ports_security[port_index][3]){
		if (view_flag == 0){
			cmd += "!\ninterface " + port_cmd_list[port_index] +"\n";
			view_flag = 1;
		}  
		
		cmd += ((E('_security_enable').checked)?(""):("no ")) + "port-security\n";
	}

	if (E('_security_enable').checked == false){
		E('save-button').disabled = (cmd == "");
		return cmd;
	}

	

	if (E('_max_mac').value != ports_security[port_index][4]){
		if (view_flag == 0){
			cmd += "!\ninterface " + port_cmd_list[port_index] +"\n";
			view_flag = 1;
		}  

		if (E('_max_mac').value == "")
			cmd += "no port-security maximum" + "\n";
		else
			cmd += "port-security maximum " + E('_max_mac').value +"\n";
    }

    //del mac
    //must do del action before add
	for (var j = 0; j < ports_security[port_index][5].length; j++){
		mac_found= 0;
		for (var i = 0; i < all_data.length; i++){
			if (ports_security[port_index][5][j][0] == all_data[i][1]
				&& ports_security[port_index][5][j][1] ==vlan_options[ all_data[i][0]][1]){
				mac_found = 1;
				break;
			}
		}

		if (!mac_found){
			if (view_flag == 0){
				cmd += "!\ninterface " + port_cmd_list[port_index] +"\n";
				view_flag = 1;
			} 
			cmd += "no port-security mac-address "+ports_security[port_index][5][j][0]+" vlan " + ports_security[port_index][5][j][1] +"\n";
            

        }
    }

	//add mac
	for (var i = 0; i < all_data.length; i++){
		mac_found= 0;
		for (var j = 0; j < ports_security[port_index][5].length; j++){
			if (ports_security[port_index][5][j][0] == all_data[i][1]
				&& ports_security[port_index][5][j][1] == vlan_options[ all_data[i][0]][1]){
				mac_found = 1;
				break;
			}
		}

		if (!mac_found){
			if (view_flag == 0){
				cmd += "!\ninterface " + port_cmd_list[port_index] +"\n";
				view_flag = 1;
			} 

			cmd += "port-security mac-address " + all_data[i][1]+((all_data[i][0] == "")?(""):(" vlan " + vlan_options[ all_data[i][0]][1])) +"\n";
		}
	}
	
    

	E('save-button').disabled = (cmd == "");

	return cmd;
}

function save()
{
	if (!verifyFields(null, false)) return;	

	E('_fom')._web_cmd.value = generate_cmd();
	
	if (cookie.get('debugcmd') == 1)
		alert(E('_fom')._web_cmd.value);
	
	if((E('_fom')._web_cmd.value != '')&&(cookie.get('autosave') == 1)){
		E('_fom')._web_cmd.value += "!"+"\n"+"copy running-config startup-config"+"\n";	
	}else{
		E('_fom')._web_cmd.value += "!"+"\n";
	}

	form.submit('_fom', 1);
	
	E('save-button').disabled = true;
}

function back()
{
	document.location = 'setup-port-security.jsp';	
}
function earlyInit()
{
	verifyFields(null,1);
	if (E('_security_enable').checked == true){
		displayConfig();
	}else if (E('_security_enable').checked == false){
		noneDisplayConfig();
	}
}

function init()
{

}
</script>
</head>
<body onload='init()'>
<form id='_fom' method='post' action='apply.cgi'>
<input type='hidden' name='_web_cmd' value=''>


<div class='section-title'><script type='text/javascript'>
	GetText(port_title[port_index]);
</script></div>

<div class='section'>
<script type='text/javascript'>
createFieldTable('', [
	{ title: security.enable, name: 'security_enable', type: 'checkbox', value: ports_security[port_index][3]},
	{ title: security.max_mac, name: 'max_mac', type: 'text', value:((ports_security[port_index][3])?(ports_security[port_index][4]):(1)) }
]);
//W("<td >" + security.mac_list + "</td>");
</script>


<table class='web-grid' cellspacing=1 id='mac_list_grid'></table>
<script type='text/javascript'>mac_list.setup();</script>
</div>

<div id='note_help1'><script type='text/javascript'>GetText(ui.note);</script></div>
<div id='note_help2'><script type='text/javascript'>GetText(ui.mac_style_help);</script></div>

</form>

<script type='text/javascript'>
init();
if(cookie.get('autosave') == 1)
	ui.aply=ui.aply_save;
genStdFooterWithBack("");
</script>

<script type='text/javascript'>earlyInit();</script>
</body>
</html>
