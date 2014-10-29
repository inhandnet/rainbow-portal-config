<% pagehead(menu.setup_mroute_igmp) %>

<style type='text/css'>
#igmpdownstream-grid {
	text-align: center;	
	width: 500px;
}
</style>

<script type='text/javascript'>

<% ih_sysinfo(); %>
<% ih_user_info(); %>

<% web_exec('show running-config mroute'); %>

/*
igmpproxy_config = {
	upstream: 'fastethernet 0/2',
	downstream:[['fastethernet 0/1','fastethernet 0/2']]
};
*/

<% web_exec('show interface')%>

null_interface = [['']];
//define option list
var vifs = [].concat(null_interface, cellular_interface, eth_interface, sub_eth_interface, svi_interface,xdsl_interface, gre_interface);
var upstream_vifs_options = new Array();
upstream_vifs_options = grid_list_all_vif_opts(vifs);

vifs = [].concat(cellular_interface, eth_interface, sub_eth_interface,svi_interface, xdsl_interface, gre_interface);
var now_vifs_options = new Array();
now_vifs_options = grid_list_all_vif_opts(vifs);

//define a web grid
var igmpdownstreams = new webGrid();

igmpdownstreams.exist = function(f, v)
{
	var data = this.getAllData();
	for (var i = 0; i < data.length; ++i) {
		if (data[i][f] == v) return true;
	}
	return false;
}

igmpdownstreams.existName = function(name)
{
	return this.exist(0, name);
}

igmpdownstreams.verifyFields = function(row, quiet) {
	if (quiet) return 1;

	var f = fields.getAll(row);
	
	ferror.clearAll(f);
	if(f[0].value==f[1].value) {
		ferror.set(f[0], '', quiet);		
		return 0;
	}
	if (this.existName(f[0].value)) {
		ferror.set(f[0], errmsg.bad_name4, quiet);
		return 0;
	}
	
	return 1;
}

igmpdownstreams.dataToView = function(data) {
	return [data[0],
	       data[1]];
}

igmpdownstreams.fieldValuesToData = function(row) {
	var f = fields.getAll(row);
	return [f[0].value, f[1].value]; 
}

igmpdownstreams.onDataChanged = function() 
{
	verifyFields(null, 1);
}

igmpdownstreams.resetNewEditor = function() {
	var f = fields.getAll(this.newEditor);

	ferror.clearAll(f);

	//init value
	if(igmpproxy_config.upstream!='') {
		f[1].value = igmpproxy_config.upstream;
	}
}

igmpdownstreams.setup = function() {
	this.init('igmpdownstream-grid', 'move', 10, [
		{ type: 'select', options: now_vifs_options },
		{ type: 'select', options: now_vifs_options }]);
	
	this.headerSet([mroute.downstream, mroute.upstream]);

	var downstream = igmpproxy_config.downstream;
	for (var i = 0; i < downstream.length; i++) {
		this.insertData(-1, [downstream[i][0], downstream[i][1]
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

	// --- visibility ---	

	// --- generate cmd ---
	if(E('_igmpproxy_upstream').value!=igmpproxy_config.upstream) {
		if(E('_igmpproxy_upstream').value) {
			cmd += "interface " + E('_igmpproxy_upstream').value + "\n";
			cmd += "ip igmp proxy-service\n";
			cmd += "!\n";
		} else {
			cmd += "interface " + igmpproxy_config.upstream + "\n";
			cmd += "no ip igmp proxy-service\n";
			cmd += "!\n";
		}
	}

	var downstream = igmpproxy_config.downstream;
	var data = igmpdownstreams.getAllData();
	// delete
	for(var i = 0; i < downstream.length; i++) {
		var found = 0;
		for(var j = 0; j < data.length; j++) {
			if(data[j][0]==downstream[i][0]) {//downstream interface 
				found = 1;
				break;
			}
		}
		if(!found) {
			cmd += "interface " + downstream[i][0] + "\n";
			cmd += "no ip igmp mroute-proxy " + downstream[i][1] + "\n";
			cmd += "!\n";
		}
	}

	// add or change
	for(var i = 0; i < data.length; i++) {
		var found = 0;
		var changed = 0;
		for(var j = 0; j < downstream.length; j++) {
			if(data[i][0]==downstream[j][0]) {//downstream interface 
				found = 1;
				if(data[i][1] != downstream[j][1]) {
					changed = 1;
				}
				break;
			}
		}
		if(!found || changed) {
			cmd += "interface " + data[i][0] + "\n";
			cmd += "ip igmp mroute-proxy " + data[i][1] + "\n";
			cmd += "!\n";
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
	if (igmpdownstreams.isEditing()) return;

	var fom = E('_fom');

	if((E('_fom')._web_cmd.value != '')&&(cookie.get('autosave') == 1)){
		E('_fom')._web_cmd.value += "!"+"\n"+"copy running-config startup-config"+"\n";	
	}

	form.submit(fom, 1);
}

function earlyInit()
{
	igmpdownstreams.setup();
	verifyFields(null, 1);
}

function init()
{
	if((cookie.get('autosave')) == null){
		cookie.set('autosave', 1);
	}
	igmpdownstreams.recolor();
}
</script>
</head>

<body onload='init()'>
<form id='_fom' method='post' action='apply.cgi'>
<input type='hidden' name='_web_cmd' value=''>

<div class='section-title'>
<script type='text/javascript'>
	GetText(mroute.upstream);
</script>
</div>

<div class='section'>
<script type='text/javascript'>

createFieldTable('', [
	{ title: mroute.upstream, name: 'igmpproxy_upstream', type: 'select', options: upstream_vifs_options, value: igmpproxy_config.upstream }	
]);
</script>
</div>

<div class='section-title'>
<script type='text/javascript'>
	GetText(mroute.downstream_list);
</script>
</div>
<div class='section'>
	<table class='web-grid' id='igmpdownstream-grid'></table>
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

