<% pagehead(menu.eth1) %>

<style type='text/css'>
#mip-grid  {
	width: 600px;
}
#mip-grid .co1 {
	width: 300px;
}
#mip-grid .co2 {
	width: 300px;
}
</style>
<script type='text/javascript'>

<% ih_sysinfo() %>
<% ih_user_info() %>
<% web_exec('show running-config fastethernet') %>
<% web_exec('show bridge') %>

var operator_priv = 12;

var this_eth = 'fastethernet 0/2';
var this_eth_config = [];
var multi_ip = [];
for (var i = 0; i < eth_config.length; i++){
	if (eth_config[i][0] == this_eth){
		this_eth_config = eth_config[i];
		multi_ip = this_eth_config[4];
		break;
	}
}

var speed_duplex_options = [[0, ui.autoneg],[1, ui.full100], [2,ui.half100], [3, ui.full10], [4,ui.half10]];
var speed_cmd = ["auto", "100", "100", "10", "10"];
var duplex_cmd = ["auto", "full", "half", "full", "half"];
var speed_duplex_idx;

if (this_eth_config[6] == 3) {
	speed_duplex_idx = 0;
} else if(this_eth_config[6] == 0 && this_eth_config[7] == 0) {
	speed_duplex_idx = 4;
} else if(this_eth_config[6] == 0 && this_eth_config[7] == 1) {
	speed_duplex_idx = 3;
} else if(this_eth_config[6] == 1 && this_eth_config[7] == 0) {
	speed_duplex_idx = 2;
} else if(this_eth_config[6] == 1 && this_eth_config[7] == 1) {
	speed_duplex_idx = 1;
}

function verifyFields(focused, quiet)
{
	var cmd = "";
	var fom = E('_fom');
	var view_flag = 0;
	var founded = 0;
	var mip_data = mip.getAllData();	
	
	E('save-button').disabled = true;

	for (i = 0; i < bridge_config.length; i++) {
		if (bridge_config[i][3] == 'fastethernet 0/2') {
			E('_f_ip').disabled = true;
			E('_f_mask').disabled = true;
			return 1;
		}
	}

	//delete multi IP
	for (var i = 0; i < multi_ip.length/2; i++) {
		founded = 0;
		for (var j = 0; j < mip_data.length; j++){
			if ((mip_data[j][0] == multi_ip[(2*i)+0])
				&& (mip_data[j][1] == multi_ip[(2*i)+1])){
				founded = 1;
				break;
			}
		}
		if (!founded){
			if (!view_flag){
				cmd += "!\ninterface "+this_eth_config[0]+"\n";
				view_flag = 1;
			}		
			cmd += "no ip address "+multi_ip[(2*i)+0]+" "+multi_ip[(2*i)+1]+" "+"secondary\n";
		}
	}
	
	if (!v_info_host_ip('_f_ip', quiet, true)) return 0;
	if (E('_f_ip').value.length!=0 && E('_f_mask').value.length==0 ) 
		E('_f_mask').value = '255.255.255.0';
	if (!v_info_netmask('_f_mask', quiet, true)) return 0;
	if (E('_f_ip').value.length!=0 && E('_f_mask').value.length!=0 )
		if (!v_info_ip_netmask('_f_ip', '_f_mask', quiet)) return 0;

	if ((E('_f_ip').value.length==0) && (mip_data.length != 0)){
		ferror.set(E('_f_ip'), errmsg.badMip, quiet);
		return 0;
	}else{
		ferror.clear(E('_f_ip'));
	}

	if (!v_info_num_range(E('_f_mtu'), quiet, true, 68, 1500)) return 0;

	if (!v_info_description('_f_desc', quiet, true)) return 0;
	
	if (E('_f_ip').value.length==0){
		E('mip-grid').style.display = 'none';
		E('mip-title').style.display = 'none';
	}else{
		E('mip-grid').style.display = '';
		E('mip-title').style.display = '';
	}
	
	if ((E('_f_ip').value != this_eth_config[2])
		|| (E('_f_mask').value != this_eth_config[3])){
		if (!view_flag){
			cmd += "!\ninterface "+this_eth_config[0]+"\n";
			view_flag = 1;
		}
		if (E('_f_ip').value.length==0)
			cmd += "no ip address "+this_eth_config[2]+" "+this_eth_config[3]+"\n";
		else
			cmd += "ip address " + E('_f_ip').value + " " + E('_f_mask').value + "\n";
	}

	if (E('_f_mtu').value != this_eth_config[8]) {
		if (!view_flag){
			cmd += "!\ninterface "+this_eth_config[0]+"\n";
			view_flag = 1;
		}
		if (E('_f_mtu').value.length == 0)
			cmd += "no ip mtu\n";
		else
			cmd += "ip mtu "+E('_f_mtu').value+"\n";		
	}
	
	if (speed_cmd[E('_f_speed_duplex').value] != speed_cmd[speed_duplex_idx]) {
		if (!view_flag){
			cmd += "!\ninterface "+this_eth_config[0]+"\n";
			view_flag = 1;
		}	
		cmd += "speed " + speed_cmd[E('_f_speed_duplex').value] + "\n";
	}
	
	if (duplex_cmd[E('_f_speed_duplex').value] != duplex_cmd[speed_duplex_idx]) {
		if (!view_flag){
			cmd += "!\ninterface "+this_eth_config[0]+"\n";
			view_flag = 1;
		}	
		cmd += "duplex " + duplex_cmd[E('_f_speed_duplex').value] + "\n";
	}	

	if (E('_f_track').checked != this_eth_config[5]){
		if (!view_flag){
			cmd += "!\ninterface "+this_eth_config[0]+"\n";
			view_flag = 1;
		}
		cmd += (E('_f_track').checked?"":"no ")+"track l2-state\n";
	}

	if (E('_f_desc').value != this_eth_config[1]){
		if (!view_flag){
			cmd += "!\ninterface "+this_eth_config[0]+"\n";
			view_flag = 1;
		}		
		if (E('_f_desc').value.length==0)			
			cmd += "no description\n";
		else
			cmd += "description "+ E('_f_desc').value +"\n";
	}

	//add multi IP
	for (var j = 0; j < mip_data.length; j++){
		founded = 0;
		for (var i = 0; i < multi_ip.length/2; i++){
			if ((mip_data[j][0] == multi_ip[(2*i)+0])
				&& (mip_data[j][1] == multi_ip[(2*i)+1])){
				founded = 1;
				break;
			}
		}
		if (!founded){
			if (!view_flag){
				cmd += "!\ninterface "+this_eth_config[0]+"\n";
				view_flag = 1;
			}		
			cmd += "ip address "+ mip_data[j][0]+" "+ mip_data[j][1] +" "+"secondary\n";
		}		

	}
	
	if (user_info.priv < operator_priv) {
		elem.display('save-button', 'cancel-button', false);
	}else{
		elem.display('save-button', 'cancel-button', true);
		fom._web_cmd.value = cmd;
		E('save-button').disabled = (cmd=="");	
	}
	//alert(fom._web_cmd.value);
	return 1;
}

