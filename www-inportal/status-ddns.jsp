<% pagehead(menu.status_ddns) %>

<script type="text/javascript" src="status-ddns.jsx"></script>

<script type='text/javascript'>
var ref = new webRefresh('status-ddns.jsx', '', 0, 'status_ddns_refresh');

function c(id, htm)
{
	E(id).cells[1].innerHTML = htm;
}

/*Ê××ÖÄ¸´óÐ´*/
function vif_name_format(ifname)
{
	var reg = /\b(\w)|\s(\w)/g;
	return ifname.replace(reg,function(m){return m.toUpperCase()})
}

function show_ddns()
{
	
	for (var i= 0; i < ddns_update.length; i++) {
		c('method_'+i, ddns_status[i][1]);
		c('host_'+i, ddns_status[i][2]);
		c('ip_'+i, ddns_status[i][3]);
		c('up_'+i, ddns_status[i][4]);
		c('res_'+i, ddns_status[i][5]);
	}
}

ref.refresh = function(text)
{
	try {
		eval(text);
	}
	catch (ex) {
	}
	show_ddns();
}
function earlyInit()
{
	show_ddns();
}

function init()
{
	ref.initPage(3000, 0);
}

</script>

</head>
<body onload='init()'>
<form id='_fom' method='post' action=''>

<script type='text/javascript'>	
for (var i = 0; i < ddns_status.length; i++) {
	W("<div class='section-title' id='ddns-up-title'>" + vif_name_format(ddns_status[i][0]) + "</div>");
	W("<div class='section' id='ddns-up-section'>");
	createFieldTable('', [
		{ title: ui.ddns_method, rid:'method_'+i},
		{ title: ui.ddns_hostname, rid: 'host_'+i},
		{ title: ui.ip, rid: 'ip_'+i},
		{ title: ui.last + ' ' + ui.update, rid: 'up_'+i},
		{ title: ui.last + ' ' + ui.response, rid: 'res_'+i}
	]);
	W("</div>");
}
</script>
</div>

<div id='footer'>
	<script type='text/javascript'>genStdRefresh(1,0,'ref.toggle()');</script>
</div>
</form>

<script type='text/javascript'>earlyInit();</script>
</body>
</html>
