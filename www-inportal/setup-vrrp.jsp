<% pagehead(menu.setup_vrrp) %>

<style type='text/css'>
#vrrp-grid {
	text-align: center;
	width: 710px;
}

#vrrp-grid .co1{
	width: 30px;
}
#vrrp-grid .co2{
	width: 140px;
}
#vrrp-grid .co3{
	width: 140px;
}
#vrrp-grid .co4{
	width: 110px;
}
#vrrp-grid .co5{
	width: 70px;
}
#vrrp-grid .co6 {
	width: 70px;
}
#vrrp-grid .co7{
	width: 70px;
}
#vrrp-grid .co8{
	width: 80px;
}

</style>

<script type='text/javascript'>

<% ih_sysinfo(); %>
<% ih_user_info(); %>

//[ ['ip','netmask','gateway','type','port','distance','track'] ...   ]
var vrrp_config=[];
<% web_exec('show interface')%>

//var vifs = [].concat(eth_interface, sub_eth_interface, svi_interface);
var vifs = [].concat(eth_interface, sub_eth_interface, svi_interface);
var now_vifs_options = new Array();
now_vifs_options = grid_list_all_vif_opts(vifs);

<% web_exec('show running-config vrrp') %>

//2 means disabled
for (var i = 0; i < vrrp_config.length; ++i) {
	if(vrrp_config[i][5] == 2)
		vrrp_config[i][5] = 0;

	if(vrrp_config[i][6] == '0')
		vrrp_config[i][6] = '';
		
	if(vrrp_config[i][7] == 2)
		vrrp_config[i][7] = 0;
}

for (var i = 0; i < vrrp_config.length; ++i) {
	var tmp = vrrp_config[i][7];
	
	vrrp_config[i][7] = vrrp_config[i][6];
	vrrp_config[i][6] = vrrp_config[i][5];
	vrrp_config[i][5] = vrrp_config[i][4];
	vrrp_config[i][4] = vrrp_config[i][3];
	vrrp_config[i][3] = vrrp_config[i][2];
	vrrp_config[i][2] = vrrp_config[i][1];
	vrrp_config[i][1] = vrrp_config[i][0];
	vrrp_config[i][0] = tmp;
}

var vrrp = new webGrid();

//返回两个列表的差list1 - list2
function list_reduce(list1,list2)
{
    var ret = [];
    for(var i=0;i<list1.length;i++){
        if(!list_contain(list2,list1[i]))
            ret.push(list1[i]);
    }
    //console.log(ret)
    return ret;
}

function list_contain(list,obj)
{
    for(var i=0;i<list.length;i++){
        if(list[i] == obj)
            return true;
    }

    return false;
}

//更新  已经被使用的方法名称  列表
//当if_method表格中的数据有变动时调用此函数更新

function getusedMethod()
{
	var method_used = [];
	var data = vrrp.getAllData();
	for(var i = 0; i<data.length; i++) method_used.push(data[i][1]);
	
	//console.log('getusedMethod:method_used');
	//console.log(method_used);
	
	return method_used;
}

function interface_cmp(interface, gateway){
	
	var i;
	var id = 3;
	for(i =0; i<interface.length; i++){
		if(gateway == interface[i][id]){
			return -1;
		}
	}
	return 0;
}

function interface_cmp_snd_ip(interface, gateway){
	
	var i,j;
	var id = 3;
	var snd_ip_id= 5;
	var snd_ip;
	for(i =0; i<interface.length; i++){
		if(gateway == interface[i][id]){
			return -1;
		}else {
			snd_ip = interface[i][snd_ip_id];
			for(j = 0 ; j<snd_ip.length; j+=2){
				if(snd_ip[j] == gateway) return -1;
			}
		}
	}
	return 0;
}

function check_ip(gateway)
{
	var rv = 0;
	rv = interface_cmp(cellular_interface, gateway);
	if(rv) return rv;	
	rv = interface_cmp_snd_ip(eth_interface, gateway);
	if(rv) return rv;
	rv = interface_cmp(sub_eth_interface, gateway);
	if(rv) return rv;
	rv = interface_cmp_snd_ip(svi_interface, gateway);
	if(rv) return rv;	
	rv = interface_cmp(xdsl_interface, gateway);
	if(rv) return rv;
	rv = interface_cmp(gre_interface, gateway);
	if(rv) return rv;
	rv = interface_cmp(openvpn_interface, gateway);
	if(rv) return rv;
	rv = interface_cmp(vp_interface, gateway);
	if(rv) return rv;
	rv = interface_cmp_snd_ip(lo_interface, gateway);
	if(rv) return rv;
	return rv;
}


