<% pagehead(menu.schedule) %>

<style type='text/css'>
#schedule-grid {
	text-align: center;
	width: 750px;
}

#schedule-grid .co1{
	width: 150px;
}
#schedule-grid .co2{
	width: 80px;
}
#schedule-grid .co3 {
	width: 80px;
}
#schedule-grid .co4 {
	width: 40px;
}
#schedule-grid .co5 {
	width: 40px;
}
#schedule-grid .co6 {
	width: 40px;
}
#schedule-grid .co7 {
	width: 40px;
}
#schedule-grid .co8 {
	width: 40px;
}
#schedule-grid .co9 {
	width: 40px;
}
#schedule-grid .co10 {
	width: 40px;
}

#schedule-grid2 {
	text-align: center;
	width: 750px;
}

#schedule-grid2 .co1{
	width: 150px;
}
#schedule-grid2 .co2{
	width: 80px;
}
#schedule-grid2 .co3 {
	width: 80px;
}
#schedule-grid2 .co4 {
	width: 80px;
}
#schedule-grid2 .co5 {
	width: 80px;
}
#schedule-grid2 .co6 {
	width: 40px;
}
#schedule-grid2 .co7 {
	width: 40px;
}
#schedule-grid2 .co8 {
	width: 40px;
}
#schedule-grid2 .co9 {
	width: 40px;
}
#schedule-grid2 .co10 {
	width: 40px;
}
#schedule-grid2 .co11 {
	width: 40px;
}
#schedule-grid2 .co12 {
	width: 40px;
}
</style>

<script type='text/javascript'>

<% ih_sysinfo(); %>
<% ih_user_info(); %>
<% web_exec('show running-config chronos'); %>

var hour_options = [[-1, '']];
var hour = 0;
while(hour < 24){
	hour_options.push([hour, ((hour < 10)?('0'):(''))+hour]);
	hour = hour + 1;
}

var min_options = [];
var min = 0;
while(min < 60){
	min_options.push([min, ((min < 10)?('0'):(''))+min]);
	min = min + 1;
}

var each_hours=[
[0, ''],
[1, ui.every_1h],
[2, ui.every_2h],
[3, ui.every_3h],
[4, ui.every_4h],
[5, ui.every_5h],
[6, ui.every_6h],
[7, ui.every_7h],
[8, ui.every_8h],
[9, ui.every_9h],
[10, ui.every_10h],
[11, ui.every_11h],
[12, ui.every_12h]
];

var each_mins=[
[0, ''],
[1, ui.each_1m],
[2, ui.each_2m],
[3, ui.each_3m],
[4, ui.each_4m],
[5, ui.each_5m],
[6, ui.each_6m],
[7, ui.each_7m],
[8, ui.each_8m],
[9, ui.each_9m],
[10, ui.each_10m],
[11, ui.each_11m],
[12, ui.each_12m],
[13, ui.each_13m],
[14, ui.each_14m],
[15, ui.each_15m],
[16, ui.each_16m],
[17, ui.each_17m],
[18, ui.each_18m],
[19, ui.each_19m],
[20, ui.each_20m],
[21, ui.each_21m],
[22, ui.each_22m],
[23, ui.each_23m],
[24, ui.each_24m],
[25, ui.each_25m],
[26, ui.each_26m],
[27, ui.each_27m],
[28, ui.each_28m],
[29, ui.each_29m],
[30, ui.each_30m]
];

var schedule = new webGrid();

schedule.exist = function(f, v)
{
	var data = this.getAllData();
	for (var i = 0; i < data.length; ++i) {
		if (data[i][f] == v) return true;
	}
	return false;
}
schedule.existName = function(name)
{
	return this.exist(0, name);
}

function word_end_with_dot(str, end)
{
	var a = str.split(".");
	var i;

	if (a.length < 2) return 0;
	if (a[a.length - 1] == end) return 1;
	return 0;
}

schedule.verifyFields = function(row, quiet)
{
	var f = fields.getAll(row);
	ferror.clearAll(f);

	if(this.existName(f[0].value)) {
		ferror.set(f[0],errmsg.bad_name4, quiet);
		return 0;
	}else if(f[0].value == ''){
		ferror.set(f[0],errmsg.adm3, quiet);
		return 0;
	}
	if (!((f[0].value == 'reboot') || word_end_with_dot(f[0].value, 'sh')|| word_end_with_dot(f[0].value, 'rsync'))) {
		ferror.set(f[0],errmsg.badSchName, quiet);
		return 0;		
	}
	
	return 1;
}

