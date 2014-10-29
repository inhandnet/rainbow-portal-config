<% pagehead(menu.openvpn) %>
<style type='text/css'>

#openvpn-client-grid {
	width: 800px;	
	text-align: center;
}
</style>

<script type='text/javascript'>


<% ih_sysinfo() %>
<% ih_user_info() %>

<% web_exec('show openvpn brief')%>

//var openvpn_client_brief= [[1,'2','1','10.5.3.192','1194','cisco','cisco','client']];

var cert_list = [['0',openvpn.auth_none],
		['1', openvpn.auth_userpass],
		['2', openvpn.auth_statickey],
		['3', openvpn.auth_psk],
		['4', openvpn.auth_psk_tls],
		['5', openvpn.auth_psk_tls_up]];
//[['0',' '],['1', 'username-password'],['2','static-key'],['3','preshared-key'],	['4','preshared-key/tls-authentication'],
		//['5','preshared-key/tls-authentication/username-password']];
var openvpn_client = new webGrid();

openvpn_client.exist = function(f, v)
{
	var data = this.getAllData();
	for (var i = 0; i < data.length; ++i) {
		if (data[i][f] == v) return true;
	}
	return false;
}

openvpn_client.existName = function(name)
{
	return this.exist(1, name);
}

openvpn_client.dataToView = function(data) 
{
	return [(data[0] != 0) ? ui.yes : ui.no, data[2],cert_list[data[3]][1], data[4], data[5], data[6],(data[7]=='')?'':'******', data[8]];
}

openvpn_client.fieldValuesToData = function(row) 
{
	var f = fields.getAll(row);
	return [f[0].checked ? 1 : 0, f[2].value, f[3].value, f[4].value, f[5].value, f[6].value, f[7].value,f[8].value];
}


openvpn_client.loadData = function()
{
	for (var i = 0; i < openvpn_client_brief.length; ++i) {
		this.insertData(-1, [openvpn_client_brief[i][0],  openvpn_client_brief[i][1],openvpn_client_brief[i][2],
					openvpn_client_brief[i][3],openvpn_client_brief[i][4],openvpn_client_brief[i][5],
					openvpn_client_brief[i][6],openvpn_client_brief[i][7],openvpn_client_brief[i][8]]);
	}
}

openvpn_client.setup = function() {

	this.init('openvpn-client-grid', ['sort', 'readonly','select']);
	this.headerSet([openvpn.enable, 
			openvpn.name, 
			openvpn.cert,
			openvpn.server, 
			openvpn.port, 
			openvpn.username,
			openvpn.passwd,
			openvpn.description]);
	openvpn_client.loadData();
	if (user_info.priv >= admin_priv){
		openvpn_client.footerButtonsSet(0);
		if(openvpn_client_brief.length>=10){
			E('row-add').disabled = true;
		}
	}
}

openvpn_client.jump = function(){
	document.location = 'setup-openvpn-clientN.jsp';	
}

openvpn_client.footerAdd = function(){
	cookie.unset('openvpn-modify');
	openvpn_client.jump();		
}
	
openvpn_client.footerModify = function(){
	var f = openvpn_client.getAllData();
	if (openvpn_client.selectedRowIndex < 0)
		return;
	var keyVar = f[openvpn_client.selectedRowIndex - 1][1];
	cookie.set('openvpn-modify', keyVar);
	openvpn_client.jump();
}

openvpn_client.footerDel = function(){
	var send_cmd = [];
	var f = this.getAllData();
	var cmd = '';

	if (openvpn_client.selectedRowIndex < 0 || this.selectedColIndex < 0)
		return;
	var keyVar = f[openvpn_client.selectedRowIndex - 1][1];
	if(f[openvpn_client.selectedRowIndex - 1][1] <1 ||
	f[openvpn_client.selectedRowIndex - 1][1] >10){
		show_alert(errmsg.delete_error);
		return false;
	}

	cmd += "!"+"\n";
	cmd += "no interface openvpn "+keyVar+"\n";

	E('_fom')._web_cmd.value = cmd ;

	if((E('_fom')._web_cmd.value != '')&&(cookie.get('autosave') == 1)){
		E('_fom')._web_cmd.value += "!"+"\n"+"copy running-config startup-config"+"\n";	
	}

	form.submit('_fom', 1);
}

openvpn_client.onClick = function(cell){

	var f = this.getAllData();
	if (this.canEdit) {
		if (this.moving) {
			var p = this.moving.parentNode;
			var q = PR(cell);
			if (this.moving != q) {
				var v = this.moving.rowIndex > q.rowIndex;
				p.removeChild(this.moving);
				if (v) p.insertBefore(this.moving, q);
					else p.insertBefore(this.moving, q.nextSibling);
				this.recolor();
			}
			this.moving = null;
			this.rpHide();
			this.onDataChanged();
			return;
		}
		this.edit(cell);
	}

	if (this.canBeSelected){
		var q = PR(cell);
		this.selectedRowIndex = q.rowIndex;			
		this.recolor();
		var o = this.tb.rows[this.selectedRowIndex];
		o.className = 'selected';
		if (this.selectedColIndex != -1){
			if(f[openvpn_client.selectedRowIndex - 1][4]){
				E('row-mod').disabled = false;
			}else {
				E('row-mod').disabled = true;
			}			
			E('row-del').disabled = false;
		}
		return;
	}
}

function earlyInit()
{
	var main_ovpn_id = cookie.get('openvpn-id');
	if(main_ovpn_id != null){
		cookie.set('openvpn-autoconfig', main_ovpn_id);
		cookie.unset('openvpn-id');
		openvpn_client.jump();
	}
	openvpn_client.setup();
}

function init()
{
	openvpn_client.recolor();
}

</script>

</head>
<body onload='init()'>

<form id='_fom' method='post' action='apply.cgi'>
<input type='hidden' name='_web_cmd' value=''>
<div class='section'>
	<table class='web-grid' id='openvpn-client-grid'></table>
</div>

</form>
<script type='text/javascript'>earlyInit();</script>
</body>
</html>
