<% pagehead(menu.tools_ping) %>

<style type='text/css'>
#tp-grid .co1 {
	text-align: right;
	width: 30px;
}
#tp-grid .co2 {
	width: 440px;
}
#tp-grid .co3, #tp-grid .co4, #tp-grid .co5, #tp-grid .co6 {
	text-align: right;
	width: 70px;
}
#tp-grid .header .co1 {
	text-align: left;
}
</style>

<script type='text/javascript'>
var pingdata = '';

var pg = new webGrid();
pg.setup = function() {
	this.init('tp-grid');
	this.headerSet([ui.seq, ui.hst, ui.rx, 'TTL', 'RTT (ms)', '+/- (ms)']);
}
pg.populate = function()
{
	var buf = pingdata.split('\n');
	var i;
	var r, s, t;
	var last = -1;
	var resolv = [];
	var stats = '';

	this.removeAllData();
	for (i = 0; i < buf.length; ++i) {
		if (r = buf[i].match(/^(\d+) bytes from (.+): icmp_seq=(\d+) ttl=(\d+) time=(\d+\.\d+) ms/)) {
			r.splice(0, 1);
			t = r[0];
			r[0] = r[2];
			r[2] = t;
			if (resolv[r[1]]) r[1] = resolv[r[1]] + ' (' + r[1] + ')';
			r[4] *= 1;
			r[5] = (last > 0) ? (r[4] - last).toFixed(2) : '';
			r[4] = r[4].toFixed(2);
			this.insertData(-1, r)
			last = r[4];
		}
		else if (buf[i].match(/^PING (.+) \((.+)\)/)) {
			resolv[RegExp.$2] = RegExp.$1;
		}
		else if (buf[i].match(/^(\d+) packets.+, (\d+) packets.+, (\d+%)/)) {
			stats = '   Packets: ' + RegExp.$1 + ' transmitted, ' + RegExp.$2 + ' received, ' + RegExp.$3 + ' lost<br>';
		}
		else if (buf[i].match(/^round.+ (\d+\.\d+)\/(\d+\.\d+)\/(\d+\.\d+)/)) {
			stats = 'Round-Trip: ' + RegExp.$1 + ' min, ' + RegExp.$2 + ' avg, ' + RegExp.$3 + ' max (ms)<br>' + stats;
		}
	}

	E('stats').innerHTML = stats;
	E('debug').value = pingdata;
	pingdata = '';
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

	return v_range('_f_count', quiet, 1, 50) && v_range('_f_size', quiet, 8, 10240);
}


var pinger = null;

function spin(x)
{
	E('pingb').disabled = x;
	E('_f_addr').disabled = x;
	E('_f_count').disabled = x;
	E('_f_size').disabled = x;
	E('_f_option').disabled = x;
	E('wait').style.visibility = x ? 'visible' : 'hidden';
	if (!x) pinger = null;
}

function ping()
{
	// Opera 8 sometimes sends 2 clicks
	if (pinger) return;

	if (!verifyFields(null, 0)) return;

	spin(1);

	pinger = new XmlHttp();
	pinger.onCompleted = function(text, xml) {
		eval(text);
		pg.populate();
	}
	pinger.onError = function(x) {
		//alert('error: ' + x);
		spin(0);
	}

	var addr = E('_f_addr').value;
	var count = E('_f_count').value;
	var size = E('_f_size').value;
	var option = E('_f_option').value;
	
	pinger.post('ping.cgi', 'addr=' + addr + '&count=' + count + '&size=' + size + '&option=' + option);

	cookie.set('pingaddr', addr);
	cookie.set('pingcount', count);
	cookie.set('pingsize', size);
	cookie.set('pingoption', option);
}

function init()
{
	var s;

	if ((s = cookie.get('pingaddr')) != null) E('_f_addr').value = s;
	if ((s = cookie.get('pingcount')) != null) E('_f_count').value = s;
	if ((s = cookie.get('pingsize')) != null) E('_f_size').value = s;
	if ((s = cookie.get('pingoption')) != null) E('_f_option').value = s;

	E('_f_addr').onkeypress = function(ev) { if (checkEvent(ev).keyCode == 13) ping(); }
}
</script>

</head>
<body onload='init()'>
<form action='javascript:{}'>

<div class='section-title'></div>
<div class='section'>
<script type='text/javascript'>
createFieldTable('', [
	{ title: ui.hst, name: 'f_addr', type: 'text', maxlen: 64, size: 32, value: '',
		suffix: ' <input type="button" value="Ping" onclick="ping()" id="pingb">' },
	{ title: ui.cnt, name: 'f_count', type: 'text', maxlen: 2, size: 7, value: '4' },
	{ title: ui.psize, name: 'f_size', type: 'text', maxlen: 5, size: 7, value: '32', suffix: ui.bytes },
	{ title: ui.expert, name: 'f_option', type: 'text', maxlen: 64, size: 32, value: '' }
]);
</script>
</div>

<div style="visibility:hidden;text-align:right" id="wait">
<script type='text/javascript'>GetText(infomsg.wait)</script>
<img src='images/spin.gif' style="vertical-align:top"></div>

<table id='tp-grid' class='web-grid' cellspacing=1 style="display:none"></table>
<pre id='stats' style="display:none"></pre>

<textarea id='debug' style='width:99%;height:300px;display:true;' readonly></textarea>

<div id='footer'>&nbsp;</div>
</form>
<script type='text/javascript'>pg.setup()</script>
</body>
</html>
