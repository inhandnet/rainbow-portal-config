<% pagehead(menu.status_lldp_gl) %>
<style type='text/css'>
#br-grid {
	width: 400px;	
}
#br-grid .co1{
	width: 200px;	
	text-align: left;
}

</style>

<script type='text/javascript'>
<% ih_sysinfo() %>
<% ih_user_info(); %>


<% web_exec('show lldp traffic') %>

var age_index = 0;
var insert_index = 1;
var drops_index = 2;
var delete_index = 3;


var lldp_gl = new webGrid();

lldp_gl.loadData = function() {
	this.insertData(-1, [lldp.ageout, ""+lldp_traffic[age_index]]);
	this.insertData(-1, [lldp.insert, ""+lldp_traffic[insert_index]]);
	this.insertData(-1, [lldp.drops, ""+lldp_traffic[drops_index]]);
	this.insertData(-1, [lldp.del, ""+lldp_traffic[delete_index]]);		
}


lldp_gl.setup = function() {
	this.init('br-grid', ['readonly'], 4, [
		{ type: 'text', maxlen: 128 },
		{ type: 'text', maxlen: 128 },
		{ type: 'text', maxlen: 128 },
		{ type: 'text', maxlen: 128 }
	]);
	lldp_gl.loadData();
}

var ref = new webRefresh('status-lldp-gl.jsx', '', 0, 'status_lldp_gl_refresh');

ref.refresh = function(text)
{
	lldp_traffic = [];
	try {
		eval(text);
	}
	catch (ex) {
		lldp_traffic = [];
	}
	show();
}



function show()
{	
	lldp_gl.removeAllData();
	lldp_gl.loadData();
}

function earlyInit()
{
	lldp_gl.setup();
	//show();
}

function init()
{
	lldp_gl.recolor();
	ref.initPage(3000, 0);
}



</script>

</head>
<body onload='init()'>
<form>

<div class='section'>
	<table class='web-grid' id='br-grid'></table>
</div>

<div id='footer'>
	<script type='text/javascript'>genStdRefresh(1,0,'ref.toggle()');</script>
</div>
</form>

<script type='text/javascript'>earlyInit();</script>
</body>
</html>

