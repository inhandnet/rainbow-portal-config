<% pagehead(menu.setup_track) %>

<style type='text/css'>
#track-grid {
	text-align: center;	
	width: 600px;
}

#track-grid .co1 {
	width: 40px;
}
#track-grid .co2 {
	width: 100px;
}
#track-grid .co3 {
	width: 100px;
}
</style>

<script type='text/javascript'>

<% ih_sysinfo(); %>
<% ih_user_info(); %>

<% web_exec('show running-config track'); %>

//track_config = [['1','2','1','cellular 1','0','0']];

//define option list
var type_list = [['1','interface'], ['2','sla']];
var str_type = ['', 'interface', 'sla'];

<% web_exec('show interface')%>

//define option list
var blank_interface = [['']];
//var vifs = [].concat(blank_interface, cellular_interface, eth_interface, sub_eth_interface,svi_interface, xdsl_interface, gre_interface, vp_interface,openvpn_interface);
var vifs = [].concat(blank_interface, cellular_interface, eth_interface, sub_eth_interface, svi_interface, xdsl_interface, gre_interface, vp_interface,openvpn_interface);
var now_vifs_options = new Array();
now_vifs_options = grid_list_all_vif_opts(vifs);

//define a web grid
var trackobjects = new webGrid();

trackobjects.exist = function(f, v)
{
	var data = this.getAllData();
	for (var i = 0; i < data.length; ++i) {
		if (data[i][f] == v) return true;
	}
	return false;
}

trackobjects.existName = function(name)
{
	return this.exist(0, name);
}

trackobjects.verifyFields = function(row, quiet) {
	var f = fields.getAll(row);
	
	ferror.clearAll(f);
	
	if(f[1].value=='1') {		
		f[2].value = '';
		f[2].disabled = true;	
		if (f[3].value == '')
			f[3].value = now_vifs_options[1][0];			
		f[3].disabled = false;	
	} else {
		if (f[2].value == '')
			f[2].value = '1';
		f[2].disabled = false;
		f[3].value = now_vifs_options[0][0];
		f[3].disabled = true;	
	}
	//index
	if(!v_info_num_range(f[0], quiet, false, 1, 10)) {
		return 0;	
	}
	if (this.existName(f[0].value)) {
		ferror.set(f[0], errmsg.bad_name4, quiet);
		return 0;
	}
	//sla id
	if(f[1].value=='2' && !v_info_num_range(f[2], quiet, false, 1, 10)) {
		return 0;	
	}
	//negative delay
	if(!v_info_num_range(f[4], quiet, false, 0, 180)) {
		return 0;	
	}
	//positive delay
	if(!v_info_num_range(f[5], quiet, false, 0, 180)) {
		return 0;	
	}
	return 1;
}

trackobjects.dataToView = function(data) {
	return [data[0],
	       str_type[data[1]],
	       data[2],
	       data[3],
	       data[4],
	       data[5]];
}

trackobjects.fieldValuesToData = function(row) {
	var f = fields.getAll(row);
	return [f[0].value, f[1].value, f[2].value, f[3].value, 
	       f[4].value, f[5].value];
}

trackobjects.onDataChanged = function() 
{
	verifyFields(null, 1);
}

trackobjects.resetNewEditor = function() {
	var f = fields.getAll(this.newEditor);

	ferror.clearAll(f);

	//init value
	f[0].value = this.getAllData().length + 1;
	f[1].value = '2';
	f[2].value = '1';
	f[3].disabled = true;
	f[4].value = '0';
	f[5].value = '0';
}

trackobjects.setup = function() {
	this.init('track-grid', 'move', 10, [
		{ type: 'text', maxlen: 8 },
		{ type: 'select', options: type_list },
		{ type:'text', maxlen:8 },
		{ type: 'select', options: now_vifs_options },
		{ type:'text', maxlen:8 },
		{ type:'text', maxlen:8 }]);
	
	this.headerSet([track.id, track.type, track.sla_id, ui.iface, track.neg_delay+'('+ui.seconds+')', track.pos_delay+'('+ui.seconds+')']);

	for (var i = 0; i < track_config.length; i++) {
		if(track_config[i][2]=='0') track_config[i][2] = '';
		this.insertData(-1, [track_config[i][0], track_config[i][1],
					track_config[i][2], track_config[i][3],
					track_config[i][4], track_config[i][5]
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
	var data = trackobjects.getAllData();
	// delete
	for(var i = 0; i < track_config.length; i++) {
		var found = 0;
		for(var j = 0; j < data.length; j++) {
			if(data[j][0]==track_config[i][0]) {	//index
				found = 1;
				break;
			}
		}
		if(!found) {
			cmd += "no track " + track_config[i][0] + "\n";
		}
	}

	// add or change
	for(var i = 0; i < data.length; i++) {
		var found = 0;
		var changed = 0;
		for(var j = 0; j < track_config.length; j++) {
			if(data[i][0]==track_config[j][0]) {	//index
				found = 1;
				if(data[i][1]=='1') {
					if(data[i][1] != track_config[j][1]
						|| data[i][3] != track_config[j][3]
						|| data[i][4] != track_config[j][4]
						|| data[i][5] != track_config[j][5]) {
						changed = 1;
					}
				} else {
					if(data[i][1] != track_config[j][1]
						|| data[i][2] != track_config[j][2]
						|| data[i][4] != track_config[j][4]
						|| data[i][5] != track_config[j][5]) {
						changed = 1;
					}
				}
				break;
			}
		}
		if(!found || changed) {
			cmd += "track " + data[i][0];
			if(data[i][1]=='2')
				cmd += " sla " + data[i][2];
			else
				cmd += " interface " + data[i][3];
    			cmd += " delay negative " + data[i][4];
    			cmd += " positive " + data[i][5] + "\n";
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
	if (trackobjects.isEditing()) return;

	var fom = E('_fom');

	if((E('_fom')._web_cmd.value != '')&&(cookie.get('autosave') == 1)){
		E('_fom')._web_cmd.value += "!"+"\n"+"copy running-config startup-config"+"\n";	
	}

	form.submit(fom, 1);
}

function earlyInit()
{
	trackobjects.setup();
	verifyFields(null, 1);
}

function init()
{
	if((cookie.get('autosave')) == null){
		cookie.set('autosave', 1);
	}
	trackobjects.recolor();
}
</script>
</head>

<body onload='init()'>
<form id='_fom' method='post' action='apply.cgi'>
<input type='hidden' name='_web_cmd' value=''>

<div class='section-title'>
<script type='text/javascript'>
	GetText(track.object);
</script>
</div>
<div class='section'>
	<table class='web-grid' id='track-grid'></table>
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

