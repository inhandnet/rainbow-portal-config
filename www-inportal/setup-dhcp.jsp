<% pagehead(menu.service_dhcpd) %>

<style tyle='text/css'>
#bs-grid  {
	width: 400px;
    text-align: center;
}
#bs-grid .co1, #bs-grid .co2 {
	width: 130px;
    text-align: center;
}

#interface-grid  {
	width: 800px;
    text-align: center;
}
#interface-grid .co1 {
	width: 40px;
    text-align: center;
}
#interface-grid .co2 {
	width: 120px;
    text-align: center;
}
#interface-grid .co3 {
	width: 150px;
    text-align: center;
}
#interface-grid .co4 {
	width: 150px;
    text-align: center;
}
#interface-grid .co5 {
	width: 80px;
    text-align: center;
}


</style>

<script type='text/javascript'>

<% ih_sysinfo(); %>
<% ih_user_info(); %>


//var interface_config = [['1','interface1','192.168.2.2','192.168.2.250','100'],['0','interface2','','','']];
//var mac_bind = [['00:18:05:AA:BB:CC','192.168.2.56'],['00:18:05:DD:EE:FF','192.168.2.57']];
var interface_config = [];
var mac_bind = [];
var wins_server = [''];
var svi_config = [];
var svi_name_list = [];

dns_server = {
	dns_1:'',
  	dns_2:''
};

<% web_exec('show running-config dhcp-server') %>
<% web_exec('show running-config dhcp-relay') %>
<% web_exec('show running-config name-server') %>
<% web_exec('show interface')%>

var vifs = [].concat(eth_interface, sub_eth_interface, svi_interface, dot11radio_interface);
var now_vifs_options = new Array();
now_vifs_options = grid_list_all_vif_opts(vifs);



for(var i=0 ; i< svi_config.length;i++){
    var c = svi_config[i];
    var name = 'vlan ' + c[0].toString();
    svi_name_list.push(name);
}
//alert('svi name list:'+svi_name_list);

function option_convert(a){
    ret = [];
    for(var i = 0; i < a.length; i++) {
        ret.push([a[i],a[i]]);
    }

    return ret;
}

function get_hide_interface(){
    // 
    var if_all = svi_name_list;
    var if_displayed = [];
    var if_hide = [];
    
    var tmp = interface.getAllData();
    for(var i=0; i<tmp.length;i++){
        if_displayed.push(tmp[i][1]);
    }

    //alert('if_displayed = '+if_displayed);

    for(var i=0; i<if_all.length; i++){
        var match_flag = 0;
        for(var j=0; j<if_displayed.length; j++){
            if(if_all[i] == if_displayed[j]){
                match_flag = 1;
                break;
            }
        }
        
        //if not in if_displayed
        if(match_flag == 0)
            if_hide.push(if_all[i]);            
    }
    
    //alert('if_hide = '+if_hide);

    var ret = option_convert(if_hide);
    return ret;
}


function joinAddr(a) {
	var r, i, s;

	r = [];
	for (i = 0; i < a.length; ++i) {
		s = a[i];
		if ((s != '00:00:00:00:00:00') && (s != '0.0.0.0')) r.push(s);
	}
	return r.join(';');
}

var sg = new webGrid();

sg.exist = function(f, v)
{
	var data = this.getAllData();
	for (var i = 0; i < data.length; ++i) {
		if (data[i][f] == v) return true;
	}
	return false;
}


sg.inStatic = function(n)
{
	return this.exist(1, n);
}
sg.dataToView = function(data) {
	return [data[0], data[1]];
}


sg.verifyFields = function(row, quiet)
{
	var f = fields.getAll(row);
	var s;
	
	ferror.clearAll(f);

	if(!v_mac2(f[0].value)) {
		ferror.set(f[0], errmsg.mac, quiet);
		return 0;
	}

	if (f[0].value == '0000.0000.0000') {
		ferror.set(f[0], errmsg.mac_err, quiet);
		return 0;
	}

	if (!v_ip(f[1],quiet))
		return 0;

	if (this.exist(0,f[0].value)) {
		ferror.set(f[0], errmsg.bad_name2, quiet);
		return 0;
	}
	
	if (this.exist(1,f[1].value)) {
		ferror.set(f[1], errmsg.bad_name2, quiet);
		return 0;
	}

	return 1;
}

