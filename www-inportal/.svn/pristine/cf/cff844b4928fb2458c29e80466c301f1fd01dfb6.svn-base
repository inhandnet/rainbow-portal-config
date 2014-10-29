<% pagehead(menu.setup_wan1) %>

<style type='text/css'>
#redial-grid {
	text-align: center;	
	width: 700px;
}

#redial-grid .co1 {
	width: 40px;
}
#redial-grid .co2 {
	width: 80px;
}
</style>

<script type='text/javascript'>

<% ih_sysinfo(); %>
<% ih_user_info(); %>

//var cellular_advanced=0;
cellular1_config = {
	enable: 1,
	dial_interval: 10,
	network_type: 0,
	signal_interval: 120,
	sim1_profile: 1,
	sim2_profile: 0,
	mtu: 1500,
	mru: 1500,
	ppp_timeout: 120,
	peerdns: 1,
	ppp_mode: 0,
	trig_data: 0,
	trig_sms: 0,
	ppp_idle: 60,
	ppp_static: 0,
	ppp_ip: '',
	ppp_peer: '1.1.1.3',
	ppp_lcp_interval: 55,
	ppp_lcp_retries: 5,
	sim1_roaming: 1,
	sim2_roaming: 1,
	dualsim_redial: 5,
	dualsim_uptime: 0,
	dualsim_csq1: 0,
	dualsim_csq2: 0,
	dualsim_csq_interval1: 0,
	dualsim_csq_interval2: 0,
	dualsim_csq_retries1: 0,
	dualsim_csq_retries2: 0,
	dualsim_time: 0,
	main_sim: 1,
	sim1_pincode: '',
	sim2_pincode: '',
	dualsim_enable: 0,
	ppp_init: 'AT',
	ppp_am: '0',
	ppp_debug: '0',
	ppp_options: 'nomppc',
	activate_enable: '0',
	activate_number: '*22899',
	profiles:[['1','1','3gnet','*99***1#','0','gprs','gprs']]
};

netwatcher_config = {
	keepalive:[['cellular 1','192.168.1.1','10','20','5','',''],
		   ['vlan 1','192.168.1.1','10','20','5','','']]
};
var provider_data_list = [];
var network_type_list = [];
var modem_list = [];
var modem_networksel_list = [['0',ui.auto],['1','2G'],['2','3G'],['3', '4G']];
var modem_authentication_list = [['0',ui.auto],['1','PAP'],['2','CHAP'],['3','MS-CHAP'],['4','MS-CHAPv2']];
var modem_freqsel_list = [['0',ui.al],['1','GSM850'],['2','GSM900'],['3','GSM1800'],['4','GSM1900'],['5','WCDMA850'],['6','WCDMA900'],['7','WCDMA1900'],['8','WCDMA2100']];
var dualsim_flag = 0;

<% web_exec('show running-config cellular') %>
<% web_exec('show running-config netwatcher') %>
<% modem_list() %>
<% network_list() %>

var dest_keepalive_strict = 0;

var dest_keepalive_config = ['','','30','5','5','','','0'];
for (var i = 0; i < netwatcher_config.keepalive.length; i++){
	if (netwatcher_config.keepalive[i][0] == "cellular 1"){
		dest_keepalive_config = netwatcher_config.keepalive[i];
		if(dest_keepalive_config[2] == '0') dest_keepalive_config[2] = '30';
		if(dest_keepalive_config[3] == '0') dest_keepalive_config[3] = '5';
		if(dest_keepalive_config[4] == '0') dest_keepalive_config[4] = '5';
		if(dest_keepalive_config[7] == '1') dest_keepalive_strict = 1;
		break;
	}
}

var redial = new webGrid();

var sim1Options;
var sim2Options;

function simInit()
{
	sim1Options = document.getElementById("_wan1_sim1_profile");
	sim2Options = document.getElementById("_wan1_sim2_profile");

	sim1Options.options.length = 0;
	sim2Options.options.length = 1;

	var mprofiles = cellular1_config.profiles;
	for(var i = 0; i < mprofiles.length; i++) {
		sim1Options.options[i] = new Option(mprofiles[i][0], mprofiles[i][0]);
		sim2Options.options[i+1] = new Option(mprofiles[i][0], mprofiles[i][0]);
		if(mprofiles[i][0] == cellular1_config.sim1_profile)
			sim1Options.options[i].selected = "selected";
		if(mprofiles[i][0] == cellular1_config.sim2_profile)
			sim2Options.options[i+1].selected = "selected";
	}
}

function display_disable_redial(e)
{	
	var x = e?"":"none";
	
	E('redial-grid').style.display = x;
	E('redial_title').style.display = x;
	E('redial_body').style.display = x;
	
	E('redial_body').disabled = !e;
	E('redial_title').disabled = !e;
	E('redial-grid').disabled = !e;

	return 1;
}

redial.exist = function(f, v)
{
	var data = this.getAllData();
	for (var i = 0; i < data.length; ++i) {
		if (data[i][f] == v) return true;
	}
	return false;
}

redial.existIndex = function(index)
{
	return this.exist(0, index);
}

redial.dataToView = function(data) 
{
	var auth;
	if(data[4] == '0')
		auth = ui.auto;
	else if(data[4] == '1')
		auth = 'PAP';
	else if(data[4] == '2')
		auth = 'CHAP';
	else if(data[4] == '3')
		auth = 'MS-CHAP';
	else if(data[4] == '4')
		auth = 'MS-CHAPv2';
	
	return [data[0],
		(data[1] == '1') ? 'GSM' : 'CDMA', 
		data[2],
		data[3],
		auth,	//data[4]
		data[5],
		data[6]==''? '':'******'];
}

redial.fieldValuesToData = function(row) 
{
	var f = fields.getAll(row);
	return [f[0].value, f[1].value, f[2].value, f[3].value, f[4].value, f[5].value, f[6].value];
}

redial.onDataChanged = function() 
{
	var data = redial.getAllData();
	
	sim1Options.options.length = 0;
	sim2Options.options.length = 1;
	
	for(var i = 0; i < data.length; i++) {
		sim1Options.options[i] = new Option(data[i][0], data[i][0]);
		sim2Options.options[i+1] = new Option(data[i][0], data[i][0]);
		if(data[i][0] == cellular1_config.sim1_profile)
			sim1Options.options[i].selected = "selected";
		if(data[i][0] == cellular1_config.sim2_profile)
			sim2Options.options[i+1].selected = "selected";
	}
	verifyFields(null, 1);
}

