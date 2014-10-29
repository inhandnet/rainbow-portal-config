<% pagehead(menu.status_interfaces) %>

<script type='text/javascript'>
//var cmd = '<% cgi_get("interface_id")  %>';
//<% web_exec(cgi_get("interface_id")) %>
var port_stats = [];
<% web_interface()%>
//var port_stats=[1,1,7,00337753,00000000,00000000,00000000,00000344,00000000,00001006,00000911,00001174,00000912,00000320,00000047,00000068,00000110,00078499,00000000,00000362,00000000,00000001,00000007,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000002,00000000];

var port_cmd = "";
if (port_stats.length > 3){
	port_cmd = ((port_stats[0] == 1)?("fastethernet "):(" gigabitethernet "))+port_stats[1]+"/"+port_stats[2];
}

function back()
{
	document.location = 'status-port-statistics.jsp';	
}

function c(id, htm)
{
	E(id).cells[1].innerHTML = htm;
}

function update()
{
/*
	alert(port_stats.length + "\n"+
		"inoctets "+port_stats[3]+
		"outoctets "+port_stats[4].toString());
*/
	c('port', (((port_stats[0] == 1)?("FE"):("GE"))+port_stats[1]+"/"+port_stats[2]));
	c('inoctets',  port_stats[3]);
	c('outoctets', port_stats[4].toString());	
	c('indiscard', port_stats[5].toString());
	c('inunicasts', port_stats[6].toString());
	c('outunicasts', port_stats[7].toString());
	c('inbroad', port_stats[8].toString());
	c('outbroad', port_stats[9].toString());
	
	c('inmcast', port_stats[10].toString());	
	c('outmcast', port_stats[11].toString());
	c('octets64', port_stats[12].toString());
	c('octets65', port_stats[13].toString());
	c('octets128', port_stats[14].toString());
	c('octets256', port_stats[15].toString());
	c('octets512', port_stats[16].toString());
	c('octets1024', port_stats[17].toString());	
	c('inbad', port_stats[18].toString());
	c('inmac', port_stats[19].toString());
	
	c('inunder', port_stats[20].toString());
	c('infrag', port_stats[21].toString());
	c('inover', port_stats[22].toString());
	c('injabber', port_stats[23].toString());
	c('infcs', port_stats[24].toString());
	c('outfcs', port_stats[25].toString());
	c('inpause', port_stats[26].toString());	
	c('outpause', port_stats[27].toString());
	c('defer', port_stats[28].toString());
	c('coll', port_stats[29].toString());
	
	c('single', port_stats[30].toString());
	c('multiple', port_stats[31].toString());
	c('excessive', port_stats[32].toString());
	c('late', port_stats[33].toString());
	c('infilter', port_stats[34].toString());
	c('outfilter', port_stats[35].toString());

	port_stats = [];

}

var ref = new webRefresh('status-port-detailed.jsx', 'interface_id=show interface '+ port_cmd +' statistics', 0, 'status_port_detailed_refresh');

ref.refresh = function(text)
{
//	alert(text);
	try {
		eval(text);
	}
	catch (ex) {
		;
	}
	update();
}

</script>

</head>
<body onload=''>
<form id='_fom' method='post' action='apply.cgi'>

<div class='section-title'><script type='text/javascript'>GetText(sts.detailed_info)</script></div>
<div class='section'>
<script type='text/javascript'>

var port_title = [];
var tmp_data = [];
if(port_stats[0] == 1)
	port_title.push("FE"+port_stats[1]+"/"+port_stats[2]);
else
	port_title.push("GE"+port_stats[1]+"/"+port_stats[2]);

	createFieldTable('', [
		{ title: port.port, rid: 'port', text: port_title },
		null,
		{ title: portstatus.inoctets, rid: 'inoctets', text: port_stats[3]},
		{ title: portstatus.outoctets, rid: 'outoctets', text: port_stats[4].toString()},
		{ title: portstatus.indiscard, rid: 'indiscard', text: port_stats[5].toString()},
		{ title: portstatus.inunicasts, rid: 'inunicasts', text: port_stats[6].toString() },
		{ title: portstatus.outunicasts, rid: 'outunicasts', text: port_stats[7].toString()},
		{ title: portstatus.inbroad, rid: 'inbroad', text: port_stats[8].toString()},
		{ title: portstatus.outbroad, rid: 'outbroad', text: port_stats[9].toString()},
		{ title: portstatus.inmcast, rid: 'inmcast', text: port_stats[10].toString()},
		{ title: portstatus.outmcast, rid: 'outmcast', text: port_stats[11].toString()},
		{ title: portstatus.octets64, rid: 'octets64', text: port_stats[12].toString()},
		{ title: portstatus.octets65, rid: 'octets65', text: port_stats[13].toString()},
		{ title: portstatus.octets128, rid: 'octets128', text: port_stats[14].toString()},
		{ title: portstatus.octets256, rid: 'octets256', text: port_stats[15].toString()},
		{ title: portstatus.octets512, rid: 'octets512', text: port_stats[16].toString()},
		{ title: portstatus.octets1024, rid: 'octets1024', text: port_stats[17].toString()},
		{ title: portstatus.inbad, rid: 'inbad', text: port_stats[18].toString()},
		{ title: portstatus.inmac, rid: 'inmac', text: port_stats[19].toString()},
		{ title: portstatus.inunder, rid: 'inunder', text: port_stats[20].toString()},
		{ title: portstatus.infrag, rid: 'infrag', text: port_stats[21].toString()},
		{ title: portstatus.inover, rid: 'inover', text: port_stats[22].toString()},
		{ title: portstatus.injabber, rid: 'injabber', text: port_stats[23].toString()},
		{ title: portstatus.infcs, rid: 'infcs', text: port_stats[24].toString()},
		{ title: portstatus.outfcs, rid: 'outfcs', text: port_stats[25].toString()},
		{ title: portstatus.inpause, rid: 'inpause', text: port_stats[26].toString()},
		{ title: portstatus.outpause, rid: 'outpause', text: port_stats[27].toString()},
		{ title: portstatus.defer, rid: 'defer', text: port_stats[28].toString()},
		{ title: portstatus.coll, rid: 'coll', text: port_stats[29].toString() },
		{ title: portstatus.single, rid: 'single', text: port_stats[30].toString()},
		{ title: portstatus.multiple, rid: 'multiple', text: port_stats[31].toString()},
		{ title: portstatus.excessive, rid: 'excessive', text: port_stats[32].toString()},
		{ title: portstatus.late, rid: 'late', text: port_stats[33].toString()},
		{ title: portstatus.infilter, rid: 'infilter', text: port_stats[34].toString()},
		{ title: portstatus.outfilter, rid: 'outfilter', text: port_stats[35].toString()}
		]);
		
W("</div>");		
W("<div id='footer'>");
W("<span id='footer-msg'></span>");
W("<input type='button' value='" + ui.bk + "' id='back-button' onclick='back();'/>");	
W("</div>");

port_stats = [];
</script>
</form>
<div id='footer'>
	<script type='text/javascript'>genStdRefresh(1,5,'ref.toggle()');</script>
</div>	
</body>
</html>