sg.resetNewEditor = function() {
	var f, c;

	f = fields.getAll(this.newEditor);
	ferror.clearAll(f);
	

	f[0].value = '0000.0000.0000';
	f[1].value = '';
}

sg.onDataChanged = function()
{
	verifyFields(null, 1);
}


sg.setup = function()
{
	this.init('bs-grid', [ 'move'], 16,
		[{ type: 'text', maxlen: 17 }, { type: 'text', maxlen: 15 }]);
	this.headerSet([ui.mac, ui.ip]);
	var s = mac_bind;

	for (var i = 0; i < s.length; i++) {
		this.insertData(-1, [s[i][0],s[i][1]]);
	}
	this.showNewEditor();
	this.resetNewEditor();
}



var interface = new webGrid();
interface.setup = function()
{
	this.init('interface-grid', ['sort'], 200,
	[{ type: 'checkbox' },
	{ type: 'select', options:  now_vifs_options } ,
	{ type: 'text', maxlen: 15 },
	{ type: 'text', maxlen: 15 } , 
	{type:'text', maxlen:15}
	]);
	
	this.headerSet([ ui.enable,ui.iface, ui.start, ui.end ,ui.lease+'('+ui.minutes+')']);
    //this.insertData(-1, [1,'interface name exp','192.168.2.2','192.168.2.100','1']);
    //this.canDelete = 1;
	
	tmp = interface_config;
	for (var i = 0; i < tmp.length; i++) {
		this.insertData(-1, [tmp[i][0]=='1'?1:0,tmp[i][1],tmp[i][2],tmp[i][3],tmp[i][4]]);
		grid_vif_opts_sub(now_vifs_options, tmp[i][1]);
	}
	
	this.showNewEditor();
	this.resetNewEditor();
	
	this.safeUpdateEditorField(1, { type: 'select', maxlen: 15, options: now_vifs_options} );
}

interface.safeUpdateEditorField = function(i, editorField) {

	var f = fields.getAll(this.newEditor);
	var data = [];
	var j, e;
	var f_disabled = [];
	//get old datas of the row
	for (j = 0; j < f.length; j++){
		data.push(f[j].value);
		f_disabled.push(f[j].disabled);
	}
	
	//update
	interface.updateEditorField(i, editorField);

	//set datas
	f = fields.getAll(this.newEditor);
	ferror.clearAll(f);
	for (j = 0; j < f.length; ++j) {
		if (f[j].selectedIndex) f[j].selectedIndex = data[j];
		else f[j].value = data[j];
		f[j].disabled = f_disabled[j];
	}

	return f;
}

interface.onDataChanged = function()
{
	verifyFields(null, 1);
	interface.safeUpdateEditorField(1, { type: 'select', maxlen: 15, options: now_vifs_options} );
}


interface.dataToView = function(data) {
	return [(data[0] == 1) ? ui.yes : ui.no, data[1],data[2],data[3],data[4]];
}
interface.fieldValuesToData = function(row) {
	var f = fields.getAll(row);
	
	tmp = [];
	if(f[0].checked == 1){
		tmp.push( 1 );
	}else{
		tmp.push( 0 );
	}
	
	tmp.push(f[1].value);
	tmp.push(f[2].value);
	tmp.push(f[3].value);
	tmp.push(f[4].value);
	return tmp;
}


interface.verifyFields = function(row,quiet)
{
	var f = fields.getAll(row);
    ferror.clearAll(f);

	//f[0].disabled = 1;
    //check if the DHCP and DHCP-relay has been enable at the some time
    if(dhcprelay_config.enable && f[0].checked){
        show_alert(ui.dhcp_dhcprelay_conflict);
        return 0;
    }

	if(!v_ip(f[2],quiet)) {
		return 0;
	} 

	if(!v_ip(f[3],quiet)) {
		return 0;
	}	

	ferror.clear(f[4]);
	if(f[4].value.length == 0){
		ferror.set(f[4],ui.dhcp_lease_empty , quiet);
		return 0;
    }else if( (f[4].value!=0) && ( !v_range(f[4],quiet,30,10080) ) ){
		return 0;
    }	

