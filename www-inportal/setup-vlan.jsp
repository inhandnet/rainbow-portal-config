<% pagehead(menu.status_vlan) %>
<style type='text/css'>

#vlan-grid {
	width: 800px;	
	text-align: center;
}


</style>

<script type='text/javascript'>

function port_to_str(type,slot,num)
{
    var tmp = '';
    if(type == 1){
		tmp = ("FE"+ slot + "/" + num);
	}else if(tmp == 2){
		tmp = ("GE"+ slot + "/" + num);
    }
    
    return tmp;
}

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

<% ih_sysinfo() %>
<% ih_user_info() %>

var operator_priv = 12;

var vlan_config= [];
var port_config=[];
<% web_exec('show running-config vlan') %>
<% web_exec('show running-config interface') %>
<% web_exec('show running-config svi') %>
//port_config=[[1,1,1,1,3,2,1,0,0,0,0,0,0,0,0,0,1,0,0,0,'',0,0],[1,1,2,1,3,2,1,0,0,0,0,0,0,0,0,0,1,0,0,0,'',0,0],*****]
//vlan_config=[[1,0,0,'VLAN0001',untagged=[[1,1,1],[1,1,2],[1,1,3],[1,1,4],[1,1,5],[1,1,6],[1,1,7],[1,1,8]],tagged=[],qinq=[]]];
//svi_config = [[1,"192.168.2.1", "255.255.255.0", [["192.168.5.1", "255.255.255.0"], ["192.168.5.2", "255.255.255.0"],["192.168.5.3", "255.255.255.0"]]]];

var port_name_list = [];
for(var i=0;i<port_config.length;i++){
	var port = port_config[i];
	if (port[1] == '0') continue; // slot 0 is not a switchport slot
	port_name_list.push(port_to_str(port[0],port[1],port[2]));
}
//alert('port_name_list:' + port_name_list);

var vlan_info_list = [];

function get_l2_vlan_config(vid)
{
	var l2_vlan = [];
	
	for(var i=0;i<vlan_config.length;i++){
		if (vlan_config[i][0] == vid){
			l2_vlan = vlan_config[i];
			break;
		}
	}

	return l2_vlan;
}

function get_l3_vlan_config(vid)
{
	var l3_vlan = [];
	
	for(var i=0;i<svi_config.length;i++){
		if (svi_config[i][0] == vid){
			l3_vlan = svi_config[i];
			break;
		}
	}

	return l3_vlan;
}

var j = 0;
for (var i = 1; i < 4095; i++){
	var l2_vlan_config = get_l2_vlan_config(i);
	var l3_vlan_config = get_l3_vlan_config(i);
	
	if (l2_vlan_config.length == 0
		&& l3_vlan_config.length == 0){
		continue;
	}
	
	vlan_info_list[j]=new Object;
	var v_obj = vlan_info_list[j]; 
	j++;
    v_obj.vid=i.toString();
    v_obj.port_name = [];//exp:['FE1/1','FE1/2','FE1/3','FE1/4','FE1/5','FE1/6']
    v_obj.port = [];//exp:[1,0,1,1,1,0,0,0]
    v_obj.ip = '';
    v_obj.netmask = '';
    v_obj.second_ip_mask = [];	

	if (l2_vlan_config.length){
	    //untagged
	    for(var m=0;m<l2_vlan_config[4].length;m++){
	        v_obj.port_name.push(port_to_str(l2_vlan_config[4][m][0],l2_vlan_config[4][m][1],l2_vlan_config[4][m][2]));
	    }
	    
	    //tagged
	    for(var m=0;m<l2_vlan_config[5].length;m++){
	        v_obj.port_name.push(port_to_str(l2_vlan_config[5][m][0],l2_vlan_config[5][m][1],l2_vlan_config[5][m][2]));
	    }	
	}

    for(var m=0;m<port_name_list.length;m++){
        if(list_contain( v_obj.port_name,port_name_list[m])){
            //alert(port_name_list[m] + 'true');
            v_obj.port.push(1);
        }else{
            //alert(port_name_list[m] + 'false');
            v_obj.port.push(0);
        } 
    }
		
	if ( l3_vlan_config.length) {
	    //search for ip/mask
	    //primary
	    v_obj.ip = l3_vlan_config[1];
	    v_obj.netmask = l3_vlan_config[2];
	    //second ip/mask
	    v_obj.second_ip_mask = l3_vlan_config[3];
	}
}

