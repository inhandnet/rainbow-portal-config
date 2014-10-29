<% pagehead(menu.status_bridge) %>
<style type='text/css'>

#bridge-grid {
	width: 800px;	
	text-align: center;
}

</style>

<script type='text/javascript'>

<% ih_sysinfo() %>
<% ih_user_info() %>
<% web_exec('show bridge') %>
<% web_exec('show running-config interface') %>

var operator_priv = 12;

var bridge = new webGrid();
bridge.dataToView = function(data)
{
	tmp = [];
	tmp.push(data[0]);

    for(var i=1;i<data.length - 1;i++)
    {
        tmp.push(data[i] == 1? ui.yes : '');
    }
    
	tmp.push(data[data.length - 1].replace(/\/$/,''));

	return tmp;
}

bridge.setup = function() {
	var br_info; 
	var br_port = ['0', '0'];
	var br_addr;

	this.init('bridge-grid', ['sort', 'readonly','select'], 8, [
				{type: 'text', maxlen: 15},
				{type: 'checkbox',},
				{type: 'checkbox'},
				{type: 'text', maxlen: 35}]);
	//this.headerSet([ui.bridge_id, ui.fastethernet1, ui.fastethernet2, [ui.primary_ip + '/' + ui.netmask]]);
	this.headerSet([ui.br_id, ui.fe_1, ui.fe_2, ui.br_ip_mask]);
	
    for(var i = 0; i < bridge_config.length; i++){
        br_info = bridge_config[i];
        br_addr = br_info[1] + '/' + br_info[2];

		for(var j = 0; j < br_info[3].length; j++) {
			if (br_info[3][j] == 'fastethernet 0/1') {
				br_port[0] = '1';
			} else if (br_info[3][j] == 'fastethernet 0/2') {
				br_port[1] = '1';
			}
		}

        //this.insertData(-1, [].concat([v_obj[0]],v_obj.port,[tmp]));
        this.insertData(-1, [br_info[0], br_port[0], br_port[1], br_addr]);
    }

	if (user_info.priv >= operator_priv)
		bridge.footerButtonsSet(0);
}

bridge.jump = function(){
	document.location = 'setup-bridge-detail.jsp';	
}

bridge.footerAdd = function(){
	cookie.unset('bridge-modify');
	bridge.jump();		
}
	
bridge.footerModify = function(){
	var f = bridge.getAllData();
	if (bridge.selectedRowIndex < 0 || bridge.selectedColIndex < 0)
		return;

	var keyVar = f[bridge.selectedRowIndex - 1][this.selectedColIndex];
	cookie.set('bridge-modify', keyVar);
	bridge.jump();
}

bridge.footerDel = function(){
	var send_cmd = [];
    var f = this.getAllData();
    var cmd = '';

	//alert(bridge.selectedRowIndex);
	//alert(bridge.selectedCowIndex);//always 0

	if (bridge.selectedRowIndex < 0 || this.selectedColIndex < 0)
		return;
	var keyVar = f[bridge.selectedRowIndex - 1][0];

    
    cmd += "!"+"\n";
    cmd += "no bridge "+keyVar+"\n";
	
	E('_fom')._web_cmd.value = cmd ;
	
	if((E('_fom')._web_cmd.value != '')&&(cookie.get('autosave') == 1)){
		E('_fom')._web_cmd.value += "!"+"\n"+"copy running-config startup-config"+"\n";	
	}

	form.submit('_fom', 1);
}

function earlyInit()
{
	bridge.setup();
}

function init()
{
	bridge.recolor();
}

</script>

</head>
<body onload='init()'>
<form id='_fom' method='post' action='apply.cgi'>
<input type='hidden' name='_web_cmd' value=''>

<div class='section'>
	<table class='web-grid' id='bridge-grid'></table>
</div>

</form>

<script type='text/javascript'>earlyInit();</script>
</body>
</html>