vrrp.verifyFields = function(row, quiet) {

	var f = fields.getAll(row);
	ferror.clearAll(f);

	if(f[5].value.length == 0)
		f[5].value=1;
	
	//VRID不能重复
	var now_vrid = f[1].value;
	var now_if = f[2].value;
	
	var tmp = vrrp.getAllData();
	for(var i=0;i<tmp.length;i++)
		if(tmp[i][1] == now_vrid && tmp[i][2]== now_if ){
		    ferror.set(f[1],vrrpd.v_id_existed , quiet);
			return 0;
		}	


	if( !v_range(f[1],quiet, 1 , 255 ) ) return 0;
	if( !v_ip(f[3],quiet) ) return 0;
	if(!check_ip(f[3].value)){
		if( !v_range(f[4],quiet, 1 , 254 )) return 0;
		if(f[4].value.length == 0)
			f[4].value=100;
	}else{ 
		if( !v_range(f[4],quiet, 255 , 255 ) ) return 0;
		if(f[4].value.length == 0)
			f[4].value=255;
	}
	if( !v_range(f[5],quiet, 1 , 255 ) ) return 0;
	
	//v_f_number(f[7], quiet, 1, 1, 10);
	
	//ferror.clear(f[7]);
    	var v = f[7].value;
	if( v.length!=0 &&  ( isNaN(v)|| v< 1 || v>10 || v.indexOf('.') != -1 )  ){
		ferror.set(f[7],vrrpd.track_id_range,quiet);
		return 0;
    }
	return 1;
}

vrrp.resetNewEditor = function() {
	f = fields.getAll(this.newEditor);
	ferror.clearAll(f);
	if(!check_ip(f[3].value))
		f[4].value=100;
	else 
		f[4].value=255;
	f[5].value=1;

	f[6].checked = 1;
	f[0].checked = 1;
}
vrrp.onDataChanged = function() {
	verifyFields(null, 1);
}

vrrp.fieldValuesToData = function(row) {
	var f = fields.getAll(row);

	tmp = [];
	for(var i=0;i<8;i++)
		tmp.push(f[i].value);
	
	if(f[6].checked == 1)
		tmp[6] = 1;
	else
		tmp[6] = 0;

	if(f[0].checked == 1)
		tmp[0] = 1;
	else
		tmp[0] = 0;

	return tmp;
}

vrrp.dataToView = function(data) {
	if(!check_ip(data[3])) { 
		return [(data[0] == 1) ? ui.yes:ui.no,data[1], data[2],data[3],data[4],data[5],(data[6] == 1) ? ui.yes:ui.no ,data[7]];
	}else {
		return [(data[0] == 1) ? ui.yes:ui.no,data[1], data[2],data[3], '255', data[5],(data[6] == 1) ? ui.yes:ui.no ,data[7]];
	}
}