//alert(vlan_info_list);


var vlan = new webGrid();

vlan.dataToView = function(data)
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

vlan.setup = function() {
	if (user_info.priv >= operator_priv)
        head_list = [].concat(ui.vlan_id,port_name_list,[ui.primary_ip + '/' + ui.netmask]);
    else
        head_list = [].concat(ui.vlan_id,port_name_list,[ui.ip + '/' + ui.netmask]);

    //alert(head_list);

    var tmp = [];
    for(var i=0;i<port_name_list.length;i++)
    {
        tmp[i] = { type: 'checkbox' };
    }
    var head_type_list = [].concat([{ type: 'text', maxlen: 15 }],tmp,{type:'text', maxlen:35});

    this.init('vlan-grid', ['sort', 'readonly','select'],8,head_type_list);
	this.headerSet(head_list);

	
    for(var i=0;i<vlan_info_list.length;i++){
        var v_obj = vlan_info_list[i];
        var tmp = v_obj.ip + '/' + v_obj.netmask;
        
        if (user_info.priv < operator_priv)
            //alert(v_obj.second_ip_mask.length);
            for(var j=0; j<v_obj.second_ip_mask.length; j++){
                tmp += "<br />" + v_obj.second_ip_mask[j][0] + '/' + v_obj.second_ip_mask[j][1];
            }

        this.insertData(-1, [].concat([v_obj.vid],v_obj.port,[tmp]));

    }

    //this.insertData(-1, ['1',1,0,0,0,1,1,0,0,'192.168.2.1/255.255.255.0']);
	//this.insertData(-1, ['2',0,0,1,0,0,0,1,0,'192.168.3.1/255.255.255.0']);
	//this.insertData(-1, ['3',0,1,0,1,0,0,0,1,'192.168.4.1/255.255.255.0']);


	//vlan.loadData();
	if (user_info.priv >= operator_priv)
		vlan.footerButtonsSet(0);

}

vlan.jump = function(){
	document.location = 'switch-vlanN.jsp';	
}

vlan.footerAdd = function(){
	cookie.unset('vlan-modify');
	vlan.jump();		
}
	
vlan.footerModify = function(){
	var f = vlan.getAllData();
	if (vlan.selectedRowIndex < 0 || vlan.selectedColIndex < 0)
		return;

	var keyVar = f[vlan.selectedRowIndex - 1][this.selectedColIndex];
	cookie.set('vlan-modify', keyVar);
	vlan.jump();
}

vlan.footerDel = function(){
	var send_cmd = [];
    var f = this.getAllData();
    var cmd = '';

	//alert(vlan.selectedRowIndex);
	//alert(vlan.selectedCowIndex);//always 0

	if (vlan.selectedRowIndex < 0 || this.selectedColIndex < 0)
		return;
	var keyVar = f[vlan.selectedRowIndex - 1][0];

	if(f[vlan.selectedRowIndex - 1][0] == 1){
		show_alert(errmsg.delete_error);
		return false;
    }
    
    cmd += "!"+"\n";
    cmd += "no interface vlan "+keyVar+"\n";
    cmd += "no vlan "+keyVar+"\n";
	
	E('_fom')._web_cmd.value = cmd ;
	
	if((E('_fom')._web_cmd.value != '')&&(cookie.get('autosave') == 1)){
		E('_fom')._web_cmd.value += "!"+"\n"+"copy running-config startup-config"+"\n";	
	}

	form.submit('_fom', 1);
}

function earlyInit()
{
	vlan.setup();
}

function init()
{
	vlan.recolor();
}

</script>

</head>
<body onload='init()'>
<form id='_fom' method='post' action='apply.cgi'>
<input type='hidden' name='_web_cmd' value=''>

<div class='section'>
	<table class='web-grid' id='vlan-grid'></table>
</div>

</form>

<script type='text/javascript'>earlyInit();</script>
</body>
</html>
