<% pagehead(menu.status_log) %>
<style type='text/css'>
#alarm-cfg{
	width: 400px;
}

#alarmlog-grid{
	width: 900px;
}
#alarmlog-grid .co1 {
	width: 30px;
}
#alarmlog-grid .co2 {
	width: 40px;
}
#alarmlog-grid .co3 {
	width: 40px;
}
#alarmlog-grid .co4 {
	width: 150px;
}
#alarmlog-grid .co5 {
	width: 100px;
}



</style>

<script type='text/javascript'>
<% ih_user_info(); %>	

var type_str = "";
var type = cookie.get('state');
if(type == null) {type = 0;type_str = "all";}
else if (type == 0) {type_str = "all";}
else if (type == 1) {type_str = "raise";}
else if (type == 2) {type_str = "confirm";}

var start_id = cookie.get('start');
if(start_id == null) start_id = 0;

var log_cnt = 10;

var post_data = "type=" + type_str + ((start_id > -1)?(" start="+start_id):("")) + ((log_cnt > 0)?(" count="+log_cnt):(""));



var states=['all', 'raise', 'confirm'];
var alarm_log_grid = new webGrid();

alarm_log_grid.dataToView = function(data) {
	return data;
}

alarm_log_grid.verifyFields = function(row, quiet) {
	return 1;
}

alarm_log_grid.setup = function() {
	this.init('alarmlog-grid', ['readonly', 'sort'], 128, [
		{ type: 'text', maxlen: 64 }, 
		{ type: 'text', maxlen: 64 }, 
//		{ type: 'text', maxlen: 64 }, 
		{ type: 'text', maxlen: 64 }, 
		{ type: 'text', maxlen: 64 }, 
		{ type: 'text', maxlen: 64 }, 
		{ type: 'text', maxlen: 256 }
		]);
//	this.headerSet([alarm.id, alarm.sts, alarm.tp, alarm.lv, alarm.dt, alarm.syst, alarm.cont]);	
	this.headerSet([alarm.id, alarm.sts, alarm.lv, alarm.dt, alarm.syst, alarm.cont]);	
}

var ref = new webRefresh('status-alarm.jsx', 'alarmlog=all', 0, 'status_alarm_refresh');
var alarm_log = [];
//var cli_cmd="";
ref.refresh = function(text)
{
//	alert(text);
	alarm_log = [];
	try {
		eval(text);
	}
	catch (ex) {
		alarm_log = [];
	}
//	alert(alarm_log.length);

	if (alarm_log.length  > 0){

		var start_id = parseInt(alarm_log[alarm_log.length - 1][0], 10);
		cookie.set('now-start', start_id);

	}
	
	update();

	
}
/*
var start_test = 0;
ref.toggle = function(delay) {
	start_test++;
	var cgi_str = 'alarmlog=all_start-id_'+start_test;
	ref.postData = cgi_str;
	if (this.running) this.stop();
	else this.start(delay);
}
*/

function start_ref(postData)
{
	ref.postData = postData;
	if (ref.running) ref.stop();
	else ref.start();
}

function firstPage()
{
	var state_coo = cookie.get('state');
	var state_id;
	if (state_coo == null) state_id = 0;
	else state_id = parseInt(state_coo, 10);
	
	//var postData = 'alarmlog='+states[state_id]+'_number_10';
	var postData = 'alarmlog='+states[state_id];
	start_ref(postData);
}

firstPage();
/*
function nextPage()
{
	var postData = 'alarmlog=';//'alarmlog=all_start-id_';
	var start_id = cookie.get('now-start');
	var p;
	var start = 0;

	var state_coo = cookie.get('state');
	var state_id;
	if (state_coo == null) state_id = 0;
	else state_id = parseInt(state_coo, 10);
	
	
	if (start_id == null) start = 1;
	else {
		start = parseInt(start_id, 10) +log_cnt;
	}
	postData += states[state_id] + "_start-id_" +start +"_number_"+ log_cnt;
//	cookie.set('now-start', start);

	start_ref(postData);

	return;
}

function lastPage()
{
	var postData = 'alarmlog=';//'alarmlog=all_start-id_';
	var start_id = cookie.get('now-start');
	var p;
	var start = 0;

	var state_coo = cookie.get('state');
	var state_id;
	if (state_coo == null) state_id = 0;
	else state_id = parseInt(state_coo, 10);
	
	if (start_id == null) start = 1;
	else {
		start = parseInt(start_id, 10);
		if (start > log_cnt) start -= log_cnt;
		else start = 1;
	}
	postData += states[state_id] + "_start-id_" +start +"_number_"+ log_cnt;
//	cookie.set('now-start', start);

	start_ref(postData);

	return;
}

*/
function update()
{
	alarm_log_grid.removeAllData();
	for (var i = 0; i < alarm_log.length; i++){
		alarm_log_grid.insertData(-1, alarm_log[i]);
	}
}


function creatSelect(options,value,idex,name)
{
	var string = '<td width=50><select onchange=verifyState() id=_'+idex+''+name+'>';

	for(var i = 0;i < options.length;i++){
		if(value == options[i]){
			string +='<option value='+options[i]+' selected>'+options[i]+'</option>';
		}else{
			string +='<option value='+options[i]+'>'+options[i]+'</option>';
		}
	}
	string +="</select></td>";

	return string;
}

	
function verifyFields(focused, quiet)
{
	
	return 1;
}

function isDigit(str)
{ 
  var reg = /^\d*$/; 

  return reg.test(str); 
 }

