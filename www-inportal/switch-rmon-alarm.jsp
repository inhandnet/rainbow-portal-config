<% pagehead(menu.switch_rmon_alarm) %>

<style type='text/css'>
#alarm_grid {
	width: 1130px;
	text-align: center;
}

</style>

<script type='text/javascript'>

<% ih_sysinfo() %>
<% ih_user_info(); %>

<% web_exec('show rmon statistics') %>
/*
statsCtrl_config=[
[1,[1,1,1],'zyb']
];
*/
<% web_exec('show rmon alarms') %>

//var alarm_config = [[1,2,3,4,5,1,7,2,9,10,11],[2,2,3,4,5,2,7,2,9,10,11]];


var tmp_old_config = [];
var sample_type = ['delta','absolute',''];

var rmon_statistics_oid_vector = ['1','3','6','1','2','1','16','1','1','1'];

var rmon_alarm_object_options =[
	['1.3.6.1.2.1.16.1.1.1.3', 'DropEvents'],
	['1.3.6.1.2.1.16.1.1.1.4', 'Octets'],
	['1.3.6.1.2.1.16.1.1.1.5', 'Pkts'],
	['1.3.6.1.2.1.16.1.1.1.6', 'BroadcastPkts'],
	['1.3.6.1.2.1.16.1.1.1.7', 'MulticastPkts'],
	['1.3.6.1.2.1.16.1.1.1.8', 'CRCAlignErrors'],
	['1.3.6.1.2.1.16.1.1.1.9', 'UndersizePkts'],
	['1.3.6.1.2.1.16.1.1.1.10', 'OversizePkts'],
	['1.3.6.1.2.1.16.1.1.1.11', 'Fragments'],
	['1.3.6.1.2.1.16.1.1.1.12', 'Jabbers'],
	['1.3.6.1.2.1.16.1.1.1.13', 'Collisions'],
	['1.3.6.1.2.1.16.1.1.1.14', 'Pkts64Octets'],
	['1.3.6.1.2.1.16.1.1.1.15', 'Pkts65to127Octets'],
	['1.3.6.1.2.1.16.1.1.1.16', 'Pkts128to255Octets'],
	['1.3.6.1.2.1.16.1.1.1.17', 'Pkts256to511Octets'],
	['1.3.6.1.2.1.16.1.1.1.18', 'Pkts512to1023Octets'],
	['1.3.6.1.2.1.16.1.1.1.19', 'Pkts1024to1518Octets']
	];

var rmon_statistics_index_options = [];

for (var i = 0; i < statsCtrl_config.length; i++){
	rmon_statistics_index_options.push([i, statsCtrl_config[i][0].toString()]);
}

function getAlarmObjectName(object_oid)
{
	for (var i = 0; i < rmon_alarm_object_options.length; i++){
		if (object_oid == rmon_alarm_object_options[i][0])
			return rmon_alarm_object_options[i][1];
	}	

	return 'Undefined';
}

function getAlarmObjectOid(oid)
{
	var oid_vector = [];

	oid_vector = oid.split('.');

	for (var i = 0; i < rmon_statistics_oid_vector.length; i++){
		if (oid_vector[i] != rmon_statistics_oid_vector[i])
			return '';
	}

	return  rmon_alarm_object_options[parseInt(oid_vector[rmon_statistics_oid_vector.length], 10) - 3][0]; 
}

function getAlarmIndexId(oid)
{
	var oid_vector = [];

	oid_vector = oid.split('.');

	for (var i = 0; i < rmon_statistics_index_options.length; i++){
		if (rmon_statistics_index_options[i][1]
			==  oid_vector[rmon_statistics_oid_vector.length + 1])
		return rmon_statistics_index_options[i][0];
	}	

	return -1;
}

function getOid(object_oid, index)
{
	return object_oid + '.' + index;
}

var alarm = new webGrid();

alarm.onDataChanged = function()
{
	if (alarm.verifyFields(alarm.newEditor, true)) return;
	verifyFields();
	
}

alarm.exist = function(f, v)
{
	var data = this.getAllData();
	for (var i = 0; i < data.length; ++i) {
		if (data[i][f] == v) return true;
	}
	return false;
}

alarm.existName = function(name)
{
	return this.exist(0, name);
}


alarm.dataToView = function(data) {
//	alert(data[2]);
	//alert(data[2]+":"+rmon_statistics_index_options[data[2]][1]);
	return [data[0], getAlarmObjectName(data[1]), rmon_statistics_index_options[data[2]][1],
		data[3], data[4],data[5],sample_type[data[6]],data[7],
		['nothing','rising','falling','risingOrFalling'][data[8]],data[9],data[10],data[11]];
}

