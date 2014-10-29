<% pagehead(menu.setup_mroute_basic) %>

<style type='text/css'>
#mroutetab-grid {
	text-align: center;	
	width: 500px;
}

#mroutetab-grid .co1 {
	width: 120px;
}
#mroutetab-grid .co2 {
	width: 120px;
}
</style>

<script type='text/javascript'>

<% ih_sysinfo(); %>
<% ih_user_info(); %>

<% web_exec('show running-config mroute'); %>

/*
mroute_basic_config = {
        enable: '1',
        mcast_route:[['192.168.3.0','255.255.255.0','fastethernet 0/1']]
};
*/

<% web_exec('show interface')%>

//define option list
var vifs = [].concat(cellular_interface, eth_interface, sub_eth_interface,svi_interface, xdsl_interface, gre_interface);
var now_vifs_options = new Array();
now_vifs_options = grid_list_all_vif_opts(vifs);

//define a web grid
var mroutetabs = new webGrid();

mroutetabs.exist = function(f, v)
{
	var data = this.getAllData();
	for (var i = 0; i < data.length; ++i) {
		if (data[i][f] == v) return true;
	}
	return false;
}

mroutetabs.existName = function(name)
{
	return this.exist(0, name);
}

mroutetabs.verifyFields = function(row, quiet) {
	var f = fields.getAll(row);

	ferror.clearAll(f);
	//ip
	if(!v_info_ip(f[0], quiet, false)) {
		return 0;
	}
	return 1;
}

mroutetabs.dataToView = function(data) {
	return [data[0],
	       data[1],
	       data[2]];
}

mroutetabs.fieldValuesToData = function(row) {
	var f = fields.getAll(row);
	return [f[0].value, f[1].value, f[2].value]; 
}

mroutetabs.onDataChanged = function() 
{
	verifyFields(null, 1);
}

mroutetabs.resetNewEditor = function() {
	var f = fields.getAll(this.newEditor);

	ferror.clearAll(f);

	//init value
	f[0].value = '';
	f[1].value = '255.255.255.0';
}

mroutetabs.setup = function() {
	this.init('mroutetab-grid', 'move', 10, [
		{ type: 'text', maxlen: 15 },
		{ type:'text', maxlen:15 },
		{ type: 'select', options: now_vifs_options }]);
	
	this.headerSet([ui.src, ui.netmask, ui.iface]);

	var mcast_route = mroute_basic_config.mcast_route;	
	for (var i = 0; i < mcast_route.length; i++) {
		this.insertData(-1, [mcast_route[i][0], mcast_route[i][1],
					mcast_route[i][2]
					]);
	}
	
	this.showNewEditor();
	this.resetNewEditor();
	
}

function verifyFields(focused, quiet)
{
	var ok = 1;
	var cmd = "";
	var fom = E('_fom');

	E('save-button').disabled = true;

	var mcast_route = mroute_basic_config.mcast_route;	
	var enable = E('_f_mroute_enable').checked;
	
	// --- visibility ---	

	// --- generate cmd ---
	if(mroute_basic_config.enable!=enable) {
		if(enable) {
			cmd += "ip multicast-routing\n";
		} else {
			cmd += "no ip multicast-routing\n";
		}
	}

	var data = mroutetabs.getAllData();
	// delete
	for(var i = 0; i < mcast_route.length; i++) {
		var found = 0;
		for(var j = 0; j < data.length; j++) {
			if(data[j][0]==mcast_route[i][0] 
			    &&data[j][1]==mcast_route[i][1]) {//src & net
				found = 1;
				break;
			}
		}
		if(!found) {
			cmd += "no ip mroute " + mcast_route[i][0] + " " + mcast_route[i][1] + "\n";
		}
	}

	// add or change
	for(var i = 0; i < data.length; i++) {
		var found = 0;
		var changed = 0;
		for(var j = 0; j < mcast_route.length; j++) {
			if(data[i][0]==mcast_route[j][0] 
			    &&data[i][1]==mcast_route[j][1]) {//src & net
				found = 1;
				if(data[i][2] != mcast_route[j][2]) {
					changed = 1;
				}
				break;
			}
		}
		if(!found || changed) {
			cmd += "ip mroute " + data[i][0] + " " + data[i][1] + " " + data[i][2] + "\n";
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
	
	return ok;
}

function save()
{
	if (mroutetabs.isEditing()) return;

	var fom = E('_fom');

	if((E('_fom')._web_cmd.value != '')&&(cookie.get('autosave') == 1)){
		E('_fom')._web_cmd.value += "!"+"\n"+"copy running-config startup-config"+"\n";	
	}

	form.submit(fom, 1);
}

function earlyInit()
{
	mroutetabs.setup();
	verifyFields(null, 1);
}

function init()
{
	if((cookie.get('autosave')) == null){
		cookie.set('autosave', 1);
	}
	mroutetabs.recolor();
}
</script>
</head>

<body onload='init()'>
<form id='_fom' method='post' action='apply.cgi'>
<input type='hidden' name='_web_cmd' value=''>

<div class='section'>
<script type='text/javascript'>

createFieldTable('', [
	{ title: ui.enable, name: 'f_mroute_enable', type: 'checkbox', value: mroute_basic_config.enable=='1'}
]);
</script>
</div>

<div class='section-title'>
<script type='text/javascript'>
	GetText(mroute.static);
</script>
</div>
<div class='section'>
	<table class='web-grid' id='mroutetab-grid'></table>
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

