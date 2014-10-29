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

#ifacl-grid {
	width: 400px;	
	text-align: center;
}

#ifacl-grid .co1{
	width: 100px;	
	text-align: center;
}

#ifacl_head{
	background: #e2dff7;
}

</style>

<script type='text/javascript'>

function port_to_str(type,slot,num)
{
    var tmp = '';
    if(type == 1){
		tmp = ("FE"+ slot + "/" + num);
	}else if(type == 2){
		tmp = ("GE"+ slot + "/" + num);
    }else if(type == 3){
    }else if(type == 4){
    }else if(type == 5){
		tmp = ("cellular " + num);
    }else if(type == 6){
		tmp = ("tunnel " + num);
    }else if(type == 7){
    }else if(type == '8'){
        tmp = ("vlan " + num);
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

//var acl_list=[1,2,3,4,5,6,7,8];
//var interface_list=['interface1','interface2','interface3','interface4','interface5','interface6','interface7','interface8'];

<% ih_sysinfo() %>
<% ih_user_info() %>

var operator_priv = 12;

var if_acl_config = [  [[1, 0, 10], 1, 1]];
//svi_config = [[1,"192.168.2.1", "255.255.255.0", [["192.168.5.1", "255.255.255.0"], ["192.168.5.2", "255.255.255.0"],["192.168.5.3", "255.255.255.0"]]]];

svi_config = [];
 
<% web_exec('show running-config interface') %>

var port_name_list = [];
var port_obj_list = [];
for(var i=0 ; i< switchports.length;i++){
    var c = switchports[i];

	//slot 0 is not a switch port
	if (c[1] == '0') continue;
    var port_obj = new Object();
    
    port_obj.name = port_to_str(c[0],c[1],c[2] );
    port_obj.mode = c[3] ? 'Trunk':'Access';
    port_obj.native_vlan = c[4];
    port_obj_list.push(port_obj);
}
//console.log(port_name_list)



function verifyFields(focused, quiet){
    var cmd = '';

    for(var i=0 ; i< port_obj_list.length;i++){

        var mode_now = E((port_obj_list[i].name).replace(' ','_') + '_mode').value;
        var native_vlan_now = E((port_obj_list[i].name).replace(' ','_') + '_native_vlan').value;

        var mode_old = port_obj_list[i].mode;
        var native_vlan_old = port_obj_list[i].native_vlan;

        if(mode_now == 'Access'){
            E((port_obj_list[i].name).replace(' ','_') + '_native_vlan').disabled = 1;
            E((port_obj_list[i].name).replace(' ','_') + '_native_vlan').value = native_vlan_old;
        }else
            E((port_obj_list[i].name).replace(' ','_') + '_native_vlan').disabled = 0;
		
		if(!v_range(E((port_obj_list[i].name).replace(' ','_') + '_native_vlan'),quiet,1,4094))
			return 0;

        if( (mode_now != mode_old)||(native_vlan_now != native_vlan_old)){
            var port_name = port_obj_list[i].name.slice(-3)
            //console.log(port_name);
            
            cmd += '!\n';
            cmd += 'interface fastethernet ' + port_name + ' \n';
            
            if(mode_now == 'Access'){
                cmd += 'switchport mode access \n';
            }else{
                if(mode_old != 'Trunk')
                    cmd += 'switchport mode trunk \n';
                if(native_vlan_old != native_vlan_now)
                    cmd += 'switchport trunk native vlan ' + native_vlan_now + '\n';
            }
        }
        
    }
    
    E('save-button').disabled = 1;
    if(cmd != ''){
        //alert(cmd);
        E('save-button').disabled = 0;
        E('_fom')._web_cmd.value = cmd;
    }

    if (user_info.priv < operator_priv) {
		elem.display('save-button', 'cancel-button', false);
	}else{
		elem.display('save-button', 'cancel-button', true);
	}

    return 1;
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

function earlyInit()
{
}

function init()
{
    verifyFields('', 1);
}

</script>

</head>
<body onload='init()'>
<form id='_fom' method='post' action='apply.cgi'>
<input type='hidden' name='_web_cmd' value=''>


<script type='text/javascript'>
var modes = ['Access','Trunk'];
W("<table class=web-grid cellspacing=1 id='ifacl-grid' >");
W("<tr id='ifacl_head' >");
W("<th >");W(ui.prt);W("</th>");
W("<th >");W(ui.trunk_mode);W("</th>");
W("<th >");W(ui.trunk_native);W("</th>");
W("</tr>");
for(var i=0;i<port_obj_list.length;i++){
	W("<tr>");
	W("<td>");
    W(port_obj_list[i].name);
	W("</td>");
	W(creatSelect(modes,port_obj_list[i].mode,(port_obj_list[i].name).replace(' ','_') + '_mode'));
    W("<td><input type='text' value='" + port_obj_list[i].native_vlan +"' onchange=verifyFields(null,true) id = '" + (port_obj_list[i].name.replace(' ','_') + '_native_vlan') + "' >");
	W("</tr>");
}

//W("<tr bgcolor='#F0F0F0'><td colspan='3' align='right'>");
//W("<input type='button' style='width:100px' onclick='reloadPage()' value=" + ui.cancel + " />");
//W("<input type='button' style='width:100px' onclick='save()' value=" + ui.save + " />");
//W("</td></tr>")

W("</table>")
</script>
<div>
<script type='text/javascript'>GetText(ui.note);</script>
</div>
<div>
<script type='text/javascript'>GetText(infomsg.nativeVlan);</script>
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

