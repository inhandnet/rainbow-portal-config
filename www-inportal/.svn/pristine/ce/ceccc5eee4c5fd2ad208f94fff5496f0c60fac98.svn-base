<% pagehead(menu.switch_vlan) %>

<style type='text/css'>
#second_ip-grid  {
	width: 500px;
	text-align: center;
}

#port-grid  {
	width: 600px;
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

var max_vlan_id = 4000;
if(<%ih_license('ip8')%> || <%ih_license('ir8')%>) {
	max_vlan_id = 15;
}
		
<% web_exec('show running-config vlan') %>
<% web_exec('show running-config interface') %>
<% web_exec('show running-config svi') %>
//port_config=[[1,1,1,1,3,2,1,0,0,0,0,0,0,0,0,0,1,0,0,0,'',0,0],[1,1,2,1,3,2,1,0,0,0,0,0,0,0,0,0,1,0,0,0,'',0,0],*****]
//vlan_config=[[1,0,0,'VLAN0001',untagged=[[1,1,1],[1,1,2],[1,1,3],[1,1,4],[1,1,5],[1,1,6],[1,1,7],[1,1,8]],tagged=[],qinq=[]]];
//svi_config = [[1,"192.168.2.1", "255.255.255.0", [["192.168.5.1", "255.255.255.0"], ["192.168.5.2", "255.255.255.0"],["192.168.5.3", "255.255.255.0"]]]];



var vlan_cookie = cookie.get('vlan-modify');
if (vlan_cookie == null){
	vlan_cookie = 0;
}

var port_obj_list = [];
var someone_trunk = 0;
var someone_native = 0;

for(var i=0;i<switchports.length;i++){
    var c = switchports[i];
	if (c[1] == '0') continue; // slot 0 is not a switchport slot
    var port_obj = new Object();
    
    port_obj.name = port_to_str(c[0],c[1],c[2] );
    port_obj.mode = c[3] ? 'TRUNK':'ACCESS';
	if (c[3])
		someone_trunk = 1;
    //console.log(port_obj.mode)
    port_obj.native_vlan = c[4];
	if (c[4] == vlan_cookie)
		someone_native = 1;
    port_obj_list.push(port_obj);
}




