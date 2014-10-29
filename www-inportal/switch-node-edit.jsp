<% pagehead(raps.node_config) %>

<style tyle='text/css'>
#bs-grid {
	width: 250px;
}
#bs-grid .co1 {
	width: 100px;
	text-align: center;
}
#bs-grid .co2 {
	width: 150px;
	text-align: center;
}

</style>

<script type='text/javascript'>


var tunnel_name = '<% cgi_get("ipsec_tunnel_name") %>';
var tunnel_action = '<% cgi_get("ipsec_tunnel_action") %>';
var ipsec_tunnels = [];
var instance_id = 1;

var node = new webGrid();
var node_type_buf = ['','RPL-Owner','RPL-Neighbor','RPL-Neighbor-Next','Normal'];
var node_mode_buf = ['','Ring-Node','InterConnection-Node'];

var switch_interface = [];
for (i=1; i<=24; i++) {
	switch_interface.push([i, i]);
}

function creatSelect(options,value,name)
{
	var string = '<td><select onchange=verifyFields() id=_'+''+name+'>';

	for(var i = 1;i < options.length;i++){
		if(value == options[i]){
			string +='<option value='+options[i]+' selected>'+options[i]+'</option>';
		}else{
			string +='<option value='+options[i]+'>'+options[i]+'</option>';
		}
	}
	string +="</select></td>";

	return string;
}

function v_ipsec_id(v, quiet)
{
	var id_type = E(v + '_type').value;
	var x = E(v).value;
	
	elem.display(PR(v), id_type!='0');
	
	if(id_type!='0'){
		ferror.clear(v);
		if(x=="@") E(v).value="";
		if(!v_length(v, quiet, 1, 64)){
			return 0;
		}else{
			if(id_type=='2'){//FQDN
				if(x.substr(0,1)!='@'){
					E(v).value = '@' + x;
				}
			}else{//User FQDN
				x = x.split('@');
				if(x.length!=2 || x[0]=='' || x[1]==''){
					ferror.set(v, errmsg.bad_ufqdn, quiet);
					return 0;
				}else{
					ferror.clear(v, errmsg.bad_ufqdn, quiet);
				}
			}
		}
	}
	
	return 1;
}

function verifyFields(focused, quiet)
{
	var ok = 1;

	if(E('_ring_type').value == 0){

		elem.display_and_enable('_node_mode', '_port_mode','_virtual_channel', 0);
		if(E('_node_type').value == 3){
			elem.display_and_enable('_designation_port',0);
		}else{
			elem.display_and_enable('_designation_port',1);
		}
	}else{
		elem.display_and_enable('_node_mode', '_port_mode','_virtual_channel', 1);
		if(E('_node_type').value == 3){
			elem.display_and_enable('_designation_port',0);
		}else{
			elem.display_and_enable('_designation_port',1);
		}
		if(E('_node_mode').value == 0){
			elem.display_and_enable('_virtual_channel', 0);
		}else{
			elem.display_and_enable('_virtual_channel', 1);
			if(E('_port_mode').value == 1){
				elem.display_and_enable('_virtual_channel', 1);
				
			}else{
				elem.display_and_enable('_virtual_channel', 0);
			}
		}
				
		//E('bs-grid').style.display = 'block';
		//E('_port_parameters_title').style.display = 'block';
	}

	//E('_port_parameters').style.display = dis ? 'none' : 'block';
	
	return ok;
}

function save()
{
	var i;

	if (!verifyFields(null, false)) return;
	
	var fom = E('_fom');
	
	var tunnel = [
			E('_instance_id').value,
			E('_ring_type').value,
			E('_node_type').value,
			E('_designation_port').value,
			E('_node_mode').value,
			E('_port_mode').value,
			E('_virtual_channel').checked ? "1" : "0"
		];
	
	var n = ipsec_tunnels.length;	
	if (tunnel_action=='new'){
		ipsec_tunnels[n] = tunnel;
		n++;
	} else {
		tunnel_action = 'edit';
		for (i=0; i<n; i++){
			if (ipsec_tunnels[i][0] == tunnel_name){
				ipsec_tunnels[i] = tunnel;
				break;
			}
		}		
	}
	
	var fom = E('_fom');
	

	//fom.ipsec_tunnel_action.value = tunnel_action;
	//fom.advanced.value = E('_f_advanced').checked ? '1' : '0';
	
	var s = '';
	
	for (i=0; i<n; i++){
		s += ipsec_tunnels[i].join(',');
		s += ';';
	}		
	
	
	fom.ipsec_tunnels.value = s;
	

	E('_ipsec_tunnel_name').disabled = false;
	form.submit(fom, 0);
	E('_ipsec_tunnel_name').disabled = (tunnel_action=='edit');
//	document.location = 'ipsec-tunnels.jsp';		
}

