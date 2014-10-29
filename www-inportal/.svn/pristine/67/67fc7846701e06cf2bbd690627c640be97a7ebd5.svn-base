<% pagehead(menu.gre_tunnels) %>

<style type='text/css'>
#gre-grid {
	width: 800px;
}

#gre-grid .co1 {
	width: 30px;
	text-align: center;
}

#gre-grid .co2 {
	width: 60px;
	text-align: center;
}

#gre-grid .co3 {
	width: 60px;
	text-align: center;
}

#gre-grid .co4 {
	width: 60px;
	text-align: center;
}

#gre-grid .co5 {
	width: 60px;
	text-align: center;
}

#gre-grid .co6 {
	width: 60px;
	text-align: center;
}

#gre-grid .co7 {
	width: 60px;
	text-align: center;
}

#gre-grid .co8 {
	width: 60px;
	text-align: center;
}

#gre-grid .co9 {
	width: 30px;
	text-align: center;
}

#gre-grid .co10 {
	width: 30px;
	text-align: center;
}
</style>

<script type='text/javascript'>

<% ih_sysinfo(); %>
<% ih_user_info(); %>

<% web_exec('show running-config gre')%>

//var gre_config=[[1,'1','1.1.1.1','1.2.3.4','1.1.1.2', 'abc123', '192.168.2.134', 'desc', 1, 1]];
//var gre_config = [[1, '2', '1.1.1.1', '255.255.255.0', '192.168.5.2', '1.1.1.2','123456', '1500', '192.168.5.1', 'abcd', 1,'1.1.1.2', 'abc123', 123, ''],
//	[1, '1', '1.1.1.1', '255.255.255.0', '192.168.5.2', '','123456', '1460', '192.168.5.1', 'abcd', 1,'1.1.1.2', 'abcdef', 123, 'test']];

function netmask_str_to_int(str)
{
	var tmp=str.split('.');	//split the netmask to four parts
	var part;
	var number=0;

	for(var i = 0; i < tmp.length; i++) {
		part=parseInt(tmp[i]).toString(2);	//transfer the decimal to binary
		for(var j = 0; j<part.length; j++) {
			if (part.charAt(j) == '1')
			number++;
		}
	}
	return number;
}

var gre = new webGrid();

gre.exist = function(f, v)
{
	var data = this.getAllData();
	for (var i = 0; i < data.length; ++i) {
		if (data[i][f] == v) return true;
	}
	return false;
}

gre.existName = function(name)
{
	return this.exist(1, name);
}

gre.dataToView = function(data) {
	return [(data[0] != 0) ? ui.yes : ui.no, data[1], data[2], data[3], data[4], data[5], (data[6]=='')?'':'******', (data[7] != 0)?ui.yes:ui.no, data[8], data[9]];
}

gre.fieldValuesToData = function(row) {
	var f = fields.getAll(row);
//	return [f[0].checked ? 1 : 0, f[1].value, f[2].value, f[3].value, f[4].value, f[5].value, f[6].value, f[7].value, f[8].checked ? 1 : 0, f[9].checked ? 1 : 0];
	return [f[0].checked ? 1 : 0, f[1].value, f[2].value, f[3].value, f[4].value, f[5].value, f[6].value, f[7].checked ? 1 : 0, f[8].value, f[9].value];
}

gre.loadData = function()
{
	var local_vip;
	var netmask;
	var ipsec_prof;

	for (var i = 0; i < gre_config.length; ++i) {
		if(gre_config[i][3] == '') {	//local vip netmask is null
			local_vip = gre_config[i][2];
		} else {
			netmask = netmask_str_to_int(gre_config[i][3]);
			local_vip = gre_config[i][2] + '/' + netmask;
		}

		if(gre_config[i][14]=='') {
			ipsec_prof = 'Disable';	
		} else {
			ipsec_prof = gre_config[i][14];
		}
		
		this.insertData(-1, [gre_config[i][0], gre_config[i][1], local_vip, 
						gre_config[i][8], gre_config[i][5],gre_config[i][4], 
						gre_config[i][6], gre_config[i][10],ipsec_prof, 
						gre_config[i][9]]);

	}
}

gre.setup = function() {
	this.init('gre-grid', ['sort', 'readonly', 'select']);
//	this.headerSet([ui.enable, ui.nam, 
//		gre_tun.local_vip, ui.peer, gre_tun.remote_vip, 
//		ipsec.auth_key, gre_tun.local, ui.desc, 'NHRP Enable', 'IPsec Protection']);
	this.headerSet([ui.enable, gre_tun.index, 
		gre_tun.local_vip, gre_tun.local, gre_tun.remote_vip, ui.peer,  
		ipsec.auth_key, gre_tun.nhrp_enable, gre_tun.ipsec_profile, ui.desc]);

	gre.loadData();

	if (user_info.priv >= admin_priv)
		gre.footerButtonsSet(0);

}

gre.jump = function()
{
	document.location = 'setup-gre-tunnelN.jsp';
}

gre.footerAdd = function()
{
	cookie.unset('gre-modify');
	cookie.set('gre-network-type', 1);
	gre.jump();
}

gre.footerModify = function()
{
	var f = gre.getAllData();
	if((gre.selectedRowIndex < 0) || (gre.selectedColIndex < 0))
			return;
//	var keyVar = f[gre.selectedRowIndex - 1][this.selectedColIndex];
	var keyVar = f[gre.selectedRowIndex - 1][1];	//gre index
//	alert("Bone:index:"+(gre.selectedRowIndex)+" colIndex"+this.selectedColIndex+" keyVar:"+keyVar);
	cookie.set('gre-modify', keyVar);

	if(f[gre.selectedRowIndex - 1][4] != '') {	//peer vip
		cookie.set('gre-network-type', 1);		//network type:point to point
	} else {
		cookie.set('gre-network-type', 2);		//network type:subnet
		
	}
	gre.jump();	
}

gre.footerDel = function()
{
	var send_cmd = [];
	var f = this.getAllData();
	if (gre.selectedRowIndex < 0 || this.selectedColIndex < 0)
		return;
	var keyVar = f[gre.selectedRowIndex - 1][1];

	E('_fom')._web_cmd.value += "!"+"\n"+"no interface tunnel "+keyVar+"\n";

	if((E('_fom')._web_cmd.value != '')&&(cookie.get('autosave') == 1)){
		E('_fom')._web_cmd.value += "!"+"\n"+"copy running-config startup-config"+"\n";	
	}

	form.submit('_fom', 1);
}

function earlyInit()
{
	gre.setup();
}

function init()
{
	gre.recolor();
}
</script>
</head>
<body onload='init()'>
<form id='_fom' method='post' action='apply.cgi'>
<input type='hidden' name='_web_cmd' value=''>

<div class='section'>
	<table class='web-grid' id='gre-grid'></table>
</div>

</form>

<script type='text/javascript'>earlyInit()</script>
</body>
</html>