vrrp.setup = function() {
	this.init('vrrp-grid', 'move', 128, [
		{ type: 'checkbox'  },
		{ type: 'text', maxlen: 15 },
		{ type: 'select', options: now_vifs_options},
		{ type: 'text', maxlen: 15 }, 
		{ type: 'text', maxlen:15 },
		{ type: 'text', maxlen:15 },
		{ type: 'checkbox'  },	 
		{ type: 'text', maxlen: 15 }	]), 
	
	this.headerSet([ui.enable,vrrpd.vid, ui.iface,vrrpd.vip, vrrpd.priority, vrrpd.advertise_interval,vrrpd.preemption_mode,vrrpd.track_id]);
	//this.insertData(-1, ['10', 'vlan 1', '' , '100' , '1' , 1 , '0',1 ]);
	
	var vrrps = vrrp_config;
	for (var i = 0; i < vrrps.length; ++i) {
		this.insertData(-1, [vrrps[i][0], vrrps[i][1], vrrps[i][2] , vrrps[i][3] , vrrps[i][4] , vrrps[i][5] , vrrps[i][6],vrrps[i][7] ]);
	}

	this.showNewEditor();
	this.resetNewEditor();
	
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

function conver_zz(a)
{
	//conver [ ip,netmask,gateway,type,port,distance,track] -> [ip,natmask,type,port, gateway,distance,track ]
	//when is gateway, type and index of json are 0, need this function
	var tmp = [];
	tmp[0] = a[0];
	tmp[1] = a[1];

	if(a[4] != 0){//interface
		tmp[3] = a[4];
        
		if(a[3] == '5')
			tmp[2] = 0;//cellular
		else if(a[3] == '6')
			tmp[2] = 1;//tunnel
		else 
			tmp[2] = 2;//vlan
            
		tmp[4] = a[2];

	}else{//gateway
		tmp[2] = 3;
		tmp[3] = '';
		tmp[4] = a[2];
	}
	tmp[5] = a[5];
	tmp[6] = a[6];
	
	return tmp;
}

function verifyFields(focused, quiet)
{
	//f = vrrp.getALL();

	var fom = E('_fom');	
	var cmd = '';
	
	//alert('f.length = ' + f.length.toString);
	var vrrp_add = [];
	var vrrp_del = [];
	
	E('save-button').disabled = true;	
	//console.log(tmp_data[0]);
	
	var vrrp_old = vrrp_config;
	//alert('vrrp_old.length = '+ vrrp_old.length.toString() );
	//alert('vrrp_old = [' + vrrp_old.join(',') + "]" );
	//console.log(vrrp_old );
	var vrrp_now = vrrp.getAllData();
	//alert('vrrp_now.length =' + vrrp_now.length.toString() );
	//alert('vrrp_now = [' + vrrp_now.join(',') + "]" );
	
	//vrrp add = vrrp_now - vrrp_old
	if(vrrp_old.length != 0){
		for(var i=0 ;i<vrrp_now.length ;i++){
			for(var j=0 ;j<vrrp_old.length ; j++){
				if( !list_cmp(  vrrp_now[i],vrrp_old[j]) )
					break;
				if(j == vrrp_old.length - 1){
					vrrp_add.push(vrrp_now[i])
				}
			}
		}
	}else
		vrrp_add = vrrp_now;
	//alert('vrrp_add.length = '+ vrrp_add.length.toString() );
	//alert('vrrp_add = [' + vrrp_add.join(',') + "]" );
	//console.log('vrrp_add = [[' + vrrp_add.join('],[') + "]]" );
	
	//vrrp_del = vrrp_old - vrrp_now
	if(vrrp_now.length != 0){
		for(var i=0 ;i<vrrp_old.length ;i++){
			for(var j=0 ;j<vrrp_now.length ; j++){
				if( !list_cmp(  vrrp_old[i],vrrp_now[j]) )
					break;
				if(j == vrrp_now.length - 1){
					vrrp_del.push(vrrp_old[i])
				}
			}
		}
	}else
		vrrp_del = vrrp_old;
	//alert('vrrp_del.length = '+ vrrp_del.length.toString() );
	//alert('vrrp_del = [' + vrrp_del.join(',') + "]" );
	//console.log('vrrp_del = [[' + vrrp_del.join('],[') + "]]" );
	
	for(var i=0 ; i<vrrp_del.length ; i++){
		cmd += '!\n'
		cmd += 'interface ' + vrrp_del[i][2]+ '\n';   
		cmd += 'no vrrp ' + vrrp_del[i][1] + ' ip\n';
		cmd += 'no vrrp ' + vrrp_del[i][1] + ' priority\n';
		cmd += 'no vrrp ' + vrrp_del[i][1] + ' advertise-timers\n';
		cmd += 'vrrp ' + vrrp_del[i][1] + ' preempt-mode\n';//default is preempt-mode
		cmd += 'no vrrp ' + vrrp_del[i][1] + ' track\n';
		cmd += 'no vrrp ' + vrrp_del[i][1] + ' enable\n';
	}
	

	for(var i=0 ; i<vrrp_add.length ; i++){
		cmd += '!\n'
		cmd += 'interface ' + vrrp_add[i][2]+ '\n';   
			
		cmd += 'vrrp ' + vrrp_add[i][1] + ' ip '+ vrrp_add[i][3] +'\n';
		if(!check_ip(vrrp_add[i][3])) cmd += 'vrrp ' + vrrp_add[i][1] + ' priority '+ vrrp_add[i][4] +'\n';
		cmd += 'vrrp ' + vrrp_add[i][1] + ' advertise-timers '+ vrrp_add[i][5] +'\n';
		
		if(vrrp_add[i][6])
			cmd += 'vrrp ' + vrrp_add[i][1] + ' preempt-mode\n';
		else	
			cmd += 'no vrrp ' + vrrp_add[i][1] + ' preempt-mode\n';
			
		if(vrrp_add[i][7].length != 0)	
			cmd += 'vrrp ' + vrrp_add[i][1] + ' track '+ vrrp_add[i][7] +'\n';
		
		if(vrrp_add[i][0])
			cmd += 'vrrp ' + vrrp_add[i][1] + ' enable\n';
		else
			cmd += 'no vrrp ' + vrrp_add[i][1] + ' enable\n';
	}
	
	//alert(cmd);

	if (user_info.priv < admin_priv) {
		elem.display('save-button', 'cancel-button', false);
	}else{
		elem.display('save-button', 'cancel-button', true);
		fom._web_cmd.value = cmd;
		E('save-button').disabled = (cmd=="");
	}

	return 1;
}

function save()
{
	if (vrrp.isEditing()) return;

	var fom = E('_fom');

	if((E('_fom')._web_cmd.value != '')&&(cookie.get('autosave') == 1)){
		E('_fom')._web_cmd.value += "!"+"\n"+"copy running-config startup-config"+"\n";	
	}

	form.submit(fom, 1);
}

function earlyInit()
{
	vrrp.setup();
	verifyFields(null, true);
}

function init()
{
	if((cookie.get('autosave')) == null){
		cookie.set('autosave', 1);
	}
	vrrp.recolor();
}
</script>
</head>
<body onload='init()'>
<form id='_fom' method='post' action='apply.cgi'>
<input type='hidden' name='_web_cmd' value=''>

<div class='section'>
	<table class='web-grid' id='vrrp-grid'></table>
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