function on_remove()
{
	if (!confirm(ipsec.confm_del)) return;

	var fom = E('_fom');
	
	tunnel_action = 'delete';
/*
	E('delete-button').disabled = 1;
	E('save-button').disabled = 1;
*/
	fom.ipsec_tunnel_action.value = tunnel_action;
	fom.advanced.value = E('_f_advanced').checked ? '1' : '0';
	
	var s = '';
	var n = ipsec_tunnels.length;	
	for (i=0; i<n; i++){
		if (ipsec_tunnels[i][0] == tunnel_name) continue;
		s += ipsec_tunnels[i].join(',');
		s += ';';
	}
	
	fom.ipsec_tunnels.value = s;
		
	E('_ipsec_tunnel_name').disabled = false;
	form.submit(fom, 0);
	E('_ipsec_tunnel_name').disabled = (tunnel_action=='edit');
//	fom.submit();

//	document.location = 'ipsec-tunnels.jsp';		
}

function cancel()
{
	document.location = 'switch-raps-node.jsp';	
}

node.setup = function()
{
	this.init('bs-grid', ['sort', 'move'], 20,[
		{ type: 'text', maxlen: 15 }, 
		{ type: 'select', options: [[0,'enable'],[1,'disable']] }
		
	]);

	this.headerSet(['Ring-ID','Enable']);
/*
	var port_config = rstp_port_config.split(';');
	for(var i = 0;i < port_config.length;++i){
		var tmp_config = port_config[i].split(',');
		if(tmp_config[3] == 'force-true'){
			tmp_config[3] = 0;
		}else if(tmp_config[3] == 'force-false'){
			tmp_config[3] = 1;
		}else{
			tmp_config[3] = 2;
		}

		if(tmp_config[4] == 'point-to-point'){
			tmp_config[4] = 0;
		}else if(tmp_config[4] == 'share'){
			tmp_config[4] = 1;
		}else{
			tmp_config[4] = 2;
		}

		if(tmp_config[5] == 'all'){
			tmp_config[5] = 1;
		}else{
			tmp_config[5] = 0;
		}

		stp.insertData(-1,[tmp_config[0], tmp_config[1], tmp_config[2], tmp_config[3], tmp_config[4], tmp_config[5]]);
	}	
*/
	this.showNewEditor();
	
}


function init()
{
//	verifyFields(null, 1);
}
</script>

</head>
<body onload='init()'>
<form id='_fom' method='post' action='apply.cgi'>
<input type='hidden' name='_redirect' value='switch-raps-node.jsp'/>
<input type='hidden' name='_service' value='ipsec_tunnels-restart'/>
<input type='hidden' name='advanced'/>
<input type='hidden' name='ipsec_tunnels'/>
<input type='hidden' name='ipsec_tunnel_action'/>

<div class='section-title'><script type='text/javascript'>GetText(raps.node_config)</script></div>
<div class='section'>
<script type='text/javascript'>
	var ike_policies = ike_default_policies;
	var ipsec_policies = ipsec_default_policies;
