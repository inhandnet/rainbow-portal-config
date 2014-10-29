<% pagehead(menu.setup_aaa) %>
<style type='text/css'>
#aaa-grid {
	width: 650px;	
	text-align: center;
}

#aaa-grid_head1{
	background: #e2dff7;
}

#aaa-grid_head2{
	background: #e2dff7;
}

</style>

<script type='text/javascript'>

<% ih_sysinfo(); %>
<% ih_user_info(); %>

// console, telnet, ssh, http.
// 0 - none, 1 – local, 2 – tacacs+, 3 - radius, 4 - ldap
aaa_authen_config = [['0','0','0'],['1','3','0'],['0','0','0'],['0','0','0']];
aaa_author_config = [['0','0','0'],['1','3','0'],['1','3','0'],['0','0','0']];

<% web_exec('show running-config aaa'); %>


aaa_options = ['none','local','tacacs+','radius','ldap'];

for(var i=0;i<4;i++){
    for(var j=0;j<3;j++){
        aaa_authen_config[i][j] = aaa_options[ aaa_authen_config[i][j] ];
        
        aaa_author_config[i][j] = aaa_options[ aaa_author_config[i][j] ];
    }
}


function list_contain(list,obj)
{
    for(var i=0;i<list.length;i++){
        if(list[i] == obj)
            return true;
    }

    return false;
}
//返回两个列表的差
function list_reduce(list1,list2)
{
    ret = [];
    for(var i=0;i<list1.length;i++){
        if(!list_contain(list2,list1[i]))
            ret.push(list1[i]);
    }
    //console.log(ret)
    return ret;
}


var first_cmd = '';
function verifyFields(focused, quiet)
{
    var cmd = '';

    var ways = ['console','telnet','ssh','http'];
    var actions = ['a1','a2'];
    var sequences = ['first','second','third'];
    var configs = [aaa_authen_config,aaa_author_config];
    var cmd_heads = ['authentication','authorization'];

    for(var j=0;j<actions.length;j++){
        var config = configs[j];
        var cmd_head = cmd_heads[j];
        
        for(var i=0;i<ways.length;i++){
            var choosed = [];
            var changed_flag = 0;

            for(var k=0;k<sequences.length;k++){
                var id =  actions[j] + '_' + ways[i] + '_' + sequences[k];
                
                if( list_contain(choosed,'none')){
                    E(id).value = 'none'; 
                    E(id).disabled =1;
                }else{
                    E(id).disabled =0;
                    //console.log(id)
                    resetOptions(E(id),list_reduce(aaa_options,choosed));
                    choosed.push(E(id).value);
                }
                
                //have changed?
                if(config[i][k] != E(id).value){
                    changed_flag = 1;
                    //console.log('changed ' + id);
                    //console.log(config[i][k] + '----' + E(id).value);
                }
            }
            
            if(changed_flag){
                cmd += 'no aaa ' + cmd_head + ' ' + ways[i] + ' default\n';
                
                var v = E(actions[j] + '_' + ways[i] + '_' + sequences[0]).value;
                if( v != 'none'){
                    cmd += 'aaa ' + cmd_head + ' ' + ways[i] + ' default ' + v;
                
                    v = E(actions[j] + '_' + ways[i] + '_' + sequences[1]).value;
                    if( v != 'none')
                        cmd += ' ' + v;
                    else
                        cmd += '\n';
                        
                    v = E(actions[j] + '_' + ways[i] + '_' + sequences[2]).value;
                    if( v != 'none')
                        cmd += ' ' + v + '\n';
                    else
                        cmd += '\n';
                }
            }
        }
    }
    
    E('save-button').disabled = 1;
    if(cmd != '' ){
        E('save-button').disabled = 0;
        E('_fom')._web_cmd.value = cmd;
        //alert(cmd);
    }
    
    return 1;
}

function creatSelect(options,default_value,id)
{
	var string = "<td><select onchange=verifyFields(null,true) id = " + id + ">";
	for(var i = 0;i < options.length;i++){
		if(default_value == options[i]){
			string +="<option value='"+options[i]+"' selected>"+options[i]+"</option>";
		}else{
			string +="<option value='"+options[i]+"'>"+options[i]+"</option>";
		}
	}
    
	string +="</select></td>";
	return string;
}

function resetOptions(objSelect,options){
    var optObj = objSelect.options;

    //save old value
    var old_value = objSelect.value;

    //remove all old options
    while(optObj.length != 0){
        optObj[0] = null;
    }

    //add new options
    for(var i=0;i < options.length;i++){
        var varItem = new Option(options[i], options[i]);     
        optObj.add(varItem);     
    }

    //resume value
    objSelect.value=old_value;
    
}

