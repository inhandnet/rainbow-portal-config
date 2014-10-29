<% pagehead(menu.route_static) %>

<style type='text/css'>
#route-grid {
	text-align: center;
	width: 580px;
}

#route-grid .co1, #route-grid .co2{
	width: 100px;
}
#route-grid .co3 {
	width: 140px;
}
#route-grid .co4 {
	width: 100px;
}
#route-grid .co5 {
	width: 60px;
}
#route-grid .co6 {
	width: 80px;
}

</style>

<script type='text/javascript'>

<% ih_sysinfo(); %>
<% ih_user_info(); %>
<% web_exec('show interface')%>

var operator_priv = 12;

//var vifs = [].concat(cellular_interface, eth_interface, sub_eth_interface, svi_interface, xdsl_interface, gre_interface,openvpn_interface,vp_interface);
var vifs = [].concat(cellular_interface, eth_interface, sub_eth_interface, svi_interface, xdsl_interface, gre_interface,openvpn_interface,vp_interface, bridge_interface);
var now_vifs_options = new Array();
now_vifs_options = grid_list_all_vif_opts(vifs);

//[ ['ip','netmask','gateway','ifname','distance','track'] ...   ]
<% web_exec('show running-config route'); %>

var route = new webGrid();

route.verifyFields = function(row, quiet) {

	var f = fields.getAll(row);
	ferror.clearAll(f);

	if (f[0].value.length==0) f[0].value = '0.0.0.0';
	if (f[1].value.length==0) f[1].value = '255.255.255.0';

	
	if( !v_ip(f[0],quiet) ) return 0;
	if( !v_netmask(f[1],quiet) ) return 0;
	if(f[3].value != ''){
		if( !v_ip(f[3],quiet) ) return 0;
		if(check_gw(f[3].value)) {
			ferror.set(f[3], errmsg.ip, quiet);
			return 0;
		}
	}
	if(f[3].value == '' && f[2].value == ''){
		return 0;
	}
	if( f[4].value != ''){
		if(!v_range(f[4],quiet,2,255)) return 0;
	}
	if( f[5].value >0){
		if(!v_range(f[5],quiet,1,10)) return 0;
	}
	
	return 1;
}

route.dataToView = function(data) {
	
	 return [data[0], data[1], data[2], data[3], data[4], data[5]];   
}


route.fieldValuesToData = function(row) {
	var f = fields.getAll(row);
	
	return [f[0].value, f[1].value, f[2].value, f[3].value, f[4].value, f[5].value,];
}

route.resetNewEditor = function() {
	var f, c;

	f = fields.getAll(this.newEditor);
	ferror.clearAll(f);
	
	f[0].value = '';
	f[1].value = '';
	f[2].value = '';
	f[3].value = '';
	f[4].value = '';
	f[5].value = '';
}

route.setup = function() {
	this.init('route-grid', 'move', 128, [
		{ type: 'text', maxlen: 15 },
		{ type: 'text', maxlen: 15 }, 
		{ type: 'select', options: now_vifs_options },
		{ type: 'text', maxlen:15 },
		{ type: 'text', maxlen:15 },
		{ type: 'text', maxlen:15 }
	]);

	grid_vif_opts_add(now_vifs_options, "");
	this.headerSet([ui.dst, ui.netmask,ui.iface, ui.gateway, ui.distance, ui.track]);
    
	var routes = static_route_config;
	for (var i = 0; i < routes.length; ++i) {
		this.insertData(-1, [routes[i][0], routes[i][1], routes[i][2], routes[i][3],routes[i][4], routes[i][5]]);
	}

	this.showNewEditor();
	this.resetNewEditor();
}

route.onDataChanged = function() {
	verifyFields(null, true);
}


function interface_cmp(interface, gateway){
	
	var i;
	var id = 3;
	for(i =0; i<interface.length; i++){
		if(gateway == interface[i][id]){
			return -1;
		}
	}
	return 0;
}

function interface_cmp_snd_ip(interface, gateway){
	
	var i,j;
	var id = 3;
	var snd_ip_id= 5;
	var snd_ip;
	for(i =0; i<interface.length; i++){
		if(gateway == interface[i][id]){
			return -1;
		}else {
			snd_ip = interface[i][snd_ip_id];
			for(j = 0 ; j<snd_ip.length; j+=2){
				if(snd_ip[j] == gateway) return -1;
			}
		}
	}
	return 0;
}

