<% pagehead(menu.setup_lo0) %>

<style type='text/css'>
#mip-grid  {
	width: 600px;
}
#mip-grid .co1 {
	width: 300px;
}
#mip-grid .co2 {
	width: 300px;
}
</style>

<script type='text/javascript'>

<% ih_sysinfo(); %>
<% ih_user_info(); %>
lo_config = [[1,"", "",[] ]];
<% web_exec('show running-config loopback') %>

var lo_config = {
	ip:lo_config[0][1],
	netmask:lo_config[0][2],
	multi_ip:lo_config[0][3]
};

//a=b return 0
//a!=b return 1
function list_cmp(a,b)
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

var first_cmd = '';
function verifyFields(focused, quiet)
{
	var i;
    var a;
    var cmd ='';
    
    // --- visibility ---
	var vis = {
		_lo0_ip: 1,
		_lo0_netmask: 1
    };

	elem.display(PR('_lo0_ip'), PR('_lo0_netmask'), vis._lo0_ip);	
    E('_lo0_ip').disabled = 1;
    E('_lo0_netmask').disabled = 1;	
	// --- verify ---
	// IP address
	a = ['_lo0_ip'];
	for (i = a.length - 1; i >= 0; --i){
		if ((vis[a[i]]) && (!v_ipnz(a[i], quiet))) return 0;
	}
    
    //netmask
	a = E('_lo0_netmask');
	if (a.value.length==0) a.value = '255.255.255.0';
    if (vis._lo0_netmask && !v_netmask('_lo0_netmask', quiet)) return 0;

    //cmd += "interface loopback 1\n"; 

    var ip_now = mip.getAllData();
    
    var ip_old = [];
    tmp = lo_config.multi_ip;
	for (var i = 0; i < tmp.length; ++i) {
		ip_old.push( [tmp[i][0], tmp[i][1]]);
	}
    
    var ip_add = [];
    var ip_del = [];

    //ip add = ip_now - ip_old
	if(ip_old.length != 0){
		for(var i=0 ;i<ip_now.length ;i++){
			for(var j=0 ;j<ip_old.length ; j++){
				if( !list_cmp(  ip_now[i],ip_old[j]) )
					break;
				if(j == ip_old.length - 1){
					ip_add.push(ip_now[i])
				}
			}
		}
	}else
        ip_add = ip_now;

    //ip_del = ip_old - ip_now
	if(ip_now.length != 0){
		for(var i=0 ;i<ip_old.length ;i++){
			for(var j=0 ;j<ip_now.length ; j++){
				if( !list_cmp(  ip_old[i],ip_now[j]) )
					break;
				if(j == ip_now.length - 1){
					ip_del.push(ip_old[i])
				}
			}
		}
	}else
		ip_del = ip_old;
        
    //ip del    
    for(var i=0 ; i<ip_del.length ; i++ ){
        cmd += 'no ip address ' + ip_del[i][0] + ' ' + ip_del[i][1] + ' secondary\n';
    }

    //ip add
    for(var i=0 ; i<ip_add.length ; i++ ){
        cmd += 'ip address ' + ip_add[i][0] + ' ' + ip_add[i][1] + ' secondary\n';
    }

    if(cmd != '')
        cmd = "interface loopback 1\n" + cmd; 
        
    E('save-button').disabled = 1;
    if((cmd != '') ){
        E('save-button').disabled = 0;
        E('_fom')._web_cmd.value = cmd;
        //alert(cmd);
        return 1;
    }

	if (user_info.priv < admin_priv) {
		elem.display('save-button', 'cancel-button', false);
	}else{
		elem.display('save-button', 'cancel-button', true);
	}

	return 0;
}

var mip = new webGrid();
mip.verifyFields = function(row, quiet) {
	var f = fields.getAll(row);

	if (f[1].value.length==0) f[1].value = '255.255.255.0';
	if (!v_info_host_ip(f[0], quiet, false)) return 0;
	if (!v_info_netmask(f[1], quiet, false)) return 0;
	if (!v_info_ip_netmask(f[0], f[1], quiet)) return 0;
	return 1;
}

mip.setup = function() {
	this.init('mip-grid', '', 10, [
		{ type: 'text', maxlen: 15 }, { type: 'text', maxlen: 15 }]);
	this.headerSet([ui.ip, ui.netmask]);
//	var mip = nvram.lo0_mip.split(';');
	var mip = lo_config.multi_ip;
	
	for (var i = 0; i < mip.length; ++i) {
			this.insertData(-1, [mip[i][0], mip[i][1]]);
	}
	this.showNewEditor();
	this.resetNewEditor();
}

mip.onDataChanged = function()
{
	verifyFields(null, 1);
}

function earlyInit()
{
	mip.setup();
	verifyFields(null, 1);
}

function save()
{
	var i;

	if (!verifyFields(null, false)) return;
	if (mip.isEditing()) return;

	var fom = E('_fom');

//	var data = mip.getAllData();
//	var r = [];
//	for (var i = 0; i < data.length; ++i) r.push(data[i].join(','));
//	fom.lo0_mip.value = r.join(';');
	
	if((E('_fom')._web_cmd.value != '')&&(cookie.get('autosave') == 1)){
		E('_fom')._web_cmd.value += "!"+"\n"+"copy running-config startup-config"+"\n";	
	}


	form.submit(fom, 1);
}
</script>

</head>
<body>
<form id='_fom' method='post' action='apply.cgi'>
<input type='hidden' name='_web_cmd' value=''>


<script type='text/javascript'>
W("<div class='section'>");

createFieldTable('', [
//attrib: "readonly=1",
	{ title: ui.ip, name: 'lo0_ip', type: 'text', maxlen: 15, size: 17, value: lo_config.ip },
	{ title: ui.netmask, name: 'lo0_netmask', type: 'text', maxlen: 15, size: 17, value: lo_config.netmask }
]);
</script>

<div id='pppoe_title' class='section-title'>
<script type='text/javascript'>
	GetText(ui.mip);
</script>
</div>
<div class='section'>
	<table class='web-grid' id='mip-grid'></table>	
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