alarm.fieldValuesToData = function(row) {
	var f = fields.getAll(row);
	return [f[0].value, f[1].value, f[2].value, f[3].value, f[4].value, f[5].value,f[6].value,f[7].value,f[8].value,f[9].value,f[10].value,f[11].value];
}

alarm.verifyFields = function(row, quiet) {
	var f = fields.getAll(row);
	var s;

	ferror.clearAll(f);
	f[5].disabled = true;
	f[8].disabled = true;
	//index


	if (v_f_number(f[0], quiet, false, 1, 65535) == 0) return 0;
	if (this.existName(f[0].value)) {
		ferror.set(f[0], errmsg.bad_id, quiet);
		return 0;
	}else{
		ferror.clear(f[0]);
	}	

	//Alarm object

	//Alarm index errmsg.port_empty
	if (rmon_statistics_index_options.length == 0){
		ferror.set(f[2], errmsg.opt_empty, quiet);
		return 0;
	}else{
		ferror.clear(f[2]);
	}
	
	//if (!v_length(f[2], quiet, 1)) return 0;

	
	//rising thr
	if (!v_f_number(f[3], quiet, false, 0, 2147483647)) return 0;

	//falling thr
	if (!v_f_number(f[4], quiet, false, 0, 2147483647)) return 0;

	if ((f[3].value * 1) < (f[4].value * 1)){
		ferror.set(f[3], errmsg.ras_fal, quiet);
		ferror.set(f[4], errmsg.ras_fal, true);
		return 0;
	}else{
		ferror.clear(f[3]);
		ferror.clear(f[4]);
	}
	//value

	//type
	
	//interval
	if (!v_f_number(f[7], quiet, false, 1, 2147483647)) return 0;

	//rising event
	if (!v_f_number(f[9], quiet, false, 1, 65535)) return 0;

	//falling event
	if (!v_f_number(f[10], quiet, false, 1, 65535)) return 0;

	//owner string
	if(v_f_text(f[11], quiet, 0, 32) == 0) return 0;

	return 1;
}

alarm.resetNewEditor = function() {
	var f = fields.getAll(this.newEditor);
//	f[0].value = 0;
	
	f[1].value = rmon_alarm_object_options[0][0];
	f[2].value = ((rmon_statistics_index_options.length > 0)?(rmon_statistics_index_options[0][0]):(''));
	
	f[3].value = '';
	f[4].value = '';
	f[5].value = '';
	f[6].selected = '';
	f[7].value = '';
	f[8].value = 3;
	f[8].disabled = true;
	f[9].value = '';
	f[10].value = '';
	f[11].value = 'Monitor';
	
	f[5].disabled = true;
	ferror.clearAll(fields.getAll(this.newEditor));
}

alarm.setup = function() {

	this.init('alarm_grid', 'move', 80, [
		{ type: 'text'},
		{ type: 'select', options: rmon_alarm_object_options},//object
		{ type: 'select', options: rmon_statistics_index_options},//index
		{ type: 'text'},
		{ type: 'text'},
		{ type: 'text'},
		{ type: 'select', options: [[0,'delta'],[1,'absolute']]},
		{ type: 'text'},
		{ type: 'select', options: [[1,'rising'],[2,'falling'],[3,'risingOrFalling']]},
		{ type: 'text'},
		{ type: 'text'},
		{ type: 'text'}
		]);
	this.headerSet([rmon.index,rmon.alarm_object, rmon.alarm_index, rmon.rising_thr,rmon.falling_thr,rmon.value,rmon.type,rmon.interval,rmon.startup_alarm,rmon.rising_event,rmon.falling_event,rmon.owner_string]);

	for(var i=0;i<alarm_config.length;++i){
		tmp_old_config[i] = [];
		//index
		tmp_old_config[i][0] = alarm_config[i][0].toString();
		//object
		tmp_old_config[i][1] = getAlarmObjectOid(alarm_config[i][1].toString());
		//Alarm index
		tmp_old_config[i][2] = getAlarmIndexId(alarm_config[i][1].toString());
		
		//variable
		//tmp_old_config[i][1] = alarm_config[i][1].toString();
		
		//rising thr
		tmp_old_config[i][3] = alarm_config[i][2].toString();
		//falling thr
		tmp_old_config[i][4] = alarm_config[i][3].toString();
		//value
		tmp_old_config[i][5] = alarm_config[i][4].toString();
		//type
		tmp_old_config[i][6] = alarm_config[i][5];

		//interval
		tmp_old_config[i][7] = alarm_config[i][6].toString();
		//startupAlarm
		tmp_old_config[i][8] = alarm_config[i][7].toString();
		//risingEvent
		tmp_old_config[i][9] = alarm_config[i][8].toString();
		//fallingEvent
		tmp_old_config[i][10] = alarm_config[i][9].toString();
		//owner
		tmp_old_config[i][11] = alarm_config[i][10].toString();

		
		alarm.insertData(-1,tmp_old_config[i]);
	}

	alarm.showNewEditor();
	alarm.resetNewEditor();
}