/*	
	v = nvram.ipsec_tunnels.split(';');

	var n = 0;	
	for (var i = 0; i < v.length; ++i) {
		var r;
		if (r = v[i].split(',')) {
			if (r[0]=='') continue;
			ipsec_tunnels[n++] = r;
		}
	}
	
	if(tunnel_action=='edit'){
		for (i=0; i<ipsec_tunnels.length; i++){
			if(ipsec_tunnels[i][0]==tunnel_name) break;
		}
		
		if(i>=ipsec_tunnels.length){
			tunnel_action = 'new';
		}else{
			var k = 1;
//ipsec tunnels:
//basic  : name,iface,dst,startup_mode,neg_mode,ipsec_proto,ipsec_mode,type,src_net,src_mask,dst_net,dst_mask,
//Phase 1: ike_policy,ike_lifetime,src_id_type,src_id,dst_id_type,dst_id,auth_type,auth_key,
//Phase 2: ipsec_policy,ipsec_lifetime,pfs,
//Link   : dpd_interval, dpd_timeout, icmp_host, icmp_interval, icmp_timeout, icmp_retries,
//Others : restart_wan,others	
	
			tunnel_iface = ipsec_tunnels[i][k++];
			tunnel_dst = ipsec_tunnels[i][k++];
			tunnel_startup_mode = ipsec_tunnels[i][k++];
			tunnel_neg_mode = ipsec_tunnels[i][k++];
			tunnel_ipsec_proto = ipsec_tunnels[i][k++];
			tunnel_ipsec_mode = ipsec_tunnels[i][k++];
			tunnel_type = ipsec_tunnels[i][k++];
			tunnel_src_net = ipsec_tunnels[i][k++];
			tunnel_src_mask = ipsec_tunnels[i][k++];
			tunnel_dst_net = ipsec_tunnels[i][k++];
			tunnel_dst_mask = ipsec_tunnels[i][k++];
			tunnel_ike_policy = ipsec_tunnels[i][k++];
			tunnel_ike_lifetime = ipsec_tunnels[i][k++];
			tunnel_src_id_type = ipsec_tunnels[i][k++];
			tunnel_src_id = ipsec_tunnels[i][k++];
			tunnel_dst_id_type = ipsec_tunnels[i][k++];
			tunnel_dst_id = ipsec_tunnels[i][k++];
			tunnel_auth_type = ipsec_tunnels[i][k++];
			tunnel_auth_key = ipsec_tunnels[i][k++];
			tunnel_ipsec_policy = ipsec_tunnels[i][k++];
			tunnel_ipsec_lifetime = ipsec_tunnels[i][k++];
			tunnel_pfs = ipsec_tunnels[i][k++];
			tunnel_dpd_interval = ipsec_tunnels[i][k++];
			tunnel_dpd_timeout = ipsec_tunnels[i][k++];
			
			tunnel_icmp_host = ipsec_tunnels[i][k++];
			tunnel_icmp_host = tunnel_icmp_host.replace('&', ',');
			tunnel_icmp_interval = ipsec_tunnels[i][k++];
			tunnel_icmp_timeout = ipsec_tunnels[i][k++];
			tunnel_icmp_retries = ipsec_tunnels[i][k++];	
			
			if (k < ipsec_tunnels[i].length) tunnel_restart_wan = ipsec_tunnels[i][k++];			
			else tunnel_restart_wan = 'N';
				
			if (k < ipsec_tunnels[i].length) tunnel_icmp_local = ipsec_tunnels[i][k++];			
			else tunnel_icmp_local = '';
				
			if (k < ipsec_tunnels[i].length) tunnel_others = ipsec_tunnels[i][k++];			
			else tunnel_others = '';
		}
	}
	
	if(tunnel_action!='edit'){//new
		tunnel_action = 'new';
		
		tunnel_iface = '*';
		tunnel_dst = '0.0.0.0';
		tunnel_startup_mode = '0';
		tunnel_neg_mode = '0';
		tunnel_ipsec_proto = '0';
		tunnel_ipsec_mode = '0';
		tunnel_type = '3';
		tunnel_src_net = nvram.lan0_ip;
		tunnel_src_mask = nvram.lan0_netmask;
		tunnel_dst_net = '0.0.0.0';
		tunnel_dst_mask = '255.255.255.0';
		tunnel_ike_policy = ike_policies[1][0]; //use modp1024 by default
		tunnel_ike_lifetime = '86400';
		tunnel_src_id_type = '0';
		tunnel_src_id = '';
		tunnel_dst_id_type = '0';
		tunnel_dst_id = '';
		tunnel_auth_type = '0';
		tunnel_auth_key = '';
		tunnel_ipsec_policy = ipsec_policies[0][0];
		tunnel_ipsec_lifetime = '3600';
		tunnel_pfs = '0';
		
		tunnel_dpd_interval = '60';
		tunnel_dpd_timeout = '180';		
		tunnel_icmp_host = '';
		tunnel_icmp_local = '';
		tunnel_icmp_interval = '60';
		tunnel_icmp_timeout = '5';
		tunnel_icmp_retries = '10';
		
		tunnel_restart_wan = '1';
		tunnel_others = '';
	}
*/
//instance id:

	createFieldTable('', [
		
		{ title: raps.instance_id, indent: 2, name: 'instance_id', type: 'text', maxlen: 15, size: 10, value: instance_id},
		{ title: raps.ring_type, indent: 2, name: 'ring_type', type: 'select', options: [[0,'Single-Ring'],[1,'Multi-Ring']], value: 0 },
		{ title: raps.node_type, indent: 2, name: 'node_type', type: 'select', options: [[0,'RPL-Owner'],[1,'RPL-Neighbor'],[2,'RPL-Neighbor-Next'],[3,'Normal']], value: 0 },
		{ title: raps.designation_port, indent: 2, name: 'designation_port', type: 'select', options: [[0,'Port0'],[1,'Port1']], value: 0 },
//Phase 1: ike_policy,ike_lifetime,src_id_type,src_id,dst_id_type,dst_id,auth_type,auth_key,
		//{ title: ''},
		//{ title: '<b>' + raps.node_mode + '</b>'},
		{ title: raps.node_mode, indent: 2, name: 'node_mode', type: 'select', options: [[0,'Ring-Node'],[1,'InterConnection-Node']], value: 0 },
//interConnection port configure
		//{ title: ''},
		//{ title: '<b>' + raps.node_mode + '</b>',name: 'mode_title'},
		{ title: '', indent: 2, name: 'port_mode', type: 'select', options: [[0,'Major-Ring'],[1,'Sub-Ring']], value: 0 },
//RAPS  virtual channel
		//{title: ''},
		//{title: '<b>' + raps.virtual_channel + '</b>'},
		{ title: raps.virtual_channel, indent: 2, name: 'virtual_channel', type: 'checkbox', value: 0},
		]);

