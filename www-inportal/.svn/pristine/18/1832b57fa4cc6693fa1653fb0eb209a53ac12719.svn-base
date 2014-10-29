<% pagehead(menu.switch_stp) %>

<style tyle='text/css'>



</style>

<script type='text/javascript'>

<% ih_sysinfo() %>
<% ih_user_info(); %>

//var spanning_tree_config=[1, 32768, 10, 9, 15, 2, 6, [[1,0,1], 0, 128, 0,0, 0, 2]];
<% web_exec('show running-config spanning-tree') %>

//spanning_tree_config =[1,61440,20,2,15,2,6,[[1,1,1],0,128,0,0,0,2,-1], [[1,1,2],0,128,0,0,0,2,-1]];

var tmp_old_config = [];
var port_title_list = [];
var port_cmd_list = [];
var switch_interface = [];
var bridge_priority = [[0,'0'],[1,'4096'],[2,'8192'],[3,'12288'],[4,'16384'],[5,'20480'],[6,'24576'],[7,'28672'],
			[8,'32768'],[9,'36864'],[10,'40960'],[11,'45056'],[12,'49152'],[13,'53248'],[14,'57344'],[15,'61440'],
			[16,'--']];
var port_priority = [0, 16, 32, 48, 64, 80, 96, 112, 128, 144, 160, 176, 192, 208, 224, 240,'--'];
var bpdu_guard_options = [];

bpdu_guard_options.push([0,'Do Not Shutdown']);
bpdu_guard_options.push([1,'Until Reset']);
bpdu_guard_options.push([2,rstp.guard_opt2]);

for (var i=7; i<spanning_tree_config.length; i++) {
	if(spanning_tree_config[i][0][0] == 1){
		port_cmd_list.push("fastethernet "+ spanning_tree_config[i][0][1] + "/" + spanning_tree_config[i][0][2]);
		port_title_list.push("FE"+ spanning_tree_config[i][0][1] + "/" + spanning_tree_config[i][0][2]);
	}else if(spanning_tree_config[i][0][0] == 2){
		port_cmd_list.push("gigabitethernet "+ spanning_tree_config[i][0][1] + "/" + spanning_tree_config[i][0][2]);
		port_title_list.push("GE"+ spanning_tree_config[i][0][1] + "/" + spanning_tree_config[i][0][2]);
	}
	
}

function isDigit(str)
{ 
  var reg = /^\d*$/; 

  return reg.test(str); 
 }

