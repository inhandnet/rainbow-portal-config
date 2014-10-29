<% pagehead(menu.status_vlan) %>
<style type='text/css'>

#acl-grid {
	width: 800px;	
	text-align: center;
}
#acl-grid .co1{
	width: 70px;	
}
#acl-grid .co2{
	width: 80px;	
}
#acl-grid .co3{
	width: 60px;	
}
#acl-grid .co4{
	width: 160px;	
}
#acl-grid .co5{
	width: 160px;	
}


#interface-grid {
	width: 400px;	
	text-align: center;
}

#interface-grid .co1{
	width: 180px;	
	text-align: center;
}


</style>

<script type='text/javascript'>



//judge if m contain n
//contain return True
//not contain return False
function list_contain(m,n)
{
    for(var i=0;i<m.length;i++){
        if(m[i] == n)
            return true;
    }
    return false;
}

//var acl_list=[1,2,3,4,5,6,7,8];
//var interface_list=['interface1','interface2','interface3','interface4','interface5','interface6','interface7','interface8'];

<% ih_sysinfo() %>
<% ih_user_info() %>

var operator_priv = 12;

var if_acl_config = [  [[1, 0, 10], 1, 1]];
var acl_config = [  [1, 0, ["any", "", "", ""], ["any", "", "", ""], "", 0, 0, 0, 2],
				[2, 0, ["1.1.1.1", "", "", ""], ["any", "", "", ""], "", 0, 0, 0, 2],
				[2, -1, 'is a remark string'],
				[101, 4, ["any", "", "", ""], ["any", "", "", ""], "1/20", 0, 0, 0, 2],
				[101, 4, ["any", "", "", ""], ["any", "", "", ""], "time-exceeded", 0, 0, 0, 2],
				[101, 1, ["2.2.2.0", "0.0.0.255", "", ""], ["3.3.3.0", "0.0.0.255", "", ""], "", 0, 1, 1, 2],
				[101, 1, ["2.2.2.0", "0.0.0.255", "", ""], ["any", "", "", ""], "", 0, 0, 0, 2],
				[101, 2, ["any", "", "lt", "100"], ["any", "", "lt", "300"], "", 1, 0, 1, 2]
			];
            



<% web_exec('show interface') %>
 
<% web_exec('show running-config access-list') %>


/*****************************************************************/
var vifs = [].concat(cellular_interface, eth_interface, sub_eth_interface, svi_interface, xdsl_interface, gre_interface, vp_interface, dot11radio_interface);
var now_vifs_options = new Array();
now_vifs_options = grid_list_all_vif_opts(vifs);
//alert(now_vifs_options);
/*****************************************************************/



var interface_obj_list = [];
//alert('interface name list:'+interface_name_list);

//for(var i=0 ; i< interface_name_list.length;i++){
for(var i=0 ; i< now_vifs_options.length;i++){
    var interface_obj = new Object();
    interface_obj.name = now_vifs_options[i][0];
    
    var flag = 0; 
    var j=0;
    for(j=0 ; j< if_acl_config.length;j++){
        if( interface_obj.name == if_acl_config[j][0]){
            flag = 1;
            break;
        }
    }
    if(flag == 0){
        interface_obj.in_acl = 'none';
        interface_obj.out_acl = 'none';
        interface_obj.admin_acl = 'none';
    }else{
        interface_obj.in_acl = if_acl_config[j][1] == 0 ? 'none':if_acl_config[j][1];
        interface_obj.out_acl = if_acl_config[j][2] == 0? 'none':if_acl_config[j][2];
        interface_obj.admin_acl = if_acl_config[j][3] == 0? 'none':if_acl_config[j][3];

        //alert('in out admin:'+interface_obj.in_acl + interface_obj.out_acl + interface_obj.admin_acl);
    }
    interface_obj_list.push(interface_obj);
}
//alert(interface_obj_list.length);
var ace_obj_list = [];
var acl_index_list = [];
for(var i=0 ; i< acl_config.length;i++){
    var ace_obj = new Object();
    ace_obj.index = acl_config[i][0];
    ace_obj.remark = '';
    
    if(acl_config[i][1] == -1){//is a remark
        var l = ace_obj_list.length;
        if(l > 0){
            if(ace_obj_list[l-1].index == ace_obj.index )
                ace_obj_list[l-1].remark += acl_config[i][2];
        }
        continue;
    }

    ace_obj.action = acl_config[i][8] == 1 ? 'deny':'permit';
    ace_obj.type = acl_config[i][1] ;
    ace_obj.log = acl_config[i][7] ;
    ace_obj.fragments = acl_config[i][6] ;
    ace_obj.established = acl_config[i][5] ;

    ace_obj.src_ip = acl_config[i][2][0];
    ace_obj.src_mask = acl_config[i][2][1];
    ace_obj.src_port_operation = acl_config[i][2][2];
    ace_obj.src_port_num = acl_config[i][2][3];
    
    ace_obj.dst_ip = acl_config[i][3][0];
    ace_obj.dst_mask = acl_config[i][3][1];
    ace_obj.dst_port_operation = acl_config[i][3][2];
    ace_obj.dst_port_num = acl_config[i][3][3];

    ace_obj.icmp_arg = acl_config[i][4];

    if( !list_contain(acl_index_list,ace_obj.index))
        acl_index_list.push(ace_obj.index);

    ace_obj_list.push(ace_obj);
}