schedule.dataToView = function(data) 
{
	return [data[0], hour_options[parseInt(data[1])+1][1], min_options[parseInt(data[2])][1],
		(data[3] == 1?ui.yes_p:' '),
		(data[4] == 1?ui.yes_p:' '),
		(data[5] == 1?ui.yes_p:' '),
		(data[6] == 1?ui.yes_p:' '),
		(data[7] == 1?ui.yes_p:' '),
		(data[8] == 1?ui.yes_p:' '),
		(data[9] == 1?ui.yes_p:' ')];
}

schedule.fieldValuesToData = function(row) {
	var f = fields.getAll(row);

	return [f[0].value, f[1].value, f[2].value, 
		f[3].checked?1:0,
		f[4].checked?1:0,
		f[5].checked?1:0,
		f[6].checked?1:0,
		f[7].checked?1:0,
		f[8].checked?1:0,
		f[9].checked?1:0];
}

schedule.resetNewEditor = function() {
	var f, c;

	f = fields.getAll(this.newEditor);
	ferror.clearAll(f);
	
	f[0].value = '';
	f[1].value = -1;
	f[2].value = 0;
	f[3].checked = 0;
	f[4].checked = 0;
	f[5].checked = 0;
	f[6].checked = 0;
	f[7].checked = 0;
	f[8].checked = 0;
	f[9].checked = 0;
}

schedule.setup = function() {
	this.init('schedule-grid', 'move', 10, [
		{ type: 'text', maxlen: 128 }, //task
		{ type: 'select', options: hour_options },//hour
		{ type: 'select', options: min_options },//minute
		{ type: 'checkbox'},//Sun
		{ type: 'checkbox'},//Mon
		{ type: 'checkbox'},//Tues
		{ type: 'checkbox'},//Wed
		{ type: 'checkbox'},//Thurs
		{ type: 'checkbox'},//Fri
		{ type: 'checkbox'}//Sat
	]); 

	this.headerSet([ui.cmd, ui.hours, ui.minutes, ui.sun, ui.mon, ui.tues, ui.wed, ui.thurs, ui.fri, ui.sat]);
    
	for (var i = 0; i < chronos_config1.length; ++i) {
		this.insertData(-1, [chronos_config1[i][0], chronos_config1[i][1], chronos_config1[i][2], 
			chronos_config1[i][3][0], chronos_config1[i][3][1], chronos_config1[i][3][2], chronos_config1[i][3][3], 
			chronos_config1[i][3][4], chronos_config1[i][3][5], chronos_config1[i][3][6]]);
	}

	this.showNewEditor();
	this.resetNewEditor();
}

schedule.onDataChanged = function() {
	verifyFields(null, true);
}

///////////////////////////////////////////////////////////////////////////////
var schedule2 = new webGrid();

schedule2.exist = function(f, v)
{
	var data = this.getAllData();
	for (var i = 0; i < data.length; ++i) {
		if (data[i][f] == v) return true;
	}
	return false;
}
schedule2.existName = function(name)
{
	return this.exist(0, name);
}

schedule2.verifyFields = function(row, quiet)
{
	var f = fields.getAll(row);
	ferror.clearAll(f);


	if(this.existName(f[0].value)) {
		ferror.set(f[0],errmsg.bad_name4, quiet);
		return 0;
	}else if(f[0].value == ''){
		ferror.set(f[0],errmsg.adm3, quiet);
		return 0;
	}
	if (!((f[0].value == 'reboot') || word_end_with_dot(f[0].value, 'sh')|| word_end_with_dot(f[0].value, 'rsync'))) {
		ferror.set(f[0],errmsg.badSchName, quiet);
		return 0;		
	}

	if (f[1].value > 0){
		f[2].value = 0;
		f[2].disabled = 1;
	}else
		f[2].disabled = 0;
	
	if (f[3].value < 0){
		f[4].value = -1;
		f[4].disabled = 1;
	}else{
		f[4].disabled = 0;
		if (f[4].value < 0){
			ferror.set(f[4],errmsg.selTim, quiet);
			return 0;
		}
	}
	
	return 1;
}