function verifyState()
{
	var state = 0;
	if (E('_state').value == 'Confirm')
		state = 2;
	else if (E('_state').value == 'Raise')
		state = 1;
	else 
		state = 0;
	
 	cookie.set('state', state);
	//alert(cookie.get('state'));
	//reload page
	reloadPage();
}
/*
function verifyStart()
{
	var start = -1;

	if ((E('_start_id').value != '')
		&& (!isDigit(E('_start_id').value) || (parseInt(E('_start_id').value, 10) < 0))) {
		ferror.set('_start_id', errmsg.al_start_id, false);
		return 0;
	}else{
		ferror.clear('_start_id');
	}


 	if (E('_start_id').value == '') start = -1;
	else start = parseInt(E('_start_id').value, 10);
		
 	cookie.set('start', start);

	//alert(cookie.get('start'));
}

function verifyCnt()
{
	var log_cnt = 0;

	if ((E('_log_cnt').value != '')
		&& (!isDigit(E('_log_cnt').value) 
			|| (parseInt(E('_log_cnt').value, 10) < 1) 
			|| (parseInt(E('_log_cnt').value, 10) > 100))){
		ferror.set('_log_cnt', errmsg.al_count, false);
		return 0;
	}else{
		ferror.clear('_log_cnt');
	}


 	if (E('_log_cnt').value == '') start = 0;
	else log_cnt = parseInt(E('_log_cnt').value, 10);
		
 	cookie.set('count', log_cnt);

	//alert(cookie.get('count'));
}
*/
function save()
{
}




function earlyInit()
{
	alarm_log_grid.setup();
}

function init()
{
/*
	var e = E('find-text');
	if (e) e.onkeypress = function(ev) {
		if (checkEvent(ev).keyCode == 13) find();
	}	
*/
	var disabled = 0;
	if (user_info.priv < admin_priv) {
		disabled = 1;
	}else{
		disabled = 0;
	}

	E('clear-all').disabled = disabled;
	E('confirm-all').disabled = disabled;
	
	ref.initPage(3000, 0);
//	ref.start();
	
}

function ClearAll()
{
	//document.location = 'status-alarm.jsp?show_alarm_log=all';	
	
	E('_fom')._web_cmd.value = "!\nalarm clear all\n";

	if (cookie.get("debugcmd") == 1)
		alert(E('_fom')._web_cmd.value);
	form.submit('_fom', 1);
	
}

function ConfirmAll()
{
	E('_fom')._web_cmd.value = "!\nalarm confirm all\n";

	if (cookie.get("debugcmd") == 1)
		alert(E('_fom')._web_cmd.value);
	form.submit('_fom', 1);
}

function ViewHis()
{
/*
	E('_fom')._web_cmd.value = "!\nconfirm all\n";

	if (cookie.get("debugcmd") == 1)
		alert(E('_fom')._web_cmd.value);
	form.submit('_fom', 1);
	*/
}

function ClearHis()
{
	E('_fom')._web_cmd.value = "!\nalarm clear history\n";

	if (cookie.get("debugcmd") == 1)
		alert(E('_fom')._web_cmd.value);
	form.submit('_fom', 1);
}




</script>

</head>
<body onload='init()'>
<form id='_fom' method='post' action='apply.cgi'>
<input type='hidden' name='_web_cmd' value=''>
<div id='_alarmlog_grid' class='section'>
<table cellspacing=1 id='alarmlog-cfg'>
<script type='text/javascript'>
	//W("<tr id='alarmlog-cfg'>");
	
	W("<td width=200>" + alarm.st+":" + "</td>"); 
	W(creatSelect(['All','Raise','Confirm'],['All','Raise','Confirm'][type], '' ,'state'));
	W("<td width=50>" + "" + "</td>"); 
//	W("<td width=100>" + "<input type='button' style='width:200px' value='"+alarm.lpg+"' id='last_page' onclick='lastPage();'/>"  + "</td>"); 
//	W("<td width=50>" + "" + "</td>"); 
//	W("<td width=100>" + "<input type='button' style='width:200px' value='"+alarm.npg+"' id='next_page' onclick='nextPage();'/>"  + "</td>"); 
/*	
	W("<td width=50>" + "" + "</td>"); 

	
	W("<td width=150>" + "Start From:" + "</td>"); 					
	W("<td width=50><input type='text' onchange='verifyStart()' id='_start_id' value='" + ((start_id >= 0)?(start_id):('')) + "'></td>");
	W("<td width=50>" + "" + "</td>"); 
	W("<td width=150>" + "View Number:" + "</td>"); 					
	W("<td width=50><input type='text' onchange='verifyCnt()' id='_log_cnt' value='" + ((log_cnt > 0)?(log_cnt):('')) + "'></td>");
*/
	W("</tr>");
	W("</tr>");
</script>
</table>
<table class='web-grid' id='alarmlog-grid'></table>	

<script type='text/javascript'>
W("</div>");		
W("<div id='footer'>");
W("<span id='footer-msg'></span>");
W("<input type='button' style='width:200px' value='"+alarm.cla+"' id='clear-all' onclick='ClearAll();'/>");	
W("<input type='button' style='width:200px'  value='"+alarm.coa+"' id='confirm-all' onclick='ConfirmAll();'/>");	
//W("<input type='button' style='width:200px'  value='View History Alarm Log' id='view-his' onclick='ViewHis();'/>");	
//W("<input type='button' style='width:200px'  value='"+alarm.clh+"' id='clear-his' onclick='ClearHis();'/>");	
W("<input type='button' style='width:200px'  value='"+alarm.rl+"' id='reload' onclick='reloadPage();'/>");	
W("</div>");

</script>
</div>

<!--
<div id='footer'>
	<script type='text/javascript'>genStdRefresh(1,5,'ref.toggle()');</script>
</div>
-->
<script type='text/javascript'>earlyInit()</script>
</form>
</body>
</html>

