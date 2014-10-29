<% pagehead(menu.setup_time) %>
<!---->
<script type="text/javascript" src="status-time.jsx"></script>
<!---->
<script type='text/javascript'>

<% ih_sysinfo() %>
<% ih_user_info(); %>

var operator_priv = 12;

var year_options = [];
var year = 2000;
while(year < 2038 ){
	year_options.push([year, year]);
	year = year + 1;
}

var month_options = [];
var month = 1;
while(month < 13){
	month_options.push([month, ((month < 10)?('0'):(''))+month]);
	month = month + 1;
}

var date_basic_options = [];
var date = 1;
var date_options = [];
while (date < 29){
	date_basic_options.push([date, ((date < 10)?('0'):(''))+date]);
	date_options.push([date, ((date < 10)?('0'):(''))+date]);
	date = date + 1;
}



var hour_options = [];
var hour = 0;
while(hour < 24){
	hour_options.push([hour, ((hour < 10)?('0'):(''))+hour]);
	hour = hour + 1;
}

var min_sec_options = [];
var min_sec = 0;
while(min_sec < 60){
	min_sec_options.push([min_sec, ((min_sec < 10)?('0'):(''))+min_sec]);
	min_sec = min_sec + 1;
}

function genDateOpt(year, month)
{
	date_options = [];

	for (var j = 0; j < date_basic_options.length; j++)
		date_options.push(date_basic_options[j]);
	
	var i = 29;
	if (month == 2){//28 or 29 days
¡¡		if ((year%400==0) || ((year%100!=0) && (year%4==0))) {//Leap
			date_options.push([i, i]);
		}
	}else if ((month == 1) || (month == 3) || (month == 5)
				|| (month == 7) || (month == 8) ||(month == 10) ||(month == 12)){//31 days
		for (i = 29; i <= 31; i++)
			date_options.push([i, i]);
	}else{//30 days
		for (i = 29; i <= 30; i++)
			date_options.push([i, i]);
	}
}

function UpdateDateOpt()
{
	var year = E('_f_year').value;
	var month = E('_f_month').value;

	//alert(document.getElementsByName("vlan_if_options").length);
	var old_options = document.getElementsByName("f_date")[0];
	//alert(old_options.length);

	genDateOpt(year, month);

	if (old_options.options.length == date_options.length)
		return ;

	while(old_options.options.length>0){
		old_options.remove(0);
	}
	for(var j=0;j<date_options.length;j++){
      var item = new Option(date_options[j][1],date_options[j][0]);
	  old_options.options.add(item);
	}		
}

function verifyFields(focused, quiet)
{
	var ok = 1;
	var cmd = "";
	var fom = E('_fom_tz');
	var view_flag = 0;

	var old_date = E('_f_date').value;
	UpdateDateOpt();
	if (old_date > date_options.length)
		E('_f_date').value = date_options[date_options.length - 1][0];
	else
		E('_f_date').value = old_date;

	
	E('tz-button').disabled = true;	

	var s = E('_f_tm_sel').value;
	
//	var f_dst = E('_f_tm_dst');
	var f_tz = E('_f_tm_tz');
	if (s == 'custom') {
//		f_dst.disabled = true;
		f_tz.disabled = false;
//		PR(f_dst).style.display = 'none';
		PR(f_tz).style.display = '';
		
		if(f_tz.value==""){
			ferror.set('_f_tm_tz', infomsg.ntp3, quiet);
			return 0;
		}
		ferror.clear('_f_tm_tz');
	}else {
		f_tz.disabled = true;
		PR(f_tz).style.display = 'none';

		/*
		PR(f_dst).style.display = 'none';
		if (s.match(/^([A-Z]+[\d:-]+)[A-Z]+/)) {
			if (!f_dst.checked) s = RegExp.$1;
			f_dst.disabled = false;
		}
		else {
			f_dst.disabled = true;
		}
		*/
		f_tz.value = s;
	}

	if (f_tz.value!=ih_sysinfo.timezone) {
		if (!view_flag){
			cmd += "!\n"
			view_flag = 1;
		}
		
		cmd += "clock timezone " + f_tz.value + "\n!\n";

	}
	
	
	if (user_info.priv < operator_priv) {
		elem.display('tz-button', false);
	}else{
		elem.display('tz-button', true);
		fom._web_cmd.value = cmd;
		E('tz-button').disabled = (cmd=="");	
	}
	
	return 1;
}

