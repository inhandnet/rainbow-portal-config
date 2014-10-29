<% pagehead(menu.switch_dot1x) %>

<style tyle='text/css'>
#bs-grid {
	text-align: center;
	width: 850px;	
}


</style>

<script type='text/javascript'>

<% ih_sysinfo() %>
<% ih_user_info(); %>

<% web_exec('show running-config dot1x') %>
/*
dot1x_config = {
				enable:1,		//Enable:N=1; Disable:N=0
				port_config:[
								[[1,1,1],2,30,60,0,3600,2,30,30],
								[[1,1,2],2,30,60,0,3600,2,30,30],
								[[1,1,3],2,30,60,0,3600,2,30,30],
								[[1,1,4],2,30,60,0,3600,2,30,30],
								[[1,1,5],2,30,60,0,3600,2,30,30],
								[[1,1,6],2,30,60,0,3600,2,30,30],
								[[1,1,7],2,30,60,0,3600,2,30,30],
								[[1,1,8],2,30,60,0,3600,2,30,30],
								[[2,1,1],2,30,60,0,3600,2,30,30],
								[[2,1,2],2,30,60,0,3600,2,30,30]
							]
		};
*/
<% web_exec('show running-config interface') %>

var port_name_idx = 0;
var cfg_idx = 1;
var txperiod_idx = 2;
var quiet_period_idx = 3;
var reauth_enabled_idx = 4;
var reauth_period_idx = 5;
var reauth_max_idx = 6;
var supp_to_idx = 7;
var svr_to_idx = 8;
var maxreq_idx = 9;

var cfg_opts = [[0,'Disabled'],[1,'Force-Authorized'],[2,'Auto'],[3,'Force-Unauthorized']];
var cfg_cmds = ['', 'force-authorized', 'auto', 'force-unauthorized'];
var enabled_opts = [[0, 'No'], [1, 'Yes']];


var port_cmd_list = [];
var port_name_list = [];

for(var i=0;i<port_config.length;++i){

	if(port_config[i][0] == 1){
		port_cmd_list.push("fastethernet "+ port_config[i][1] + "/" + port_config[i][2]);
		port_name_list.push("FE "+ port_config[i][1] + "/" + port_config[i][2]);
	}else if(port_config[i][0] == 2){
		port_cmd_list.push("gigabitethernet "+ port_config[i][1] + "/" + port_config[i][2]);
		port_name_list.push("GE "+ port_config[i][1] + "/" + port_config[i][2]);
	}
}


var dot1x_port = new webGrid();
dot1x_port.dataToView = function(data) {
	var view_data = [];

	for (var i = 0; i < data.length; i++){
		if (i == cfg_idx){
			view_data.push(cfg_opts[data[cfg_idx]][1]);
		}else if (i == reauth_enabled_idx){
			view_data.push(enabled_opts[data[reauth_enabled_idx]][1]);
		}else{
			view_data.push(data[i]);
		}
	}
	return view_data;
}

dot1x_port.onDataChanged = function()
{
	verifyFields();
}


