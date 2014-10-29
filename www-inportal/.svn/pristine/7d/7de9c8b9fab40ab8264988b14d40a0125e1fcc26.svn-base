<% pagehead(menu.setup_portal_nc) %>

<style type='text/css'>
#allow-grid  {
        width: 400px;
}
#allow-grid .co1 {
        width: 50px;
}
#allow-grid .co2 {
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

function verifyFields(focused, quiet)
{
	var cmd = "";
	var fom = E('_fom');
	var view_flag = 0;
	var founded = 0;

	var enable = E('_f_enable').checked;
	var dis_public = E('_f_public').checked;
	var gw_if =  E('_f_iface').value;
	//var gw_ip =  E('_f_gw_ip').value = E('_f_gw_ip').value.trim();
	var homepage = E('_f_homepage').value;
	//var hp_redirection = E('_f_homepage_redirection').checked;	
//	var allowed_web_hosts = E('_f_allowed_web_hosts').value;
	var splash_form = E('_f_form').value;
 	var login_timeout = E('_f_login_timeout').value = E('_f_login_timeout').value.trim();                   
 	var allowed_data = allowed.getAllData(); 

	E('save-button').disabled = true;

	if (gw_if != portal_nc_config.nc_interface) {
		cmd += "portal interface "+ gw_if +"\n";
	}
/*
	if (gw_ip != portal_nc_config.nc_gateway_ip_addr) {
		if (!v_info_ip('_f_gw_ip', 0, 1))
			return 0;

		if (gw_ip != "") 
			cmd += "portal gateway-ipaddr "+ gw_ip +"\n";
		else 
			cmd += "no portal gateway-ipaddr\n ";
	}	
*/
	if (homepage != portal_nc_config.nc_homepage) {
		if (!v_info_url('_f_homepage', 0, 1))
			return 0;		

		if (homepage != "") 
			cmd += "portal homepage "+ homepage +"\n";
		else
			cmd += "no portal homepage \n";
	}
/*
	if (hp_redirection && (portal_nc_config.nc_homepage_redirection == 0)) {
		cmd += "portal hp-redirection \n";
	} else if (!hp_redirection  && (portal_nc_config.nc_homepage_redirection == 1)) {
		cmd += "no portal hp-redirection \n";
	} 
*/
/*
	if (allowed_web_hosts != portal_nc_config.nc_allowed_web_hosts) {
		 if (!v_info_url('_f_allowed_web_hosts', 0, 1))
			return 0;
		if (allowed_web_hosts != "") 
			cmd += "portal allowed-web-hosts "+ allowed_web_hosts +"\n";
		else
			cmd += "no portal allowed-web-hosts \n";
	}
*/
	if (splash_form != portal_nc_config.nc_splash_form) {
		if (splash_form != "")
			cmd += "portal splash-form "+ splash_form +"\n";
		else
			cmd += "no portal splash-form\n";	
	}

	if (login_timeout != portal_nc_config.nc_login_timeout) {
		if (!_v_f_range(E('_f_login_timeout'), 0, 60, 86400))
			return 0;

		cmd += "portal login-timeout "+ login_timeout +"\n";
	}

	if (dis_public != portal_nc_config.nc_disable_public) {
		if (dis_public)
			cmd += "no portal public-access\n"
		else
			cmd += "portal public-access\n"
	}

	/* deleted hosts */
        for (var i = 0; i < portal_nc_config.nc_allowed_web_list.length; ++i) {
		found = 0;
        	for (var j = 0; j < allowed_data.length; ++j) {
			if (portal_nc_config.nc_allowed_web_list[i]
				== allowed_data[j][1]) {
				found = 1;
				break;
			}
		}
		if (!found) {
			cmd += "no portal allowed-web-hosts "+ portal_nc_config.nc_allowed_web_list[i] +"\n";
		}
	}
	/* added hosts */
        for (var j = 0; j < allowed_data.length; ++j) {
		found = 0;
        	for (var i = 0; i < portal_nc_config.nc_allowed_web_list.length; ++i) {
			if (portal_nc_config.nc_allowed_web_list[i]
				== allowed_data[j][1]) {
				found = 1;
				break;
			}
		}
		if (!found) {
			cmd += "portal allowed-web-hosts "+ allowed_data[j][1] +"\n";
		}
		
	}

	if (enable && (portal_nc_config.nc_enable == 0)) {
		cmd += "portal enable\n";
	} else if (!enable && (portal_nc_config.nc_enable == 1)) {
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

var allowed = new webGrid();
allowed.verifyFields = function(row, quiet) {
        var f = fields.getAll(row);
	
	if (!v_info_url(f[1], quiet, false)) return 0;
      /*  
        if (!v_info_host_ip(f[0], quiet, false)) return 0;
        if (f[0].value.length!=0 && f[1].value.length==0)
                f[1].value = '255.255.255.0';
        if (!v_info_netmask(f[1], quiet, false)) return 0;
        if (!v_info_ip_netmask(f[0], f[1], quiet)) return 0;
	*/
        return 1;
}
var allowed_idx = 1;
allowed.setup = function() {
        this.init('allow-grid', '', 256, [
                { type: 'text', maxlen: 5 }, 
                { type: 'text', maxlen: 63 }]);
        this.headerSet([ui.id, ui.hst]);
        var i ;
        for (i = 0; i < portal_nc_config.nc_allowed_web_list.length; ++i) {
                        this.insertData(-1, [i+1, portal_nc_config.nc_allowed_web_list[i]]);
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
	allowed.setup();
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
		value: portal_nc_config.nc_enable=='1'},
	{ title: ui.iface, name: 'f_iface', type: 'select', options:now_vifs_options, 
		value: portal_nc_config.nc_interface},
/*
	{ title: ui.hotspot_nc_gatewayaddr, name: 'f_gw_ip', type: 'text', maxlen: 15, size: 15, 
		value: portal_nc_config.nc_gateway_ip_addr },
*/
	{ title: ui.hotspot_nc_home, name: 'f_homepage', type: 'text', maxlen: 64, size: 64, 
		value: portal_nc_config.nc_homepage },
	{ title: ui.hotspot_nc_public, name: 'f_public', type: 'checkbox', 
		value: portal_nc_config.nc_disable_public=='1'},
/*
	{ title: ui.hotspot_nc_redirect, name: 'f_homepage_redirection', type: 'checkbox',  
		value: portal_nc_config.nc_homepage_redirection == 1},
	{ title: ui.hotspot_nc_allowweb, name: 'f_allowed_web_hosts', type: 'text', maxlen: 128, size: 64, 
		value: portal_nc_config.nc_allowed_web_hosts},
*/
	{ title: ui.hotspot_nc_form, name: 'f_form', type: 'text', maxlen: 64, size: 64, 
		value: portal_nc_config.nc_splash_form },
	{ title: ui.hotspot_nc_timeout, name: 'f_login_timeout', type: 'text', maxlen: 16, size: 15, 
		value: portal_nc_config.nc_login_timeout}
]);
</script>
</div>
<div id='allow-title' class='section-title'>
<script type='text/javascript'>
        GetText(ui.hotspot_nc_allowweb);
</script>
</div>
<div class='section'>
        <table class='web-grid' id='allow-grid'></table>
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