redial.verifyDelete = function(data) 
{
	var mydata = redial.getAllData();

	//TODO:check if the profiles index in the sim options
	
	for(var i = 0; i < mydata.length; i++) {
		sim1Options.options[i] = new Option(mydata[i][0], mydata[i][0]);
		sim2Options.options[i+1] = new Option(mydata[i][0], mydata[i][0]);
	}	
	
	return true;
}

redial.verifyFields = function(row, quiet)
{
	var f = fields.getAll(row);

	f[2].disabled = (f[1].value == '2');	//f[1]:network type

	if(!v_info_num_range(f[0], quiet, false, 1, 10)) return 0;
	if(this.existIndex(f[0].value)) {
		ferror.set(f[0], errmsg.bad_name4, quiet);
		return 0;
	}

	if(f[1].value == '1') {
		if(!v_length(f[2], quiet, 1, 31))
			return 0;
	}
	if(!v_length(f[3], quiet, 1, 16))
		return 0;

	return 1;
}

redial.resetNewEditor = function() {
	var f = fields.getAll(this.newEditor);

	ferror.clearAll(f);

	f[0].value = '';
	f[1].value = '1';
	f[2].value = '';
	f[3].value = '';
	f[4].value = '0';
	f[5].value = '';
	f[6].value = '';
}

redial.setup = function() 
{
	this.init('redial-grid', 'move', 10, [
		{ type: 'text', maxlen:8},
		{ type: 'select', options:[
			['1','GSM'],
			['2','CDMA']]},
		{ type: 'text', maxlen:32},
		{ type: 'text', maxlen:15},
		{ type: 'select', options:modem_authentication_list},
		{ type: 'text', maxlen:32},
		{ type: 'password', maxlen:32}
	]);
	this.headerSet([rmon.index, ui.network, 'APN', ui.callno, ui.wl_auth, ui.username, ui.password]);
	for (var i = 0; i < cellular1_config.profiles.length; i++)
			this.insertData(-1, [cellular1_config.profiles[i][0],
							cellular1_config.profiles[i][1],
							cellular1_config.profiles[i][2],
							cellular1_config.profiles[i][3],
							cellular1_config.profiles[i][4],
							cellular1_config.profiles[i][5],
							cellular1_config.profiles[i][6]
							]);
	this.showNewEditor();
	this.resetNewEditor();
}

var provider_list=[];
var i;

provider_list.push(['', ui.custom]);
for(i=0; i<provider_data_list.length; i++)
{
	provider_list.push([ provider_data_list[i][0],provider_data_list[i][0]]);
}

var network_list=[];
network_list.push(['', ui.custom]);

for(i=0; i<network_type_list.length; i++)
{
	network_list.push([ network_type_list[i],network_type_list[i]]);
}