dot1x_port.verifyFields = function(row, quiet)
{
	var f = fields.getAll(row);

	f[port_name_idx].disabled = true;
//	alert(f[cfg_idx].value);
	//Enabled
		f[txperiod_idx].disabled = true;
		f[quiet_period_idx].disabled = true;
		f[reauth_enabled_idx].disabled = true;
		f[reauth_period_idx].disabled = true;
		f[reauth_max_idx].disabled = true;
		f[supp_to_idx].disabled = true;
		f[svr_to_idx].disabled = true;
		return 1;
        
    /*    
    //txPeriod
	if (!v_f_number(f[txperiod_idx], quiet, true, 1, 65535)) return 0;
	//quietPeriod
	if (!v_f_number(f[quiet_period_idx], quiet, true, 0, 65535)) return 0;

	//reAuthPeriod
	if (!v_f_number(f[reauth_period_idx], quiet, true, 60, 86400)) return 0;
	//reAuthMax
	if (!v_f_number(f[reauth_max_idx], quiet, true, 1, 10)) return 0;
	//suppTimeout
	if (!v_f_number(f[supp_to_idx], quiet, true, 1, 300)) return 0;
	//serverTimeout
	if (!v_f_number(f[svr_to_idx], quiet, true, 1, 300)) return 0;
	//maxReq
	//if (!v_f_number(f[maxreq_idx], quiet, true, 1, 10)) return 0;
	
    return 1;
    */
}
dot1x_port.setup = function()
{
	var dot1x_port_config = [];

	this.init('bs-grid', ['nodelete'], 64,[
		{ type: 'text', maxlen: 10 }, //Port name
		{ type: 'select', options: cfg_opts }, //reAuthEnabled
		{ type: 'text', maxlen: 10 }, //txPeriod
		{ type: 'text', maxlen: 10 }, //quietPeriod
		{ type: 'select', options: enabled_opts }, //reAuthEnabled
		{ type: 'text', maxlen: 10 }, //reAuthPeriod
		{ type: 'text', maxlen: 10 }, //reAuthMax
		{ type: 'text', maxlen: 10 }, //suppTimeout
		{ type: 'text', maxlen: 10 }//, //serverTimeout
//		{ type: 'text', maxlen: 10 } //maxReq
	]);

	//this.headerSet([port.port, 'Enable', 'txPeriod(s)','quietPeriod(s)','reAuthEnabled','reAuthPeriod(s)','reAuthMax','suppTimeout(s)','serverTimeout(s)']);
	this.headerSet([port.port, ui.enable, ui.dot1x_tx,ui.dot1x_quietPeriod,ui.dot1x_reAuthEnabled,ui.dot1x_reAuthPeriod,ui.dot1x_reAuthMax,ui.dot1x_suppTimeout,ui.dot1x_serverTimeout]);

	for (var i = 0; i < port_name_list.length; i++){
		dot1x_port_config = [];
		for (var j = 0; j < dot1x_config.port_config.length; j++){
			if ((dot1x_config.port_config[j][0][0] != port_config[i][0])
				|| (dot1x_config.port_config[j][0][1] != port_config[i][1])
				|| (dot1x_config.port_config[j][0][2] != port_config[i][2])){
				continue;
			}
			dot1x_port_config.push(port_name_list[i]);

			for (var k = 1; k < dot1x_config.port_config[j].length; k++){
				if (k == cfg_idx|| k== reauth_enabled_idx){
					dot1x_port_config.push(dot1x_config.port_config[j][k]);
				}else{
					dot1x_port_config.push(dot1x_config.port_config[j][k].toString());
				}
			}
			/*
			dot1x_port_config = dot1x_config.port_config[j];
			dot1x_port_config[0] = port_name_list[i];
			*/
			//alert(dot1x_port_config);
			dot1x_port.insertData(-1,dot1x_port_config);	
		}
	}
	

}	