function save_tz()
{
	if (!verifyFields(null, false)) return;
	if (cookie.get('debugcmd') == 1)
		alert(E('_fom_tz')._web_cmd.value);
	if (cookie.get('autosave') == 1)
		E('_fom_tz')._web_cmd.value += "!\ncopy running-config startup-config\n";
	form.submit('_fom_tz', 1);
}

function save_tm()
{
	var cmd = "!\nclock set ";

	cmd += E('_f_year').value+"."+E('_f_month').value+"."+E('_f_date').value+"-";
	cmd	+= E('_f_hour').value+":"+E('_f_min').value+":"+E('_f_sec').value+"\n";
	//alert(cmd);
	E('_fom')._web_cmd.value = cmd;
	form.submit('_fom', 1);	
}
var timezone_list = [
		['custom',ui.custom],	
		['UTC12','UTC-12:00 ' + tm.utc_n12],
		['UTC11','UTC-11:00 ' + tm.utc_n11],
		['UTC10','UTC-10:00 ' + tm.utc_n10],
		['NAST9NADT,M3.2.0/2,M11.1.0/2','UTC-09:00 ' + tm.utc_n9],
		['PST8PDT,M3.2.0/2,M11.1.0/2','UTC-08:00 ' + tm.utc_n8],
		['UTC7','UTC-07:00 ' + tm.utc_n7],
		['MST7MDT,M3.2.0/2,M11.1.0/2','UTC-07:00 ' + tm.utc_n7_2],
		['UTC6','UTC-06:00 ' + tm.utc_n6],
		['CST6CDT,M3.2.0/2,M11.1.0/2','UTC-06:00 ' + tm.utc_n6_2],		
		['UTC5','UTC-05:00 ' + tm.utc_n5],
		['EST5EDT,M3.2.0/2,M11.1.0/2','UTC-05:00 ' + tm.utc_n5_2],
		['UTC4','UTC-04:00 ' + tm.utc_n4],
		['AST4ADT,M3.2.0/2,M11.1.0/2','UTC-04:00 ' + tm.utc_n4_2],
		['BRWST4BRWDT,M10.3.0/0,M2.5.0/0','UTC-04:00 ' + tm.utc_n4_3],
		['NST3:30NDT,M3.2.0/0:01,M11.1.0/0:01','UTC-03:30 ' + tm.utc_n3_30],
		['WGST3WGDT,M3.5.6/22,M10.5.6/23','UTC-03:00 ' + tm.utc_n3],
		['BRST3BRDT,M10.3.0/0,M2.5.0/0','UTC-03:00 ' + tm.utc_n3_2],
		['UTC3','UTC-03:00 ' + tm.utc_n3_3],
		['UTC2','UTC-02:00 ' + tm.utc_n2],
		['STD1DST,M3.5.0/2,M10.5.0/2','UTC-01:00 ' + tm.utc_n1],
		['UTC0','UTC+00:00 ' + tm.utc_0],
		['GMT0BST,M3.5.0/2,M10.5.0/2','UTC+00:00 ' + tm.utc_0_2],
		['UTC-1','UTC+01:00 ' + tm.utc_p1],
		//['STD-1DST,M3.5.0/2,M10.5.0/2','UTC+01:00 ' + tm.utc_p1_2],
		['CET-1CEST,M3.5.0/2,M10.5.0/3','UTC+01:00 ' + tm.utc_p1_2],
		['UTC-2','UTC+02:00 ' + tm.utc_p2],
		['STD-2DST,M3.5.0/2,M10.5.0/2','UTC+02:00 ' + tm.utc_p2_2],
		['UTC-3','UTC+03:00 ' + tm.utc_p3],
		['EET-2EEST-3,M3.5.0/3,M10.5.0/4','UTC+03:00 ' + tm.utc_p3_2],
		['UTC-4','UTC+04:00 ' + tm.utc_p4],
		['UTC-5','UTC+05:00 ' + tm.utc_p5],
		['UTC-5:30','UTC+05:30 ' + tm.utc_p5_30],
		['UTC-6','UTC+06:00 ' + tm.utc_p6],
		['UTC-7','UTC+07:00 ' + tm.utc_p7],
		['UTC-8','UTC+08:00 ' + tm.utc_p8],
		['UTC-9','UTC+09:00 ' + tm.utc_p9],
		['CST-9:30CST,M10.5.0/2,M3.5.0/3', 'UTC+09:30 ' + tm.utc_p9_30],
		['UTC-10','UTC+10:00 ' + tm.utc_p10],
		['STD-10DST,M10.5.0/2,M3.5.0/2','UTC+10:00 ' + tm.utc_p10_2],
		['UTC-11','UTC+11:00 ' + tm.utc_p11],
		['UTC-12','UTC+12:00 ' + tm.utc_p12],
		['STD-12DST,M10.5.0/2,M3.5.0/2','UTC+12:00 ' + tm.utc_p12_2]
/* REMOVE-BEGIN
		,
		['NAST9NADT,M4.1.0/2,M10.5.0/2','UTC-09:00 Alaska (Old DST)'],
		['PST8PDT,M4.1.0/2,M10.5.0/2','UTC-08:00 Pacific Time (Old DST)'],
		['MST7MDT,M4.1.0/2,M10.5.0/2','UTC-07:00 Mountain Time (Old DST)'],
		['CST6CDT,M4.1.0/2,M10.5.0/2','UTC-06:00 Central Time (Old DST)'],
		['EST5EDT,M4.1.0/2,M10.5.0/2','UTC-05:00 Eastern Time (Old DST)'],
		['STD4DST,M4.1.0/2,M10.5.0/2','UTC-04:00 Atlantic Time (Old DST)'],
		['STD3:30DST,M4.1.0/2,M10.5.0/2','UTC-03:30 Newfoundland (Old DST)']
REMOVE-END */
	];

