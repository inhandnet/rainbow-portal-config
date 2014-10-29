<% pagehead(menu.setup_wlan_ip) %>

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
<% web_exec('show running-config dot11') %>
/*
wlan0_config = {
	'l3_config':['192.168.1.1','255.255.255.0',['192.168.3.1','255.255.255.0','192.168.4.1','255.255.255.0']]
};
*/

var multi_ip = wlan0_config.l3_config[2];

function verifyFields(focused, quiet)
{
	var cmd = "";
	var fom = E('_fom');
	var view_flag = 0;
	var founded = 0;
	var mip_data = mip.getAllData();	
	
	E('save-button').disabled = true;

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
				cmd += "!\ninterface  dot11radio 1\n";
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

	
	if (E('_f_ip').value.length==0){
		E('mip-grid').style.display = 'none';
		E('mip-title').style.display = 'none';
	}else{
		E('mip-grid').style.display = '';
		E('mip-title').style.display = '';
	}
	
	if ((E('_f_ip').value != wlan0_config.l3_config[0])
		|| (E('_f_mask').value != wlan0_config.l3_config[1])){
		if (!view_flag){
			cmd += "!\ninterface dot11radio 1\n";
			view_flag = 1;
		}
		if (E('_f_ip').value.length==0)
			cmd += "no ip address "+this_wlan_config[2]+" "+this_wlan_config[3]+"\n";
		else
			cmd += "ip address " + E('_f_ip').value + " " + E('_f_mask').value + "\n";
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
				cmd += "!\ninterface dot11radio 1\n";
				view_flag = 1;
			}		
			cmd += "ip address "+ mip_data[j][0]+" "+ mip_data[j][1] +" "+"secondary\n";
		}		

	}
	
	if (user_info.priv < admin_priv) {
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
	E('save-button').disabled = true;
}
</script>
</head>
<body>
<form id='_fom' method='post' action='apply.cgi'>
<input type='hidden' name='_web_cmd' value=''>


<div class='section'>
<script type='text/javascript'>

createFieldTable('', [
	{ title: ui.primary_ip, name: 'f_ip', type: 'text', maxlen: 16, size: 15, value: wlan0_config.l3_config[0] },
	{ title: ui.netmask, name: 'f_mask', type: 'text', maxlen: 16, size: 15, value: wlan0_config.l3_config[1] }
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