	grid_vif_opts_sub(now_vifs_options, f[1].value);
	return 1;
}

interface.resetNewEditor = function(){
	f = fields.getAll(this.newEditor);
	ferror.clearAll(f);
	
	f[4].value = '1440';
}

tmp_func_onClick = interface.onClick;
interface.onClick = function(cell)
{
	var q = PR(cell);
	var data = this.getAllData();
	var thisData = data[q.rowIndex -1];
	this.safeUpdateEditorField(1, { type: 'select', maxlen: 15, options: [[thisData[1], thisData[1]]]} );
		
	tmp_func_onClick.apply(interface,arguments);
	
	var f = fields.getAll(interface.editor);
	f[1].disabled = true;
}

interface.verifyDelete = function(data) {
	grid_vif_opts_add(now_vifs_options, data[1]);
	return true;
}

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

function verifyFields(focused, quiet)
{
	var a;
	var ok = 1;
	var cmd = '';


	//if(E('_dhcpd_wins').value.length==0) 
	//	E('_dhcpd_wins').value = '0.0.0.0';		

	if(E('_dhcpd_wins').value.length) {
		if (!v_ip(E('_dhcpd_wins'), quiet)) return 0;
	} else {
		ferror.clear(E('_dhcpd_wins'));		
	}

	if(E('_dhcpd_wins').value != wins_server[0])
		cmd += ((E('_dhcpd_wins').value == '')?('no '):('')) + 'ip dhcp-server wins-server ' 
			+ ((E('_dhcpd_wins').value == '')?(''):(E('_dhcpd_wins').value)) + '\n';

	E('_f_dns').value = dns_server.dns_1 + ' ' + dns_server.dns_2;
	E('_f_dns').disabled = true;

	//diff mac-ip pair configuration
	var mac_add = [];
	var mac_del = [];
	var mac_old = mac_bind; 
	var mac_now = [];
	
	tmp_data = sg.getAllData();
	for(var i=0 ; i<tmp_data.length ; i++ ){
		mac_now[i] = [];
		mac_now[i][0] = tmp_data[i][0];
		mac_now[i][1] = tmp_data[i][1];
	}
	//alert('mac_now.length =' + mac_now.length.toString() );
	
	//mac add = mac_now - mac_old
	if(mac_old.length != 0){
		for(var i=0 ;i<mac_now.length ;i++){
			for(var j=0 ;j<mac_old.length ; j++){
				if( !list_cmp(  mac_now[i],mac_old[j]) )
					break;
	 
				if(j == mac_old.length - 1){
					mac_add.push(mac_now[i])
				}
			}
	 	}
	}else
		mac_add = mac_now;
	//alert('mac_add.length = '+ mac_add.length.toString() );
	   
	//mac del = mac_old - mac_now
	if(mac_now.length != 0){
		for(var i=0 ;i<mac_old.length ;i++){
			for(var j=0 ;j<mac_now.length ; j++){
				if( !list_cmp(  mac_old[i],mac_now[j]) )
					break;
				if(j == mac_now.length - 1){
					mac_del.push(mac_old[i])
				}
	    	}
		}
	}else
		mac_del = mac_old;
	//alert('mac_del.length = '+ mac_del.length.toString() );
	
	for(var i=0 ; i<mac_del.length ; i++){
		cmd += 'no ip dhcp-server binding ' + mac_del[i][0] + '\n';   
	}

	for(var i=0 ; i<mac_add.length ; i++){
		cmd += 'ip dhcp-server binding ' + mac_add[i][0] + ' ' +  mac_add[i][1] + '\n';   
	}
	
	
	//diff interface configuration
	var if_add = [];
	var if_del = [];
	var if_old = interface_config; 
	var if_now = [];

	tmp_data = interface.getAllData();
	for(var i=0 ; i<tmp_data.length ; i++ ){
		if_now[i] = tmp_data[i];
	}
	//alert('if_now.length =' + if_now.length.toString() );
	
	//if add = if_now - if_old
	if(if_old.length != 0){
		for(var i=0 ;i<if_now.length ;i++){
			for(var j=0 ;j<if_old.length ; j++){
				if( !list_cmp(  if_now[i],if_old[j]) )
					break;

				//if( if_now[i][0] == 0 )//disabled
				//	break;
	 
				if(j == if_old.length - 1){
					if_add.push(if_now[i])
				}
			}
	 	}
	}else
		if_add = if_now;
	//alert('if_add.length = '+ if_add.length.toString() );
	//alert('if_add = '+ if_add );
	   
	//if_del = if_old - if_now
	if(if_now.length != 0){
		for(var i=0 ;i<if_old.length ;i++){
			for(var j=0 ;j<if_now.length ; j++){
				if( !list_cmp(  if_old[i],if_now[j]) )
					break;
				if(j == if_now.length - 1){
					if_del.push(if_old[i])
				}
	    	}
		}
	}else
		if_del = if_old;
	//alert('if_del.length = '+ if_del.length.toString() );
	//alert('if_del = '+ if_del );

	for(var i=0 ; i<if_del.length ; i++){
		cmd += '!\n';
		cmd += 'interface ' + if_del[i][1] + '\n';
		cmd += 'no ip dhcp-server enable\n';   
		cmd += 'no ip dhcp-server range\n';   
		cmd += 'no ip dhcp-server lease\n';   
	}

	for(var i=0 ; i<if_add.length ; i++){
		cmd += '!\n';
		cmd += 'interface ' + if_add[i][1] + '\n';
		
		if( if_add[i][0] == 0 )
			cmd += 'no ip dhcp-server enable\n';
		else
			cmd += 'ip dhcp-server enable\n';

		cmd += 'ip dhcp-server range ' + if_add[i][2] + ' ' + if_add[i][3] + '\n';   

        if(if_add[i][4] == 0)//0表示时间为无限长
            cmd += 'ip dhcp-server lease ' + 'infinite' + '\n';   
        else
            cmd += 'ip dhcp-server lease ' + if_add[i][4] + '\n';   
	}
    
    
    E('save-button').disabled = 1;
    if(cmd != ''){
        E('save-button').disabled = 0;
		E('_fom')._web_cmd.value = cmd;
		//console.log(cmd);
    }

	if (user_info.priv < admin_priv) {
		elem.display('save-button', 'cancel-button', false);
	}else{
		elem.display('save-button', 'cancel-button', true);
	}

	return ok;	
}