function verifyFields(focused, quiet)
{

	var i;
	var ok = 1;
	var cmd = "";
	var fom = E('_fom');
	sim1Options = document.getElementById("_wan1_sim1_profile");
	sim2Options = document.getElementById("_wan1_sim2_profile");	
	
	E('save-button').disabled = true;

	// --- visibility ---	
	var enable = E('_f_wan1_enable').checked;
	var advanced = E('_f_advanced').checked;
	var mode = E('_wan1_ppp_mode').value;	
	var statc = E('_f_wan1_ppp_static').checked;
	var dualsim = E('_f_wan1_dualsim_enable').checked;
	var keepalive_strict = E('_f_wan1_keepalive_strict').checked;
	
	var dial_interval = E('_wan1_ppp_redial_interval').value;
	var sim1_profile = E('_wan1_sim1_profile').value;
	var sim2_profile = E('_wan1_sim2_profile').value;
	var network_type = E('_wan1_ppp_network_select').value;
	var trig_data = E('_f_wan1_trig_data').checked?'1':'0';
	var trig_sms = E('_f_wan1_trig_sms').checked?'1':'0';
	var ppp_idletime = E('_wan1_ppp_idletime').value;
	var ppp_ip = E('_wan1_ppp_ip').value;
	var ppp_peer = E('_wan1_ppp_peer').value;
	var ppp_timeout = E('_wan1_ppp_timeout').value;
	var mtu = E('_wan1_mtu').value;
	var mru = E('_wan1_ppp_mru').value;
	var peerdns = E('_f_wan1_ppp_peerdns').checked;
	var check_interval = E('_wan1_ppp_check_interval').value;
	var check_retries = E('_wan1_ppp_check_retries').value;
	var sim1_roaming = E('_wan1_sim1_roaming').checked;
	var sim2_roaming = E('_wan1_sim2_roaming').checked;
	var keepalive_server1 = E('_wan1_keepalive_server1').value;
	var keepalive_server2 = E('_wan1_keepalive_server2').value;
	var keepalive_interval = E('_wan1_keepalive_interval').value;
	var keepalive_timeout = E('_wan1_keepalive_timeout').value;
	var keepalive_retries = E('_wan1_keepalive_retries').value;
	var dualsim_main = E('_wan1_dualsim_main').value;
	var dualsim_redial = E('_wan1_dualsim_redial').value;
	var dualsim_uptime = E('_wan1_dualsim_uptime').value;
	var dualsim_sim1_csq = E('_wan1_sim1_csq_value').value;
	var dualsim_sim2_csq = E('_wan1_sim2_csq_value').value;
	var dualsim_sim1_csq_interval = E('_wan1_sim1_csq_interval').value;
	var dualsim_sim2_csq_interval = E('_wan1_sim2_csq_interval').value;
	var dualsim_sim1_csq_retries = E('_wan1_sim1_csq_retries').value;
	var dualsim_sim2_csq_retries = E('_wan1_sim2_csq_retries').value;
	var dualsim_backtime = E('_wan1_dualsim_backtime').value;
	var sim1_pin = E('_wan1_sim1_pin').value;	
	var sim2_pin = E('_wan1_sim2_pin').value;	
	var rssi_interval = E('_wan1_rssi_interval').value;
	var ppp_init = E('_wan1_ppp_init').value;
	var ppp_am = E('_f_wan1_ppp_am').checked;
	var ppp_debug = E('_f_wan1_debug').checked;
	var ppp_options = E('_wan1_ppp_options').value;
	var activate_enable = E('_f_wan1_activate_enable').checked;
	var activate_no = E('_f_wan1_activate_number').value;

	
	elem.display_and_enable(('_wan1_ppp_network_select'), ("wan1_sim1"), ("wan1_sim2"), ('_wan1_sim1_roaming'), 
					('_wan1_sim2_roaming'), ('_f_wan1_ppp_static'), ('_wan1_ppp_mode'), ('_f_wan1_trig_data'), 
					('_f_wan1_trig_sms'), ('_wan1_ppp_idletime'), ('_wan1_ppp_redial_interval'), 
					('_f_advanced'), ('_wan1_sim1_profile'), ('_wan1_sim2_profile'), 
					('_wan1_keepalive_server1'), ('_wan1_keepalive_server2'), ('_wan1_keepalive_interval'), ('_wan1_keepalive_timeout'),
					('_wan1_keepalive_retries'), ('_wan1_sim1_pin'), ('_wan1_sim2_pin'), ('_f_wan1_keepalive_strict'),
					enable);			
					

	elem.display_and_enable(('_wan1_ppp_ip'), ('_wan1_ppp_peer'), statc && enable);

	elem.display_and_enable(('_wan1_ppp_init'), ('_wan1_rssi_interval'), ('_wan1_ppp_timeout'), ('_wan1_mtu'), 
					('_wan1_ppp_mru'), ('_f_wan1_ppp_peerdns'), 
					('_wan1_ppp_check_interval'), ('_wan1_ppp_check_retries'), 
					('_f_wan1_dualsim_enable'), ('_f_wan1_ppp_am'), 
					('_f_wan1_debug'), ('_wan1_ppp_options'),
					enable&advanced);
					
	elem.display_and_enable(('_wan1_ppp_idletime'), ('_f_wan1_trig_data'), ('_f_wan1_trig_sms'), 
					(mode==1 && enable));
	elem.display_and_enable(('_wan1_ppp_redial_interval'), (mode!=2 && enable));
	
	elem.display_and_enable(('_wan1_dualsim_main'), ('_wan1_dualsim_redial'), ('_wan1_dualsim_uptime'), ('_wan1_sim1_csq_value'),
					('_wan1_sim2_csq_value'),('_wan1_sim1_csq_interval'),('_wan1_sim2_csq_interval'),('_wan1_sim1_csq_retries'),
					('_wan1_sim2_csq_retries'), ('_wan1_dualsim_backtime'), 
					(advanced && dualsim && enable));
	
	if(ih_sysinfo.product_number.indexOf("VS08") ==-1){
		elem.display_and_enable(('_f_wan1_activate_number'), ('_f_wan1_activate_enable'),0);
	}else {
		elem.display_and_enable(('_f_wan1_activate_enable'), ('_f_wan1_activate_number'),enable);
		if(cellular1_config.phone_number){
			elem.display_and_enable(('_f_wan1_activate_number'), ('_f_wan1_activate_enable'), 0);
		}else {
			if(activate_enable){
				elem.display_and_enable(('_f_wan1_activate_number'), enable);
			}else {
				elem.display_and_enable(('_f_wan1_activate_number'), 0);
			}
		}
	}

	if((dualsim_sim1_csq == '0')||(dualsim_sim1_csq == '')){
		E('_wan1_sim1_csq_interval').disabled = 1;	
		E('_wan1_sim1_csq_retries').disabled = 1;	
	}
	if((dualsim_sim2_csq == '0')||(dualsim_sim2_csq == '')){
		E('_wan1_sim2_csq_interval').disabled = 1;	
		E('_wan1_sim2_csq_retries').disabled = 1;	
	}
	if(!enable) {

		display_disable_redial(0);
		if(cellular1_config.enable) {
			cmd += "!\n";
			cmd += "interface cellular 1\n";
			cmd += "shutdown\n";
		}

	} else {
		var data_found = 0;
		var data_changed = 0;

		display_disable_redial(1);
		
		if(advanced) {
			cookie.set('cellular_advanced', 1);
		} else {
			cookie.set('cellular_advanced', 0);
		}

		if(!cellular1_config.enable) {
			cmd += "!\n";
			cmd += "interface cellular 1\n";
			cmd += "no shutdown\n";
		}
		//cancel profile apply  
		if((sim1_profile != cellular1_config.sim1_profile) || (sim2_profile != cellular1_config.sim2_profile)) {
			cmd += "!\n";
			cmd += "interface cellular 1\n";
			if(sim1_profile != cellular1_config.sim1_profile
				&& cellular1_config.sim1_profile != 0){
				cmd += "no dialer profile " + cellular1_config.sim1_profile + "\n";
			}
			if(sim2_profile != cellular1_config.sim2_profile
				&& cellular1_config.sim2_profile != 0){
				cmd += "no dialer profile " + cellular1_config.sim2_profile + " secondary" + "\n";
			}
		}
		
		//verify for the redial grid
		var datap = redial.getAllData();
		var mprofiles = cellular1_config.profiles;

		//delete the profile from json which have been deleted from web
		for(var i = 0; i < mprofiles.length; i++) {
			data_found = 0;
			data_changed = 0;
			for(var j = 0; j < datap.length; j++) {
				if(mprofiles[i][0] == datap[j][0]) {	//profile index
					data_found = 1;
					break;
				}
			}
			if(!data_found) {
				cmd += "!\n";
				if(mprofiles[i][1] == '1')	//gsm
					cmd += "no cellular 1 gsm profile " + mprofiles[i][0] + "\n";
				else if(mprofiles[i][1] == '2')	//cdma
					cmd += "no cellular 1 cdma profile " + mprofiles[i][0] + "\n";
			}
		}

		//check if change or add
		//add the profile into json which have been added by the web
		for(var i = 0; i < datap.length; i++) {
			var auth;
			data_found = 0;
			data_changed = 0;

			if(datap[i][4] == '0')
				auth = 'auto';
			else if(datap[i][4] == '1')
				auth = 'pap';
			else if(datap[i][4] == '2')
				auth = 'chap';
			else if(datap[i][4] == '3')
				auth = 'ms-chap';
			else if(datap[i][4] == '4')
				auth = 'ms-chapv2';

			for(var j = 0; j < mprofiles.length; j++) {
				if(datap[i][0] == mprofiles[j][0]) {	//profile index
					data_found = 1;
					if((datap[i][1] != mprofiles[j][1]) ||
						(datap[i][2] != mprofiles[j][2]) ||
						(datap[i][3] != mprofiles[j][3]) ||
						(datap[i][4] != mprofiles[j][4]) ||
						(datap[i][5] != mprofiles[j][5]) ||
						(datap[i][6] != mprofiles[j][6])) {
						data_changed = 1;	
					}
					break;
				}
			}
			if(!data_found || data_changed) {
				cmd += "!\n";
				if(datap[i][1] == '1') {	//gsm
					if((datap[i][5] == "") || (datap[i][6] == "")) {
						cmd += "cellular 1 gsm profile " + datap[i][0] + " " + datap[i][2] + " " +
								datap[i][3] + " " + auth + "\n";
					} else {
						cmd += "cellular 1 gsm profile " + datap[i][0] + " " + datap[i][2] + " " +
								datap[i][3] + " " + auth + " " + datap[i][5] + " " + datap[i][6] + "\n";
					}
				} else if(datap[i][1] == '2') {	//cdma
					cmd += "cellular 1 cdma profile " + datap[i][0] + " " + datap[i][3] + " " +
							auth + " " + datap[i][5] + " " + datap[i][6] + "\n";
				}
			}
		}
		
		if(dualsim){
			if(sim2_profile == 0){
				dualsim_flag = 1;
				sim2Options.options[1].selected = "selected";
				sim2_profile = 1;
			}
			if(dualsim != cellular1_config.dualsim_enable){
				cmd += "!\n";	
				cmd += "cellular 1 dual-sim enable\n";
			}
		}
		if(dualsim == 0){
			if(dualsim_flag == 1){
				dualsim_flag = 0;
				sim2_profile = cellular1_config.sim2_profile;
				sim2Options.options[sim2_profile].selected = "selected";
			}
			if(dualsim != cellular1_config.dualsim_enable){
				cmd += "!\n";
				cmd += "no cellular 1 dual-sim enable\n";
			}
		}
		if(dualsim_main != cellular1_config.main_sim){
			cmd += "!\n";
			if(dualsim_main == 3) cmd += "cellular 1 dual-sim main random\n"; 
			else if(dualsim_main == 4) cmd += "cellular 1 dual-sim main sequence\n"; 
			else cmd += "cellular 1 dual-sim main " + dualsim_main + "\n"; 
		}
		if(dualsim_redial != cellular1_config.dualsim_redial){
			if (!v_range('_wan1_dualsim_redial', quiet, 1, 10)){
				elem.display2(('_wan1_dualsim_redial'), 1);	
				return 0;
			}else{
				cmd += "!\n";
				cmd += "cellular 1 dual-sim policy redial " + dualsim_redial + "\n";
				ferror.clear('_wan1_dualsim_redial');
			}
		}else ferror.clear('_wan1_dualsim_redial');
		if(dualsim_uptime != cellular1_config.dualsim_uptime){
			if (!v_range('_wan1_dualsim_uptime', quiet, 0, 8640000)){
				elem.display2(('_wan1_dualsim_uptime'), 1);	
				return 0;
			}else{
				cmd += "!\n";
				if(dualsim_uptime=='0') {
					cmd += "no cellular 1 dual-sim policy uptime\n";
				} else {
					cmd += "cellular 1 dual-sim policy uptime " + dualsim_uptime + "\n";
				}
				ferror.clear('_wan1_dualsim_uptime');
			}
		}else ferror.clear('_wan1_dualsim_uptime');
		
		ferror.clear('_wan1_sim1_csq_value');	
		ferror.clear('_wan1_sim2_csq_value');	
		ferror.clear('_wan1_sim1_csq_interval');	
		ferror.clear('_wan1_sim2_csq_interval');	
		ferror.clear('_wan1_sim1_csq_retries');	
		ferror.clear('_wan1_sim2_csq_retries');
		if((dualsim_sim1_csq != cellular1_config.dualsim_csq1)||
			(dualsim_sim1_csq_interval != cellular1_config.dualsim_csq_interval1)||
			(dualsim_sim1_csq_retries != cellular1_config.dualsim_csq_retries1)){
			if (!v_range('_wan1_sim1_csq_value', quiet, 0, 31)){
				elem.display(PR('_wan1_sim1_csq_value'), 1);	
				return 0;
			}else if (!v_range('_wan1_sim1_csq_interval', quiet, 0, 86400)){
				elem.display(PR('_wan1_sim1_csq_interval'), 1);	
				return 0;
			}else if (!v_range('_wan1_sim1_csq_retries', quiet, 0, 100)){
				elem.display(PR('_wan1_sim1_csq_retries'), 1);	
				return 0;
			}else{
				cmd += "!\n";
				if((dualsim_sim1_csq == '0')||(dualsim_sim1_csq == '')) cmd += "no cellular 1 dual-sim policy csq\n";
				else cmd += "cellular 1 dual-sim policy csq " + dualsim_sim1_csq + " interval " + dualsim_sim1_csq_interval + " retries " + dualsim_sim1_csq_retries + "\n";
			}
		}
		if((dualsim_sim2_csq != cellular1_config.dualsim_csq2)||
			(dualsim_sim2_csq_interval != cellular1_config.dualsim_csq_interval2)||
			(dualsim_sim2_csq_retries != cellular1_config.dualsim_csq_retries2)){
			if (!v_range('_wan1_sim2_csq_value', quiet, 0, 31)){
				elem.display(PR('_wan1_sim2_csq_value'), 1);	
				return 0;
			}else if (!v_range('_wan1_sim2_csq_interval', quiet, 0, 86400)){
				elem.display(PR('_wan1_sim2_csq_interval'), 1);	
				return 0;
			}else if (!v_range('_wan1_sim2_csq_retries', quiet, 0, 100)){
				elem.display(PR('_wan1_sim2_csq_retries'), 1);	
				return 0;
			}else{
				cmd += "!\n";
				if((dualsim_sim2_csq == '0')||(dualsim_sim2_csq == '')) cmd += "no cellular 1 dual-sim policy csq secondary\n";
				else cmd += "cellular 1 dual-sim policy csq " + dualsim_sim2_csq + " interval " + dualsim_sim2_csq_interval + " retries " + dualsim_sim2_csq_retries + " secondary"+"\n";
			}
		}

		if (dualsim_backtime != '0'){
			if (!v_info_num_range('_wan1_dualsim_backtime', quiet, true, 30, 8640000)) return 0;
			if (E('_wan1_dualsim_backtime').value == '') {
				E('_wan1_dualsim_backtime').value = '0';
				dualsim_backtime = E('_wan1_dualsim_backtime').value;
			}
		}
		if(dualsim_backtime != cellular1_config.dualsim_time){
			if(dualsim_backtime == '0'){ 
				cmd += "!\n";
				cmd += "no cellular 1 dual-sim policy backtime\n";
			}else{
					cmd += "!\n";
					cmd += "cellular 1 dual-sim policy backtime " + dualsim_backtime + "\n";
			}
		}
		
		if((sim1_roaming != cellular1_config.sim1_roaming) || (sim2_roaming != cellular1_config.sim2_roaming)){
			cmd += "!\n";
			if(sim1_roaming != cellular1_config.sim1_roaming){
				if(sim1_roaming == 0) cmd += "cellular 1 sim 1 roaming forbid\n";
				else cmd += "no cellular 1 sim 1 roaming forbid\n";
			}
			if(sim2_roaming != cellular1_config.sim2_roaming){
				if(sim2_roaming == 0) cmd += "cellular 1 sim 2 roaming forbid\n";
				else cmd += "no cellular 1 sim 2 roaming forbid\n"
			}
		}

		if((sim1_profile != cellular1_config.sim1_profile) || (sim2_profile != cellular1_config.sim2_profile)) {
			cmd += "!\n";
			cmd += "interface cellular 1\n";
			if(sim1_profile != cellular1_config.sim1_profile){
				if(sim1_profile != 0) cmd += "dialer profile " + sim1_profile + "\n";
			}
			if(sim2_profile != cellular1_config.sim2_profile){
				if(sim2_profile != 0) cmd += "dialer profile " + sim2_profile + " secondary " + "\n";
				//else cmd += "no dialer profile " + cellular1_config.sim2_profile + " secondary" + "\n";
			}
		}
		
		ferror.clear('_wan1_sim1_pin');
		ferror.clear('_wan1_sim2_pin');
		if((sim1_pin != cellular1_config.sim1_pincode) || (sim2_pin != cellular1_config.sim2_pincode)) {
			if(sim1_pin != cellular1_config.sim1_pincode){
				if((sim1_pin == "")||(sim1_pin == '0')){
					cmd += "!\n";
					cmd += "no cellular 1 sim 1 " + cellular1_config.sim1_pincode + " \n";
				}else{
					if (!v_length('_wan1_sim1_pin', quiet, 4, 8)){
						elem.display2(('_wan1_sim1_pin'), 1);
						return 0;
					}
					cmd += "!\n";
					cmd += "cellular 1 sim 1 " + sim1_pin + " \n";
				}
			}
			if(sim2_pin != cellular1_config.sim2_pincode){
				if((sim2_pin == "")||(sim2_pin == '0')){
					cmd += "!\n";
					cmd += "no cellular 1 sim 2 " + cellular1_config.sim2_pincode + " \n";
				}else{
					if (!v_length('_wan1_sim2_pin', quiet, 4, 8)){
						elem.display2(('_wan1_sim2_pin'), 1);
						return 0;
					}
					cmd += "!\n";
					cmd += "cellular 1 sim 2 " + sim2_pin + " \n";
				}
			}
		}
		
		if(keepalive_server1 != dest_keepalive_config[1]){
			cmd += "!\n";
			cmd += "interface cellular 1\n";
			if((keepalive_server1 == "")||(keepalive_server1 == '0')){
				if((keepalive_server2 == "")||(keepalive_server2 == '0'))
					cmd += "no keepalive\n";
				else{
					alert("error: Must delete secondary before deleting primary");
					return 0;
				}
			}
		}
		if(keepalive_server2 != dest_keepalive_config[6]){
			cmd += "!\n";
			cmd += "interface cellular 1\n";
			if((keepalive_server2 == "")||(keepalive_server2 == '0')){
				cmd += "no keepalive icmp-echo " + dest_keepalive_config[6] + " secondary\n";
			}else{
				if((dest_keepalive_config[6] != '')&&(dest_keepalive_config[6] != '0')){
					cmd += "no keepalive icmp-echo " + dest_keepalive_config[6] + " secondary\n";
				}
				cmd += "keepalive icmp-echo " + keepalive_server2 + " secondary\n";
			}
		}
		if(keepalive_strict != dest_keepalive_strict){
			cmd += "!\n";
			cmd += "interface cellular 1\n";
			if(keepalive_strict) cmd += "keepalive icmp-echo strict\n";
			else cmd += "no keepalive icmp-echo strict\n"
		}
		ferror.clear('_wan1_keepalive_interval');
		ferror.clear('_wan1_keepalive_timeout');
		ferror.clear('_wan1_keepalive_retries');
		if((keepalive_server1 != dest_keepalive_config[1]) ||
			(keepalive_interval != dest_keepalive_config[2]) ||
			(keepalive_timeout != dest_keepalive_config[3]) ||
			(keepalive_retries != dest_keepalive_config[4])){
			cmd += "!\n";
			cmd += "interface cellular 1\n";
			if((keepalive_server1 != "")&&(keepalive_server1 != '0'))
				cmd += "keepalive icmp-echo " + keepalive_server1;
			if (!v_range('_wan1_keepalive_interval', quiet, 1, 604800)){
				elem.display2(('_wan1_keepalive_interval'), 1);	
				return 0;
			}else{
				if((keepalive_server1 != "")&&(keepalive_server1 != '0'))
					cmd += " interval " + keepalive_interval;
				ferror.clear('_wan1_keepalive_interval');
			}
			if (!v_range('_wan1_keepalive_timeout', quiet, 1, 604800)){
				elem.display2(('_wan1_keepalive_timeout'), 1);	
				return 0;
			}else{
				if((keepalive_server1 != "")&&(keepalive_server1 != '0'))
					cmd += " timeout " + keepalive_timeout; 
				ferror.clear('_wan1_keepalive_timeout');
			}
			if (!v_range('_wan1_keepalive_retries', quiet, 1, 1000)){
				elem.display2(('_wan1_keepalive_retries'), 1);	
				return 0;
			}else{
				if((keepalive_server1 != "")&&(keepalive_server1 != '0'))
					cmd += " retry " + keepalive_retries + "\n"
				ferror.clear('_wan1_keepalive_retries');
			}
			
		}
		if(network_type != cellular1_config.network_type) {
			var tmp;
			if(network_type == 0) 
				tmp = 'auto';
			else if(network_type == 1)
				tmp = '2g';
			else if(network_type == 2)
				tmp = '3g';
			else if(network_type == 3)
				tmp = '4g';
			cmd += "!\n";
			cmd += "cellular 1 network " + tmp + "\n";
		}
	
		if(dial_interval != cellular1_config.dial_interval) {
			if(!v_range('_wan1_ppp_redial_interval', quiet, 0, 3600)){
				elem.display2(('_wan1_ppp_redial_interval'), 1);	
				return 0;
			}else{
				cmd += "!\n";
				cmd += "cellular 1 dial interval " + dial_interval + "\n";
				ferror.clear('_wan1_ppp_redial_interval');
			}
		}else ferror.clear('_wan1_ppp_redial_interval');
		
		ferror.clear('_wan1_ppp_ip');
		ferror.clear('_wan1_ppp_peer');
		if(statc == 0){
			if(statc != cellular1_config.ppp_static) {
				cmd += "!" + "\n";
				cmd += "interface cellular 1\n";
				cmd += "ip address negotiated" + "\n";
			}
		}else{
			if((ppp_ip != cellular1_config.ppp_ip)||(ppp_peer != cellular1_config.ppp_peer)){
				if(ppp_ip != ""){
					if(!v_ip('_wan1_ppp_ip', quiet)) {
						ferror.set('_wan1_ppp_ip', errmsg.ip, quiet);
						return 0;
					}else{
						cmd += "!" + "\n";
						cmd += "interface cellular 1\n";
						cmd += "ip address static local " + ppp_ip + "\n";
					}
				}else{
					cmd += "!" + "\n";
					cmd += "interface cellular 1\n";
					cmd += "no ip address static local\n";
				}
				if(ppp_peer != ""){
					if(!v_ip('_wan1_ppp_peer', quiet)) {
						ferror.set('_wan1_ppp_peer', errmsg.ip, quiet);
						return 0;
					}else{
						cmd += "!" + "\n";
						cmd += "interface cellular 1\n";
						cmd += "ip address static peer " + ppp_peer + "\n";
					}
				}else{
					cmd += "!" + "\n";
					cmd += "interface cellular 1\n";
					cmd += "no ip address static peer\n";
				}
			}
		}

		if(mode==1){
			if(!E('_f_wan1_trig_data').checked && !E('_f_wan1_trig_sms').checked){
				alert(infomsg.trig);
				//E('_f_wan1_trig_data').checked = 1;
				return 0;
			}
		}
		if((mode != cellular1_config.ppp_mode)
			|| (cellular1_config.trig_data != trig_data)
			|| (cellular1_config.trig_sms != trig_sms)
			|| (cellular1_config.ppp_idle != ppp_idletime)) {
			cmd += "!\n";
			cmd += "interface cellular 1\n";
			if(mode == 0) {
				cmd += "dialer activate auto\n";
			} else if(mode == 1) {
				
				if (cellular1_config.trig_data != trig_data){
					cmd += (trig_data=='1'?"":"no ") + "dialer activate traffic\n";
				}
				if (cellular1_config.trig_sms != trig_sms){
					cmd += (trig_sms=='1'?"":"no ") + "dialer activate sms\n";
				}
				if (ppp_idletime == '')
					cmd += "no dialer idle-timeout\n";
				else
					cmd += "dialer idle-timeout " + ppp_idletime+ "\n";
			} else {
				cmd += "dialer activate manual\n";
			}	
		}	

		if(ppp_timeout != cellular1_config.ppp_timeout) {
			if (!v_range('_wan1_ppp_timeout', quiet, 10, 3600)){
				elem.display2(('_wan1_ppp_timeout'), 1);	
				return 0;
			} else {
				cmd += "!\n";
				cmd += "interface cellular 1\n";
				cmd += "dialer timeout " + ppp_timeout + "\n";
				ferror.clear('_wan1_ppp_timeout');	
			}
		}else ferror.clear('_wan1_ppp_timeout');

		if(mtu != cellular1_config.mtu) {
			if (!v_range('_wan1_mtu', quiet, 128, 1500)) {
				elem.display(PR('_wan1_mtu'), 1);
				return 0;
			} else {
				cmd += "!\n";
				cmd += "interface cellular 1\n";
				cmd += "ip mtu " + mtu + "\n";	
				ferror.clear('_wan1_mtu');	
			}
		}else ferror.clear('_wan1_mtu');	
	
		if(mru != cellular1_config.mru) {
			if (!v_range('_wan1_ppp_mru', quiet, 128, 1500)){
				elem.display(PR('_wan1_ppp_mru'), 1);	
				return 0;
			} else {
				cmd += "!\n";
				cmd += "interface cellular 1\n";
				cmd += "ip mru " + mru + "\n";
				ferror.clear('_wan1_ppp_mru');
			}
		}else ferror.clear('_wan1_ppp_mru');

		if(peerdns != cellular1_config.peerdns) {
			cmd += "!\n";
			cmd += "interface cellular 1\n";
			if(cellular1_config.peerdns == 1) {
				cmd += "no ppp ipcp dns request\n";
			} else {
				cmd += "ppp ipcp dns request\n";
			}
		}

		ferror.clear('_wan1_ppp_check_interval');
		ferror.clear('_wan1_ppp_check_retries');
		if((check_interval != cellular1_config.ppp_lcp_interval) ||
			(check_retries != cellular1_config.ppp_lcp_retries)) {
			if (!v_range('_wan1_ppp_check_interval', quiet, 0, 640800)){
				elem.display2(('_wan1_ppp_check_interval'), 1);	
				return 0;
			}
			if(check_interval == 0){
				cmd += "!\n";
				cmd += "interface cellular 1\n";
				cmd += "no ppp keepalive\n";
			}else{
				if (!v_range('_wan1_ppp_check_retries', quiet, 0, 100)){
					elem.display2(('_wan1_ppp_check_retries'), 1);	
					return 0;
				}
				cmd += "!\n";
				cmd += "interface cellular 1\n";
				cmd += "ppp keepalive " + check_interval + " " + check_retries + "\n";
			}
		}

		ferror.clear('_wan1_rssi_interval');
		if(rssi_interval != cellular1_config.signal_interval){
			if (!v_range('_wan1_rssi_interval', quiet, 0, 3600)){
				elem.display2(('_wan1_rssi_interval'), 1);	
				return 0;
			}else{
				cmd += "!\n";
				cmd += "cellular 1 signal interval " + rssi_interval + "\n";
			}
		}

		ferror.clear('_wan1_ppp_init');
		if(ppp_init != cellular1_config.ppp_init){
			cmd += "!\n";
			cmd += "interface cellular 1\n";
			if(ppp_init!=''){
				cmd += "ppp initial string " + ppp_init + "\n";
			} else {
				cmd += "no ppp initial string\n";
			}
			cmd += "!\n";
		}
		if(ppp_am != cellular1_config.ppp_am){
			cmd += "!\n";
			cmd += "interface cellular 1\n";
			if(ppp_am=='1'){
				cmd += "ppp accm default\n";
			} else {
				cmd += "no ppp accm default\n";
			}
			cmd += "!\n";
		}
		if(ppp_debug != cellular1_config.ppp_debug){
			cmd += "!\n";
			cmd += "interface cellular 1\n";
			if(ppp_debug=='1'){
				cmd += "ppp debug\n";
			} else {
				cmd += "no ppp debug\n";
			}
			cmd += "!\n";
		}
		ferror.clear('_wan1_ppp_options');
		if(ppp_options != cellular1_config.ppp_options){
			cmd += "!\n";
			cmd += "interface cellular 1\n";
			if(ppp_options!=''){
				cmd += "ppp options \"" + ppp_options + "\"\n";
			} else {
				cmd += "no ppp options\n";
			}
			cmd += "!\n";
		}
		if(activate_enable != cellular1_config.activate_enable ){
			if(activate_enable){
				cmd += "!\n";
				cmd += "cellular 1 activation enable\n";
				cmd += "!\n";
			}else {
				cmd += "!\n";
				cmd += "no cellular 1 activation\n";
				cmd += "!\n";
			}
		}
		if(activate_enable && activate_no && activate_no != cellular1_config.activate_number){
			cmd += "!\n";
			cmd += "cellular 1 activate-module " + activate_no + "\n";
			cmd += "!\n";
		}
		//alert(cmd);
	}
	if (user_info.priv < admin_priv) {
		elem.display('save-button', 'cancel-button', false);
	}else{
		elem.display('save-button', 'cancel-button', true);
		fom._web_cmd.value = cmd;
		E('save-button').disabled = (cmd=="");	
	}

	return ok;
}