schedule2.dataToView = function(data) 
{
	return [data[0], each_hours[parseInt(data[1])][1], each_mins[parseInt(data[2])][1],
		hour_options[parseInt(data[3])+1][1],hour_options[parseInt(data[4])+1][1],
		(data[5] == 1?ui.yes_p:' '),
		(data[6] == 1?ui.yes_p:' '),
		(data[7] == 1?ui.yes_p:' '),
		(data[8] == 1?ui.yes_p:' '),
		(data[9] == 1?ui.yes_p:' '),
		(data[10] == 1?ui.yes_p:' '),
		(data[11] == 1?ui.yes_p:' ')];
}

schedule2.fieldValuesToData = function(row) {
	var f = fields.getAll(row);

	return [f[0].value, f[1].value, f[2].value, f[3].value, f[4].value,
		f[5].checked?1:0,
		f[6].checked?1:0,
		f[7].checked?1:0,
		f[8].checked?1:0,
		f[9].checked?1:0,
		f[10].checked?1:0,
		f[11].checked?1:0];
}

schedule2.resetNewEditor = function() {
	var f, c;

	f = fields.getAll(this.newEditor);
	ferror.clearAll(f);
	
	f[0].value = '';
	f[1].value = 1;
	f[2].value = 0;
	f[2].disabled = 1;
	f[3].value = -1;
	f[4].value = -1;	
	f[4].disabled = 1;
	f[5].checked = 0;
	f[6].checked = 0;
	f[7].checked = 0;
	f[8].checked = 0;
	f[9].checked = 0;
	f[10].checked = 0;
	f[11].checked = 0;
}

schedule2.setup = function() {
	this.init('schedule-grid2', 'move', 10, [
		{ type: 'text', maxlen: 128 }, //task
		{ type: 'select', options: each_hours},//every-hour
		{ type: 'select', options: each_mins },//every-minute
		{ type: 'select', options: hour_options },//hour1
		{ type: 'select', options: hour_options },//hour2
		{ type: 'checkbox'},//Sun
		{ type: 'checkbox'},//Mon
		{ type: 'checkbox'},//Tues
		{ type: 'checkbox'},//Wed
		{ type: 'checkbox'},//Thurs
		{ type: 'checkbox'},//Fri
		{ type: 'checkbox'}//Sat
	]); 

	this.headerSet([ui.cmd, ui.xhours, ui.xminutes, ui.startHour, ui.endHour, 
		ui.sun, ui.mon, ui.tues, ui.wed, ui.thurs, ui.fri, ui.sat]);
    
	for (var i = 0; i < chronos_config2.length; ++i) {
		this.insertData(-1, [chronos_config2[i][0], chronos_config2[i][1], chronos_config2[i][2], 
			chronos_config2[i][3], chronos_config2[i][4], 
			chronos_config2[i][5][0], chronos_config2[i][5][1], chronos_config2[i][5][2], chronos_config2[i][5][3], 
			chronos_config2[i][5][4], chronos_config2[i][5][5], chronos_config2[i][5][6]]);
	}

	this.showNewEditor();
	this.resetNewEditor();
}

schedule2.onDataChanged = function() {
	verifyFields(null, true);
}

///////////////////////////////////////////////////////////////////////////////


function gen_week_cmd(week)
{
	var cmd = '';
	var i;
	var flag = 0;
	
	for (i = 0; i < 7; i++) {
		if (week[i] > 0) {
			if (flag){
				cmd += ','; 
			}
			flag = 1;
			cmd += i.toString();
		}
	}
	//alert("week:"+cmd);
	return cmd;
}

function print_cmd(chronos, flag)
{
	var cmd = '';
	var week = '';
	
	if(!flag){
		cmd += "no chronos " + chronos[0];
	}else {
		cmd += "chronos " + chronos[0];
		week = gen_week_cmd(chronos[3]);
		if (week.length > 0) {
			cmd += " weekday "+week;
		}
		if (chronos[1] > 0) 
			cmd += " hour "+chronos[1];
		if (chronos[2] > 0) 
			cmd += " minute "+chronos[2];
	}
	cmd += "\n";
	return cmd;
}