function save()
{
	var i;

	if (!verifyFields(null, false)) return;
	
	if((E('_fom')._web_cmd.value != '')&&(cookie.get('autosave') == 1)){
		E('_fom')._web_cmd.value += "!"+"\n"+"copy running-config startup-config"+"\n";	
	}

	form.submit('_fom', 1);
}

function init(){
    if (user_info.priv < admin_priv) {
        elem.display('save-button', 'cancel-button', false);
	}else{
        elem.display('save-button', 'cancel-button', true);
    }

} 


</script>
</head>
<body onload='init()'>
<form id='_fom' method='post' action='apply.cgi'>
<input type='hidden' name='_web_cmd' value=''>

<script type='text/javascript'>


W("<div class='section'>")
W("<table class=web-grid cellspacing=1  id='aaa-grid' on>");
W("<tr id='aaa-grid_head1'>")
W("<th rowspan='2' valign='bottom'> &nbsp;" + ui.aaa_service + "&nbsp;</th>")
W("<th colspan='3'>" + ui.aaa_authen + "</th>")
W("<th colspan='3'>" + ui.aaa_author + "</th>")
W('</tr>')

W("<tr id='aaa-grid_head1'>")
//W("<th>sequence</th>")
W("<td>1</td>")
W("<td>2</td>")
W("<td>3</td>")
W("<td>1</td>")
W("<td>2</td>")
W("<td>3</td>")
W('</tr>')

W('<tr>')
W("<td>console</th>")
W(creatSelect(aaa_options,aaa_authen_config[0][0],'a1_console_first'));
W(creatSelect(aaa_options,aaa_authen_config[0][1],'a1_console_second'));
W(creatSelect(aaa_options,aaa_authen_config[0][2],'a1_console_third'));
W(creatSelect(aaa_options,aaa_author_config[0][0],'a2_console_first'));
W(creatSelect(aaa_options,aaa_author_config[0][1],'a2_console_second'));
W(creatSelect(aaa_options,aaa_author_config[0][2],'a2_console_third'));
W('</tr>')

W('<tr>')
W("<td>telnet</th>")
W(creatSelect(aaa_options,aaa_authen_config[1][0],'a1_telnet_first'));
W(creatSelect(aaa_options,aaa_authen_config[1][1],'a1_telnet_second'));
W(creatSelect(aaa_options,aaa_authen_config[1][2],'a1_telnet_third'));
W(creatSelect(aaa_options,aaa_author_config[1][0],'a2_telnet_first'));
W(creatSelect(aaa_options,aaa_author_config[1][1],'a2_telnet_second'));
W(creatSelect(aaa_options,aaa_author_config[1][2],'a2_telnet_third'));
W('</tr>')

W('<tr>')
W("<td>ssh</th>")
W(creatSelect(aaa_options,aaa_authen_config[2][0],'a1_ssh_first'));
W(creatSelect(aaa_options,aaa_authen_config[2][1],'a1_ssh_second'));
W(creatSelect(aaa_options,aaa_authen_config[2][2],'a1_ssh_third'));
W(creatSelect(aaa_options,aaa_author_config[2][0],'a2_ssh_first'));
W(creatSelect(aaa_options,aaa_author_config[2][1],'a2_ssh_second'));
W(creatSelect(aaa_options,aaa_author_config[2][2],'a2_ssh_third'));
W('</tr>')

W("<tr>")
W("<td>web</th>")
W(creatSelect(aaa_options,aaa_authen_config[3][0],'a1_http_first'));
W(creatSelect(aaa_options,aaa_authen_config[3][1],'a1_http_second'));
W(creatSelect(aaa_options,aaa_authen_config[3][2],'a1_http_third'));
W(creatSelect(aaa_options,aaa_author_config[3][0],'a2_http_first'));
W(creatSelect(aaa_options,aaa_author_config[3][1],'a2_http_second'));
W(creatSelect(aaa_options,aaa_author_config[3][2],'a2_http_third'));
W('</tr>')

//W("<tr bgcolor='#F0F0F0'><td colspan='7' align='right'>");
//W("<input type='button' id='aaa-grid_save' style='width:100px' onclick='save()' value=" + ui.save + " />");
//W("<input type='button' id='aaa-grid_cancel' style='width:100px' onclick='reloadPage()' value=" + ui.cancel + " />");
//W("</td></tr>")


W('</table>');

</script>
</div>

</form>

<script type='text/javascript'>




if(cookie.get('autosave') == 1)
    ui.aply=ui.aply_save;
genStdFooter("");
</script>
<script type='text/javascript'>verifyFields(null, 1);</script>
</body>
</html>