function save()
{
	if (!verifyFields(null, false)) return;
	if (sg.isEditing()) return;
	if (interface.isEditing()) return;
	
	var fom = E('_fom');

	if((E('_fom')._web_cmd.value != '')&&(cookie.get('autosave') == 1)){
		E('_fom')._web_cmd.value += "!"+"\n"+"copy running-config startup-config"+"\n";	
	}

	form.submit(fom, 1);
}

function earlyInit() 
{
	sg.setup();
	//range.setup();
	interface.setup();
	verifyFields(null, 1);
}

function init()
{
	var i;
	var s = '';
	

	sg.recolor();
}

</script>
</head>
<body onload='init()'>
<form id='_fom' method='post' action='apply.cgi'>
<input type='hidden' name='_web_cmd' value=''>


<div class='section-title' id='_enable_interface_title'>
<script type='text/javascript'>
	GetText(ui.interface_dhcp_enable);
</script>
</div>
<div class='section' id='_enable_interface'>
	<table class='web-grid' id='interface-grid'></table>
</div>
<div class='section'>
<script type='text/javascript'>
createFieldTable('', [
	{ title: ui.dns_server, name: 'f_dns', type: 'text', maxlen: 33, size: 32,
			suffix: ' <a href="setup-dns.jsp">' + ui.edit + '</a>',
			value: dns_server.dns_1 + ' ' + dns_server.dns_2 },
	{ title: ui.wins, name: 'dhcpd_wins', type: 'text', maxlen: 15, size: 17, value: wins_server[0] }
]);
</script>
</div>
<div class='section-title' id='_static_dhcpd_title'>
<script type='text/javascript'>
	GetText(ui.static_dhcp);
</script>
</div>
<div class='section' id='_static_dhcpd'>
	<table class='web-grid' id='bs-grid'></table>
</div>


</form>
<script type='text/javascript'>
if(cookie.get('autosave') == 1)
	ui.aply=ui.aply_save;
genStdFooter("");
</script>
<script type='text/javascript'>earlyInit();</script>
</body>
</html>