var acl_index_option = [];
acl_index_option.push(['none','none']);
for(var i = 0; i < acl_index_list.length; i++) {
	acl_index_option.push([acl_index_list[i], acl_index_list[i]]);
}

function option_convert(a){
    ret = [];
    for(var i = 0; i < a.length; i++) {
        ret.push([a[i],a[i]]);
    }

    return ret;
}

//从表格中获得对应接口的acl情况
function get_acl_from_table(interface_name){
    var tmp_data = ifconfig.getAllData();
    var in_acl = 'none';
    var out_acl = 'none';
    var admin_acl = 'none';

    for(var i=0 ; i<tmp_data.length ; i++ ){
        if( tmp_data[i][0] == interface_name ){ //name
            //alert(interface_name_now);
            var in_acl = tmp_data[i][1];
            var out_acl = tmp_data[i][2];
            var admin_acl = tmp_data[i][3];
            break;
        }
    }

    return [in_acl,out_acl,admin_acl];
}

function verifyFields(focused, quiet){
    var cmd = '';
    var tmp_data = ifconfig.getAllData();
    
    for(var i=0 ; i< interface_obj_list.length;i++){
        var interface_name_now = interface_obj_list[i].name;
        
        var acl_now = get_acl_from_table(interface_name_now); 
        
        var in_acl_now = acl_now[0];
        var out_acl_now = acl_now[1];
        var admin_acl_now = acl_now[2];
        
        var in_acl_old = interface_obj_list[i].in_acl;
        var out_acl_old = interface_obj_list[i].out_acl;
        var admin_acl_old = interface_obj_list[i].admin_acl;

        if( in_acl_now != in_acl_old){
            cmd += '!\n';
            cmd += 'interface ' + interface_name_now + ' \n';
            
            if(in_acl_now != 'none'){
                cmd += 'ip access-group ' + in_acl_now + ' in\n'
            }else{
                cmd += 'no ip access-group ' + in_acl_old + ' in\n'
            }
        }
        
        if( out_acl_now != out_acl_old){
            cmd += '!\n';
            cmd += 'interface ' + interface_name_now + ' \n';
            
            if(out_acl_now != 'none'){
                cmd += 'ip access-group ' + out_acl_now + ' out\n'
            }else{
                cmd += 'no ip access-group ' + out_acl_old + ' out\n'
            }
        }

        if( admin_acl_now != admin_acl_old){
            cmd += '!\n';
            cmd += 'interface ' + interface_name_now + ' \n';
            
            if(admin_acl_now != 'none'){
                cmd += 'ip access-group ' + admin_acl_now + ' admin\n'
            }else{
                cmd += 'no ip access-group ' + admin_acl_old + ' admin\n'
            }
        }
    }
    
    if (user_info.priv < operator_priv) {
		elem.display('save-button', 'cancel-button', false);
	}else{
		elem.display('save-button', 'cancel-button', true);
	}

    E('save-button').disabled = 1;
    if(cmd != ''){
        E('save-button').disabled = 0;
        //if(confirm(cmd))
        //alert(cmd);
        E('_fom')._web_cmd.value = cmd;
    }

    return 1;
}

function save()
{
	if (!verifyFields(null, false)) return;

	if (ifconfig.isEditing()) return;
	
	if ((cookie.get('debugcmd') == 1))
		alert(E('_fom')._web_cmd.value);
	
	if((E('_fom')._web_cmd.value != '')&&(cookie.get('autosave') == 1)){
		E('_fom')._web_cmd.value += "!"+"\n"+"copy running-config startup-config"+"\n";	
	}

	form.submit('_fom', 1);
}