function dot1x_port_gen_cmd()
{
	var cmd = "";
	var if_view_flag = 1;
	var ports_data = dot1x_port.getAllData();
	
	for (var i = 0; i < ports_data.length; i++){
		if_view_flag = 1;
		//Enabled
		if (ports_data[i][cfg_idx] != dot1x_config.port_config[i][cfg_idx]){
			if (if_view_flag){
				cmd += "!\n";
				cmd += "interface "+port_cmd_list[i] +"\n";
				if_view_flag = 0;
			}
			cmd += ((ports_data[i][cfg_idx] == 0)?("no "):(""))+"authentication port-control"
					+(" "+cfg_cmds[ports_data[i][cfg_idx]])+"\n";
		}

		if (ports_data[i][cfg_idx] == 0)
			continue;
		
		
		//txPeriod
		if (ports_data[i][txperiod_idx] != dot1x_config.port_config[i][txperiod_idx]){
			if (if_view_flag){
				cmd += "!\n";
				cmd += "interface "+port_cmd_list[i] +"\n";
				if_view_flag = 0;
			}
			cmd += ((ports_data[i][txperiod_idx] == '')?("no "):(""))+"dot1x timeout tx-period"
					+((ports_data[i][txperiod_idx] == '')?(""):(" "+ports_data[i][txperiod_idx]))+"\n";
		}
		//quietPeriod
		if (ports_data[i][quiet_period_idx] != dot1x_config.port_config[i][quiet_period_idx]){
			if (if_view_flag){
				cmd += "!\n";
				cmd += "interface "+port_cmd_list[i] +"\n";
				if_view_flag = 0;
			}
			cmd += ((ports_data[i][quiet_period_idx] == '')?("no "):(""))+"dot1x timeout quiet-period"
					+((ports_data[i][quiet_period_idx] == '')?(""):(" "+ports_data[i][quiet_period_idx]))+"\n";
		}		
		//reAuthEnabled
		if (ports_data[i][reauth_enabled_idx] != dot1x_config.port_config[i][reauth_enabled_idx]){
			if (if_view_flag){
				cmd += "!\n";
				cmd += "interface "+port_cmd_list[i] +"\n";
				if_view_flag = 0;
			}
			cmd += ((ports_data[i][reauth_enabled_idx])?(""):("no "))+"authentication periodic\n";
		}			
		//reAuthPeriod
		if (ports_data[i][reauth_period_idx] != dot1x_config.port_config[i][reauth_period_idx]){
			if (if_view_flag){
				cmd += "!\n";
				cmd += "interface "+port_cmd_list[i] +"\n";
				if_view_flag = 0;
			}
			cmd += ((ports_data[i][reauth_period_idx] == '')?("no "):(""))+"dot1x timeout reauth-period"
					+((ports_data[i][reauth_period_idx] == '')?(""):(" "+ports_data[i][reauth_period_idx]))+"\n";
		}		
		//reAuthMax
		if (ports_data[i][reauth_max_idx] != dot1x_config.port_config[i][reauth_max_idx]){
			if (if_view_flag){
				cmd += "!\n";
				cmd += "interface "+port_cmd_list[i] +"\n";
				if_view_flag = 0;
			}
			cmd += ((ports_data[i][reauth_max_idx] == '')?("no "):(""))+"authentication max-reauth-req"
					+((ports_data[i][reauth_max_idx] == '')?(""):(" "+ports_data[i][reauth_max_idx]))+"\n";
		}		
		//suppTimeout
		if (ports_data[i][supp_to_idx] != dot1x_config.port_config[i][supp_to_idx]){
			if (if_view_flag){
				cmd += "!\n";
				cmd += "interface "+port_cmd_list[i] +"\n";
				if_view_flag = 0;
			}
			cmd += ((ports_data[i][supp_to_idx] == '')?("no "):(""))+"dot1x timeout supp-timeout"
					+((ports_data[i][supp_to_idx] == '')?(""):(" "+ports_data[i][supp_to_idx]))+"\n";
		}			
		//serverTimeout
		if (ports_data[i][svr_to_idx] != dot1x_config.port_config[i][supp_to_idx]){
			if (if_view_flag){
				cmd += "!\n";
				cmd += "interface "+port_cmd_list[i] +"\n";
				if_view_flag = 0;
			}
			cmd += ((ports_data[i][svr_to_idx] == '')?("no "):(""))+"dot1x timeout server-timeout"
					+((ports_data[i][svr_to_idx] == '')?(""):(" "+ports_data[i][svr_to_idx]))+"\n";
		}		
		//maxReq
	}

	if (cmd != "")
		cmd += "!\n";
	return cmd;
}
function verifyFields(focused, quiet)
{
	var cmd = "";
	var fom = E('_fom');
	var cfg_view_flag = 1;
	var dis;
	
	E('save-button').disabled = true;	
	
	dis = !(E('_f_enable').checked);
	E('bs-grid').style.display = dis ? 'none' : '';

	if ((!dis) != dot1x_config.enable){
		if (cfg_view_flag){
			cmd += "!\n";
			cfg_view_flag = 0;
		}
		
		cmd += ((dis)?("no "):(""))+"dot1x system-auth-control\n";
	}
	if (!dis)
		cmd += dot1x_port_gen_cmd();

	//alert(cmd);
	if (user_info.priv < admin_priv) {
		elem.display('save-button','cancel-button', false);
	}else{
		elem.display('save-button','cancel-button', true);
		fom._web_cmd.value = cmd;
		E('save-button').disabled = (cmd=="");	
	}	
	return 1;
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
}

</script>
</head>
<body onload='init()'>
<form id='_fom' method='post' action='apply.cgi'>
<input type='hidden' name='_web_cmd' value=''>


<div class='section'>
<script type='text/javascript'>
createFieldTable('', [	{ title: ui.enable + ' 802.1x', name: 'f_enable', type: 'checkbox', value: dot1x_config.enable}]);
</script>
</div>

<div class='section'>
	<table class='web-grid' cellspacing=1 id='bs-grid'></table>
	<script type='text/javascript'>dot1x_port.setup();</script>	
</div>

<script type='text/javascript'>
init();
if(cookie.get('autosave') == 1)
	ui.aply=ui.aply_save;
genStdFooter("");
</script>
</form>
<script type='text/javascript'>verifyFields(null, 1);</script>
</body>
</html>


