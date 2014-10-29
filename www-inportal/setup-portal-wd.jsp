<% pagehead(menu.setup_portal_nc) %>

<style type='text/css'>
#mac-grid  {
        width: 400px;
}
#mac-grid .co1 {
        width: 50px;
}
#mac-grid .co2 {
        width: 350px;
}
#allow-grid  {
        width: 400px;
}
#allow-grid .co1 {
        width: 50px;
}
#allow-grid .co2 {
        width: 350px;
}
#knownblack-grid  {
        width: 400px;
}
#knownblack-grid .co1 {
        width: 50px;
}
#knownblack-grid .co2 {
        width: 350px;
}
#knownwhite-grid  {
        width: 400px;
}
#knownwhite-grid .co1 {
        width: 50px;
}
#knownwhite-grid .co2 {
        width: 350px;
}
</style>

<script type='text/javascript'>

<% ih_sysinfo() %>
<% ih_user_info() %>
<% web_exec('show running-config portal') %>

<% web_exec('show interface') %>
var vifs = [].concat(dot11radio_interface);
var now_vifs_options = new Array();
now_vifs_options = grid_list_all_vif_opts(vifs);

var wan_vifs = [].concat(cellular_interface, eth_interface, sub_eth_interface, svi_interface, xdsl_interface, gre_interface,openvpn_interface,vp_interface);
var wan_vifs_options = new Array();
wan_vifs_options = grid_list_all_vif_opts(wan_vifs);


var known_acl_options = [['deny', ui.hotspot_nc_white],['permit', ui.hotspot_nc_black]];

function display_disable_blacklist(e)
{	
	var x = e?"":"none";
	
	E('knownblack-grid').style.display = x;
	E('knownblack-title').style.display = x;
	E('knownblack-body').style.display = x;

	E('knownblack-grid').disabled = !e;
	E('knownblack-title').disabled = !e;
	E('knownblack-body').disabled = !e;
	return 1;
}

function display_disable_whitelist(e)
{	
	var x = e?"":"none";
	
	E('knownwhite-grid').style.display = x;
	E('knownwhite-title').style.display = x;
	E('knownwhite-body').style.display = x;

	E('knownwhite-grid').disabled = !e;
	E('knownwhite-title').disabled = !e;
	E('knownwhite-body').disabled = !e;
	return 1;
}