function check_port_change(quiet)
{
	var cmd = '';
	for(var i=7;i<spanning_tree_config.length;++i){
		var interface_view =1;
		if(E('_'+i+'_port_rstp_enable').value == 'Disable'){
			E('_'+i+'_port_priority').disabled = true;
			E('_'+i+'_rstp_cost').disabled = true;
			E('_'+i+'_port_rstp_edge').disabled = true;
			E('_'+i+'_port_connect_type').disabled = true;
			E('_'+i+'_port_bpdu_guard').disabled = true;
		}else{
			E('_'+i+'_port_priority').disabled = false;
			E('_'+i+'_rstp_cost').disabled = false;
			E('_'+i+'_port_rstp_edge').disabled = false;
			E('_'+i+'_port_connect_type').disabled = false;
			E('_'+i+'_port_bpdu_guard').disabled = false;
		}
		
		//check port rstp enable
		if(E('_'+i+'_port_rstp_enable').value != ['Enable','Disable'][spanning_tree_config[i][1]]){
			if(interface_view){
				cmd += "!" + "\n";
				cmd += "interface "+ port_cmd_list[i-7]+"\n";
				interface_view = 0;
			}
			if(E('_'+i+'_port_rstp_enable').value == 'Disable')
				cmd += "no spanning-tree" + "\n";
			else
				cmd += "spanning-tree" + "\n";
		}
		//check port priority
		/*
		if((E('_'+i+'_port_priority').value < 0) 
			||(E('_'+i+'_port_priority').value > 240)
			||(!isDigit(E('_'+i+'_port_priority').value))
			|| (E('_'+i+'_port_priority').value % 16 != 0)){
			ferror.set(E('_'+i+'_port_priority'), errmsg.rstp_port_pri, quiet);
			return 0;
		}else{
			ferror.clear(E('_'+i+'_port_priority'), errmsg.rstp_port_pri, quiet);
		}
		*/
		if(E('_'+i+'_port_rstp_enable').value == 'Enable'){
				if (E('_'+i+'_port_priority').value == '--'){
					if (spanning_tree_config[i][2] != 128){
						if(interface_view){
							cmd += "!" + "\n";
							cmd += "interface "+ port_cmd_list[i-7]+"\n";
							interface_view = 0;
						}
						cmd += "no spanning-tree port-priority"+"\n";
					}
				}else{
					if (E('_'+i+'_port_priority').value != spanning_tree_config[i][2]){
						if(interface_view){
							cmd += "!" + "\n";
							cmd += "interface "+ port_cmd_list[i-7]+"\n";
							interface_view = 0;
						}
						cmd += "spanning-tree port-priority " +E('_'+i+'_port_priority').value+"\n";
					}
				}

				/*
				if(E('_'+i+'_port_priority').value != spanning_tree_config[i][2]){
					if(interface_view){
						cmd += "!" + "\n";
						cmd += "interface "+ port_cmd_list[i-7]+"\n";
						interface_view = 0;
					}
					if(E('_'+i+'_port_priority').value == '')
						cmd += "no spanning-tree port-priority"+"\n";
					else
						cmd += "spanning-tree port-priority " +E('_'+i+'_port_priority').value+"\n";
				}
				*/
					
				//check rstp cost
				/*
				if(((E('_'+i+'_rstp_cost').value < 0) ||(E('_'+i+'_rstp_cost').value > 200000000))&&(E('_'+i+'_rstp_cost').value != 'Auto')){
					ferror.set(E('_'+i+'_rstp_cost'), errmsg.rstp_port_cost, quiet);
					return 0;
				}else{
					ferror.clear(E('_'+i+'_rstp_cost'), errmsg.rstp_port_cost, quiet);
				}
				*/
				
				//check port spanning tree cost
				if(E('_'+i+'_rstp_cost').value != 'Auto'){
					if(E('_'+i+'_rstp_cost').value != spanning_tree_config[i][3]){
						if(interface_view){
							cmd += "!" + "\n";
							cmd += "interface "+ port_cmd_list[i-7]+"\n";
							interface_view = 0;
						}
						if(E('_'+i+'_rstp_cost').value == '')
							cmd += "no spanning-tree cost"+"\n";
						else
							cmd += "spanning-tree cost " +E('_'+i+'_rstp_cost').value+"\n";
					}
				}else{
					if(spanning_tree_config[i][3] != 0){
						if(interface_view){
							cmd += "!" + "\n";
							cmd += "interface "+ port_cmd_list[i-7]+"\n";
							interface_view = 0;
						}
						cmd += "no spanning-tree cost"+"\n";
					}
				}
				
				//check  edge port
				if(E('_'+i+'_port_rstp_edge').value != ['No','Yes'][spanning_tree_config[i][4]]){
					if(interface_view){
						cmd += "!" + "\n";
						cmd += "interface "+ port_cmd_list[i-7]+"\n";
						interface_view = 0;
					}
					if(E('_'+i+'_port_rstp_edge').value == 'No')
						cmd += "no spanning-tree edge"+"\n";
					else
						cmd += "spanning-tree edge"+"\n";
				}
	
				/*
				//check mcheck
				if(E('_'+i+'_port_mcheck_enable').value != ['Disable','Enable'][spanning_tree_config[i][5]]){
					if(interface_view){
						cmd += "!" + "\n";
						cmd += "interface "+ port_cmd_list[i-7]+"\n";
						interface_view = 0;
					}
					if(E('_'+i+'_port_mcheck_enable').value == 'Disable')
						cmd += "no spanning-tree mcheck" + "\n";
					else
						cmd += "spanning-tree mcheck" + "\n";
				}
				*/
				//check  link type
				if(E('_'+i+'_port_connect_type').value != ['No','Yes','Auto'][spanning_tree_config[i][6]]){
					if(interface_view){
						cmd += "!" + "\n";
						cmd += "interface "+ port_cmd_list[i-7]+"\n";
						interface_view = 0;
					}
					if(E('_'+i+'_port_connect_type').value == 'No')
						cmd += "spanning-tree link-type shared"+"\n";
					else if(E('_'+i+'_port_connect_type').value == 'Yes')
						cmd += "spanning-tree link-type p2p"+"\n";
					else if(E('_'+i+'_port_connect_type').value == 'Auto')
						cmd += "no spanning-tree link-type" + "\n";
				}
				//alert(E('_'+i+'_port_bpdu_guard').value + ":"+spanning_tree_config[i][7]);
				if ((E('_'+i+'_port_bpdu_guard').value == 'Do Not Shutdown')){
					if ((spanning_tree_config[i][7] != -2)){
						if(interface_view){
							cmd += "!" + "\n";
							cmd += "interface "+ port_cmd_list[i-7]+"\n";
							interface_view = 0;
						}
						cmd += "no spanning-tree bpduguard" + "\n";
					}
				}else if (( E('_'+i+'_port_bpdu_guard').value == 'Until Reset')){
					if ((spanning_tree_config[i][7] != -1)){
						if(interface_view){
							cmd += "!" + "\n";
							cmd += "interface "+ port_cmd_list[i-7]+"\n";
							interface_view = 0;
						}						
						cmd += "spanning-tree bpduguard" + "\n";
					}
				}else if ((spanning_tree_config[i][7] != E('_'+i+'_port_bpdu_guard').value)){
						if(interface_view){
							cmd += "!" + "\n";
							cmd += "interface "+ port_cmd_list[i-7]+"\n";
							interface_view = 0;
						}				
					cmd += "spanning-tree bpduguard timeout "+ E('_'+i+'_port_bpdu_guard').value  + "\n";
				}
				
		}

		

		
	}

	return cmd;

}


