<% pagehead(menu.service_dnsrelay) %>

<style type='text/css'>
#dnsrelay-grid {
	width: 600px;
}
#dnsrelay-grid .co1 {
	width: 200px;
	text-align: center;
}
#dnsrelay-grid .co2, #dnsrelay-grid .co3 {
	width: 200px;
	text-align: center;
}

</style>



<script type='text/javascript'>

<% ih_sysinfo(); %>
<% ih_user_info(); %>


var dns_relay={
	enable:1
};
var host = [];
var interface_config = [];
//var host = [ ['www.163.com','ip1','ip2'] , [ 'www.baidu.com','ip1','ip2']];

<% web_exec('show running-config dns-relay'); %>
<% web_exec('show running-config host'); %>
<% web_exec('show running-config dhcp-server'); %>

var dhcp_enabled = 0;
for(var i=0;i<interface_config.length;i++){
	if(interface_config[i][0] == '1'){
		dhcp_enabled = 1;
		break;
	}
}

var dnsrelay = new webGrid();
dnsrelay.verifyFields = function(row, quiet) {
	
	var f = fields.getAll(row);
	var tmp;
	
	f[0].value = f[0].value.replace(/\s+/g, ' ');
	
	tmp = f[0].value.split('.');
	
	if(tmp.length<=1){
		ferror.set(f[0], errmsg.bad_host, quiet);
		return 0;
	}else{
		ferror.clear(f[0]);
	}

	if(!v_ip(f[1],quiet) ) 
		return 0;

	if(f[2].value != '')
		if(!v_ip(f[2],quiet) )
			return 0;
	

	return 1;
}

dnsrelay.onDataChanged = function() {
	verifyFields(null, true);

}

dnsrelay.setup = function() {
	this.init('dnsrelay-grid', ['sort', 'move'], 128, [
		{ type: 'text', maxlen: 32 }, { type: 'text', maxlen: 16 }, { type: 'text', maxlen: 16 }]);
	this.headerSet([ui.hst, ui.ip1, ui.ip2]);
	
	for (var i = 0; i < host.length; i++) {
		this.insertData(-1, [host[i][0],host[i][1],host[i][2]]);
	}
	//this.sort(0);
	this.showNewEditor();
	this.resetNewEditor();
}

//a=b return 0
//a!=b return 1
function host_cmp(a,b)
{
	if( a.length != b.length )
		return 1;

	for(var i=0 ; i<a.length ; i++){
		if(a[i] != b[i] ){
			return 1;
		}				
	}
	return 0;
}


function verifyFields(focused, quiet)
{
	var cmd = '';

    if(dhcp_enabled == 1){
		E('_f_dnsrelay_enable').checked = 1;
        elem.enable('_f_dnsrelay_enable', false);
    }
	
	vis = E('_f_dnsrelay_enable').checked;
	E('dnsrelay-grid').style.display = vis ? 'block' : 'none';
	E('dnsrelay-grid-title').style.display = vis ? 'block' : 'none';
	
	if(!vis) {//off
		dnsrelay.rpHide();
		//on -> off dns-relay
		if(dns_relay.enable == 1)
			cmd  += "no ip dns-relay server\n";
	}else{//on
		//off -> on
		if(dns_relay.enable == 0)
			cmd += "ip dns-relay server\n";
	}

	var host_add = [];
	var host_del = [];
	var host_old = host; 
	var host_now = [];

	tmp_data = dnsrelay.getAllData();
	for(var i=0 ; i<tmp_data.length ; i++ ){
		host_now[i] = [];
		host_now[i][0] = tmp_data[i][0];
		host_now[i][1] = tmp_data[i][1];
		if( tmp_data[i][2] != ''){
			host_now[i][2] = tmp_data[i][2];
		}else
			host_now[i][2] = '';
	}
	//alert('host_now.length =' + host_now.length.toString() );

	//host add = host_now - host_old
	if(host_old.length != 0){
		for(var i=0 ;i<host_now.length ;i++){
			for(var j=0 ;j<host_old.length ; j++){
				if( !host_cmp(  host_now[i],host_old[j]) )
					break;

				if(j == host_old.length - 1){
					host_add.push(host_now[i])
				}
			}
		}
	}else
		host_add = host_now;
	//alert('host_add.length = '+ host_add.length.toString() );
	
	//host del = host_old - host_now
	if(host_now.length != 0){
		for(var i=0 ;i<host_old.length ;i++){
			for(var j=0 ;j<host_now.length ; j++){
				if( !host_cmp(  host_old[i],host_now[j]) )
					break;

				if(j == host_now.length - 1){
					host_del.push(host_old[i])
				}
			}
		}
	}else
		host_del = host_old;
	//alert('host_del.length = '+ host_del.length.toString() );
	
	
	for(var i=0 ; i<host_del.length ; i++){
		cmd += 'no ip host ' + host_del[i][0] + '\n';   
	}
	
	for(var i=0 ; i<host_add.length ; i++){
		cmd += 'ip host ' + host_add[i][0] + ' ' +  host_add[i][1] + ' ' + host_add[i][2] + '\n';   
	}

    E('save-button').disabled = 1;
	if(cmd != ''){
        E('save-button').disabled = 0;
		E('_fom')._web_cmd.value = cmd;
	}

	//alert('cmd str:'+ cmd);
	
	if (user_info.priv < admin_priv) {
		elem.display('save-button', 'cancel-button', false);
	}else{
		elem.display('save-button', 'cancel-button', true);
	}

	return 1;
}

function save()
{
	if (dnsrelay.isEditing()) return;

	var fom = E('_fom');

	if((E('_fom')._web_cmd.value != '')&&(cookie.get('autosave') == 1)){
		E('_fom')._web_cmd.value += "!"+"\n"+"copy running-config startup-config"+"\n";	
	}

	form.submit(fom, 1);
}

function earlyInit()
{
	dnsrelay.setup();
	if(dns_relay.enable == 1){
		E('_f_dnsrelay_enable').checked = 1;
    }
	verifyFields(null, true);
}

function init()
{
	dnsrelay.recolor();
}
</script>
</head>
<body onload='init()'>
<form id='_fom' method='post' action='apply.cgi'>
<input type='hidden' name='_web_cmd' value=''>

<div class='section'>
<script type='text/javascript'>
createFieldTable('', [
	{ title: ui.enable + " " + ui.dnsrelay, name: 'f_dnsrelay_enable', type: 'checkbox', 
		value: dns_relay.enable }
]);
</script>
</div>

<div class='section-title' id='dnsrelay-grid-title'>
<script type='text/javascript'>
GetText(ui.dnsrelay_static);
</script>
</div>
<div class='section'>
	<table class='web-grid' id='dnsrelay-grid'></table>
</div>

</form>
<script type='text/javascript'>
if(cookie.get('autosave') == 1)
	ui.aply=ui.aply_save;
genStdFooter("");
</script>
<script type='text/javascript'>earlyInit()</script>
</body>
</html>