//alert(vlan_cookie);

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

    for(var m=0;m<port_obj_list.length;m++){
        if(list_contain( v_obj.port_name,port_obj_list[m].name)){
            //alert(port_obj_list[m].name + 'true');
            v_obj.port.push(1);
        }else{
            //alert(port_obj_list[m].name + 'false');
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


//start use for add a vlan
var v_obj_now = new Object;
v_obj_now.vid='';
v_obj_now.port_name = [];//exp:['FE1/1','FE1/2','FE1/3','FE1/4','FE1/5','FE1/6']
v_obj_now.port = [];//exp:[1,0,1,1,1,0,0,0]
for(var i=0 ; i<port_obj_list.length;i++){
    v_obj_now.port.push(0);
}
v_obj_now.ip = '';
v_obj_now.netmask = '';
v_obj_now.second_ip_mask = [];
//end

var vid_list = [];//save all the vlan's vid
for(var i=0;i<vlan_info_list.length;i++)
{
    vid_list.push(vlan_info_list[i].vid);
    if(vlan_info_list[i].vid == vlan_cookie){
        //alert('vid match');
        v_obj_now = vlan_info_list[i];
        break;
    }
}
//alert('v_obj_now.port:' + v_obj_now.port);
//alert('v_obj_now.second_ip_mask:' + v_obj_now.second_ip_mask);


function back()
{
	document.location = 'setup-vlan.jsp';	
}


function save()
{
	if (!verifyFields(null, false)) return;	

	if ((cookie.get('debugcmd') == 1))
		alert(E('_fom')._web_cmd.value);
	
	if((E('_fom')._web_cmd.value != '')&&(cookie.get('autosave') == 1)){
		E('_fom')._web_cmd.value += "!"+"\n"+"copy running-config startup-config"+"\n";	
	}
	
	form.submit('_fom', 1);
}



function init()
{
	if((cookie.get('autosave')) == null){
		cookie.set('autosave', 1);
	}
}
</script>
</head>
<body onload='init()'>
<form id='_fom' method='post' action='apply.cgi'>
<input type='hidden' name='_web_cmd' value=''>

<div class='section'>
<script type='text/javascript'>
var id_tb = [{ title: ui.vlan_id, name: 'f_vid', type: 'text', maxlen: 4, size: 6, value: v_obj_now.vid }];
createFieldTable('', id_tb);
</script>
</div>
<div class='section-title'>
<script type='text/javascript'>W(vlan.vi);</script>
</div>
<div class='section'>
<script type='text/javascript'>

var vlan_tb = [
					{ title: vlan.pri},
					{ title: ui.ip, indent:2, name: 'f_main_ip', type: 'text', maxlen: 16, size: 15, value: v_obj_now.ip },
					{ title: ui.netmask, indent:2,name: 'f_main_ip_netmask', type: 'text', maxlen: 16, size: 15, value: v_obj_now.netmask },
					{ title: vlan.snd}
				];
createFieldTable('', vlan_tb);

var first_cmd = '';
if(vlan_cookie == 0){//add
    E('_f_vid').value = "";
}else{//modify
    E('_f_vid').value = vlan_cookie;
}

function v_ip_range(start_ip,end_ip,ip)
{
    //verify if ip str in range start_ip - end_ip
    //in range return 1
    //not in range return 0

	var start = _checkIput_fomartIP(start_ip) + _checkIput_fomartIP(start_ip) + _checkIput_fomartIP(start_ip) + _checkIput_fomartIP(start_ip);
	var end = _checkIput_fomartIP(end_ip) + _checkIput_fomartIP(end_ip) + _checkIput_fomartIP(end_ip) + _checkIput_fomartIP(end_ip);
    var start = _checkIput_fomartIP(ip) + _checkIput_fomartIP(ip) + _checkIput_fomartIP(ip) + _checkIput_fomartIP(ip);

    start = parseInt(start, 10);      
    end = parseInt(end, 10);      
    ip = parseInt(ip, 10);

    if((start <= ip) && (ip <= end))
        return 1;    
    else
        return 0;    
} 

var second_ip = new webGrid();
second_ip.setup = function()
{
	this.init('second_ip-grid', ['move'],10,[{ type: 'text', maxlen: 15 } ,{ type: 'text', maxlen: 17 }]);
	this.headerSet([ui.ip,ui.netmask]);
    for(var i=0; i<v_obj_now.second_ip_mask.length; i++)
    {
        var ip_mask = v_obj_now.second_ip_mask[i];
        this.insertData(-1, [ip_mask[0],ip_mask[1]]);
    } 
    //this.insertData(-1, ['192.168.4.2','255.255.255.0']);
	//this.insertData(-1, ['192.168.4.3','255.255.255.0']);
	this.showNewEditor();
	this.resetNewEditor();
}


second_ip.verifyFields = function(row,quiet)
{
	var f = fields.getAll(row);
    ferror.clearAll(f); 
    if(f[1].value.length == 0) f[1].value='255.255.255.0';

	if(!v_info_host_ip(f[0],quiet, 0)) return 0;
	if(!v_info_netmask(f[1],quiet, 0)) return 0;
	return 1;
}
second_ip.onDataChanged = function()
{
	verifyFields(null, 1);
}


function verifyFields(focused, quiet)
{
    var cmd = '';
	var svi_flag = 0;
	var snd_found;
	
    if(vlan_cookie == 0){//add
        E('_f_vid').disabled = false;
    }else{//modify
	    E('_f_vid').disabled = true;
    }
    ferror.clear( E('_f_vid'));        	
    ferror.clear( E('_f_main_ip'));        	
    ferror.clear( E('_f_main_ip_netmask'));

	E('save-button').disabled = 1;

	if(!v_info_num_range('_f_vid',quiet, 0, 1, max_vlan_id))  return 0;
    if(vlan_cookie == 0){
        if( list_contain( vid_list,E('_f_vid').value) ){
            ferror.set(E('_f_vid'), "vid has already been used", quiet);
		    return 0;
        }
    }
	v_obj_now.vid =  E('_f_vid').value;	

	if(!v_info_host_ip( E('_f_main_ip'),quiet, 1)) return 0;	
    if( E('_f_main_ip').value != ''){
		if(!v_info_netmask( E('_f_main_ip_netmask'),quiet, 1)) return 0;
		if (E('_f_main_ip_netmask').value == '') E('_f_main_ip_netmask').value = "255.255.255.0";
    }

	cmd += "!\n";
	cmd += "interface vlan " + E('_f_vid').value + "\n";
	cmd += "!\n";
			
	/*Generic ip cmd*/
	if (v_obj_now.ip !=  E('_f_main_ip').value
		|| v_obj_now.netmask !=  E('_f_main_ip_netmask').value) {
		if (!svi_flag) {
			cmd += "!\n";
			cmd += "interface vlan " + E('_f_vid').value + "\n";
			svi_flag = 1;
		}
		if (E('_f_main_ip').value != '')
			cmd += "ip address " + E('_f_main_ip').value + ' ' + E('_f_main_ip_netmask').value + "\n";
		else
			cmd += "no ip address "+v_obj_now.ip +" " + v_obj_now.netmask +"\n";
	}
	
	var second_ip_list = second_ip.getAllData();
    if((E('_f_main_ip').value == '') && (quiet == 0) && (second_ip_list.length !=0)){
        
        var msg = "Only after the Primary IP has been configured, the Secondary IP to take effect,";
        msg += "Are you sure?";
        if(!confirm(msg))
            return 0;
    }	
	/*second ip deleted*/
    for(var i=0; i<v_obj_now.second_ip_mask.length; i++) {
		snd_found = 0;
		for(j=0;j<second_ip_list.length;j++) {
			if ((second_ip_list[j][0] == v_obj_now.second_ip_mask[i][0])
				&& (second_ip_list[j][1] == v_obj_now.second_ip_mask[i][1])) {
				snd_found = 1;
				break;
			}
		}
		if (!snd_found) {
			if (!svi_flag) {
				cmd += "!\n";
				cmd += "interface vlan " + E('_f_vid').value + "\n";
				svi_flag = 1;
			}			
			cmd += "no ip address " + v_obj_now.second_ip_mask[i][0] + ' ' + v_obj_now.second_ip_mask[i][1] + " secondary\n";
		}
    }
	
	/*second ip added*/
	for(j=0;j<second_ip_list.length;j++){
		snd_found = 0;
    	for(var i=0; i<v_obj_now.second_ip_mask.length; i++) {
			if ((second_ip_list[j][0] == v_obj_now.second_ip_mask[i][0])
				&& (second_ip_list[j][1] == v_obj_now.second_ip_mask[i][1])) {
				snd_found = 1;
				break;
			}
		}
		if (!snd_found) {
			if (!svi_flag) {
				cmd += "!\n";
				cmd += "interface vlan " + E('_f_vid').value + "\n";
				svi_flag = 1;
			}			
			cmd += "ip address " + second_ip_list[j][0] + ' ' + second_ip_list[j][1] + " secondary\n";
		}
    }	

    v_obj_now.port_changed = [];//current status
    for(var i=0;i<port_obj_list.length;i++)
    {
        if(E('port_' + port_obj_list[i].name).checked){
            v_obj_now.port_changed.push(1);
        }else {
            v_obj_now.port_changed.push(0);
        }
    }    

    for(i=0 ;i<port_obj_list.length;i++){
        if(v_obj_now.port[i] != v_obj_now.port_changed[i]){
            cmd += "!\n";
            //into port interface
            var tmp = port_obj_list[i].name;
            if(tmp.slice(0,1) == 'F')
                cmd += "interface fastethernet ";
            else
                cmd += "interface gigabitethernet ";
            cmd += tmp.slice(2) + '\n';
            
            //console.log(port_obj_list[i].mode + i);
            if(v_obj_now.port_changed[i] == 0){
                if(port_obj_list[i].mode == 'ACCESS')
                    cmd += "no switchport access vlan\n";//ACCESS mode
                else
                    cmd += "switchport trunk allowed vlan remove " + v_obj_now.vid + "\n";//TRUNK mode
            }else{    
                if(port_obj_list[i].mode == 'ACCESS')
                    cmd += "switchport access vlan " + v_obj_now.vid + "\n";//ACCESS mode
                else
                    cmd += "switchport trunk allowed vlan add " + v_obj_now.vid + "\n";//TRUNK mode
            }
        }
    }

	if( cmd != '' ){
        E('save-button').disabled = 0;
        E('_fom')._web_cmd.value = cmd; 
        return 1;
    } 
   
    return 0;
}


function earlyInit()
{
    second_ip.setup();
    //when a port's mode is Trunk,if current VLAN is the port's native VLAN,made it can't be delete
    for(var i=0;i<port_obj_list.length;i++){
        if( (port_obj_list[i].mode == "TRUNK") && (port_obj_list[i].native_vlan == v_obj_now.vid))
                E('port_' + port_obj_list[i].name).disabled = 1;
    }

    //when vlan1,and the port's mode is ACCESS make ports can't be unchecked
    if(v_obj_now.vid == '1'){
        for(i=0 ;i<port_obj_list.length;i++){
            if((port_obj_list[i].mode == "ACCESS") && (v_obj_now.port[i] == 1)) 
                E('port_' + port_obj_list[i].name).disabled = 1;//不能把access模式下的端口从Vlan1中删除
        }
    }

}

</script>
</div>

<div class='section'>
<table class='web-grid' id='second_ip-grid'></table>
</div>


<div class='section-title'>
<script type='text/javascript'>W(ui.vlan_member_ports);</script>
</div>

<div class='section'>

<table class='web-grid' cellspacing=1 id='port-grid'>
<tr> 
<script type='text/javascript'>
       
for(var i =0;i< port_obj_list.length;i++){
    W("<td><b>" + port_obj_list[i].name + "</b></td>");
}

W('</tr><tr>')
for(var i =0;i< port_obj_list.length;i++){
    if(v_obj_now.port[i])
        W("<td align='middle'><input type='checkbox' onclick='this.blur();' onchange='verifyFields()' id='port_" + port_obj_list[i].name + "'checked = 0" + "></td>");
    else
        W("<td align='middle'><input type='checkbox' onclick='this.blur();' onchange='verifyFields()' id='port_" + port_obj_list[i].name + "'></td>");
}

</script>
</tr>
</table>
</div>

<div><script type='text/javascript'>if (someone_trunk) GetText(ui.note);</script></div>
<div><script type='text/javascript'>
	if (someone_trunk){
		var first = 1;
		for (var i = 0; i < port_obj_list.length; i++){
			if (port_obj_list[i].mode == 'TRUNK'){
				if (first){
					W(port_obj_list[i].name);
					first = 0;
				}else
					W(', '+port_obj_list[i].name);
			}
		}
		GetText(infomsg.vlanTrk);
		W(';');
	}
</script></div>
<div><script type='text/javascript'>
	if (someone_trunk && someone_native){
		GetText(infomsg.vlanNat1);
		var first = 1;
		for (var i = 0; i < port_obj_list.length; i++){
			if (port_obj_list[i].mode == 'TRUNK')
				if (port_obj_list[i].native_vlan == vlan_cookie){
					if (first){
						W(port_obj_list[i].name);
						first = 0;
					}else
						W(', '+port_obj_list[i].name);
				}
		}
		GetText(infomsg.vlanNat2);
		W(vlan_cookie);
	}
</script></div>

<script type='text/javascript'>
if(cookie.get('autosave') == 1)
	ui.aply=ui.aply_save;
genStdFooterWithBack("");
</script>

</form>
<script type='text/javascript'>earlyInit();</script>
<script type='text/javascript'>verifyFields(null, true);</script>
</body>
</html>