function writeText(obj, option)
{
	//alert("writeText obj.value = "+obj.value);
	if (obj.value < 2){
		obj.parentNode.nextSibling.value = bpdu_guard_options[obj.value][1];
		//alert("writeText 1 obj.value = "+obj.value);
		ferror.clear(E(obj.parentNode.nextSibling));
		//alert("writeText 2 obj.value = "+obj.value);
		verifyFields(null, 1);
	}else{
		obj.parentNode.nextSibling.value = "";
		//alert("writeText 3 obj.value = "+obj.value);
		E(obj.parentNode.nextSibling).focus();
		//alert("writeText 4 obj.value = "+obj.value);
		if (!v_f_number(E(obj.parentNode.nextSibling), true, false, 5, 86400)) return 0;
	}
}
function creatInputSelect(options,value,idex,name)
{
	var string = '<td><div style="position:relative"><span style="position:absolute;margin-left:100px;margin-top:1px;width:18px;overflow:hidden;"><select style="width:118px;hight:1px;margin-top:1px;margin-left:-100px" onchange=writeText(this,options)  >';
	var text_value = "";
	var sel_val ;

	if (value < 2) sel_val = value;
	else sel_val = 2;

	
	for(var i = 0;i < options.length;i++){
		if(sel_val == options[i][0]){
			string +='<option value='+options[i][0]+' selected>'+options[i][1]+'</option>';
		}else{
			string +='<option value='+options[i][0]+'>'+options[i][1]+'</option>';
		}
	}

	string +='</select></span>';

	if (value >= 5)
		text_value = value.toString();
	else
		text_value = options[value][1];
	
	string +='<input style="margin-top:1px;top:-1px;width:95px;hight:10px;left:0px;" onchange=verifyFields(null,1) id=_'+idex+''+name+' '+'value="'+ text_value +'">';
	string +='</div></td>';
	return string;
}

function creatSelect(options,value,idex,name)
{
	var string = '<td><select onchange=verifyFields(null,1) id=_'+idex+''+name+'>';

	for(var i = 0;i < options.length;i++){
		if(value == options[i]){
			string +='<option value='+options[i]+' selected>'+options[i]+'</option>';
		}else{
			string +='<option value='+options[i]+'>'+options[i]+'</option>';
		}
	}
	string +="</select></td>";

	return string;
}