function creatSelect(options,default_value,id)
{
	var string = "<td><select onchange=verifyFields(null,true) id = " + id + ">";
	for(var i = 0;i < options.length;i++){
		if(default_value == options[i]){
			string +='<option value='+options[i]+' selected>'+options[i]+'</option>';
		}else{
			string +='<option value='+options[i]+'>'+options[i]+'</option>';
		}
	}
    
	string +="</select></td>";
	return string;
}

var ifconfig = new webGrid();
ifconfig.setup = function() {

    this.init('interface-grid', ['sort','select'],now_vifs_options.length,
        [//{ type: 'select',  options:  option_convert(interface_name_list)},
        { type: 'select',  options:  now_vifs_options},
        { type: 'select',  options: acl_index_option},
        { type: 'select',  options: acl_index_option},
        { type: 'select',  options: acl_index_option}]);
            
    //最大行数=接口数

	this.headerSet([ui.interface_name,ui.in_acl,ui.out_acl,ui.admin_acl]);
   
    for(var i=0;i<interface_obj_list.length;i++){
        var tmp_if = interface_obj_list[i];
        if((tmp_if.in_acl != 'none') || (tmp_if.out_acl != 'none') || (tmp_if.admin_acl != 'none')){
            this.insertData(-1, [tmp_if.name,tmp_if.in_acl,tmp_if.out_acl,tmp_if.admin_acl] );
			grid_vif_opts_sub(now_vifs_options, tmp_if.name);
        }
    }
	
	
	this.showNewEditor();
	this.resetNewEditor();
	this.updateEditorField(0, { type: 'select', maxlen: 15, options: now_vifs_options} );
}

ifconfig.verifyFields = function(row, quiet) {
    
    var f = fields.getAll(row);

    /*
    if( (f[1].value == 'none') && (f[2].value == 'none') && (f[3].value == 'none') ){
        ferror.set(f[3],ui.at_least_one_acl , quiet);
		return 0;
	}*/	
	grid_vif_opts_sub(now_vifs_options, f[0].value);
	return 1;
}


ifconfig.verifyDelete = function(data) {
	grid_vif_opts_add(now_vifs_options, data[0]);
	return true;
}



ifconfig.onDataChanged = function() {
	this.updateEditorField(0, { type: 'select', maxlen: 15, options: now_vifs_options} );
    //结束编辑已经存在的接口时，在接口名称的下拉框里面只显示表格中不存在的接口
	verifyFields(null, 1);
}
ifconfig.onClick = function(cell)
{
	var q = PR(cell);
	var data = this.getAllData();
	var thisData = data[q.rowIndex -1];
	this.updateEditorField(0, { type: 'select', maxlen: 15, options: [[thisData[0], thisData[0]]]} );
	
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

    var f = fields.getAll(this.editor);
	f[0].disabled = true;
}


var acl = new webGrid();

acl.setup = function() {
    this.init('acl-grid', ['readonly','select'],8,
        [{ type: 'text', maxlen: 25 } ,	{ type: 'text',maxlen:25 },
        { type: 'text', maxlen: 25 } ,	{ type: 'text',maxlen:25 },
        { type: 'text',maxlen:25 },{ type: 'text',maxlen:25 },
        { type: 'text',maxlen:25 }]);
	
	//this.headerSet(['ACL index','type','action','src ip/mask and port','dest ip/mask and port','flags','discription']);
	this.headerSet([ui.id,ui.acl_action,ui.acl_protocols,ui.acl_src,ui.acl_dest,ui.acl_other,ui.desc]);
    for(var i=0;i<ace_obj_list.length;i++){
        var ace_obj = ace_obj_list[i];

        var src =  ace_obj.src_ip + '/' + ace_obj.src_mask + 
        '; port' + ace_obj.src_port_operation + ace_obj.src_port_num; 
        
        var dst = ace_obj.dst_ip + '/' + ace_obj.dst_mask + 
        '; port' + ace_obj.dst_port_operation + ace_obj.dst_port_num;

		var behavior = ace_obj.action;
        if(ace_obj.log != '') behavior += '&log';
        var flags = '';
        if(ace_obj.fragments != '') flags += 'fragments;';
        if(ace_obj.established != '') flags += 'established;';
        if(ace_obj.icmp_arg != '') flags += 'icmp(' + ace_obj.icmp_arg +');';;

        this.insertData(-1, [ace_obj.index,behavior,ace_obj.type,src,dst,flags,ace_obj.remark]);
    }
	
	if (user_info.priv >= operator_priv)
		acl.footerButtonsSet(0);
}

