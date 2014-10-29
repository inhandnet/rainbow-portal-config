<% pagehead(menu.eth1) %>

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
<% web_exec('show running-config alarm') %>

var alarm_input_title = [['warm-start', alarm.warm_map],
							['cold-start', alarm.cold_map],
							['memory-low', alarm.mem_map],
							['digital-input-high', ui.io_alarm_high],
							['digital-input-low', ui.io_alarm_low],
							['link-down fastethernet 0/1', 'FE0/1 '+alarm.down_map],
							['link-up fastethernet 0/1', 'FE0/1 '+alarm.up_map],
							['link-down fastethernet 0/2', 'FE0/2 '+alarm.down_map],
							['link-up fastethernet 0/2', 'FE0/2 '+alarm.up_map],
							['link-down fastethernet 1/1', 'FE1/1 '+alarm.down_map],
							['link-up fastethernet 1/1', 'FE1/1 '+alarm.up_map],
							['link-down fastethernet 1/2', 'FE1/2 '+alarm.down_map],
							['link-up fastethernet 1/2', 'FE1/2 '+alarm.up_map],
							['link-down fastethernet 1/3', 'FE1/3 '+alarm.down_map],
							['link-up fastethernet 1/3', 'FE1/3 '+alarm.up_map],
							['link-down fastethernet 1/4', 'FE1/4 '+alarm.down_map],
							['link-up fastethernet 1/4', 'FE1/4 '+alarm.up_map],
							['cellular', menu.setup_wan1+' Up/Down'],
							['dialer', menu.setup_pppoe+' Up/Down'],
							['fastethernet', menu.eth+' Up/Down'],
							['vlan', 'VLAN'+' Up/Down']
							];


function get_alarm_input_title(al_json)
{
	for (var i = 0; i < alarm_input_title.length; i++){
		if (al_json == alarm_input_title[i][0]){
			return alarm_input_title[i][1];
		}
	}
	return '';
}

function verifyFields(focused, quiet)
{
	var cmd = "";
	var fom = E('_fom');
	var view_flag = 0;
	var founded = 0;
	
	E('save-button').disabled = true;

	for (var i = 0; i < alarm_input_options.length; i++){
		if (E('_f_in_'+i).checked != alarm_input[i]){
			cmd += "!\n" + (E('_f_in_'+i).checked?"":"no ") + "alarm input " + alarm_input_options[i] + "\n";
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
	verifyFields(null, true);
}
</script>
</head>
<body>
<form id='_fom' method='post' action='apply.cgi'>
<input type='hidden' name='_web_cmd' value=''>


<div class='section'>
<script type='text/javascript'>
var alarm_input_tb = [];
for (var i = 0; i < alarm_input_options.length; i++){
	alarm_input_tb.push({ title: get_alarm_input_title(alarm_input_options[i]), name: 'f_in_'+i, type: 'checkbox', value: alarm_input[i]});
}
createFieldTable('', alarm_input_tb);
</script>
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

