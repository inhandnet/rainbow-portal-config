<% pagehead(menu.switch_sntp) %>

<style tyle='text/css'>
#bs-grid {
	width:250px;	
}
#bs-grid .co1 {
	width:150px;
	text-align: center;
}

#bs-grid .co2 {
	width:100px;
	text-align: center;
}

</style>

<script type='text/javascript'>

<% ih_sysinfo() %>
<% ih_user_info(); %>

var sntpc_config = {
	enable: 0,
	debug_status: 0,
	interval: 60,
	server_list: [['202.102.240.85','80'],['202.102.240.86','81']]
};

<% web_exec('show running-config sntp-client') %>

<% web_exec('show interface')%>

var vif_blank = [['', '']];
var vifs = [].concat(vif_blank, cellular_interface, eth_interface, sub_eth_interface,svi_interface, xdsl_interface, gre_interface, vp_interface, openvpn_interface);
var now_vifs_options = new Array();
now_vifs_options = grid_list_all_vif_opts(vifs);

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
	
    if(f[0].value == ''){
        ferror.set(f[0], errmsg.adm3, quiet);
        return 0;
    }else{
		ferror.clear(f[0]);
    }
        
    
    if (this.existName(0,f[0].value)) {
		ferror.set(f[0], errmsg.bad_addr2, quiet);
		return 0;
	}else{
		ferror.clear(f[0], errmsg.bad_addr2, quiet);
	}

	if(!check_domain_name(f[0].value)){
		ferror.set(f[0], errmsg.domain_name, quiet);
		return 0;
	}else{
		ferror.clear(f[0], errmsg.domain_name, quiet);
	}
	/*
	if(!check_ip(f[0].value)){
		ferror.set(f[0], errmsg.ip, quiet);
		return 0;
	}else{
		ferror.clear(f[0], errmsg.ip, quiet);
	}
*/
	if ((f[1].value != '') && (f[1].value < 1)||(f[1].value > 65535)||(!isDigit(f[1].value))) {
		ferror.set(f[1], errmsg.sntp_server_port, quiet);
		return 0;
	}else{
		ferror.clear(f[1], errmsg.sntp_server_port, quiet);
	}
		
	return 1;
}

grid.resetNewEditor = function() {
	var f = fields.getAll(this.newEditor);
	f[0].value= '';
	f[1].value = '123';
	
	ferror.clearAll(fields.getAll(this.newEditor));

}

grid.setup = function()
{
	this.init('bs-grid', ['sort', 'move'], 10,[
		{ type: 'text'},
		{ type: 'text'}
	]);

	grid.headerSet([sntp.server_ip,port.port]);
	
	for(var i = 0;i < sntpc_config.server_list.length;++i){
			
		grid.insertData(-1,[sntpc_config.server_list[i][0],sntpc_config.server_list[i][1]]);
	}	

	grid.showNewEditor();
	grid.resetNewEditor();
	
}

function isDigit(str)
{ 
  var reg = /^\d*$/; 

  return reg.test(str); 
 }

function check_ip(ip_address)
{
	var tmp_ip;

	if(ip_address != ''){
		tmp_ip = ip_address.split('.');
		if(tmp_ip.length != 4)
			return false;

		for(var i=0;i<tmp_ip.length;++i){
			if((tmp_ip[i] < 0)||(tmp_ip[i] > 255)||(tmp_ip[i] == '')||(!isDigit(tmp_ip[i])))
				return false;
		}
		if(ip_address == '0.0.0.0')
			return false;
	}
	
	return true;
}

