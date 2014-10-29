<% pagehead(menu.status_log) %>
<style type='text/css'>
#statsroute-cfg{
	width: 200px;
    text-align: left;
}

#statsroute-grid{
	width: 700px;
    text-align: center;
}
#statsroute-grid .co1 {
	width: 80px;
    text-align: center;
}
#statsroute-grid .co2 {
	width: 100px;
    text-align: center;
}
#statsroute-grid .co3 {
	width: 100px;
    text-align: center;
}
#statsroute-grid .co4 {
	width: 100px;
    text-align: center;
}
#statsroute-grid .co5 {
	width: 120px;
    text-align: center;
}
#statsroute-grid .co6 {
	width: 100px;
    text-align: center;
}
#statsroute-grid .co7 {
	width: 100px;
    text-align: center;
}
</style>

<script type='text/javascript'>


var cmd_str='show ip route';

<% web_exec('show ip route'); %>

var filter_str = '';

update_route_table = function()
{
	var rt=[];
	status_route_grid.removeAllData();
	for(var i=0;i<route_status.length;i++){
		rt=route_status[i];
		if(filter_str != ''){
			if(rt[0]== filter_str){
				status_route_grid.insertData(-1, rt);
			}
		}else {
			status_route_grid.insertData(-1, rt);
		}
	}
}




var states=['all', 'connected', 'Static', 'rip', 'ospf'];
var status_route_grid = new webGrid();

status_route_grid.dataToView = function(data) {
	return data;
}

status_route_grid.verifyFields = function(row, quiet) {
	return 1;
}

status_route_grid.setup = function() {
	this.init('statsroute-grid', ['readonly', 'sort'], 128, [
		{ type: 'text', maxlen: 64 }, 
		{ type: 'text', maxlen: 64 }, 
		{ type: 'text', maxlen: 64 }, 
		{ type: 'text', maxlen: 64 }, 
		{ type: 'text', maxlen: 64 }, 
		{ type: 'text', maxlen: 64 }, 
		{ type: 'text', maxlen: 64 }
		]);
	this.headerSet([ui.typ,ui.dst, ui.netmask, ui.gateway, ui.iface, ui.distance_metric, ui.rule_time]);
	
    verifyState();
}

var ref = new webRefresh('status-route.jsx', 'alarmlog=all', 0, 'status_route_refresh');
var stats_route = [];
ref.refresh = function(text)
{
	stats_route = [];
	try {
		eval(text);
	}
	catch (ex) {
	}
    
    update_route_table();
}

function start_ref(postData)
{
	ref.postData = postData;
	
	if (ref.running) ref.stop();

	ref.start();
}


function creatSelect(options,value,idex,name)
{
	var string = '<td width=50><select onchange=verifyState() id=_'+idex+''+name+'>';

	for(var i = 0;i < options.length;i++){
		if(value == options[i]){
			string +='<option value='+options[i]+' selected>'+options[i]+'</option>';
		}else{
			string +='<option value='+options[i]+'>'+options[i]+'</option>';
		}
	}
	string +="</select></td>";

	return string;
}


	
function verifyFields(focused, quiet)
{
	
	return 1;
}

function isDigit(str)
{ 
  var reg = /^\d*$/; 

  return reg.test(str); 
 }



function verifyState()
{
	var state = 0;
	if (E('_state').value == 'OSPF'){
		state = 4;
	}else if (E('_state').value == 'RIP'){
		state = 3;
	}else if (E('_state').value == 'Static'){
		state = 2;
	}else if (E('_state').value == 'Connected'){
		state = 1;
	}else{
		state = 0;
	}

	filter = ['','C','S','R','O'];
	filter_str = filter[state];

 	cookie.set('state', state);
	//alert(cookie.get('state'));
	update_route_table();
	
	//reload page
	//reloadPage();
}


function earlyInit()
{
    x = cookie.get('state');
    if( x != null)
        E('_state').selectedIndex = x;

    status_route_grid.setup();
}

function init()
{
	
    ref.initPage(3000, 0);
	
}



</script>

</head>
<body onload='init()'>
<form id='_fom' method='post' action='apply.cgi'>
<input type='hidden' name='_web_cmd' value=''>
<div id='_statsroute_grid' class='section'>
<table cellspacing=1 id='statsroute-cfg'>
<script type='text/javascript'>
	
	//W("<td width=200>" + alarm.st+":" + "</td>"); 
	W("<td width=200>" + ui.typ + ":" + "</td>"); 
	W(creatSelect(['All','Connected','Static','RIP','OSPF'],'', '' ,'state'));
	W("<td width=50>" + "" + "</td>"); 
</script>
</table>
<table class='web-grid' id='statsroute-grid'></table>	


</div>

<div id='footer'>
	<script type='text/javascript'>genStdRefresh(1,5,'ref.toggle()');</script>
</div>
<script type='text/javascript'>earlyInit()</script>
</form>
</body>
</html>