function earlyInit()
{
	simInit();
	if((cookie.get('cellular_advanced')) == null) {
		cookie.set('cellular_advanced', 0);
	}

	redial.setup();
	verifyFields(null, true);

}

function init()
{
	if((cookie.get('autosave')) == null){
		cookie.set('autosave', 1);
	}
}

function save()
{
	var i;

	if (!verifyFields(null, false)) return;
	
	var fom = E('_fom');
	var enable = E('_f_wan1_enable').checked;

	if((E('_fom')._web_cmd.value != '')&&(cookie.get('autosave') == 1)){
		E('_fom')._web_cmd.value += "!"+"\n"+"copy running-config startup-config"+"\n";	
	}

	form.submit(fom, 1);
}

</script>

</head>
<body>
<form id='_fom' method='post' action='apply.cgi'>
<input type='hidden' name='_web_cmd' value=''>


<div class='section'>
<script type='text/javascript'>

createFieldTable('', [
	{ title: ui.enable, name: 'f_wan1_enable', type: 'checkbox', value: cellular1_config.enable=='1'},
	{ title: ui.activate_enable, name: 'f_wan1_activate_enable', type: 'checkbox', value: cellular1_config.activate_enable=='1'},
	{ title: ui.activate_number, indent: 2, name: 'f_wan1_activate_number', type: 'text', maxlen: 16, size: 18, value: cellular1_config.activate_number},	
	{ title: "", multi: [
		{ custom: '<span id="wan1_sim1">SIM1 &emsp;&emsp;&ensp;&thinsp;</span>'},
		{ custom: '<span id="wan1_sim2">SIM2 </span>'} ]},
	{ title: ui.profile, multi: [
		{ name: 'wan1_sim1_profile', type:'select', attrib: 'style="width:70px;"', options:[], value:cellular1_config.sim1_profile, suffix: '&thinsp;'},
		{ name: 'wan1_sim2_profile', type:'select', attrib: 'style="width:70px;"', options:[['0',' ']], value:cellular1_config.sim2_profile } ]},
	{ title: ui.roam, multi: [
		{ name: 'wan1_sim1_roaming', type:'checkbox', value: cellular1_config.sim1_roaming, suffix: '&emsp;&emsp;&emsp;&emsp;&thinsp;'},
		{ name: 'wan1_sim2_roaming', type:'checkbox', value: cellular1_config.sim2_roaming } ]},
	{ title: "PIN Code", multi: [
		{ name: 'wan1_sim1_pin', type:'text', maxlen: 8, size: 8, value: cellular1_config.sim1_pincode},
		{ name: 'wan1_sim2_pin', type:'text', maxlen: 8, size: 8, value: cellular1_config.sim2_pincode} ]},
	{ title: ui.networksel_type, name: 'wan1_ppp_network_select', type: 'select', options: modem_networksel_list,
		value: cellular1_config.network_type},
	{ title: ui.statc, name: 'f_wan1_ppp_static', type: 'checkbox', value: cellular1_config.ppp_static=='1'},
	{ title: ui.ip, indent: 2, name: 'wan1_ppp_ip', type: 'text', maxlen: 15, size: 17, value: cellular1_config.ppp_ip },
	{ title: ui.peer, indent: 2, name: 'wan1_ppp_peer', type: 'text', maxlen: 15, size: 17, value: cellular1_config.ppp_peer },
	{ title: ui.conn_mode, name: 'wan1_ppp_mode', type: 'select', options: [['0', ui.keep_online],['1', ui.demand],['2', ui.manual_dial]],
		value: cellular1_config.ppp_mode },
	{ title: ui.trig_data, indent: 2, name: 'f_wan1_trig_data', type: 'checkbox', value: cellular1_config.trig_data=='1'},
	{ title: ui.trig_sms, indent: 2, name: 'f_wan1_trig_sms', type: 'checkbox', value: cellular1_config.trig_sms=='1'},
//	{ title: ui.sms_up, indent: 2, name: 'wan1_sms_up', type: 'text', maxlen: 128, size: 17, suffix:' '+infomsg.sms_fmt, value: redial_config.wan1_sms_up },
//	{ title: ui.sms_down, indent: 2, name: 'wan1_sms_down', type: 'text', maxlen: 128, size: 17, suffix:' '+infomsg.sms_fmt, value: redial_config.wan1_sms_down },
	{ title: ui.max_idle, indent: 2, name: 'wan1_ppp_idletime', type: 'text', maxlen: 5, size: 7, suffix: ui.seconds,
		value: cellular1_config.ppp_idle },
	{ title: ui.redial_interval, indent: 0, name: 'wan1_ppp_redial_interval', type: 'text', maxlen: 5, size: 7, suffix: ui.seconds, value: cellular1_config.dial_interval },
	{ title: ui.icmp_host, name: 'wan1_keepalive_server1', type:'text', maxlen:64, size:17, value: dest_keepalive_config[1] },
	{ title: "", name: 'wan1_keepalive_server2', type:'text', maxlen:64, size:17, value: dest_keepalive_config[6] }, 
	{ title: ui.icmp_interval, name: 'wan1_keepalive_interval', type: 'text', maxlen: 6, size: 7, suffix: ui.seconds, value: dest_keepalive_config[2], suffix: ui.seconds },
	{ title: ui.icmp_timeout, name: 'wan1_keepalive_timeout', type: 'text', maxlen: 6, size: 7, suffix: ui.seconds, value: dest_keepalive_config[3], suffix: ui.seconds },
	{ title: ui.icmp_retries, name: 'wan1_keepalive_retries', type: 'text', maxlen: 5, size: 7, value: dest_keepalive_config[4] },
	{ title: ui.icmp_strict, name: 'f_wan1_keepalive_strict', type: 'checkbox', value: dest_keepalive_strict },
	//{ title: ui.sim2, name: 'wan1_sim2', indent: 2, type:'select', options:[['0','Disable']], value:cellular1_config.sim2_profile }	]}
//	{ title: ui.icmp_host, indent: 2, name: 'wan1_icmp_host', type: 'text', maxlen: 64, size: 17, value: redial_config.wan1_icmp_host },
//	{ title: ui.icmp_interval, indent: 2, name: 'wan1_icmp_interval', type: 'text', maxlen: 5, size: 7, suffix: ui.seconds, value: redial_config.wan1_icmp_interval},
//	{ title: ui.icmp_timeout, indent: 2, name: 'wan1_icmp_timeout', type: 'text', maxlen: 5, size: 7, suffix: ui.seconds, value: redial_config.wan1_icmp_timeout },
//	{ title: ui.icmp_retries, indent: 2, name: 'wan1_icmp_retries', type: 'text', maxlen: 5, size: 7, value: redial_config.wan1_icmp_retries },
		
	{ title: '<b>' + ui.advanced + '</b>', indent: 0, name: 'f_advanced', type: 'checkbox', value: cookie.get('cellular_advanced')==1},
	{ title: ui.init, indent: 2, name: 'wan1_ppp_init', type: 'text', maxlen: 64, size: 64, value: cellular1_config.ppp_init },
//	{ title: ui.pincode, indent: 2, name: 'wan1_ppp_pincode', type: 'password', maxlen: 8, size: 8, value: redial_config.wan1_ppp_pincode },
	{ title: ui.rssi_time, indent: 2, name: 'wan1_rssi_interval', type: 'text', maxlen: 8, size: 6, suffix: ui.seconds, value: cellular1_config.signal_interval },
	{ title: ui.call_timeout, indent: 2, name: 'wan1_ppp_timeout', type: 'text', maxlen: 32, size: 6, suffix: ui.seconds, value: cellular1_config.ppp_timeout },
	{ title: ui.mtu, indent: 2, name: 'wan1_mtu', type: 'text', maxlen: 4, size: 6, value: cellular1_config.mtu },
	{ title: ui.mru, indent: 2, name: 'wan1_ppp_mru', type: 'text', maxlen: 4, size: 6, value: cellular1_config.mru },
//	{ title: ui.txql, indent: 2, name: 'wan1_ppp_txql', type: 'text', maxlen: 4, size: 6, value: redial_config.wan1_ppp_txql },
//	{ title: ui.ppp_iph_comp, indent: 2, name: 'f_wan1_ppp_iph_comp', type: 'checkbox', value: redial_config.wan1_ppp_iph_comp=='1'},
	{ title: ui.ppp_am, indent: 2, name: 'f_wan1_ppp_am', type: 'checkbox', value: cellular1_config.ppp_am=='1'},
	{ title: ui.peerdns, indent: 2, name: 'f_wan1_ppp_peerdns', type: 'checkbox', value: cellular1_config.peerdns=='1'},
	{ title: ui.check_interval, indent: 2, name: 'wan1_ppp_check_interval', type: 'text', maxlen: 6, size: 7, suffix: ui.seconds + infomsg.disable_msg,
		value: cellular1_config.ppp_lcp_interval },
	{ title: ui.check_retries, indent: 2, name: 'wan1_ppp_check_retries', type: 'text', maxlen: 3, size: 7, value: cellular1_config.ppp_lcp_retries },
	{ title: ui.dualsim, indent: 2, name: 'f_wan1_dualsim_enable', type: 'checkbox', value: cellular1_config.dualsim_enable },
	{ title: ui.dualsim_main, indent: 2, name: 'wan1_dualsim_main', type: 'select', options: [['1', 'SIM1'],['2','SIM2'],['3',ui.random],['4',ui.sequence]], value: cellular1_config.main_sim },
	{ title: ui.dualsim_redial, indent: 2, name: 'wan1_dualsim_redial', type: 'text', maxlen: 5, size: 7, value: cellular1_config.dualsim_redial},
	{ title: ui.dualsim_uptime, indent: 2, name: 'wan1_dualsim_uptime', type: 'text', maxlen: 5, size: 7, value: cellular1_config.dualsim_uptime, suffix: ui.seconds + infomsg.disable_msg},
//	{ title: ui.dualsim_csq, indent: 2, name: 'wan1_dualsim_csq', type: 'text', maxlen: 5, size: 7, value: cellular1_config.dualsim_csq, suffix: infomsg.disable_msg},
	{ title: ui.csq_threshold, indent: 2, multi: [
		{ name: 'wan1_sim1_csq_value', type:'text', maxlen: 8, size: 8, value: cellular1_config.dualsim_csq1},
		{ name: 'wan1_sim2_csq_value', type:'text', maxlen: 8, size: 8, value: cellular1_config.dualsim_csq2, suffix: infomsg.disable_msg} ]},
	{ title: ui.csq_interval, indent: 2, multi: [
		{ name: 'wan1_sim1_csq_interval', type:'text', maxlen: 8, size: 8, value: cellular1_config.dualsim_csq_interval1},
		{ name: 'wan1_sim2_csq_interval', type:'text', maxlen: 8, size: 8, value: cellular1_config.dualsim_csq_interval2, suffix: infomsg.disable_msg} ]},
	{ title: ui.csq_retries, indent: 2, multi: [
		{ name: 'wan1_sim1_csq_retries', type:'text', maxlen: 8, size: 8, value: cellular1_config.dualsim_csq_retries1},
		{ name: 'wan1_sim2_csq_retries', type:'text', maxlen: 8, size: 8, value: cellular1_config.dualsim_csq_retries2} ]},
	{ title: ui.dualsim_time, indent: 2, name: 'wan1_dualsim_backtime', type: 'text', maxlen: 7, size: 7, value: cellular1_config.dualsim_time, suffix: ui.seconds+infomsg.disable_msg},
	{ title: ui.debug, indent: 2, name: 'f_wan1_debug', type: 'checkbox', value: cellular1_config.ppp_debug=='1'},
	{ title: ui.expert, indent: 2, name: 'wan1_ppp_options', type: 'text', maxlen: 256, size: 64, value: cellular1_config.ppp_options }
]);
</script>
</div>

<div id='redial_title' class='section-title'>
<script type='text/javascript'>
	GetText(ui.profile);
</script>
</div>

<div id='redial_body' class='section'>
	<table class='web-grid' id='redial-grid'></table>
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
