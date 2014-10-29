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
	width: 100px;
}
#schedule-grid .co3 {
	width: 80px;
}
#schedule-grid .co4 {
	width: 80px;
}
#schedule-grid .co5 {
	width: 80px;
}
#schedule-grid .co6 {
	width: 80px;
}
#schedule-grid .co7 {
	width: 80px;
}


</style>

<script type='text/javascript'>

<% ih_sysinfo(); %>
<% ih_user_info(); %>
<% web_exec('show running-config chronos'); %>

var date_options = [];
var date = 0;
while (date < 32){
	if(date == 0){
		date_options.push([date,'']);
	}else {
		date_options.push([date, ((date < 10)?('0'):(''))+date]);
	}
	date = date + 1;
}



var hour_options = [];
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
['0', ''],
['1', ui.every_1h],
['2', ui.every_2h],
['3', ui.every_3h],
['4', ui.every_4h],
['5', ui.every_5h],
['6', ui.every_6h],
['7', ui.every_7h],
['8', ui.every_8h],
['9', ui.every_9h],
['10', ui.every_10h],
['11', ui.every_11h],
['12', ui.every_12h],
['13',ui.every_half_h]
];


var str_hours =['', ui.every_1h, ui.every_2h, ui.every_3h, ui.every_4h, 
		ui.every_5h, ui.every_6h, ui.every_7h, ui.every_8h, 
		ui.every_9h, ui.every_10h, ui.every_11h, ui.every_12h, ui.every_half_h];

var week=[
	['0',''],
	['1', ui.mon], 
	['2',ui.tues],
	['3', ui.wed],
	['4',ui.thurs],
	['5',ui.fri],
	['6',ui.sat],
	['7',ui.sun]
	];
var str_week = ['',ui.mon, ui.tues,ui.wed,
		ui.thurs,ui.fri,ui.sat,ui.sun];

var month=[
	['0',''], 
	['1',ui.jan],
	['2',ui.feb],
	['3',ui.mar],
	['4',ui.apr],
	['5',ui.may],
	['6',ui.jun],
	['7',ui.jul],
	['8',ui.aug],
	['9',ui.sept],
	['10',ui.oct],
	['11',ui.nov],
	['12',ui.dec]
	];

var str_month = ['', ui.jan, ui.feb,ui.mar,ui.apr,
		ui.may,ui.jun,ui.jul,ui.aug,
		ui.sept,ui.oct,ui.nov,ui.dec];

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
	
	if(f[1].value > '0'){
		f[2].disabled=true;
		f[3].disabled=true;
		f[4].disabled=true;
		f[5].disabled=true;
		f[6].disabled=true;	
	}else {
		f[2].disabled=false;
		f[3].disabled=false;
		f[4].disabled=false;
		f[5].disabled=false;
		f[6].disabled=false;	
	}

	if(f[3].value == '4' || f[3].value == '6' || f[3].value == '9' || f[3].value == '11'){
		if(f[4].value == '31'){
			ferror.set(f[4],errmsg.invalidate, quiet);
			return 0;
		}
	}else if(f[3].value == '2'){
		if(f[4].value > '28'){
			ferror.set(f[4],errmsg.invalidate, quiet);
			return 0;
		}
	}
	return 1;
}

schedule.dataToView = function(data) 
{
	return [data[0], str_hours[data[1]], str_week[data[2]], str_month[data[3]], date_options[data[4]][1], hour_options[data[5]][1], min_options[data[6]][1]];
}


schedule.fieldValuesToData = function(row) {
	var f = fields.getAll(row);
	return [f[0].value, f[1].value, f[2].value, f[3].value, f[4].value, f[5].value,f[6].value];
}

schedule.resetNewEditor = function() {
	var f, c;

	f = fields.getAll(this.newEditor);
	ferror.clearAll(f);
	
	f[0].value = '';
	f[1].value = '0';
	f[2].value = '0';
	f[3].value = '0';
	f[4].value = '0';
	f[5].value = '0';
	f[6].value = '0';
}

schedule.setup = function() {
	this.init('schedule-grid', 'move', 10, [
		{ type: 'text', maxlen: 128 }, 
		{ type: 'select', options: each_hours },
		{ type: 'select', options: week },
		{ type: 'select', options: month },
		{ type: 'select', options: date_options },
		{ type: 'select', options: hour_options },
		{ type: 'select', options: min_options }
	]); 

	this.headerSet([ui.cmd, ui.each_hours, ui.week,  ui.month, ui.day, ui.hours,ui.minutes]);
    
	for (var i = 0; i < chronos_config.length; ++i) {
		this.insertData(-1, [chronos_config[i][0], chronos_config[i][1], chronos_config[i][2], chronos_config[i][3],chronos_config[i][4], chronos_config[i][5],chronos_config[i][6]]);
	}

	this.showNewEditor();
	this.resetNewEditor();
}

schedule.onDataChanged = function() {
	verifyFields(null, true);
}



function print_cmd(chronos, flag)
{
	var cmd = '';
	if(!flag){
		cmd += "no chronos " + chronos[0];
	}else {
		if(chronos[0] == "reboot"){
			cmd += "chronos reboot every day ";
			if(chronos[5]){
				cmd+= chronos[5] + " ";
			}
			if(chronos[6]){
				cmd+= chronos[6] + " ";
			}
		}else {
			cmd += "chronos "+chronos[0];
			if(chronos[1]>0){
				if(chronos[1] > 12){
					cmd += " every-minutes 30";
				}else {
					cmd += " every-hours "+ chronos[1];
				}
			}else {
				if(chronos[2]){
					cmd += " week "+chronos[2];
				}else {
					cmd += " week 0";
				}
				if(chronos[3]){
					cmd += " month "+chronos[3];
				}else {
					cmd += " month 0";
				}
				if(chronos[4]){
					cmd += " day "+chronos[4];
				}else {
					cmd += " day 0";
				}
				if(chronos[5]){
					cmd += " hour "+chronos[5];
				}else {
					cmd += " hour 0";
				}
				if(chronos[6]){
					cmd += " minute "+chronos[6];
				}else {
					cmd += " minute 0";
				}
			}
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

	var data = schedule.getAllData();
	var chronos = chronos_config;
	
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
			cmd += print_cmd(chronos[i], 0);	
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
					|| data[i][3] != chronos[j][3]
					|| data[i][4] != chronos[j][4]
					|| data[i][5] != chronos[j][5]
					|| data[i][6] != chronos[j][6]) {
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
	GetText(ui.schedule);
</script>
</div>

<div class='section'>
	<table class='web-grid' id='schedule-grid'></table>
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