function isDigit(str)
{ 
  var reg = /^\d*$/; 

  return reg.test(str); 
 }

function creat_alarm(tmp_data)
{
	var cmd = '';

	cmd += "rmon alarm " + tmp_data[0] + " " + getOid(tmp_data[1], rmon_statistics_index_options[tmp_data[2]][1])+ 
		" " + tmp_data[7] + " " + sample_type[tmp_data[6]] +" " + 
		"rising-threshold " + tmp_data[3] + " " + tmp_data[9] + " " +
		"falling-threshold " +tmp_data[4] + " " + tmp_data[10] + ((tmp_data[11] != '')?(" owner " + tmp_data[11]):(""))+ "\n";

/*
	
	if(tmp_data[10] != '')
		cmd += "rmon alarm " + tmp_data[0] + " " + tmp_data[1] + " " + tmp_data[6] + " " + sample_type[tmp_data[5]] +" "
		+ "rising-threshold " + tmp_data[2] + " " + tmp_data[8] + " " + "falling-threshold " +tmp_data[3] + " " + tmp_data[9] + " owner " + tmp_data[10] + "\n";
	else
		cmd += "rmon alarm " + tmp_data[0] + " " + tmp_data[1] + " " + tmp_data[6] + " " + sample_type[tmp_data[5]] +" "
		+ "rising-threshold " + tmp_data[2] + " " + tmp_data[8] + " " + "falling-threshold " +tmp_data[3] + " " + tmp_data[9] + "\n";
	*/
	return cmd;
}

function verifyFields(focused, quiet)
{

	var cmd = "";
	var fom = E('_fom');
	var view_flag = 1;
	var record_found = 0;
	var record_changed = 0;
	  
	E('save-button').disabled = true;	
	if (alarm.isEditing()) return;	
	
	var tmp_data = alarm.getAllData();

	//check add or change
	for(var i = 0; i < tmp_data.length; i++){
		record_found = 0;
		record_changed = 0
		for(var j = 0;j<tmp_old_config.length; j++){
			if (tmp_data[i][0] == tmp_old_config[j][0]){
				//check change
				for(var k = 1;k <tmp_old_config[j].length; k++){
					if((k == 5)||(k == 8)) continue;
					if(tmp_data[i][k] != tmp_old_config[j][k]){
						record_changed = 1;
						break;
					}
				}
				record_found = 1;
				break;
			}
		}
		if (!record_found || record_changed){
			if(view_flag){
				cmd += "!" + "\n";
				view_flag = 0;
			}
			cmd += creat_alarm(tmp_data[i]);			
		}
	}
	
	//check delete 
	for(var j = 0;j<tmp_old_config.length; j++){
		record_found = 0;
		for(var i = 0; i < tmp_data.length; i++){
			if (tmp_data[i][0] == tmp_old_config[j][0]){
				record_found = 1;
				break;				
			}
		}
		if (!record_found){
			if(view_flag){
				cmd += "!" + "\n";
				view_flag = 0;
			}
			cmd += "no rmon alarm " + tmp_old_config[j][0]+ "\n";
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
	//alarm.recolor();
	//alarm.resetNewEditor();
}
</script>
</head>
<body onload='init()'>
<form id='_fom' method='post' action='apply.cgi'>
<input type='hidden' name='_web_cmd' value=''>

<div class='section'>
	<table class='web-grid' cellspacing=1 id='alarm_grid'></table>
	<script type='text/javascript'>alarm.setup();</script>
</div>

<script type='text/javascript'>
init();
if(cookie.get('autosave') == 1)
	ui.aply=ui.aply_save;
genStdFooter("");
</script>
<script type='text/javascript'>verifyFields();</script>
</form>
</body>
</html>
