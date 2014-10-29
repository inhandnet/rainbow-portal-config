<% pagehead(menu.status_log) %>
<style type='text/css'>
#log-grid .co1 {
	width: 30px;
}
#log-grid .co2 {
	width: 100px;
}
#log-grid .co3 {
	width: 100px;
}

#slog-grid .co1 {
	width: 30px;
}
#slog-grid .co2 {
	width: 100px;
}


</style>

<script type='text/javascript'>
<% ih_user_info(); %>

var operator_priv = 12;

var syslog = '';
var slogg = new webGrid();

slogg.dataToView = function(data) {
	return data;
}

slogg.verifyFields = function(row, quiet) {
	return 1;
}

slogg.setup = function() {
	this.init('slog-grid', ['readonly', 'sort'], 250, [
		{ type: 'text', maxlen: 64 }, 
		{ type: 'text', maxlen: 64 }, 
		//{ type: 'text', maxlen: 64 }, 
		{ type: 'text', maxlen: 256 }
		]);
	this.headerSet([ui.lv, ui.time2, /*ui.module,*/ ui.content]);	
	//r = this.footerSet(['', '', '', '<input type="button" style="width:140px" value="' + ui.clrlog + '" onclick="clearlog()" id="log-clear"><input type="button" style="width:140px" value="' + infomsg.log4 + '" onclick="download()" id="log-download"><input type="button" style="width:250px" value="' + infomsg.diagnose + '" onclick="diagnose()" id="log-diagnose">']);
	//r = this.footerSet(['', '', /*'',*/ '<input type="button" style="width:140px" value="' + ui.clrlog + '" onclick="clearlog()" id="log-clear"><input type="button" style="width:140px" value="' + infomsg.log4 + '" onclick="download()" id="log-download">']);
	r = this.footerSet(['', '', /*'',*/ '<input type="button" style="width:140px" value="' + ui.clrlog + '" onclick="clearlog()" id="log-clear"><input type="button" style="width:160px" value="' + infomsg.log4 + '" onclick="download()" id="log-download"><input type="button" style="width:250px" value="' + infomsg.diagnose + '" onclick="diagnose()" id="log-diagnose"><br><input type="button" style="width:140px" value="' + ui.clrhlog + '" onclick="clearhistorylog()" id="hlog-clear"><input type="button" style="width:160px" value="' + infomsg.log5 + '" onclick="history_download()" id="history-download">']);
}

var lines = cookie.get('loglines');
if(lines==null) lines = 20;

var ref = new webRefresh('viewlog.cgi', 'lines=' + lines, 0, 'status_log_refresh');
ref.refresh = function(text)
{
	syslog = text;
	update();
}

function setup_filter()
{
	var s = '';
	lines = E('_f_lines').value;
	
	cookie.set('loglines', lines);
	
	s += 'lines=' + lines;
//	s += 'level=' + E('_f_level').value;
//	s += '&type=' + E('_f_type').value;
//	s += '&find=' + escapeHTML(E('_f_find').value);
	
	ref.postData = s;
	ref.stop();
	ref.start();
}

function verifyFields(focused, quiet)
{
	if(E('_f_lines').value!=lines) setup_filter();
	
	return 1;
}

function save()
{
}

function update()
{
	slogg.removeAllData();
	
	if(syslog==''){
		slogg.insertData(-1, ['', '', /*'',*/ infomsg.nolog]);
		return;
	}

	var i, r, x, s, z1, z, r2;
	var v = syslog.split('\n');
	var level, tm, module, content;
	var maxlogs;

	n = 0;
	s = lines;
	if(s=='all') maxlogs = 250;
	else maxlogs = s * 1;
	
	if(v.length<maxlogs) i = 0;
	else{
		slogg.insertData(-1, ["", "", /*"",*/ "<a href='log/syslog.log'>" + infomsg.omit + "</a>"]);
		i = v.length-maxlogs - 1;
	}

	for (; i < v.length; ++i) {
		x = v[i];
		if(x.length<16) continue;
		
		z1 = x.indexOf('>', 1);
		if(z1<=0) continue;		
		level = x.substr(1, z1-1) * 1;
		z1 += 2;
	
		tm = x.substr(z1, 15);
		
		z1 += 16;

		
		//z = x.indexOf(':', z1);
		//if(z<=0) continue;
		//module = x.substr(z1, z-z1);

		//zly: convert '<a' to '< a'
		content = x.substr(z1).replace(/</g, '< ');
		content = content.replace(/>/g, ' >');

		//slogg.insertData(-1, [log_prio[(level&0x07)], tm,  x.substr(z1)/*module, x.substr(z+2)*/]);
		slogg.insertData(-1, [log_prio[(level&0x07)], tm, content]);
		n++;
	}	
}


function find()
{
	var s = E('find-text').value;
	if (s.length) document.location = 'viewlog.cgi?find=' + escapeCGI(s);
}

function clearlog()
{
	if(!confirm(infomsg.confm_clrlog)) return;

	location.href = 'clearlog.cgi';
}

function clearhistorylog()
{
	if(!confirm(infomsg.confm_clrhlog)) return;

	location.href = 'clearhistorylog.cgi';
}

function download()
{
	location.href = 'log/syslog.log';
}

function diagnose()
{
	location.href = 'diagnose.dat';
}

function history_download()
{
	location.href = 'log/history.log';
}


function earlyInit()
{
	slogg.setup();
}

function init()
{
	var e = E('find-text');
	if (e) e.onkeypress = function(ev) {
		if (checkEvent(ev).keyCode == 13) find();
	}	
	
	var disabled = 0;
	if (user_info.priv < operator_priv) {
		disabled = 1;
	}else{
		disabled = 0;
	}

	E('log-clear').disabled = disabled;
	E('hlog-clear').disabled = disabled;
	
	ref.initPage(10000, 0);
	ref.start();
}
</script>

</head>
<body onload='init()'>
<form id='_fom' action='javascript:{}'>


<div class='section'>
<script type='text/javascript'>
createFieldTable('', [
/*	{ title: ui.lv, name: 'f_level', type: 'select', options: 
		log_prio_list,
		value: 'all' },
//	{ title: ui.fnd, name: 'f_find', type: 'text', maxlen: 15, size: 17, value: '' },
	{ title: infomsg.rctlog, name: 'f_lines', type: 'select', suffix : ' ' + ui.lines + " " + "<input type='button' value='" + ui.filter + "' onclick='setup_filter()'>", options: [['20','20'], ['50','50'],['100','100'],['200','200'],['500','500'],['1000','1000'],['all',ui.al]],
		value: '20' }
*/
	{ title: infomsg.rctlog, name: 'f_lines', type: 'select', suffix : ' ' + ui.lines,
		options: [['20','20'], ['50','50'],['100','100'],['200','200'],['all',ui.al]],
		value: lines }
]);
</script>
	</div>
</div>

<div id='_slog_grid' class='section'>
	<table class='web-grid' id='slog-grid'></table>	
</div>

<div id='footer'>
	<script type='text/javascript'>genStdRefresh(1,5,'ref.toggle()');</script>
</div>

<script type='text/javascript'>earlyInit()</script>
</form>
</body>
</html>