function disablePortCfg(disabled)
{
	for( var i = 7; i < spanning_tree_config.length; i++){
		E('_'+i+'_port_rstp_enable').disabled = disabled;
		E('_'+i+'_port_priority').disabled = disabled || (E('_'+i+'_port_rstp_enable').value == "Disable");
		E('_'+i+'_rstp_cost').disabled = disabled || (E('_'+i+'_port_rstp_enable').value == "Disable");
		E('_'+i+'_port_rstp_edge').disabled = disabled || (E('_'+i+'_port_rstp_enable').value == "Disable");
		E('_'+i+'_port_connect_type').disabled = disabled || (E('_'+i+'_port_rstp_enable').value == "Disable");
		E('_'+i+'_port_bpdu_guard').disabled = disabled || (E('_'+i+'_port_rstp_enable').value == "Disable");
	}
}

function verifyFields(focused, quiet)
{
	var a;
	var ok = 1;
	var dis;
	var cmd = "";
	var fom = E('_fom');
	var view_flag = 1;

	E('save-button').disabled = true;

	//dis = !(E('_f_rstp_enable').checked);

	//elem.display_and_enable('_f_version_support','_rstp_priority', '_rstp_forward_time', '_rstp_hello_time', '_rstp_max_age', '_rstp_transmit_count', !dis);
	
	//E('_port_parameters').style.display = dis ? 'none' : 'block';
	//E('_port_parameters_title').style.display = dis ? 'none' : 'block';


	if (E('_f_rstp_enable').checked){
		disablePortCfg(false);
	}else{
		disablePortCfg(true);
	}

	if(E('_rstp_hello_time').value != ''){
		if((E('_rstp_hello_time').value < 1) ||(E('_rstp_hello_time').value > 10)||(!isDigit(E('_rstp_hello_time').value))){
			ferror.set(E('_rstp_hello_time'), errmsg.hello_time, quiet);
			return 0;
		}else{
			ferror.clear(E('_rstp_hello_time'));
		}
	}

	if(E('_rstp_max_age').value != ''){
		if((E('_rstp_max_age').value < 6) 
			||(E('_rstp_max_age').value > 40)
			||(!isDigit(E('_rstp_max_age').value))
			||(E('_rstp_max_age').value < 2*(parseInt(E('_rstp_hello_time').value,10)+1))){
			ferror.set(E('_rstp_max_age'), errmsg.max_age, quiet);
			return 0;
		}else{
			ferror.clear(E('_rstp_max_age'));
		}
	}

	if(E('_rstp_forward_time').value != ''){
		if((E('_rstp_forward_time').value < 4) ||(E('_rstp_forward_time').value > 30)||(!isDigit(E('_rstp_forward_time').value))||(E('_rstp_max_age').value > 2*(parseInt(E('_rstp_forward_time').value,10)-1))){
			ferror.set(E('_rstp_forward_time'), errmsg.forward_time, quiet);
			return 0;
		}else{
			ferror.clear(E('_rstp_forward_time'));
		}
	}
	
	if(E('_rstp_transmit_count').value != ''){
		if((E('_rstp_transmit_count').value < 1) ||(E('_rstp_transmit_count').value > 20)||(!isDigit(E('_rstp_transmit_count').value))){
			ferror.set(E('_rstp_transmit_count'), errmsg.invalid, quiet);
			return 0;
		}else{
			ferror.clear(E('_rstp_transmit_count'));
		}
	}

	//check port cost & bpdu guard
	for( var i = 7; i < spanning_tree_config.length; i++){
		if ((E('_'+i+'_rstp_cost').value != 'A')
			&& (E('_'+i+'_rstp_cost').value != 'Au')
			&& (E('_'+i+'_rstp_cost').value != 'Aut')
			&& (E('_'+i+'_rstp_cost').value != 'Auto')){
			if (!v_f_number(E('_'+i+'_rstp_cost'), quiet, true, 1, 200000000)) return 0;
		}else{
			E('_'+i+'_rstp_cost').value = 'Auto';
			ferror.clear(E('_'+i+'_rstp_cost'));
		}
		if (E('_'+i+'_port_bpdu_guard').value != 'Do Not Shutdown'
			&& E('_'+i+'_port_bpdu_guard').value != 'Until Reset'){
			if (!v_f_number(E('_'+i+'_port_bpdu_guard'), quiet, false, 5, 86400)) return 0;
		}
		//ferror.clear(E('_'+i+'_port_bpdu_guard'));
	}

	
		
	//check rstp enable
	var f_rstp_enable = E('_f_rstp_enable').checked ? 1 : 0;
	
	//check stp enable
	if(f_rstp_enable != spanning_tree_config[0]){
		if(f_rstp_enable == 0){
			if(view_flag){
				cmd += "!" + "\n";//back to config view
				view_flag =0;
			}
			cmd += "no spanning-tree " + "\n";//diable rstp
		}else{
			if(view_flag){
				cmd += "!" + "\n";//back to config view
				view_flag =0;
			}
			cmd += "spanning-tree " + "\n";//enable rstp
		}
	}
	//check mode
	/*
	if(E('_f_version_support').value != spanning_tree_config[5]){
		if(view_flag){
			cmd += "!" + "\n";//back to config view
			view_flag =0;
		}
		if(E('_f_version_support').value == 1){
			cmd += "spanning-tree mode stp" + "\n";//
		}else if(E('_f_version_support').value == 2){
			cmd += "spanning-tree mode rstp" + "\n";//enable rstp
		}else if(E('_f_version_support').value == 0){
			cmd += "no spanning-tree mode" + "\n";
		}
	}
	*/
	//check priority
	if (E('_rstp_priority').value == 16){
		if (spanning_tree_config[1] != 32768){//default
			if(view_flag){
				cmd += "!" + "\n";//back to config view
				view_flag =0;
			}
			cmd += "no spanning-tree priority" + "\n";//set rstp priority
		}
	}else{
		if (E('_rstp_priority').value != (spanning_tree_config[1] / 4096)){
			if(view_flag){
				cmd += "!" + "\n";//back to config view
				view_flag =0;
			}
			cmd += "spanning-tree priority " + (E('_rstp_priority').value * 4096) + "\n";//set rstp priority
		}
	}
	
	//check hello time
	if(E('_rstp_hello_time').value != spanning_tree_config[3]){
		if(view_flag){
			cmd += "!" + "\n";//back to config view
			view_flag =0;
		}
		if(E('_rstp_hello_time').value == ''){
			cmd += "no spanning-tree hello-time" + "\n";//set rstp hello time
		}else{
			cmd += "spanning-tree hello-time " + E('_rstp_hello_time').value + "\n";//set rstp hello time
		}
	}
	//check max age
	if(E('_rstp_max_age').value != spanning_tree_config[2]){
		if(view_flag){
			cmd += "!" + "\n";//back to config view
			view_flag =0;
		}
		if(E('_rstp_max_age').value == ''){
			cmd += "no spanning-tree max-age " + "\n";//set rstp max age
		}else{
			cmd += "spanning-tree max-age " + E('_rstp_max_age').value + "\n";//set rstp max age
		}
	}
	//check transmit count
	if(E('_rstp_transmit_count').value != spanning_tree_config[6]){
		if(view_flag){
			cmd += "!" + "\n";//back to config view
			view_flag =0;
		}
		if(E('_rstp_transmit_count').value == ''){
			cmd += "no spanning-tree transmit hold-count" + "\n";//set rstp transmit count
		}else{
			cmd += "spanning-tree transmit hold-count " + E('_rstp_transmit_count').value + "\n";//set rstp transmit count
		}
	}
	//check forward time
	if(E('_rstp_forward_time').value != spanning_tree_config[4]){
		if(view_flag){
			cmd += "!" + "\n";//back to config view
			view_flag =0;
		}
		if(E('_rstp_forward_time').value == ''){
			cmd += "no spanning-tree forward-delay" + "\n";//set rstp forward time
		}else{
			cmd += "spanning-tree forward-delay " + E('_rstp_forward_time').value + "\n";//set rstp forward time
		}
	}
	
	//check port's rstp
	if (f_rstp_enable == 1)
		cmd += check_port_change(quiet);
	
	//alert(cmd);
	if (user_info.priv < admin_priv){
		elem.display('save-button', 'cancel-button', false);
	}else{
		elem.display('save-button', 'cancel-button', true);
		fom._web_cmd.value = cmd;
		E('save-button').disabled = (cmd=="");	
	}
	
	return ok;	
}