function check_gw(gateway)
{
	var rv = 0;
	rv = interface_cmp(cellular_interface, gateway);
	if(rv) return rv;	
	rv = interface_cmp_snd_ip(eth_interface, gateway);
	if(rv) return rv;
	rv = interface_cmp(sub_eth_interface, gateway);
	if(rv) return rv;
	rv = interface_cmp_snd_ip(svi_interface, gateway);
	if(rv) return rv;	
	rv = interface_cmp(xdsl_interface, gateway);
	if(rv) return rv;
	rv = interface_cmp(gre_interface, gateway);
	if(rv) return rv;
	rv = interface_cmp(openvpn_interface, gateway);
	if(rv) return rv;
	rv = interface_cmp(vp_interface, gateway);
	if(rv) return rv;
	rv = interface_cmp_snd_ip(lo_interface, gateway);
	if(rv) return rv;
	return rv;
}


function print_cmd(route, flag)
{
	var cmd = '';
	if(!flag){
		cmd += "no ip route " + route[0]+ " " + route[1] + " ";
		if(route[2]){
			cmd+= route[2] + " ";
		}
		if(route[3]){
			cmd+= route[3] + " ";
		}
		if(route[4]>1){
			cmd+= route[4] + " ";
		}
		if(route[5]>0){
			cmd+= "track "+route[5] + " ";
		}
	}else {
		cmd += "ip route " + route[0]+ " " + route[1] + " ";
		if(route[2]){
			cmd+= route[2] + " ";
		}
		if(route[3]){
			cmd+= route[3] + " ";
		}
		if(route[4]>1){
			cmd+= route[4] + " ";
		}
		if(route[5]>0){
			cmd+= "track "+route[5] + " ";
		}
	}
	cmd += "\n";
	return cmd;
}

function verifyFields(focused, quiet)
{

	var cmd = '';
	var fom = E('_fom');	
	
	E('save-button').disabled = true;

	var data = route.getAllData();
	var routes = static_route_config;
	// delete
	for(var i = 0; i < routes.length; i++) {
		var found = 0;
		for(var j = 0; j < data.length; j++) {
			if((routes[i][0] == data[j][0])&& (routes[i][1] == data[j][1]) && (routes[i][4] == data[j][4])){
				found = 1;
				break;
			}
		}
		if(!found) {
			cmd += print_cmd(routes[i], 0);	
		}
	}
	//add
	for(var i = 0; i < data.length; i++) {
		var found = 0;
		var changed = 0;
		for(var j = 0; j < routes.length; j++) {
			if(data[i][0]==routes[j][0] &&
				data[i][1]==routes[j][1] &&
				data[i][4]==routes[j][4]) {//id
				found = 1;
				if(data[i][2] != routes[j][2]
					|| data[i][3] != routes[j][3]
					|| data[i][5] != routes[j][5]) {
					changed = 1;
				}
				break;
			}
		}
		if(!found || changed) {
			cmd += print_cmd(data[i], 1);	
		}
	}
	//alert(cmd);
	if (user_info.priv < operator_priv) {
		elem.display('save-button', 'cancel-button', false);
	}else{
		elem.display('save-button', 'cancel-button', true);
		fom._web_cmd.value = cmd;
		E('save-button').disabled = (cmd=="");
	}

	return 1;
}

function save()
{
	if (route.isEditing()) return;

	var fom = E('_fom');

	if((E('_fom')._web_cmd.value != '')&&(cookie.get('autosave') == 1)){
		E('_fom')._web_cmd.value += "!"+"\n"+"copy running-config startup-config"+"\n";	
	}

	form.submit(fom, 1);
}

function earlyInit()
{
	route.setup();
	verifyFields(null, true);
}

function init()
{
	if((cookie.get('autosave')) == null){
		cookie.set('autosave', 1);
	}
	route.recolor();
}
</script>
</head>
<body onload='init()'>
<form id='_fom' method='post' action='apply.cgi'>
<input type='hidden' name='_web_cmd' value=''>

<div class='section'>
	<table class='web-grid' id='route-grid'></table>
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

