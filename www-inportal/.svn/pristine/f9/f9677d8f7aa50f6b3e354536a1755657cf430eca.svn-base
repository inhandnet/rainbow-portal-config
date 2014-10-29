<% pagehead(menu.status_interfaces) %>

<script type='text/javascript'>
//var cmd = '<% cgi_get("interface_id")  %>';
//<% web_exec(cgi_get("interface_id")) %>

<% web_interface("interface_id")%>
//var port_stats=[1,1,7,00337753,00000000,00000000,00000000,00000344,00000000,00001006,00000911,00001174,00000912,00000320,00000047,00000068,00000110,00078499,00000000,00000362,00000000,00000001,00000007,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000002,00000000];

function back()
{
	document.location = 'status-interfaces-statistics.jsp';	
}

</script>

</head>
<body onload=''>
<form id='_fom' method='post' action='apply.cgi'>

<div class='section-title'><script type='text/javascript'>GetText(status.detailed_info)</script></div>
<div class='section'>
<script type='text/javascript'>

var port_title = [];
var tmp_data = [];
if(port_stats[0] == 1)
	port_title.push("FE"+port_stats[1]+"/"+port_stats[2]);
else
	port_title.push("GE"+port_stats[1]+"/"+port_stats[2]);

	createFieldTable('', [
		{ title: 'Port', rid: '', text: port_title },
		null,
		{ title: 'InGoodOctetsLo', rid: '', text: port_stats[3]},
		{ title: 'InGoodOctetsHi', rid: '', text: port_stats[4].toString()},
		{ title: 'InBadOctets', rid: '', text: port_stats[5].toString()},
		{ title: 'OutFCSErr', rid: '', text: port_stats[6].toString() },
		{ title: 'InUnicasts', rid: '', text: port_stats[7].toString()},
		{ title: 'Deferred', rid: '', text: port_stats[8].toString()},
		{ title: 'InBroadcasts', rid: '', text: port_stats[9].toString()},
		{ title: 'InMulticasts', rid: '', text: port_stats[10].toString()},
		{ title: 'Octets64', rid: '', text: port_stats[11].toString()},
		{ title: 'Octets65to127', rid: '', text: port_stats[12].toString()},
		{ title: 'Octets128to255', rid: '', text: port_stats[13].toString()},
		{ title: 'Octets256to511', rid: '', text: port_stats[14].toString()},
		{ title: 'Octets512to1023', rid: '', text: port_stats[15].toString()},
		{ title: 'OctetsMax', rid: '', text: port_stats[16].toString()},
		{ title: 'OutOctetsLo', rid: '', text: port_stats[17].toString()},
		{ title: 'OutOctetsHi', rid: '', text: port_stats[18].toString()},
		{ title: 'OutUnicasts', rid: '', text: port_stats[19].toString()},
		{ title: 'Excessive', rid: '', text: port_stats[20].toString()},
		{ title: 'OutMulticasts', rid: '', text: port_stats[21].toString()},
		{ title: 'OutBroadcasts', rid: '', text: port_stats[22].toString()},
		{ title: 'Single', rid: '', text: port_stats[23].toString()},
		{ title: 'OutPause', rid: '', text: port_stats[24].toString()},
		{ title: 'InPause', rid: '', text: port_stats[25].toString()},
		{ title: 'Multiple', rid: '', text: port_stats[26].toString()},
		{ title: 'Undersize', rid: '', text: port_stats[27].toString()},
		{ title: 'Fragments', rid: '', text: port_stats[28].toString()},
		{ title: 'Oversize', rid: '', text: port_stats[29].toString() },
		{ title: 'Jabber', rid: '', text: port_stats[30].toString()},
		{ title: 'InMACRcvErr', rid: '', text: port_stats[31].toString()},
		{ title: 'InFCSErr', rid: '', text: port_stats[32].toString()},
		{ title: 'Collisions', rid: '', text: port_stats[33].toString()},
		{ title: 'Late', rid: '', text: port_stats[34].toString()},
		{ title: 'inDiscardLo', rid: '', text: port_stats[35].toString()},
		{ title: 'inDiscardHi', rid: '', text: port_stats[36].toString()},
		{ title: 'inFiltered', rid: '', text: port_stats[37].toString()},
		{ title: 'outFiltered', rid: '', text: port_stats[38].toString()},
		]);
		
W("</div>");		
W("<div id='footer'>");
W("<span id='footer-msg'></span>");
W("<input type='button' value='" + ui.bk + "' id='back-button' onclick='back();'/>");	
W("</div>");
	
</script>
</form>
</body>
</html>