/*
W("<td width=120>" + raps.instance_id + " " + "</td>");
W("<td><input name= 'instance_id' type='text' onclick='verifyFields();' id='_instance_id' size='10' value='" + instance_id + "'></td>");
W("<br>");
W("<p>");
W("<td><input name= 'ring_type' type='radio' onclick='verifyFields();' id='single_ring' value=''></td>");
W("<td width=120>" + 'Single Ring' + " " + "</td>");
W("<td><input name= 'ring_type' type='radio' onclick='verifyFields();' id='multi_ring' value=''></td>");
W("<td width=120>" + 'Multi Ring' + " " + "</td>");
W("<br>");
W("<p>");
W("<td width=120>" + raps.node_type+ " " + "</td>");
W(creatSelect(node_type_buf,0,'node_type'));
W("<td width=120>" + ' ' + " " + "</td>");
W("<td><input name= 'port' type='radio' onclick='verifyFields();' id='port0' value=''></td>");
W("<td width=120>" + 'Port0' + " " + "</td>");
W("<td><input name= 'port' type='radio' onclick='verifyFields();' id='port1' value=''></td>");
W("<td width=120>" + 'Port1' + " " + "</td>");
W("<br>");
W("<p>");

W("<td width=120>" + raps.node_mode + " " + "</td>");
W(creatSelect(node_mode_buf,0,'node_mode'));
W("<td width=120>" + ' ' + " " + "</td>");
W("<td><input name= 'ring' type='radio' onclick='verifyFields();' id='_major_ring' value=''></td>");
W("<td width=120>" + 'Major Ring' + " " + "</td>");
W("<td><input name= 'ring' type='radio' onclick='verifyFields();' id='_sub_ring' value=''></td>");
W("<td width=120>" + 'Sub Ring' + " " + "</td>");
W("<br>");
W("<p>");
W("<td width=120>" + 'Virtual Channel' + " " + "</td>");
W("<td><input name= 'virtual_channel' type='checkbox' onclick='verifyFields();' id='_virtual_channel' value=''></td>");
W("<br>");
W("<p>");
*/

W("</div>");		
W("<div id='footer'>");
W("<span id='footer-msg'></span>");
W("<input type='button' value='" + ui.save + "' id='save-button' onclick='save()'/>");
W("<input type='button' value='" + ui.cancel + "' id='cancel-button' onclick='cancel();'/>");	
W("<input type='button' value='" + ui.del + "' id='delete-button' onclick='on_remove()'/>");
W("</div>");

	E('delete-button').style.display = (tunnel_action=='edit') ? "" : "none";
	
	verifyFields(null, 1);
	
</script>
</form>

</body>
</html>
