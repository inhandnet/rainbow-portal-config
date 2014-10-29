<% pagehead(menu.setup_network) %>

<style tyle='text/css'>
#bs-grid {
	width:250px;	
}
#bs-grid .co1 {
	width:100px;
	text-align: center;
}
#bs-grid .co2 {
	width:150px;
	text-align: center;
}

</style>

<script type='text/javascript'>

<% ih_sysinfo() %>
<% ih_user_info(); %>

<% web_exec('show ip interface') %>
/*
if_config = {
    ip_address: "10.5.1.89",
    subnet_mask: "255.255.255.0",
    gateway: "10.5.1.254",
    dns_list:['202.106.0.20']
};
*/


var ip_address,netmask,gateway_addr;
ip_address = if_config.ip_address;
netmask = if_config.subnet_mask;
gateway_addr= if_config.gateway;

var ip_changed = 0;
var grid = new webGrid();

grid.onDataChanged = function()
{
	verifyFields();
}

grid.exist = function(f, v)
{
	var data = this.getAllData();
	for (var i = 0; i < data.length; ++i) {
		if (data[i][f] == v) return true;
	}
	return false;
}

grid.existName = function(position,name)
{
	return this.exist(position, name);
}

grid.dataToView = function(data) {
	return [data[0],data[1]];
}

grid.fieldValuesToData = function(row) {
	var f = fields.getAll(row);
		
	return [f[0].value,f[1].value];
}

grid.verifyFields = function(row, quiet)
{
	var f = fields.getAll(row);
	var s;
	
	if (this.existName(0,f[0].value)) {
		ferror.set(f[0], errmsg.bad_session, quiet);
		return 0;
	}else{
		ferror.clear(f[0], errmsg.bad_session, quiet);
	}

	if (this.existName(1,f[1].value)) {
		ferror.set(f[1], errmsg.bad_addr2, quiet);
		return 0;
	}else{
		ferror.clear(f[1], errmsg.bad_addr2, quiet);
	}

	if (!v_host_ip(f[1], quiet)) return 0;

	return 1;
}

grid.resetNewEditor = function() {
	var f = fields.getAll(this.newEditor);
	var tmp_data = grid.getAllData();

	f[0].disabled = true;
	f[0].value = tmp_data.length+1;
	f[1].value= '0.0.0.0';
	
	ferror.clearAll(fields.getAll(this.newEditor));

}

grid.setup = function()
{
	this.init('bs-grid', ['sort', 'move'], 6,[
		{ type: 'text'},
		{ type: 'text'}
	]);

	this.headerSet([ui.index,ui.dns]);
		
	for(var i = 0;i < if_config.dns_list.length;++i){			
		grid.insertData(-1,[(i+1).toString(),if_config.dns_list[i]]);
	}	

	this.showNewEditor();
	grid.resetNewEditor();
}




