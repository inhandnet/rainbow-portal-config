<% pagehead(menu.service_dhcpc) %>

<script type='text/javascript'>

<% ih_sysinfo(); %>
<% ih_user_info(); %>

<% web_exec('show interface')%>

//take care: sequence strict
var vifs = [].concat(dot11radio_interface, eth_interface, svi_interface);
var now_vifs_options = new Array();
now_vifs_options = grid_list_all_vif_opts(vifs);


function eth_vif_dhcpc_enable(ifname)
{
	for (var i = 0; i < vifs.length; i++) {
		if (vifs[i][0] == ifname) {
			return (vifs[i][6]);
		}
	}
}

/*����ĸ��д*/
function vif_name_format(ifname)
{
	var reg = /\b(\w)|\s(\w)/g;
	return ifname.replace(reg,function(m){return m.toUpperCase()})
}


function verifyFields(focused, quiet)
{
	var a;
	var ok = 1;
	var cmd = '';

	for (var i = 0; i < vifs.length; i++) {
		if (E('_dhcpc_'+i).checked != vifs[i][6]){
			cmd += "!\ninterface "+ vifs[i][0] + "\n";
			cmd += (E('_dhcpc_'+i).checked?"":"no ")+"ip address dhcp\n";
		}
	}
    
    E('save-button').disabled = 1;
    if(cmd != ''){
        E('save-button').disabled = 0;
		E('_fom')._web_cmd.value = cmd;
    }

	if (user_info.priv < admin_priv) {
		elem.display('save-button', 'cancel-button', false);
	}else{
		elem.display('save-button', 'cancel-button', true);
	}

	return ok;	
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
	verifyFields(null, 1);
}

function init()
{}

</script>
</head>
<body onload='init()'>
<form id='_fom' method='post' action='apply.cgi'>
<input type='hidden' name='_web_cmd' value=''>
<div class='section'>
<script type='text/javascript'>
var dhcpc_tb = [];
//dhcpc_tb.push({ title: ui.enable, name: ''});
for (var i = 0; i < now_vifs_options.length; i++){
	dhcpc_tb.push({ title: vif_name_format(now_vifs_options[i][0]), name: 'dhcpc_'+i, type: 'checkbox', value: eth_vif_dhcpc_enable(now_vifs_options[i][0])});
}
createFieldTable('', dhcpc_tb);
</script>
</div>
</form>
<script type='text/javascript'>
if(cookie.get('autosave') == 1)
	ui.aply=ui.aply_save;
genStdFooter("");
</script>
<script type='text/javascript'>earlyInit();</script>
</body>
</html>
