<% pagehead(menu.fw_acl) %>

<style type='text/css'>
#acl-grid .co1 {
	width: 40px;
	text-align: center;
}
#acl-grid .co2 {
	width: 100px;
}
#acl-grid .co3 {
	width: 120px;
}
#acl-grid .co4 {
	width: 80px;
}
#acl-grid .co5 {
	width: 120px;
}
#acl-grid .co6 {
	width: 80px;
}
#acl-grid .co7 {
	width: 80px;
}
#acl-grid .co8 {
	width: 60px;
}

</style>

<script type='text/javascript'>

<% nvram("fw_strict,fw_acl"); %>

var aclg = new webGrid();
var nvram = {
 fw_strict: '',
 fw_acl: '1<1<0.0.0.0/0<<<<1<0<>1<2<0.0.0.0/0<<<<1<0<>1<4<0.0.0.0/0<<<<1<0<46>1<4<0.0.0.0/0<<<<1<0<78946>'
}; 

aclg.dataToView = function(data) {
	return [(data[0] != '0') ? ui.yes : ui.no, ['TCP', 'UDP', 'ICMP', ui.al][data[1] - 1], (data[2].match(/(.+)-(.+)/)) ? (RegExp.$1 + ' -<br>' + RegExp.$2) : data[2], data[3], (data[4].match(/(.+)-(.+)/)) ? (RegExp.$1 + ' -<br>' + RegExp.$2) : data[4], data[5], [fw.accept, fw.drop][data[6]*1 - 1], (data[7] != '0') ? ui.yes : ui.no, data[8]];
}

aclg.fieldValuesToData = function(row) {
	var f = fields.getAll(row);
	return [f[0].checked ? 1 : 0, f[1].value, f[2].value, f[3].value, f[4].value, f[5].value, f[6].value, f[7].checked ? 1 : 0, f[8].value];
}

aclg.verifyFields = function(row, quiet) {
	var f = fields.getAll(row);
	var s;

	f[2].value = f[2].value.trim();
	ferror.clear(f[2]);
	if ((f[2].value.length) && (!v_iptip(f[2], 0))) return 0;

	if (f[1].value <= 2){
		ferror.clear(f[3]);
		f[3].value = f[3].value.trim();
		if (f[3].value.length && !v_iptport(f[3], quiet)) return 0;
		f[3].disabled = 0;
	}else{
		f[3].disabled = 1;
	}
		
	ferror.clear(f[4]);
	if ((f[4].value.length) && (!v_iptip(f[2], 0))) return 0;
	
	if (f[1].value <= 2){
		ferror.clear(f[5]);
		f[5].value = f[5].value.trim();
		if (f[5].value.length && !v_iptport(f[5], quiet)) return 0;
		f[5].disabled = 0;
	}else{
		f[5].disabled = 1;
	}
			
	f[8].value = f[8].value.replace(/>/g, '_');
	return 1;
}

aclg.resetNewEditor = function() {
	var f = fields.getAll(this.newEditor);
	f[0].checked = 1;
	f[1].selectedIndex = 3;
	f[2].value = '0.0.0.0/0';
	f[3].value = '';
	f[4].value = '';
	f[5].value = '';
	f[6].selectedIndex = 0;
	f[7].checked = 0;
	
	f[3].disabled = 1;
	f[5].disabled = 1;
		
	ferror.clearAll(fields.getAll(this.newEditor));
}

aclg.setup = function() {
	this.init('acl-grid', 'move', 50, [
		{ type: 'checkbox' },
		{ type: 'select', options: [[1, 'TCP'],[2, 'UDP'],[3,'ICMP'],[4, ui.al ]] },
		{ type: 'text', maxlen: 32 },
		{ type: 'text', maxlen: 16 },
		{ type: 'text', maxlen: 32 },
		{ type: 'text', maxlen: 16 },
		{ type: 'select', options: [[1, fw.accept],[2, fw.drop]] },
		{ type: 'checkbox' },
		{ type: 'text', maxlen: 32 }]);
	this.headerSet([ui.enable, fw.proto, fw.src_ip, fw.src_port, fw.dst, fw.dst_port, fw.act, fw.log, ui.desc]);

	var nv = nvram.fw_acl.split('>');
	for (var i = 0; i < nv.length; ++i) {
		var r;
		
		if (r = nv[i].match(/^(\d)<(\d)<(.*)<(.*)<(.*)<(.*)<(\d)<(\d)<(.*)$/)) {
			r[1] *= 1;
			r[2] *= 1;
			r[3] = r[3].length==0 ? '0.0.0.0' : r[3];
			r[4] = r[4].replace(/:/g, '-');
			r[6] = r[6].replace(/:/g, '-');
			r[7] *= 1;
			r[8] *= 1;
			//if (!fixIP(r[5], 1)) r[5] = lipp + r[5];
			aclg.insertData(-1, [r[1], r[2], r[3], r[4], r[5], r[6],r[7],r[8],r[9]]);
		}
	}
	aclg.showNewEditor();
}

function verifyFields(focused, quiet)
{
	return 1;
}

function save()
{
	if (!verifyFields(null, false)) return;	
	
	if (aclg.isEditing()) return;

	var data = aclg.getAllData();
	var s = '';
	for (var i = 0; i < data.length; ++i) {
		data[i][3] = data[i][3].replace(/-/g, ':');
		data[i][5] = data[i][5].replace(/-/g, ':');
		s += data[i].join('<') + '>';
	}
	var fom = E('_fom');
	fom.fw_acl.value = s;
	form.submit(fom, 1);
}

function init()
{
	aclg.recolor();
	aclg.resetNewEditor();
}
</script>
</head>
<body onload='init()'>
<form id='_fom' method='post' action='apply.cgi'>
<input type='hidden' name='_service' value='firewall-restart'/>
<input type='hidden' name='fw_acl'/>

<div class='section-title'></div>
<div class='section'>
	<table class='web-grid' cellspacing=1 id='acl-grid'></table>
	<script type='text/javascript'>aclg.setup();</script>
</div>

<script type='text/javascript'>genStdFooter("");</script>
</form>
</body>
</html>