acl.dataToView = function(data){
    var v = [];
    var tmp = '';
    v.push(data[0].toString());
    v.push(data[1]);

    data[2] = data[2].toString();
    var replaces = [['0','ip'],['1','ip'],['2','tcp'],['3','udp'],['4','icmp']];
    for(var i=0;i<replaces.length;i++)
        data[2] = data[2].replace(replaces[i][0],replaces[i][1]);    
    v.push(data[2]);
	
    //src do str replace to make infomation looks better
    replaces = [['any/','any'],[/; port$/,''],[/\/$/,''],['neq','!='],['eq','='],['lt','<'],['gt','>'],['range',' ']];
    for(var i=0;i<replaces.length;i++)
        data[3] = data[3].replace(replaces[i][0],replaces[i][1]);
    v.push(data[3]);

    //dest
    for(var i=0;i<replaces.length;i++)
        data[4] = data[4].replace(replaces[i][0],replaces[i][1]);
    v.push(data[4]);
    
    v.push(data[5]);
    v.push(data[6]);
    return v;
}


acl.onClick = function(cell) {
	if (user_info.priv < operator_priv) {
		return;
	}	
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
			onDataChanged();
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
			E('row-mod').disabled = false;
			E('row-del').disabled = false;
		}
	    
        E('row-mod').disabled = true;//by zw,can't modify
		return;
		//return this.tb.rows[this.selectedRowIndex]._data;
	}

}

acl.jump = function(){
	document.location = 'setup-acl-detail.jsp';	
}

acl.footerAdd = function(){
	cookie.unset('acl-modify');
	acl.jump();		
}
	
acl.footerModify = function(){
    show_alert("can't modify one ace,please del it")
    return ;

    var f = acl.getAllData();
	if (acl.selectedRowIndex < 0 || acl.selectedColIndex < 0)
		return;

	//var keyVar = f[acl.selectedRowIndex - 1][this.selectedColIndex];
	var keyVar = acl.selectedRowIndex;
	cookie.set('acl-modify', keyVar);
	acl.jump();
}

acl.footerDel = function(){
    var r=confirm("This operation will delete all ACLs with the same index, are you sure?");
    var f = acl.getAllData();
    
    if (r==true){
        var keyVar = f[acl.selectedRowIndex - 1][0];
        //alert('del acl '+ keyVar);
        var cmd = '';
        cmd += "!\n"; 
        cmd += "no access-list " + keyVar + "\n";//del the acl

        //if the acl has benn used in one or more interface,release it         
        for(var i=0 ; i< interface_obj_list.length;i++){
            var interface_name_now = interface_obj_list[i].name;
            
            var tmp_cmd = '';
            if( keyVar ==  interface_obj_list[i].in_acl )
                tmp_cmd += 'no ip access-group ' + keyVar + ' in\n'
                
            if( keyVar ==  interface_obj_list[i].out_acl )
                tmp_cmd += 'no ip access-group ' + keyVar + ' out\n'
            
            if( keyVar ==  interface_obj_list[i].admin_acl )
                tmp_cmd += 'no ip access-group ' + keyVar + ' admin\n'
                
            if(tmp_cmd != ''){
                cmd += '!\n';
                cmd += 'interface ' + interface_name_now + ' \n';
                cmd += tmp_cmd;
            }
        }

        E('_fom')._web_cmd.value = cmd;
	
	    if((E('_fom')._web_cmd.value != '')&&(cookie.get('autosave') == 1)){    
		    E('_fom')._web_cmd.value += "!"+"\n"+"copy running-config startup-config"+"\n";	
	    }

	    form.submit('_fom', 1);
    }
}

function earlyInit()
{
	//interface.setup();
	acl.setup();
    ifconfig.setup();
	verifyFields(null, 1);

    if (user_info.priv < operator_priv) {
		elem.display('save-button', 'cancel-button', false);
	}else{
		elem.display('save-button', 'cancel-button', true);
	}
}

function init()
{
}



</script>

</head>
<body onload='init()'>
<form id='_fom' method='post' action='apply.cgi'>
<input type='hidden' name='_web_cmd' value=''>



<div class='section-title'>
<script type='text/javascript'>
W(ui.acl_list);
</script>
</div>
<div class='section'>
	<table class='web-grid' id='acl-grid'></table>
</div>
<div class='section-title'>
<script type='text/javascript'>
W(ui.interface_list);
</script>
</div>


<div class='section'>
	<table class='web-grid' id='interface-grid'></table>
</div>
<script type='text/javascript'>
if(cookie.get('autosave') == 1)
	ui.aply=ui.aply_save;
genStdFooter("");
</script>

</form>

<script type='text/javascript'>earlyInit();</script>
</body>
</html>
