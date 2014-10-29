<% pagehead(menu.switch_bridge) %>

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
<% ih_sysinfo() %>
<% ih_user_info() %>
		
<% web_exec('show bridge') %>
<% web_exec('show running-config interface') %>

var bridge_cookie = cookie.get('bridge-modify');
if (bridge_cookie == null){
	bridge_cookie = 0;
}

var br_id = '';
var primary_ip_mask = ['',''];
var br_port = [0, 0];
var br_port_name = ['FE 0/1', 'FE 0/2'];
var second_ip_mask = [];

for(var i = 0; i < bridge_config.length; i++)
{
	var br_info;
    if(bridge_config[i][0] == bridge_cookie){
        br_info = bridge_config[i];
		br_id = br_info[0];
		primary_ip_mask[0] = br_info[1];
		primary_ip_mask[1] = br_info[2];

		for(var j = 0; j < br_info[3].length; j++) {
			if (br_info[3][j] == 'fastethernet 0/1') {
				br_port[0] = 1;
			} else if (br_info[3][j] == 'fastethernet 0/2') {
				br_port[1] = 1;
			}
		}
        break;
    }
}

function back()
{
	document.location = 'setup-bridge.jsp';	
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
var id_tb = [{ title: ui.br_id, name: 'f_vid', type: 'text', maxlen: 4, size: 6, value: br_id }];
createFieldTable('', id_tb);
</script>
</div>
<div class='section-title'>
<script type='text/javascript'>W(ui.br_iface);</script>
</div>
<div class='section'>
<script type='text/javascript'>

var bridge_tb = [
					{ title: ui.br_primary_ip},
					{ title: ui.ip, indent:2, name: 'f_main_ip', type: 'text', maxlen: 16, size: 15, value: primary_ip_mask[0]},
					{ title: ui.netmask, indent:2,name: 'f_main_ip_netmask', type: 'text', maxlen: 16, size: 15, value: primary_ip_mask[1] },
					{ title: ui.br_sencond_ip}
				];
createFieldTable('', bridge_tb);

var first_cmd = '';
if(bridge_cookie == 0){//add
    E('_f_vid').value = "";
}else{//modify
    E('_f_vid').value = bridge_cookie;
}

function v_ip_range(start_ip,end_ip,ip)
{
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
    for(var i=0; i<second_ip_mask.length; i++)
    {
        var ip_mask = second_ip_mask[i];
        this.insertData(-1, [ip_mask[0],ip_mask[1]]);
    } 

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
	var id;
	
    if(bridge_cookie == 0){//add
        E('_f_vid').disabled = false;
    }else{//modify
	    E('_f_vid').disabled = true;
    }
    ferror.clear( E('_f_vid'));        	
    ferror.clear( E('_f_main_ip'));        	
    ferror.clear( E('_f_main_ip_netmask'));

	E('save-button').disabled = 1;

	if(!v_info_num_range('_f_vid',quiet, 0, 1, 4))  
		return 0;
	/*
    if(bridge_cookie == 0){
        if( list_contain( vid_list,E('_f_vid').value) ){
            ferror.set(E('_f_vid'), "vid has already been used", quiet);
		    return 0;
        }
    }
	*/
	id =  E('_f_vid').value;	
	cmd += "!\n";
	cmd += "bridge " + E('_f_vid').value + "\n";

	if(!v_info_host_ip( E('_f_main_ip'),quiet, 1)) 
		return 0;	
    if( E('_f_main_ip').value != ''){
		if(!v_info_netmask( E('_f_main_ip_netmask'),quiet, 1)) 
			return 0;
		if (E('_f_main_ip_netmask').value == '') 
			E('_f_main_ip_netmask').value = "255.255.255.0";
    }
			
	/*Generic ip cmd*/
	if (primary_ip_mask[0] !=  E('_f_main_ip').value
		|| primary_ip_mask[1] !=  E('_f_main_ip_netmask').value) {
		
		cmd += "interface bridge " + E('_f_vid').value + "\n";

		if (E('_f_main_ip').value != '') 
			cmd += "ip address " + E('_f_main_ip').value + ' ' + E('_f_main_ip_netmask').value + "\n";
		else
			cmd += "no ip address "+primary_ip_mask[0] +" " + primary_ip_mask[0] +"\n";
	}
	
	var second_ip_list = second_ip.getAllData();
    if((E('_f_main_ip').value == '') && (quiet == 0) && (second_ip_list.length !=0)){
        
        var msg = "Only after the Primary IP has been configured, the Secondary IP to take effect,";
        msg += "Are you sure?";
        if(!confirm(msg))
            return 0;
    }	
	/*second ip deleted*/
    for(var i=0; i< second_ip_mask.length; i++) {
		snd_found = 0;
		for(j=0;j<second_ip_list.length;j++) {
			if ((second_ip_list[j][0] == second_ip_mask[i][0])
				&& (second_ip_list[j][1] == second_ip_mask[i][1])) {
				snd_found = 1;
				break;
			}
		}
		if (!snd_found) {
			cmd += "!\n";
			cmd += "interface bridge " + E('_f_vid').value + "\n";
			cmd += "no ip address " + second_ip_mask[i][0] + ' ' + second_ip_mask[i][1] + " secondary\n";
		}
    }
	
	/*second ip added*/
	for(j=0;j<second_ip_list.length;j++){
		snd_found = 0;
    	for(var i=0; i < second_ip_mask.length; i++) {
			if ((second_ip_list[j][0] == second_ip_mask[i][0])
				&& (second_ip_list[j][1] == second_ip_mask[i][1])) {
				snd_found = 1;
				break;
			}
		}
		if (!snd_found) {
			cmd += "!\n";
			cmd += "interface bridge " + E('_f_vid').value + "\n";
			cmd += "ip address " + second_ip_list[j][0] + ' ' + second_ip_list[j][1] + " secondary\n";
		}
    }	

    for(i=0 ;i < br_port_name.length;i++){
		var iface;
		if (i == 0)
			iface = "fastethernet 0/1";
		else if (i == 1) 
			iface = "fastethernet 0/2";
			
        if(br_port[i] != E('port_' + br_port_name[i]).checked) {
            cmd += "!\n";
			cmd += "interface " + iface + "\n";
			
			if(E('port_' + br_port_name[i]).checked)
                cmd += "bridge-group " + E('_f_vid').value + "\n";
			else 
                cmd += "no bridge-group " + E('_f_vid').value + "\n";
        }
    }

	//alert(cmd);
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
}

</script>
</div>

<div class='section'>
<table class='web-grid' id='second_ip-grid'></table>
</div>

<div class='section-title'>
<script type='text/javascript'>W(ui.br_mem);</script>
</div>

<div class='section'>

<table class='web-grid' cellspacing=1 id='port-grid'>
<tr class='header'> 
<script type='text/javascript'>
       
for(var i = 0; i < br_port.length;i++){
    W("<td><b>" + br_port_name[i] + "</b></td>");
}

W('</tr><tr>')
for(var i = 0; i < br_port.length; i++){
    if(br_port[i])
        W("<td align='middle'><input type='checkbox' onclick='this.blur();' onchange='verifyFields()' id='port_" + br_port_name[i] + "'checked = 1" + "></td>");
    else
        W("<td align='middle'><input type='checkbox' onclick='this.blur();' onchange='verifyFields()' id='port_" + br_port_name[i] + "'></td>");
}

</script>
</tr>
</table>
</div>

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