function check_domain_name(domain_name)
{
	var dotpos = 0;
	
	if (check_ip(domain_name)) return true;

	if (domain_name.length > 26)
		return false;

	for (var i = 0; i < domain_name.length; i++){
		if (!(
			(domain_name.charAt(i) >= 'a' && domain_name.charAt(i) <= 'z')
			|| (domain_name.charAt(i) >= 'A' && domain_name.charAt(i) <= 'Z')
			|| (domain_name.charAt(i) >= '0' && domain_name.charAt(i) <= '9')
			|| (domain_name.charAt(i) == '-')
			|| (domain_name.charAt(i) == '.')
			)){
			return false;
		}

		if (domain_name.charAt(i) == '.')
			dotpos = i;
	}

	if (dotpos == 0 || domain_name.length - dotpos <2) return false;

	return true;
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

	if (!v_f_number(E('_f_update_interval'), quiet, false, 60, 2592000)) return 0;
	if (!v_info_host_ip(E('_f_src_ip'), quiet, true)) return 0;

	if (E('_f_src_if').value != ''){
		E('_f_src_ip').disabled = 1;
		E('_f_src_ip').value = '';
	} else {
		E('_f_src_ip').disabled = 0;
	}
/*
	//sntp debug status
	if(E('_f_sntp_debug').value != sntpc_config.debug_status){
		
		if(E('_f_sntp_debug').value == 0){
			cmd += "no debug sntp-client" + "\n";
		}else{
			cmd += "debug sntp-client" + "\n";
		}
	}
*/

	//sntp updata interval
	if(E('_f_update_interval').value != sntpc_config.interval){
		if(E('_f_update_interval').value != ''){
			cmd += "sntp-client update-interval " + E('_f_update_interval').value + "\n";
		}else{
			cmd += "no sntp-client update-interval" + "\n";
		}
	}
	
	//server list
	var tmp_data = grid.getAllData();
	if(tmp_data.length >0){
		if(sntpc_config.server_list.length > 0){
			//check delete
			for(var i=0;i<sntpc_config.server_list.length;++i){
				var j;
				for(j=0;j<tmp_data.length;j++){
					if(sntpc_config.server_list[i][0] == tmp_data[j][0]){
						break;
					}
					/*
					else{
						j++;
						if(j == tmp_data.length){
							cmd += "no sntp-client server " + sntpc_config.server_list[i][0]+"\n";
						}
					}
					*/
				}

				if(j == tmp_data.length){
					cmd += "no sntp-client server " + sntpc_config.server_list[i][0]+"\n";
				}
			}
			
			//check add
			for(var i=0;i<tmp_data.length;++i){
				var j;
				for(j=0;j<sntpc_config.server_list.length;j++){
					if(tmp_data[i][0] == sntpc_config.server_list[j][0]){//old list
						if(tmp_data[i][1] != sntpc_config.server_list[j][1]){//change port
							if (tmp_data[i][1] != '')
								cmd += "sntp-client server " + tmp_data[i][0]  + " port " + tmp_data[i][1] + "\n";
							else
								cmd += "sntp-client server " + tmp_data[i][0]  + "\n";
						}
						break;
					}
					/*
					else{
						j++;
						if(j == sntpc_config.server_list.length){
							cmd += "sntp-client server " + tmp_data[i][1]+"\n";
						}
					}
					*/
					
				}
				
				if(j == sntpc_config.server_list.length){//new list
					if (tmp_data[i][1] != '')
						cmd += "sntp-client server " + tmp_data[i][0]  + " port " + tmp_data[i][1] + "\n";
					else
						cmd += "sntp-client server " + tmp_data[i][0]  + "\n";
				}
				
			}
		}else{
		//add all
			for(var i=0;i<tmp_data.length;++i){
				if(tmp_data[i][1] == '')
					cmd += "sntp-client server " + tmp_data[i][0]+"\n";
				else
					cmd += "sntp-client server " + tmp_data[i][0]  + " port " + tmp_data[i][1] + "\n";
			}
		}
	}else{
		//delete all
		for(var j=0;j< sntpc_config.server_list.length;++j){
			cmd += "no sntp-client server " + sntpc_config.server_list[j][0] +"\n";
		}
	}

	//source 
	if ((E('_f_src_if').value == '' && E('_f_src_if').value != sntpc_config.source_if)
		|| E('_f_src_ip').value == '' && E('_f_src_ip').value != sntpc_config.source) {
		cmd += "no sntp-client source\n";
	}
	if (E('_f_src_if').value != '' && E('_f_src_if').value != sntpc_config.source_if) {
		cmd += "sntp-client source interface "+ E('_f_src_if').value  +"\n";
	}

	if (E('_f_src_ip').value != '' && E('_f_src_ip').value != sntpc_config.source) {
		cmd += "sntp-client source "+ E('_f_src_ip').value  +"\n";
	}	
	
	//sntp client status
	if(E('_f_sntp_enable').checked != sntpc_config.enable){
		if(E('_f_sntp_enable').checked == 0){
			cmd += "no sntp-client" + "\n";
		}else{
			cmd += "sntp-client" + "\n";
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
		
	if (!verifyFields(null, false)) return;
	
	if (cookie.get('debugcmd') == 1)
		alert(E('_fom')._web_cmd.value);
	
	if((E('_fom')._web_cmd.value != '')&&(cookie.get('autosave') == 1)){
		E('_fom')._web_cmd.value += "!"+"\n"+"copy running-config startup-config"+"\n";	
	}
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
	{ title: ui.enable, name: 'f_sntp_enable', type: 'checkbox', value: sntpc_config.enable},
	//{ title: sntp.sntp_debug , name: 'f_sntp_debug', type: 'select',options:[[0,sntp.sntp_disable],[1,sntp.sntp_enable]],value: sntpc_config.debug_status},
	{ title: sntp.update_interval, name: 'f_update_interval', type: 'text', suffix: ' '+ui.seconds + '(60-2592000)',size:9,value: sntpc_config.interval},
	{ title: l2tpc.src_if, name: 'f_src_if', type:'select', options:now_vifs_options, value:sntpc_config.source_if},
	{ title: ui.dhcp_src, name: 'f_src_ip', type:'text', size:16, value:sntpc_config.source},
]);
</script>
</div>


<div class='section-title' id='_port_parameters_title'>
<script type='text/javascript'>
	GetText(sntp.server_list);
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