function verifyFields(focused, quiet)
{

	var cmd = '';
	var fom = E('_fom');
	var week = '';
	
	E('save-button').disabled = true;

	var data = schedule.getAllData();
	var chronos = chronos_config1;
	
	// delete
	for(var i = 0; i < chronos.length; i++) {
		var found = 0;
		for(var j = 0; j < data.length; j++) {
			if(chronos[i][0] == data[j][0]){
				found = 1;
				break;
			}
		}
		if(!found) {
			cmd += "no chronos " + chronos[i][0];
			cmd += "\n";
		}
	}
	//add
	for(var i = 0; i < data.length; i++) {
		var found = 0;
		var changed = 0;
		for(var j = 0; j < chronos.length; j++) {
			if(data[i][0]==chronos[j][0]) {
				found = 1;
				if(data[i][1] != chronos[j][1]
					|| data[i][2] != chronos[j][2]
					|| data[i][3] != chronos[j][3][0]
					|| data[i][4] != chronos[j][3][1]
					|| data[i][5] != chronos[j][3][2]
					|| data[i][6] != chronos[j][3][3]
					|| data[i][7] != chronos[j][3][4]
					|| data[i][8] != chronos[j][3][5]
					|| data[i][9] != chronos[j][3][6]
					) {
					//alert("changed");
					changed = 1;
				}
				break;
			}
		}
		if(!found || changed) {
			cmd += "chronos " + data[i][0];
			week = gen_week_cmd([data[i][3],data[i][4],data[i][5],data[i][6],data[i][7],data[i][8],data[i][9]]);
			if (week.length > 0) 
				cmd += " weekday "+week;			
			if (data[i][1] > 0) 
				cmd += " hour "+data[i][1];
			cmd += " minute "+data[i][2];
			cmd += "\n";
		}
	}

	var data2 = schedule2.getAllData();
	var chronos2 = chronos_config2;
	
	// delete
	for(var i = 0; i < chronos2.length; i++) {
		var found = 0;
		for(var j = 0; j < data2.length; j++) {
			if(chronos2[i][0] == data2[j][0]){
				found = 1;
				break;
			}
		}
		if(!found) {
			cmd += "no chronos " + chronos2[i][0];
			cmd += "\n";
		}
	}
	//add
	for(var i = 0; i < data2.length; i++) {
		var found = 0;
		var changed = 0;
		for(var j = 0; j < chronos2.length; j++) {
			if(data2[i][0]==chronos2[j][0]) {
				found = 1;
				if(data2[i][1] != chronos2[j][1]
					|| data2[i][2] != chronos2[j][2]
					|| data2[i][3] != chronos2[j][3]
					|| data2[i][4] != chronos2[j][4]
					|| data2[i][5] != chronos2[j][5][0]
					|| data2[i][6] != chronos2[j][5][1]
					|| data2[i][7] != chronos2[j][5][2]
					|| data2[i][8] != chronos2[j][5][3]
					|| data2[i][9] != chronos2[j][5][4]
					|| data2[i][10] != chronos2[j][5][5]
					|| data2[i][11] != chronos2[j][5][6]
					) {
					//alert("changed");
					changed = 1;
				}
				break;
			}
		}
		if(!found || changed) {
			cmd += "chronos " + data2[i][0];
			if (data2[i][1] > 0)
				cmd += " every-hour "+data2[i][1];
			else if (data2[i][2] > 0)
				cmd += " every-minute "+data2[i][2];
			if (data2[i][3] >= 0)
				cmd += " between hour "+data2[i][3]+" and "+data2[i][4];
			week = gen_week_cmd([data2[i][5],data2[i][6],data2[i][7],data2[i][8],data2[i][9],data2[i][10],data2[i][11]]);
			if (week.length > 0) 
				cmd += " on weekday "+week;
			cmd += "\n";
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

	return 1;
}

function save()
{
	if (schedule.isEditing()) return;

	var fom = E('_fom');

	if((E('_fom')._web_cmd.value != '')&&(cookie.get('autosave') == 1)){
		E('_fom')._web_cmd.value += "!"+"\n"+"copy running-config startup-config"+"\n";	
	}

	form.submit(fom, 1);
}

function earlyInit()
{
	schedule.setup();
	schedule2.setup();
	verifyFields(null, true);
}

function init()
{
	if((cookie.get('autosave')) == null){
		cookie.set('autosave', 1);
	}
	schedule.recolor();
}
</script>
</head>
<body onload='init()'>
<form id='_fom' method='post' action='apply.cgi'>
<input type='hidden' name='_web_cmd' value=''>

<div class='section-title'>
<script type='text/javascript'>
	GetText(ui.schedule1);
</script>
</div>

<div class='section'>
	<table class='web-grid' id='schedule-grid'></table>
</div>

<div class='section-title'>
<script type='text/javascript'>
	GetText(ui.schedule2);
</script>
</div>
<div class='section'>
	<table class='web-grid' id='schedule-grid2'></table>
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

