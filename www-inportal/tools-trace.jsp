<% pagehead(menu.tools_trace) %>
<script type='text/javascript' src='js/inrouter.js'></script>
<link rel='stylesheet' type='text/css' href='css/inrouter.css'>

<style type='text/css'>
#ttr-grid .co1, #ttr-grid .co3 {
	text-align: right;
}
#ttr-grid .co1 {
	width: 30px;
}
#ttr-grid .co2 {
	width: 410px;
}
#ttr-grid .co4, #ttr-grid .co5, #ttr-grid .co6 {
	text-align: right;
	width: 70px;
}
#ttr-grid .header .co1 {
	text-align: left;
}
</style>

<script type='text/javascript'>
var tracedata = '';

var tg = new webGrid();
tg.setup = function() {
	this.init('ttr-grid');
	this.headerSet(['Hop', 'Address', 'Min (ms)', 'Max (ms)', 'Avg (ms)', '+/- (ms)']);
}
tg.populate = function() {
	var seq = 1;
	var buf = tracedata.split('\n');
	var i, j, k;
	var s, f;
	var addr, emsg, min, max, avg;
	var time;
	var last = -1;

	this.removeAllData();
	for (i = 0; i < buf.length; ++i) {
		if (!buf[i].match(/^\s*(\d+)\s+(.+)$/)) continue;
		if (RegExp.$1 != seq) continue;

		s = RegExp.$2;

		if (s.match(/^([\w\.-]+)\s+\(([\d\.]+)\)/)) {
			addr = RegExp.$1;
			if (addr != RegExp.$2) addr += ' (' + RegExp.$2 + ')';
		}
		else addr = '*';

		min = max = avg = '';
		change = '';
		if (time = s.match(/(\d+\.\d+) ms/g)) {		// odd: captures 'ms'
			min = 0xFFFF;
			avg = max = 0;
			k = 0;
			for (j = 0; j < time.length; ++j) {
				f = parseFloat(time[j]);
				if (isNaN(f)) continue;
				if (f < min) min = f;
				if (f > max) max = f;
				avg += f;
				++k
			}
			if (k) {
				avg /= k;
				if (last >= 0) {
					change = avg - last;
					change = change.toFixed(2);
				}
				last = avg;
				min = min.toFixed(2);
				max = max.toFixed(2);
				avg = avg.toFixed(2);
			}
			else {
				min = max = avg = '';
				last = -1;
			}
		}
		else last = -1;

		if (s.match(/ (![<>\w+-]+)/)) emsg = RegExp.$1;
			else emsg = null;

		this.insertData(-1, [seq, addr, min, max, avg, change])
		++seq;
	}

	E('debug').value = tracedata;
	tracedata = '';
	spin(0);
}

function verifyFields(focused, quiet)
{
	var s;
	var e;

	e = E('_f_addr');
	s = e.value.trim();
	if (!s.match(/^[\w\.-]+$/)) {
		ferror.set(e, errmsg.bad_addr, quiet);
		return 0;
	}
	ferror.clear(e);

	return v_range('_f_hops', quiet, 2, 40) && v_range('_f_wait', quiet, 2, 10);
}

var tracer = null;

function spin(x)
{
	E('traceb').disabled = x;
	E('_f_addr').disabled = x;
	E('_f_hops').disabled = x;
	E('_f_wait').disabled = x;
	E('_f_proto').disabled = x;
	E('wait').style.visibility = x ? 'visible' : 'hidden';
	if (!x) tracer = null;
}

function trace()
{
	// Opera 8 sometimes sends 2 clicks
	if (tracer) return;

	if (!verifyFields(null, 0)) return;
	spin(1);

	tracer = new XmlHttp();
	tracer.onCompleted = function(text, xml) {
		eval(text);
		tg.populate();
	}
	tracer.onError = function(x) {
		//alert('error: ' + x);
		spin(0);
	}

	var addr = E('_f_addr').value;
	var hops = E('_f_hops').value;
	var wait = E('_f_wait').value;
	var proto = E('_f_proto').value;
	var option = E('_f_option').value;
	
	tracer.post('trace.cgi', 'addr=' + addr + '&hops=' + hops + '&wait=' + wait + '&icmp=' + proto + '&option=' + option);

	cookie.set('traceaddr', addr);
	cookie.set('tracehops', hops);
	cookie.set('tracewait', wait);
	cookie.set('traceproto', proto);
	cookie.set('traceoption', option);
}

function init()
{
	var s;

	if ((s = cookie.get('traceaddr')) != null) E('_f_addr').value = s;
	if ((s = cookie.get('tracehops')) != null) E('_f_hops').value = s;
	if ((s = cookie.get('tracewait')) != null) E('_f_wait').value = s;
	if ((s = cookie.get('traceproto')) != null) E('_f_proto').value = s;
	if ((s = cookie.get('traceoption')) != null) E('_f_option').value = s;

	E('_f_addr').onkeypress = function(ev) { if (checkEvent(ev).keyCode == 13) trace(); }
}
</script>

</head>
<body onload='init()'>
<form action='javascript:{}'>

<div class='section'>
<script type='text/javascript'>
createFieldTable('', [
	{ title: ui.hst, name: 'f_addr', type: 'text', maxlen: 64, size: 32, value: '', suffix: ' <input type="button" value="Trace" onclick="trace()" id="traceb">' },
	{ title: ui.max_hops, name: 'f_hops', type: 'text', maxlen: 2, size: 4, value: '20' },
	{ title: ui.timeout, name: 'f_wait', type: 'text', maxlen: 2, size: 4, value: '3', suffix: ui.seconds },
	{ title: ui.proto, name: 'f_proto', type: 'select', options: 
		[['1',"ICMP"],['0', "UDP"]], value: "0" },
	{ title: ui.expert, name: 'f_option', type: 'text', maxlen: 64, size: 32, value: '' }
]);
</script>
</div>

<div style="visibility:hidden;text-align:right" id="wait">
<script type='text/javascript'>GetText(infomsg.wait)</script>
<img src='images/spin.gif' style="vertical-align:top"></div>

<table id='ttr-grid' class='web-grid' cellspacing=1 style="display:none"></table>

<textarea id='debug' style='width:99%;height:300px;display:true' readonly></textarea>

<!-- / / / -->

<div id='footer'>&nbsp;</div>
</form>
<script type='text/javascript'>tg.setup();</script>
</body>
</html>