var tm_sel = 'custom';
var s;
var timezone_dst = '0';


//function load_data()
if (1){
	for (i=0; i<timezone_list.length; i++) {
		s = timezone_list[i][0];
		
		if (s.match(/^([A-Z]+[\d:-]+)[A-Z]+/)) {
			s = RegExp.$1;
		}
		
		if (ih_sysinfo.timezone==s) {
			tm_sel = timezone_list[i][0];
			break;
		}
	}

}

var sync_button = " <input type='button' style='width:100px' value='" + ui.sync + "' onclick='sync()' id='sync-button'>";
var time_button = " <input type='button' style='width:100px' value='" + ui.aply + "' onclick='save_tm()' id='tm-button'>";
if(cookie.get('autosave') == 1)
	ui.aply=ui.aply_save;
var timezone_button = " <input type='button' style='width:100px' value='" + ui.aply + "' onclick='save_tz()' id='tz-button'>";

var ref = new webRefresh('status-time.jsx', '', 3000, 'status_time_refresh');
var stats = 
	{time: '<% time(); %>',/////
	 ostime: ''
	 };


ref.refresh = function(text)
{
//	stats = {};
	stats.time = '';
	 stats.ostime = '';
	try {
		eval(text);
	}
	catch (ex) {
		stats = {};
	}
	show();
}

function sync()
{
	var now = new Date();
	
	location.href = 'settime.cgi?time=' + now.getTime()/1000;
}

function c(id, htm)
{
	E(id).cells[1].innerHTML = htm;
}

var first_time = 1;

