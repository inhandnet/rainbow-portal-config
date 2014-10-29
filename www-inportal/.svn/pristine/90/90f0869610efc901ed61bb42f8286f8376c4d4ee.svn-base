<% pagehead(menu.status_eth) %>

<script type="text/javascript" src="status-pppoe.jsx"></script>

<script type='text/javascript'>

var ref = new webRefresh('status-pppoe.jsx', '', 0, 'status_pppoe_refresh');
var wan_status_list=[ui.disconnected,ui.connected];

function formatTime(second) {
    var time = parseFloat(second); 
    var data = "";
    
    if (null!= time &&""!= time) {
	     var day = parseInt(Math.floor(time / 86400));  
   	     var hour = Math.floor(parseInt(Math.floor(time/3600)) - parseInt(Math.floor(time/86400)*24));  
   	     var minute = Math.floor(parseInt(Math.floor(time/60)) - parseInt(Math.floor(time/3600)*60));  
   	     var second = Math.floor(time - parseInt(Math.floor(time/60)*60)); 
	     
	     if(day <= 1) data += day + " day, ";
	     else if(day >= 2) data += day + " days, ";
	     else data += "0 day, ";
	     
   	     if ((hour > 0)&&(hour <= 9)) data += "0" + hour + ":";
   	     else if (hour >= 10) data += hour + ":";
	     else data += "00:"
	     
  	     if ((minute > 0)&&(minute <= 9)) data += "0" + minute + ":";  
	     else if(minute >= 10) data += minute + ":";
	     else data += "00:"
	     
  	     if ((second > 0)&&(second <= 9)) data += "0" + second;  
  	     else if (second >= 10) data += second;  
	     else data += "00";
    }else{  
        data = "";  
    }  
    return data;
}

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

function show_xdsl()
{
	//alert(eths.length);
	for (var i= 0; i < xdsl_interface.length; i++) {
		//c('conn_'+i, conn_type[eths[i][6]]);
		if (!xdsl_interface[i][2]) {
			xdsl_interface[i][3] = "0.0.0.0";
			xdsl_interface[i][4] = "0.0.0.0";
			xdsl_interface[i][5] = "0.0.0.0";
			xdsl_interface[i][6] = "0.0.0.0";
		}
		c('ip_'+i, xdsl_interface[i][3]);
		c('mask_'+i, xdsl_interface[i][4]);
		c('stat_'+i, wan_status_list[xdsl_interface[i][2]]);
		c('gw_'+i, xdsl_interface[i][5]);
		c('dns_'+i, xdsl_interface[i][6]);
		c('mtu_'+i, xdsl_interface[i][7]);
		c('uptime_'+i, formatTime(xdsl_interface[i][8]));
	//	c('lease_'+i, formatTime(xdsl_interface[i][10]));
	}
}

ref.refresh = function(text)
{
	try {
		eval(text);
	}
	catch (ex) {
	}
	//alert(eths);
	show_xdsl();
	//show_modem();
	//show_networks();
}
function earlyInit()
{
	show_xdsl();
//	show_modem();
//	show_networks();
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
for (var i = 0; i < xdsl_interface.length; i++) {
	W("<div class='section-title' id='xdsl-title'>" + vif_name_format(xdsl_interface[i][0]) + "</div>");
	W("<div class='section' id='xdsl-section'>");
	createFieldTable('', [
		//{ title: ui.conn_type, rid:'conn_'+i},
		{ title: menu.stat, rid: 'stat_'+i},
		{ title: ui.ip, rid: 'ip_'+i},
		{ title: ui.netmask, rid: 'mask_'+i},
		{ title: ui.gateway, rid: 'gw_'+i},
		{ title: ui.dns, rid: 'dns_'+i},
		{ title: ui.mtu, rid: 'mtu_'+i},
		{ title: ui.conn_time, rid: 'uptime_'+i}
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