var mip = new webGrid();
mip.verifyFields = function(row, quiet) {
	var f = fields.getAll(row);

	
	if (!v_info_host_ip(f[0], quiet, false)) return 0;
	if (f[0].value.length!=0 && f[1].value.length==0)
		f[1].value = '255.255.255.0';
	if (!v_info_netmask(f[1], quiet, false)) return 0;
	if (!v_info_ip_netmask(f[0], f[1], quiet)) return 0;
	return 1;
}

mip.setup = function() {
	this.init('mip-grid', '', 10, [
		{ type: 'text', maxlen: 15 }, 
		{ type: 'text', maxlen: 15 }]);
	this.headerSet([ui.secondary_ip, ui.netmask]);
	
	for (var i = 0; i < multi_ip.length/2; ++i) {
			this.insertData(-1, [multi_ip[(2*i)+0], multi_ip[(2*i)+1]]);
	}
	this.showNewEditor();
	this.resetNewEditor();
}

mip.onDataChanged = function()
{
	verifyFields(null, 1);
}

function save()
{
	if (!verifyFields(null, false)) return;

	var fom = E('_fom');

	if((E('_fom')._web_cmd.value != '')&&(cookie.get('autosave') == 1)){
		E('_fom')._web_cmd.value += "!"+"\n"+"copy running-config startup-config"+"\n";	
	}


	form.submit(fom, 1);
}

function earlyInit()
{
	mip.setup();
	verifyFields(null, true);
}
</script>
</head>
<body>
<form id='_fom' method='post' action='apply.cgi'>
<input type='hidden' name='_web_cmd' value=''>


<div class='section'>
<script type='text/javascript'>

createFieldTable('', [
	//{ title: menu.eth2},
	//{ title: ui.enable, name: 'f_enable', type: 'checkbox', value: 1},
	{ title: ui.primary_ip, name: 'f_ip', type: 'text', maxlen: 16, size: 15, value: this_eth_config[2] },
	{ title: ui.netmask, name: 'f_mask', type: 'text', maxlen: 16, size: 15, value: this_eth_config[3] },
	{ title: ui.mtu, name: 'f_mtu', type: 'text', maxlen: 4, size: 15, value: this_eth_config[8] },	
	{ title: port.speed+'/'+port.duplex, name: 'f_speed_duplex', type: 'select', options:speed_duplex_options, value: speed_duplex_idx},
	{ title: ui.tak_l2, name: 'f_track', type: 'checkbox', value: this_eth_config[5]},
	{ title: ui.desc, name: 'f_desc', type: 'text', maxlen: 127, size: 32, value: this_eth_config[1] },

]);
</script>
</div>
<div id='mip-title' class='section-title'>
<script type='text/javascript'>
	GetText(ui.mip);
</script>
</div>
<div class='section'>
	<table class='web-grid' id='mip-grid'></table>	
</div>
</form>
<script type='text/javascript'>
if(cookie.get('autosave') == 1)
	ui.aply=ui.aply_save;
genStdFooter("");
</script>
<script type='text/javascript'>earlyInit()</script>
</body>
</html>