function show()
{	
//	alert("ref");
	var now = new Date();
	var a;
	
	//stats.ostime = now.toLocaleString();
	a = now.getYear();
	if (a<1900) a += 1900;
	stats.ostime = a + '-';
	a = now.getMonth()+1;
	stats.ostime += a > 9 ? a : ('0' + a);
	stats.ostime += '-';
	a = now.getDate();
	stats.ostime += a > 9 ? a : ('0' + a);

	stats.ostime += ' ';
	
	a = now.getHours();
	stats.ostime += a > 9 ? a : ('0' + a);
	
	stats.ostime += ':';
	a = now.getMinutes();
	stats.ostime += a > 9 ? a : ('0' + a);
	
	stats.ostime += ':';
	a = now.getSeconds();
	stats.ostime += a > 9 ? a : ('0' + a);
	
	if (first_time){

		//2011-05-01 01:05:56
		var s = stats.time;
		if (s.length) {
			var ym = s.split('-');
			var date = ym[2].split(' ');
			var time = date[1].split(':');
			//alert(stats.time);
			E('_f_year').value = parseInt(ym[0], 10);
			E('_f_month').value = parseInt(ym[1], 10);
			verifyFields(null, true);
			E('_f_date').value = parseInt(date[0], 10);		
			E('_f_hour').value = parseInt(time[0], 10);
			E('_f_min').value = parseInt(time[1], 10);
			E('_f_sec').value = parseInt(time[2], 10);
			
			first_time = 0;
		}
	}
			
	//alert(stats.time);
	
	c('rtime', stats.time);
	//if(stats.ostime==stats.time)
	c('ostime', stats.ostime);
	//else
	//	c('ostime', stats.ostime );
		

}

function init()
{
	ref.initPage(3000, 3000);
}

function earlyInit()
{
	show();
	verifyFields(null, 1);
}



</script>
</head>
<body onload="init()">

<form id='_fom' method='post' action='apply.cgi'>
<input type='hidden' name='_web_cmd' value=''>

<div class='section'>
<script type='text/javascript'>

createFieldTable('', [
	{ title: ui.time, rid: 'rtime', text: stats.time },
	{ title: ui.ostime, rid: 'ostime', text: stats.ostime},
	{ title: '', text: '',suffix:sync_button}
]);
</script>
</div>

<div class='section-title'></div>

<div class='section'>
<script type='text/javascript'>

createFieldTable('', [
	{ title: ui.date_set, multi: [
	{name: 'f_year', type: 'select', suffix:' / ', options: year_options, value: 2011},
	{name: 'f_month', type: 'select', suffix:' / ', options: month_options, value: 1},
	{name: 'f_date', type: 'select', options: date_options, value: 1}
	]},
	{ title: ui.time_set, multi: [
	{name: 'f_hour', type: 'select', suffix:' : ', options: hour_options, value: 12},
	{name: 'f_min', type: 'select', suffix:' : ', options: min_sec_options, value: 0},
	{name: 'f_sec', type: 'select',  options: min_sec_options, value: 0}
	]},
	{ title: '', text: '', suffix:time_button}
]
);
</script>

</div>




</form>

<form id='_fom_tz' method='post' action='apply.cgi'>
<input type='hidden' name='_web_cmd' value=''>
<div class='section-title'></div>
<div class='section'>
<script type='text/javascript'>

createFieldTable('', [
	{ title: ui.timezone, name: 'f_tm_sel', type: 'select', options: timezone_list, value: ih_sysinfo.timezone },	
//	{ title: ui.auto_daylight, indent: 4, name: 'f_tm_dst', type: 'checkbox', value: (timezone_dst != '0' )?(1):(0)},
	{ title: ui.tz, indent: 4, name: 'f_tm_tz', type: 'text', maxlen: 32, size: 34, value: ih_sysinfo.timezone || '' },
	{ title: '', text: '',suffix:timezone_button}
]);
</script>
</div>
<div class='section-title'></div>
</form>

<script type='text/javascript'>earlyInit()</script>
</body>
</html>