function verifyFields(focused, quiet)
{
	var a;
	var ok = 1;
	var view_flag = 1;
	var cmd = "";
	var fom = E('_fom');

	E('save-button').disabled = true;
	if (grid.isEditing()) return;	
	
	//check ip address
	if (!v_host_ip(E('_f_ip_address'), quiet)) return 0;

	//check netmask
	if (!v_mask(E('_f_netmask'), quiet)) return 0;

	//check gateway
	if (E('_f_gateway').value.length > 0){
		if (!v_gateway(E('_f_gateway'), quiet, E('_f_netmask').value, E('_f_ip_address').value)) return 0;
	}

	//ip address add netmask
	ip_changed = 0;
	if(E('_f_ip_address').value != ip_address){
		if(E('_f_ip_address').value == ''){
			if(view_flag){
				cmd += "exit" + "\n";
				view_flag = 0;
			}
			cmd += "no ip address" + "\n";
			
		}else{
			if(view_flag){
				cmd += "exit" + "\n";
				view_flag = 0;
			}
			cmd += "ip address " + E('_f_ip_address').value + " " + E('_f_netmask').value + "\n";
		}
		ip_changed = 1;
	}else if(E('_f_netmask').value != netmask){
		if(view_flag){
			cmd += "exit" + "\n";
			view_flag = 0;
		}
		cmd += "ip address " + E('_f_ip_address').value + " " + E('_f_netmask').value + "\n";
	}

	//gateway
	if(E('_f_gateway').value != gateway_addr){
		if(view_flag){
			cmd += "exit" + "\n";
			view_flag = 0;
		}
		if(E('_f_gateway').value != ''){
			cmd +="ip default-gateway " + E('_f_gateway').value +"\n";
		}else{
			cmd +="no ip default-gateway" + "\n";
		}
	}

	//DNS list
	
	var tmp_data = grid.getAllData();
	
	if(tmp_data.length >0){
		if(if_config.dns_list.length > 0){
			//check add
			for(var i=0;i<tmp_data.length;++i){
				for(var j=0;j<if_config.dns_list.length;){
					if(tmp_data[i][1] == if_config.dns_list[j]){
						break;
					}else{
						j++;
						if(j == if_config.dns_list.length){
							if(view_flag){
								cmd += "exit" + "\n";
								view_flag = 0;
							}
							cmd += "ip name-server " + tmp_data[i][1]+"\n";
						}
					}
				}
			}
			//check delete
			for(var i=0;i<if_config.dns_list.length;++i){
				for(var j=0;j<tmp_data.length;){
					if(if_config.dns_list[i] == tmp_data[j][1]){
						break;
					}else{
						j++;
						if(j == tmp_data.length){
							if(view_flag){
								cmd += "exit" + "\n";
								view_flag = 0;
							}
							cmd += "no ip name-server " + if_config.dns_list[i]+"\n";
						}
					}
				}
			}
			
		}else{
		//add all
			for(var i=0;i<tmp_data.length;++i){
				if(view_flag){
					cmd += "exit" + "\n";
					view_flag = 0;
				}
				cmd += "ip name-server " + tmp_data[i][1]+"\n";
			}
		}
	}else{
		//delete all
		for(var j=0;j< if_config.dns_list.length;++j){
			if(view_flag){
				cmd += "exit" + "\n";
				view_flag = 0;
			}
			cmd += "no ip name-server " + if_config.dns_list[j] +"\n";
		}
	}
	

	//alert(cmd);
	if (user_info.priv < admin_priv) {
		elem.display('save-button', false);
	}else{
		elem.display('save-button', true);
		fom._web_cmd.value = cmd;
		E('save-button').disabled = (cmd=="");	
	}

	
	return ok;	
}


function save()
{
		
	if (!verifyFields(null, false)) return;
	if((E('_fom')._web_cmd.value != '')&&(cookie.get('autosave') == 1)){
		E('_fom')._web_cmd.value += "!"+"\n"+"copy running-config startup-config"+"\n";	
	}
	
	cookie.set('changing_ip', ip_changed);

	form.submit('_fom', 1);
}

function init()
{
	if((cookie.get('autosave')) == null){
		cookie.set('autosave', 1);
	}
	//grid.recolor();
	//grid.resetNewEditor();
}
</script>
</head>
<body onload='init()'>
<form id='_fom' method='post' action='apply.cgi'>
<input type='hidden' name='_web_cmd' value=''>

<div class='section'>
<script type='text/javascript'>

createFieldTable('', [
	{ title: ui.ip , name: 'f_ip_address', type: 'text', value: ip_address},
	{ title: ui.netmask , name: 'f_netmask', type: 'text', value: netmask},
	{ title: ui.gateway , name: 'f_gateway', type: 'text', value: gateway_addr}
]);
</script>
</div>

<div class='section-title' id='_port_parameters_title'>
<script type='text/javascript'>
	GetText(ui.dns);
</script>
</div>
<div class='section' id='_port_parameters'>
<table class='web-grid' id='bs-grid'></table>
</div>

<script type='text/javascript'>
init();
if(cookie.get('autosave') == 1)
	ui.aply=ui.aply_save;
genStdFooter("");
</script>
</form>
<script type='text/javascript'>grid.setup();</script>
<script type='text/javascript'>verifyFields(null, 1);</script>
</body>
</html>

