<% pagehead(menu.status_gps) %>

<script type="text/javascript" src="status-gps.jsx"></script>

<script type='text/javascript'>


var ref = new webRefresh('status-gps.jsx', '', 0, 'status_gps_refresh');
//var mode=wlan_mode[0];

ref.refresh = function(text)
{
	try {
		eval(text);
	}
	catch (ex) {
	}
	show_gps_time();
	show_gps_position();
	show_gps_speed();
}

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

function show_gps_time()
{
	c('gps_time', gps_position.gps_time);
}

function show_gps_position()
{
	//c('gps_n_s', gps_position.n_s_indicator);
	c('gps_latitude', gps_position.latitude);
	//c('gps_e_w', gps_position.e_w_indicator);
	c('gps_longitude', gps_position.longitude);
}

function show_gps_speed()
{
	c('gps_speed', gps_position.speed);
}

function earlyInit()
{
	show_gps_time();
	show_gps_position();
	show_gps_speed();
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
W("<div class='section-title' id='gps-time-title'>" + menu.status_gps_time + "</div>");
W("<div class='section' id='gps-time-section'>");
createFieldTable('', [
		{ title: ui.gps_time, rid: 'gps_time'}
	]);
W("</div>");	

W("<div class='section-title' id='gps-pos-title'>" + menu.status_gps_pos + "</div>");
W("<div class='section' id='gps-pos-section'>");
createFieldTable('', [
	//{ title: ui.gps_n_s, rid: 'gps_n_s' },
	{ title: ui.gps_latitude, rid: 'gps_latitude'},
	//{ title: ui.gps_e_w, rid: 'gps_e_w'},
	{ title: ui.gps_longitude, rid: 'gps_longitude'}
]);
W("</div>");

W("<div class='section-title' id='gps-speed-title'>" + menu.status_gps_speed + "</div>");
W("<div class='section' id='gps-speed-section'>");
createFieldTable('', [
	{ title: ui.gps_speed, rid: 'gps_speed'}
]);
W("</div>");

</script>
</div>

<div id='footer'>
	<script type='text/javascript'>genStdRefresh(1,0,'ref.toggle()');</script>
</div>
</form>

<script type='text/javascript'>earlyInit();</script>
</body>
</html>