function verifyFields(focused, quiet)
{
	var cmd = "";
	var fom = E('_fom');
	var view_flag = 0;
	var founded = 0;

	var enable = E('_f_enable').checked;
	var gw_if =  E('_f_iface').value;
	var ext_if =  E('_f_wan').value;
	var homepage = E('_f_homepage').value;
 	var login_period = E('_f_login_timeout').value = E('_f_login_timeout').value.trim();                   
 	var allowed_data = allowed.getAllData(); 
	var trusted_mac_data = trusted_mac.getAllData(); 
	var known_policy = E('_f_known').value;
	var knownblack_data = knownblack.getAllData(); 
	var knownwhite_data = knownwhite.getAllData();
	
	E('save-button').disabled = true;

	if (known_policy == 'deny') {
		display_disable_blacklist(0);
		display_disable_whitelist(1);
	}else{
		display_disable_blacklist(1);
		display_disable_whitelist(0);
	}

	if (gw_if != portal_wd_config.wd_interface) {
		cmd += "portal interface "+ gw_if +"\n";
	}
	if (ext_if != portal_wd_config.wd_wan) {
		cmd += "portal external-interface "+ ext_if +"\n";
	}
	if (homepage != portal_wd_config.wd_homepage) {
		if (!v_info_url('_f_homepage', 0, 1))
			return 0;		

		if (homepage != "") 
			cmd += "portal homepage "+ homepage +"\n";
		else
			cmd += "no portal homepage \n";
	}

	if (!v_info_url('_f_authserver',quiet,1)) return 0;
	if (!v_info_num_range('_f_authport',quiet,0,1,65535)) return 0;
	if (E('_f_authserver').value != portal_wd_config.wd_authserver
		|| E('_f_authport').value != portal_wd_config.wd_authport) {
		if (E('_f_authserver').value.length == 0) 
			cmd += "no portal auth-server\n";
		else
			cmd += "portal auth-server "+E('_f_authserver').value+" port "+E('_f_authport').value+"\n";
	} 

	if (!v_info_num_range('_f_login_timeout',quiet,1,5,1440))
		return 0;
	if (E('_f_login_timeout').value != portal_wd_config.wd_login_period){
		if (E('_f_login_timeout').value.length > 0)
			cmd += "portal relogin-period "+ E('_f_login_timeout').value +"\n";
		else
			cmd += "no portal relogin-period\n";
	}

	/* deleted mac */
    for (var i = 0; i < portal_wd_config.wd_trusted_mac_list.length; ++i) {
		found = 0;
        	for (var j = 0; j < trusted_mac_data.length; ++j) {
			if (portal_wd_config.wd_trusted_mac_list[i]
				== trusted_mac_data[j][1]) {
				found = 1;
				break;
			}
		}
		if (!found) {
			cmd += "no portal trusted-mac "+ portal_wd_config.wd_trusted_mac_list[i] +"\n";
		}
	}
	/* added mac */
    for (var j = 0; j < trusted_mac_data.length; ++j) {
		found = 0;
        	for (var i = 0; i < portal_wd_config.wd_trusted_mac_list.length; ++i) {
			if (portal_wd_config.wd_trusted_mac_list[i]
				== trusted_mac_data[j][1]) {
				found = 1;
				break;
			}
		}
		if (!found) {
			cmd += "portal trusted-mac "+ trusted_mac_data[j][1] +"\n";
		}
		
	}

	/* deleted hosts */
    for (var i = 0; i < portal_wd_config.wd_allowed_web_list.length; ++i) {
		found = 0;
        	for (var j = 0; j < allowed_data.length; ++j) {
			if (portal_wd_config.wd_allowed_web_list[i]
				== allowed_data[j][1]) {
				found = 1;
				break;
			}
		}
		if (!found) {
			cmd += "no portal allowed-web-hosts "+ portal_wd_config.wd_allowed_web_list[i] +"\n";
		}
	}
	/* added hosts */
    for (var j = 0; j < allowed_data.length; ++j) {
		found = 0;
        	for (var i = 0; i < portal_wd_config.wd_allowed_web_list.length; ++i) {
			if (portal_wd_config.wd_allowed_web_list[i]
				== allowed_data[j][1]) {
				found = 1;
				break;
			}
		}
		if (!found) {
			cmd += "portal allowed-web-hosts "+ allowed_data[j][1] +"\n";
		}
		
	}

	/* deleted black hosts */
    for (var i = 0; i < portal_wd_config.wd_known_black_web_list.length; ++i) {
		found = 0;
        	for (var j = 0; j < knownblack_data.length; ++j) {
			if (portal_wd_config.wd_known_black_web_list[i]
				== knownblack_data[j][1]) {
				found = 1;
				break;
			}
		}
		if (!found) {
			cmd += "no portal known-users-acl deny "+ portal_wd_config.wd_known_black_web_list[i] +"\n";
		}
	}
	/* added black hosts */
    for (var j = 0; j < knownblack_data.length; ++j) {
		found = 0;
        	for (var i = 0; i < portal_wd_config.wd_known_black_web_list.length; ++i) {
			if (portal_wd_config.wd_known_black_web_list[i]
				== knownblack_data[j][1]) {
				found = 1;
				break;
			}
		}
		if (!found) {
			cmd += "portal known-users-acl deny "+ knownblack_data[j][1] +"\n";
		}
		
	}

	/* deleted white hosts */
    for (var i = 0; i < portal_wd_config.wd_known_white_web_list.length; ++i) {
		found = 0;
        	for (var j = 0; j < knownwhite_data.length; ++j) {
			if (portal_wd_config.wd_known_white_web_list[i]
				== knownwhite_data[j][1]) {
				found = 1;
				break;
			}
		}
		if (!found) {
			cmd += "no portal known-users-acl permit "+ portal_wd_config.wd_known_white_web_list[i] +"\n";
		}
	}
	/* added white hosts */
    for (var j = 0; j < knownwhite_data.length; ++j) {
		found = 0;
        	for (var i = 0; i < portal_wd_config.wd_known_white_web_list.length; ++i) {
			if (portal_wd_config.wd_known_white_web_list[i]
				== knownwhite_data[j][1]) {
				found = 1;
				break;
			}
		}
		if (!found) {
			cmd += "portal known-users-acl permit "+ knownwhite_data[j][1] +"\n";
		}
		
	}
	if (portal_wd_config.wd_known_policy != known_policy){
		cmd += "portal known-users-acl default-policy " + known_policy +"\n";
	}
	
	if (enable && (portal_wd_config.wd_enable == 0)) {
		cmd += "portal enable\n";
	} else if (!enable && (portal_wd_config.wd_enable == 1)) {
		cmd += "no portal enable\n";
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
///////////////////////////////////////////////////////////////////////////
var trusted_mac = new webGrid();
trusted_mac.verifyFields = function(row, quiet) {
        var f = fields.getAll(row);
	if (!v_info_ucast_mac(f[1], quiet, false))return 0;
        return 1;
}
var trusted_mac_idx = 1;
trusted_mac.setup = function() {
        this.init('mac-grid', '', 10, [
                { type: 'text', maxlen: 5 }, 
                { type: 'text', maxlen: 17 }]);
        this.headerSet([ui.id, ui.mac_address]);
        var i ;
        for (i = 0; i < portal_wd_config.wd_trusted_mac_list.length; ++i) {
                        this.insertData(-1, [i+1, portal_wd_config.wd_trusted_mac_list[i]]);
        }
		trusted_mac_idx = i;
        this.showNewEditor();
        this.resetNewEditor();
}

trusted_mac.onDataChanged = function()
{
        verifyFields(null, 1);
}

trusted_mac.resetNewEditor = function()
{
	var f = fields.getAll(this.newEditor);
	trusted_mac_idx ++;
	f[0].value = trusted_mac_idx;
	f[0].disabled = true;
	ferror.clearAll(fields.getAll(this.newEditor));	
}
///////////////////////////////////////////////////////////////////////////
var allowed = new webGrid();
allowed.verifyFields = function(row, quiet) {
        var f = fields.getAll(row);
	
	if (!v_info_url(f[1], quiet, false)) return 0;
        return 1;
}
var allowed_idx = 1;
allowed.setup = function() {
        this.init('allow-grid', '', 256, [
                { type: 'text', maxlen: 5 }, 
                { type: 'text', maxlen: 63 }]);
        this.headerSet([ui.id, ui.dmain+'/IP']);
        var i ;
        for (i = 0; i < portal_wd_config.wd_allowed_web_list.length; ++i) {
                        this.insertData(-1, [i+1, portal_wd_config.wd_allowed_web_list[i]]);
        }
	allowed_idx = i;
        this.showNewEditor();
        this.resetNewEditor();
}

allowed.onDataChanged = function()
{
        verifyFields(null, 1);
}

allowed.resetNewEditor = function()
{
	var f = fields.getAll(this.newEditor);
	allowed_idx ++;
	f[0].value = allowed_idx;
	f[0].disabled = true;
	ferror.clearAll(fields.getAll(this.newEditor));	
}
/////////////////////Known Black List///////////////////////////////////////////////
var knownblack = new webGrid();
knownblack.verifyFields = function(row, quiet) {
        var f = fields.getAll(row);
	
	if (!v_info_url(f[1], quiet, false)) return 0;
        return 1;
}
var knownblack_idx = 1;
knownblack.setup = function() {
        this.init('knownblack-grid', '', 256, [
                { type: 'text', maxlen: 5 }, 
                { type: 'text', maxlen: 63 }]);
        this.headerSet([ui.id, ui.dmain+'/IP']);
        var i ;
        for (i = 0; i < portal_wd_config.wd_known_black_web_list.length; ++i) {
                        this.insertData(-1, [i+1, portal_wd_config.wd_known_black_web_list[i]]);
        }
		knownblack_idx = i;
        this.showNewEditor();
        this.resetNewEditor();
}

knownblack.onDataChanged = function()
{
        verifyFields(null, 1);
}

knownblack.resetNewEditor = function()
{
	var f = fields.getAll(this.newEditor);
	knownblack_idx ++;
	f[0].value = knownblack_idx;
	f[0].disabled = true;
	ferror.clearAll(fields.getAll(this.newEditor));	
}
////////////////////Known White List//////////////////////////////////////////////
var knownwhite = new webGrid();
knownwhite.verifyFields = function(row, quiet) {
        var f = fields.getAll(row);
	
	if (!v_info_url(f[1], quiet, false)) return 0;
        return 1;
}
var knownwhite_idx = 1;
knownwhite.setup = function() {
        this.init('knownwhite-grid', '', 256, [
                { type: 'text', maxlen: 5 }, 
                { type: 'text', maxlen: 63 }]);
        this.headerSet([ui.id, ui.dmain+'/IP']);
        var i ;
        for (i = 0; i < portal_wd_config.wd_known_white_web_list.length; ++i) {
                        this.insertData(-1, [i+1, portal_wd_config.wd_known_white_web_list[i]]);
        }
		knownwhite_idx = i;
        this.showNewEditor();
        this.resetNewEditor();
}

knownwhite.onDataChanged = function()
{
        verifyFields(null, 1);
}

knownwhite.resetNewEditor = function()
{
	var f = fields.getAll(this.newEditor);
	knownwhite_idx ++;
	f[0].value = knownwhite_idx;
	f[0].disabled = true;
	ferror.clearAll(fields.getAll(this.newEditor));	
}
/////////////////////////////////////////////////////////////////////////////////
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
	trusted_mac.setup();
	allowed.setup();
	knownblack.setup();
	knownwhite.setup();
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
	{ title: ui.enable, name: 'f_enable', type: 'checkbox', 
		value: portal_wd_config.wd_enable=='1'},
	{ title: "LAN "+ui.iface, name: 'f_iface', type: 'select', options:now_vifs_options, 
		value: portal_wd_config.wd_interface},
	{ title: "WAN "+ui.iface, name: 'f_wan', type: 'select', options:wan_vifs_options, 
		value: portal_wd_config.wd_wan},
	{ title: ui.hotspot_nc_home, name: 'f_homepage', type: 'text', maxlen: 64, size: 32, 
		value: portal_wd_config.wd_homepage },
	{ title: ui.hotspot_nc_auth, multi: [
		{ name: 'f_authserver', type:'text', maxlen: 64, size: 32,suffix: ':', value: portal_wd_config.wd_authserver},
		{ name: 'f_authport', type:'text', maxlen: 5, size: 5, value: portal_wd_config.wd_authport} ]},		
	{ title: ui.hotspot_nc_timeout, name: 'f_login_timeout', type: 'text', maxlen: 16, size: 15, suffix: '('+ui.minutes+')',
		value: portal_wd_config.wd_login_period},
	{ title: ui.hotspot_nc_knownacl, name: 'f_known', type: 'select', options:known_acl_options, 
		value: portal_wd_config.wd_known_policy},
]);
</script>
</div>
<div id='mac-title' class='section-title'>
<script type='text/javascript'>
        GetText(ui.hotspot_nc_MAClist);
</script>
</div>
<div id="mac-body" class='section'>
        <table class='web-grid' id='mac-grid'></table>
</div>

<div id='allow-title' class='section-title'>
<script type='text/javascript'>
        GetText(ui.hotspot_nc_allowweb);
</script>
</div>
<div id="allow-body" class='section'>
        <table class='web-grid' id='allow-grid'></table>
</div>

<div id='knownblack-title' class='section-title'>
<script type='text/javascript'>
        GetText(ui.hotspot_nc_knownblack);
</script>
</div>
<div id="knownblack-body" class='section'>
        <table class='web-grid' id='knownblack-grid'></table>
</div>

<div id='knownwhite-title' class='section-title'>
<script type='text/javascript'>
        GetText(ui.hotspot_nc_knownwhite);
</script>
</div>
<div id="knownwhite-body" class='section'>
        <table class='web-grid' id='knownwhite-grid'></table>
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