function save()
{
	if (!verifyFields(null, false)) return;

	if (cookie.get('debugcmd') == 1)
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

createFieldTable('', [
	{ title: rstp.enable, name: 'f_rstp_enable', type: 'checkbox', value: spanning_tree_config[0]},
	//{ title: rstp.version, indent: 2,name: 'f_version_support', type: 'select', options: [[0,'Default'],[1,'STP'],[2,'RSTP']], value: spanning_tree_config[5]},
	{ title: rstp.rstp_priority, indent: 2,name: 'rstp_priority', type: 'select', options: bridge_priority, value: (spanning_tree_config[1]/4096)},
	{ title: rstp.hello, indent: 2, name: 'rstp_hello_time', type: 'text', maxlen: 15, size: 17,suffix: ' '+'(1-10)'+ui.seconds, value: spanning_tree_config[3]},
	{ title: rstp.age, indent: 2, name: 'rstp_max_age', type: 'text', maxlen: 15, size: 17,suffix: ' '+'(6-40)'+ui.seconds, value: spanning_tree_config[2]},
	{ title: rstp.forward, indent: 2, name: 'rstp_forward_time', type: 'text', maxlen: 15, size: 17,suffix: ' '+'(4-30)'+ui.seconds, value: spanning_tree_config[4]},
	{ title: rstp.transmit_count, indent: 2, name: 'rstp_transmit_count', type: 'text', maxlen: 15, size: 17, suffix: ' '+'(1-20)',value: spanning_tree_config[6]}

]);
</script>
</div>


<div class='section-title' id='_port_parameters_title'>
<script type='text/javascript'>
	GetText(rstp.port_config);
</script>
</div>
<div class='section' id='_port_parameters'>
	<table class='web-grid' id='bs-grid'>

<script type='text/javascript'>
		W("<tr id='adm-head'>");
			W("<td >" + rstp.select_port + "</td>");
			W("<td >" + rstp.enable + "</td>");
			W("<td >" + rstp.port_priority + "</td>");
			W("<td >" + rstp.rstp_cost + "</td>");
			W("<td >" + rstp.rstp_edge + "</td>");
			W("<td >" + rstp.point_to_point + "</td>");
			W("<td >" + rstp.guard + "</td>");
		W("</tr>");
		
		for( var i = 7; i < spanning_tree_config.length; i++){
			var rstp_cost;
			var bpdu_guard_id;
			W("<td>" + port_title_list[i-7] + "</td>");
			W(creatSelect(['Enable','Disable'],['Enable','Disable'][spanning_tree_config[i][1]],i,'_port_rstp_enable'));
			W(creatSelect(port_priority,spanning_tree_config[i][2],i,'_port_priority'));
			if(spanning_tree_config[i][3] ==0) 	rstp_cost= 'Auto';
			else rstp_cost = spanning_tree_config[i][3];
			W("<td><input type='text' onchange='verifyFields(null,1)' id='_" + i + "_rstp_cost' name='" + i + "_rstp_cost' value='" + rstp_cost + "'></td>");
			W(creatSelect(['No','Yes'],['No','Yes'][spanning_tree_config[i][4]],i,'_port_rstp_edge'));
			W(creatSelect(['No','Yes','Auto'],['No','Yes','Auto'][spanning_tree_config[i][6]],i,'_port_connect_type'));
			if (spanning_tree_config[i][7] == -2){
				bpdu_guard_id = 0;
			}else if (spanning_tree_config[i][7] == -1){
				bpdu_guard_id = 1;
			}else{
				bpdu_guard_id = spanning_tree_config[i][7];
			}
			W(creatInputSelect(bpdu_guard_options,bpdu_guard_id,i,'_port_bpdu_guard'));
			W("</tr>");			
		}
</script>
	</table>
</div>

<script type='text/javascript'>
init();
if(cookie.get('autosave') == 1)
	ui.aply=ui.aply_save;
genStdFooter("");
</script>
</form>
<script type='text/javascript'>verifyFields(null, 1);</script>
</body>
</html>
