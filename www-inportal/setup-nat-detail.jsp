<% pagehead(menu.fw_nat_detail) %>

<style type='text/css'>

</style>

<script type='text/javascript'>

<% ih_sysinfo() %>
<% ih_user_info() %>

var operator_priv = 12;

nat_rule_config = [
	['0', '0', '0', '1', ['1.1.1.1', '255.255.255.0', '80', '100',[8, 0, 1]], ['1.1.1.4', '255.255.255.0', '8080', '100', [8,0,5]]]
];

<% web_exec('show running-config nat') %>
<% web_exec('show interface') %>


var vif_blank = [['', '']];
var vifs = [].concat(vif_blank, cellular_interface, eth_interface, sub_eth_interface,svi_interface,openvpn_interface, xdsl_interface, gre_interface, vp_interface, dot11radio_interface);
var interface_options = grid_list_all_vif_opts(vifs);

var transOptions;

//nat_cookie is an array
var nat_cookie = cookie.get('nat-modify');

if (nat_cookie == null){
	nat_cookie = 0;
}
//else{
//	cookie.unset('nat-modify');
//}

var dest_nat;
if(nat_cookie == 0) {
	dest_nat = 0;
} else {
	dest_nat = nat_cookie.split(',');
}
var dest_nat_config = [];
if (dest_nat){
	for (var i = 0; i < nat_rule_config.length; i++) {
/*
		if ((dest_nat[0] == nat_rule_config[i][0]) &&	//action
			(dest_nat[1] == nat_rule_config[i][1]) &&	//conn-src
			(dest_nat[2] == nat_rule_config[i][4][0]) &&	//trans-from
			(dest_nat[3] == nat_rule_config[i][5][0]))		//trans-to
		{
			dest_nat_config = nat_rule_config[i];
			break;
		}
*/
		var trans_typ = nat_rule_config[i][2];
		var tmp_from_if = nat_rule_config[i][4][4];
		var tmp_to_if = nat_rule_config[i][5][4];
		if ((dest_nat[0] == nat_rule_config[i][0]) &&	//action
			(dest_nat[1] == nat_rule_config[i][1])) //conn-src
		{
			if(trans_typ == '0') {	//ip to ip
				if((dest_nat[2] == nat_rule_config[i][4][0]) &&	//trans-from
				(dest_nat[3] == nat_rule_config[i][5][0])) {		//trans-to
					dest_nat_config = nat_rule_config[i];
					break;

				}
			} else if(trans_typ == '1') {	//ip to interface
				if((dest_nat[2] == nat_rule_config[i][4][0]) &&
					(dest_nat[3] == tmp_to_if)) {	
					dest_nat_config = nat_rule_config[i];
					break;
				}	
			} else if(trans_typ == '2') {	//interface to ip
				if((dest_nat[2] == tmp_from_if) && 
					(dest_nat[3] == nat_rule_config[i][5][0])) {		//trans-to
					dest_nat_config = nat_rule_config[i];
					break;
				
				}
			} else if(trans_typ == '3') {	//ip port to ip port	
				if (((nat_rule_config[i][3] == "1") && (dest_nat[2].indexOf("TCP") >= 0))
						|| ((nat_rule_config[i][3] == "2") && (dest_nat[2].indexOf("UDP") >= 0))) {
					if((dest_nat[2].indexOf(nat_rule_config[i][4][0]) >= 0) && 
						(dest_nat[3].indexOf(nat_rule_config[i][5][0]) >= 0)) {		//trans-to
						dest_nat_config = nat_rule_config[i];
						break;
					}
				}
			} else if(trans_typ == '4') {	//network to network
				if((dest_nat[2].indexOf(nat_rule_config[i][4][0]) >= 0) &&
					(dest_nat[3].indexOf(nat_rule_config[i][5][0]) >= 0)) {		//trans-to
					dest_nat_config = nat_rule_config[i];
					break;
				}
			} else if(trans_typ == '5') {	//ACL to INTERFACE
				if((dest_nat[2] == 'ACL:'+nat_rule_config[i][4][3]) &&
					(dest_nat[3] == tmp_to_if)) {
					dest_nat_config = nat_rule_config[i];
					break;
				}			
			} else if (trans_typ == '6') { //INTERFACE PORT to IP PORT
				if (((nat_rule_config[i][3] == "1") && (dest_nat[2].indexOf("TCP") >= 0))
						|| ((nat_rule_config[i][3] == "2") && (dest_nat[2].indexOf("UDP") >= 0))) {			
					if((dest_nat[2].indexOf(nat_rule_config[i][4][4]) >= 0) && 
						(dest_nat[3].indexOf(nat_rule_config[i][5][0]) >= 0)) {		//trans-to
						dest_nat_config = nat_rule_config[i];
						break;
					}
				}
			} else if (trans_typ == '7') {
				if ((dest_nat[2] == 'ACL:'+nat_rule_config[i][4][3]) 
						&& (dest_nat[3].indexOf(nat_rule_config[i][5][0]) >= 0)) {
					dest_nat_config = nat_rule_config[i];	
					break;
				}
			} else if (trans_typ == '8') {
				if ((dest_nat[2] == 'ACL:'+nat_rule_config[i][4][3]) 
						&& (dest_nat[3].indexOf(nat_rule_config[i][5][0]) >= 0)
						&& (dest_nat[3].indexOf(nat_rule_config[i][5][2]) >= 0)) {
					dest_nat_config = nat_rule_config[i];	
					break;
				}
			} else if (trans_typ = '10') {
				if ((dest_nat[2].indexOf(nat_rule_config[i][4][0]) >= 0) 
						&& (dest_nat[2].indexOf(nat_rule_config[i][5][0]) >= 0)
						&& (dest_nat[3].indexOf(nat_rule_config[i][6][0]) >= 0)
						&& (dest_nat[3].indexOf(nat_rule_config[i][6][1]) >= 0)) {
					dest_nat_config = nat_rule_config[i];
					break;
				}
			}
		}

	}
} else {
	dest_nat_config = [,,,,['','','','',[]],['','','','',[]],''];
}
var action_json = dest_nat_config[0];
var conn_src_json = dest_nat_config[1];
var trans_typ_json = dest_nat_config[2];
var proto_json = dest_nat_config[3];
//var trans_from_json = dest_nat_config[4];
var from_ip_json = dest_nat_config[4][0];
var from_mask_json = dest_nat_config[4][1];
var from_port_json = dest_nat_config[4][2];
var from_list_json = dest_nat_config[4][3];
var from_if_json = dest_nat_config[4][4];
//var trans_to_json = dest_nat_config[5];
var to_ip_json = dest_nat_config[5][0];
var to_mask_json = dest_nat_config[5][1];
var to_port_json = dest_nat_config[5][2];
var to_list_json = dest_nat_config[5][3];
var to_if_json = dest_nat_config[5][4];
var range_ip_json = dest_nat_config[6][0];
var range_mask_json = dest_nat_config[6][1];
var desc_json = dest_nat_config[7];

/*
function existNat(new_rule)
{
	for (var i = 0; i < nat_rule_config.length; i++) {
		if (new_rule[] == nat_rule_config[i][0])
			return 1;
	}
	return 0;
}
*/

function back()
{
	document.location = 'setup-nat.jsp';	
}

function v_info_description_ge(e, quiet, can_empty)
{
	if ((e = E(e)) == null) return 0;
	e.value = e.value.trim();/*去掉字符串中的空格*/

	if (e.value.length == 0){
		if (can_empty) {ferror.clear(e);return 1;}
		ferror.set(e, errmsg.empty_warn, quiet);
		return 1;
	}
	if(e.value.length < 12 || e.value.length >16){
		ferror.set(e, errmsg.bad_name8, quiet);
		return 0;
	}	
	if (!verify_string_desc(e)){/*合法字符校验*/
		ferror.set(e, errmsg.badDesc, quiet);
		return 0;
	}

	ferror.clear(e);
	return 1;
}

function v_info_description_ih(e, quiet, can_empty)
{
	if ((e = E(e)) == null) 
		return 0;
	e.value = e.value.trim();/*去掉字符串中的空格*/

	if (e.value.length == 0)
		return 1;
	if(e.value.length > 128){
		ferror.set(e, errmsg.bad_name9, quiet);
		return 0;
	}	
	if (!verify_string_desc(e)){/*合法字符校验*/
		ferror.set(e, errmsg.badDesc, quiet);
		return 0;
	}

	ferror.clear(e);
	return 1;
}

function verifyFields(focused, quiet)
{
	var cmd = "";
	var fom = E('_fom');

	var nat_action = E('_f_action').value;
	var nat_conn_src = E('_f_conn_src').value;
//	var nat_type = E('_f_nat_type').value;
	var snat_type = E('_f_snat_type').value;
	var dnat_type = E('_f_dnat_type').value;
	var nat_type = E('_f_nat_type').value;
	var nat_proto = E('_f_proto').value;
	var from_list = E('_f_from_list').value;
	var from_ip = E('_f_from_ip').value;
	var from_port = E('_f_from_port').value;
	var from_mask = E('_f_from_mask').value;
	var from_if = E('_f_from_iface').value;
	var to_list = E('_f_to_list').value;
	var to_ip = E('_f_to_ip').value;
	var to_port = E('_f_to_port').value;
	var to_mask = E('_f_to_mask').value;
	var to_if = E('_f_to_iface').value;
	var range_ip = E('_f_range_ip').value;
	var range_mask = E('_f_range_mask').value;
	var nat_desc = E('_f_desc').value;

	var tmp_action, tmp_conn_src, tmp_type, tmp_desc;
	var trans_type;

	E('save-button').disabled = true;

	/* 1:1NAT have no connect source and protocol,
	 * so make the nat_conn_src equal to conn_src_json,
	 * nat_proto equal to proto_json
	 * so it will not effect the following judgement
	 */
	if (nat_action == '2') {
		nat_conn_src = conn_src_json = 0;
		nat_proto = proto_json = 0;
	} 

	//clear the error fields
	ferror.clear('_f_from_ip');
	ferror.clear('_f_to_ip');
	ferror.clear('_f_from_port');
	ferror.clear('_f_to_port');
	ferror.clear('_f_from_mask');
	ferror.clear('_f_to_mask');
	ferror.clear('_f_range_ip');
	ferror.clear('_f_range_mask');
		
	if(nat_action == '0') {	//snat
		elem.display_and_enable(('_f_dnat_type'), ('_f_nat_type'), ('_f_range_ip'), ('_f_range_mask'), 0);	
		E('_f_src_range').style.display = "none";
		elem.display_and_enable(('_f_snat_type'), 1);	
		elem.display_and_enable(('_f_conn_src'), 1);
		elem.display_and_enable(('_f_desc'), 1);

		if(snat_type == '0') {	//IP to IP
			elem.display_and_enable(('_f_from_ip'), ('_f_to_ip'), 1);
			elem.display_and_enable(('_f_from_list'), ('_f_from_port'), ('_f_from_mask'), ('_f_from_iface'),
						('_f_to_list'), ('_f_to_port'), ('_f_to_mask'), ('_f_to_iface'), ('_f_proto'), 0);
			if (!v_info_host_ip('_f_from_ip', quiet, false)) return 0;
			if (!v_info_host_ip('_f_to_ip', quiet, false)) return 0;
		} else if(snat_type == '1') {	//IP to INTERFACE
			elem.display_and_enable(('_f_from_ip'), ('_f_to_iface'), 1);
			elem.display_and_enable(('_f_from_list'), ('_f_from_port'), ('_f_from_mask'), ('_f_from_iface'),
						('_f_to_list'), ('_f_to_port'), ('_f_to_mask'), ('_f_to_ip'), ('_f_proto'), 0);
			if (!v_info_host_ip('_f_from_ip', quiet, false)) return 0;			
			if (E('_f_to_iface').value == "") return 0;
		} else if(snat_type == '3') {	//IP PORT to IP PORT
			elem.display_and_enable(('_f_from_ip'), ('_f_from_port'), ('_f_to_ip'), ('_f_to_port'), ('_f_proto'), 1);
			elem.display_and_enable(('_f_from_list'), ('_f_from_mask'), ('_f_from_iface'),
						('_f_to_list'), ('_f_to_mask'), ('_f_to_iface'), 0);
			if (!v_info_host_ip('_f_from_ip', quiet, false)) return 0;
			if (!v_info_num_range('_f_from_port', quiet, false, 1, 65535)) return 0;
			if (!v_info_host_ip('_f_to_ip', quiet, false)) return 0;
			if (!v_info_num_range('_f_to_port', quiet, false, 1, 65535)) return 0;
		} else if(snat_type == '4') {	//NETWORK to NETWORK
			elem.display_and_enable(('_f_from_ip'), ('_f_from_mask'), ('_f_to_ip'), ('_f_to_mask'), 1);
			elem.display_and_enable(('_f_from_list'), ('_f_from_port'), ('_f_from_iface'),
						('_f_to_list'), ('_f_to_port'), ('_f_to_iface'), ('_f_proto'), 0);
			if (!v_info_host_ip('_f_from_ip', quiet, false)) return 0;
			if (!v_info_netmask('_f_from_mask', quiet, false)) return 0;
			if (!v_info_host_ip('_f_to_ip', quiet, false)) return 0;
			if (!v_info_netmask('_f_to_mask', quiet, false)) return 0;
		} else if(snat_type == '5') {	//ACL to INTERFACE
			elem.display_and_enable(('_f_from_list'), ('_f_to_iface'), 1);
			elem.display_and_enable(('_f_from_ip'), ('_f_from_mask'), ('_f_from_port'), ('_f_from_iface'),
						('_f_to_ip'), ('_f_to_list'), ('_f_to_mask'), ('_f_to_port'), ('_f_proto'), 0);
				if (!v_info_num_range('_f_from_list', quiet, false, 1, 199)) return 0;
				if (E('_f_to_iface').value == "") return 0;
		} else if(snat_type == '7') {   // ACL to IP
			elem.display_and_enable(('_f_from_list'), ('_f_to_ip'), 1);
			elem.display_and_enable(('_f_from_ip'), ('_f_from_port'), ('_f_from_mask'), ('_f_from_iface'),
						('_f_to_list'), ('_f_to_mask'), ('_f_to_iface'), ('_f_to_port'), ('_f_proto'), 0);

			if (!v_info_num_range('_f_from_list', quiet, false, 1, 199)) 
				return 0;
			if (!v_info_host_ip('_f_to_ip', quiet, false)) 
				return 0;
		}

	} else if(nat_action == '1') {	//dnat
		elem.display_and_enable(('_f_snat_type'), ('_f_nat_type'), ('_f_range_ip'), ('_f_range_mask'), 0);	
		E('_f_src_range').style.display = "none";
		elem.display_and_enable(('_f_dnat_type'), 1);
		elem.display_and_enable(('_f_conn_src'), 1);
		elem.display_and_enable(('_f_desc'), 1);

		if(dnat_type == '0') {	//IP to IP
			elem.display_and_enable(('_f_from_ip'), ('_f_to_ip'), 1);
			elem.display_and_enable(('_f_from_list'), ('_f_from_port'), ('_f_from_mask'), ('_f_from_iface'),
						('_f_to_list'), ('_f_to_port'), ('_f_to_mask'), ('_f_to_iface'), ('_f_proto'), 0);
			if (!v_info_host_ip('_f_from_ip', quiet, false)) return 0;
			if (!v_info_host_ip('_f_to_ip', quiet, false)) return 0;
		} else if(dnat_type == '2') {	//INTERFACE to IP
			elem.display_and_enable(('_f_from_iface'), ('_f_to_ip'), 1);
			elem.display_and_enable(('_f_from_list'), ('_f_from_port'), ('_f_from_mask'), ('_f_from_ip'),
						('_f_to_list'), ('_f_to_port'), ('_f_to_mask'), ('_f_to_iface'), ('_f_proto'), 0);
			if (E('_f_from_iface').value == "") return 0;
			if (!v_info_host_ip('_f_to_ip', quiet, false)) return 0;

		} else if(dnat_type == '3') {	//IP PORT to IP PORT
			elem.display_and_enable(('_f_from_ip'), ('_f_from_port'), ('_f_to_ip'), ('_f_to_port'), ('_f_proto'), 1);
			elem.display_and_enable(('_f_from_list'), ('_f_from_mask'), ('_f_from_iface'),
						('_f_to_list'), ('_f_to_mask'), ('_f_to_iface'), 0);
			if (!v_info_host_ip('_f_from_ip', quiet, false)) return 0;
			if (!v_info_num_range('_f_from_port', quiet, false, 1, 65535)) return 0;
			if (!v_info_host_ip('_f_to_ip', quiet, false)) return 0;
			if (!v_info_num_range('_f_to_port', quiet, false, 1, 65535)) return 0;
		} else if(dnat_type == '4') {	//NETWORK to NETWORK
			elem.display_and_enable(('_f_from_ip'), ('_f_from_mask'), ('_f_to_ip'), ('_f_to_mask'), 1);
			elem.display_and_enable(('_f_from_list'), ('_f_from_port'), ('_f_from_iface'),
						('_f_to_list'), ('_f_to_port'), ('_f_to_iface'), ('_f_proto'), 0);
			if (!v_info_host_ip('_f_from_ip', quiet, false)) return 0;
			if (!v_info_netmask('_f_from_mask', quiet, false)) return 0;
			if (!v_info_host_ip('_f_to_ip', quiet, false)) return 0;
			if (!v_info_netmask('_f_to_mask', quiet, false)) return 0;
		} else if(dnat_type == '6') { // INTERFACE PORT to IP PORT
			elem.display_and_enable(('_f_from_iface'), ('_f_from_port'), ('_f_to_ip'), ('_f_to_port'), ('_f_proto'), 1);
			elem.display_and_enable(('_f_from_list'), ('_f_from_mask'), ('_f_from_ip'),
						('_f_to_list'), ('_f_to_mask'), ('_f_to_iface'), 0);
			if (E('_f_from_iface').value == "") return 0;
			if (!v_info_num_range('_f_from_port', quiet, false, 1, 65535)) return 0;
			if (!v_info_host_ip('_f_to_ip', quiet, false)) return 0;
			if (!v_info_num_range('_f_to_port', quiet, false, 1, 65535)) return 0;
		} else if(dnat_type == '7') {
			elem.display_and_enable(('_f_from_list'), ('_f_to_ip'), 1);
			elem.display_and_enable(('_f_from_ip'), ('_f_from_port'), ('_f_from_mask'), ('_f_from_iface'),
						('_f_to_list'), ('_f_to_mask'), ('_f_to_iface'), ('_f_to_port'), ('_f_proto'), 0);

			if (!v_info_num_range('_f_from_list', quiet, false, 1, 199)) 
				return 0;
			if (!v_info_host_ip('_f_to_ip', quiet, false)) 
				return 0;
		} else if(dnat_type == '8') {
			elem.display_and_enable(('_f_from_list'), ('_f_to_ip'), ('_f_to_port'), 1);
			elem.display_and_enable(('_f_from_ip'), ('_f_from_port'), ('_f_from_mask'), ('_f_from_iface'),
						('_f_to_list'), ('_f_to_mask'), ('_f_to_iface'), ('_f_proto'), 0);

			if (!v_info_num_range('_f_from_list', quiet, false, 1, 199)) 
				return 0;
			if (!v_info_host_ip('_f_to_ip', quiet, false)) 
				return 0;
			if (!v_info_num_range('_f_to_port', quiet, false, 1, 65535)) 
				return 0;
		}
	} else if(nat_action == '2') {	//nat
		elem.display_and_enable(('_f_snat_type'), ('_f_dnat_type'), ('_f_conn_src'),
				('_f_range_ip'), ('_f_range_mask'), 0);
		elem.display_and_enable(('_f_nat_type'), 1);
		elem.display_and_enable(('_f_desc'), 1);
		if(nat_type == '0') {	//IP to IP
			elem.display_and_enable(('_f_from_ip'), ('_f_to_ip'), 1);
			elem.display_and_enable(('_f_from_list'), ('_f_from_port'), ('_f_from_mask'), ('_f_from_iface'),
						('_f_to_list'), ('_f_to_port'), ('_f_to_mask'), ('_f_to_iface'), ('_f_proto'), 0);
			E('_f_src_range').style.display = "none";
			if (!v_info_host_ip('_f_from_ip', quiet, false)) return 0;
			if (!v_info_host_ip('_f_to_ip', quiet, false)) return 0;
		} else if(nat_type == '1') {	//IP to INTERFACE
			elem.display_and_enable(('_f_from_ip'), ('_f_to_iface'), 1);
			elem.display_and_enable(('_f_from_list'), ('_f_from_port'), ('_f_from_mask'), ('_f_from_iface'),
						('_f_to_list'), ('_f_to_port'), ('_f_to_mask'), ('_f_to_ip'), ('_f_proto'), 0);
			E('_f_src_range').style.display = "none";
			if (!v_info_host_ip('_f_from_ip', quiet, false)) return 0;
			if (E('_f_to_iface').value == "") return 0;
		} else if (nat_type == '9') {  // VIP 
			elem.display_and_enable(('_f_from_ip'), ('_f_to_mask'), ('_f_to_ip'), 1);
			elem.display_and_enable(('_f_from_list'), ('_f_from_port'), ('_f_from_mask'), ('_f_from_iface'),
						('_f_to_list'), ('_f_to_port'), ('_f_proto'), ('_f_to_iface'), 0);
			E('_f_src_range').style.display = "none";
			if (!v_info_host_ip('_f_from_ip', quiet, false)) return 0;
			if (!v_info_host_ip('_f_to_ip', quiet, false)) return 0;
			if (!v_info_netmask('_f_to_mask', quiet, false)) return 0;
		} else if (nat_type == '10') {
			elem.display_and_enable(('_f_from_ip'), ('_f_to_ip'), ('_f_range_ip'), ('_f_range_mask'), 1);
			elem.display_and_enable(('_f_from_list'), ('_f_from_port'), ('_f_from_mask'), ('_f_from_iface'),
						('_f_to_list'), ('_f_to_mask'), ('_f_to_port'), ('_f_proto'), ('_f_to_iface'), 0);
			E('_f_src_range').style.display = "";
			if (!v_info_host_ip('_f_from_ip', quiet, false)) return 0;
			if (E('_f_to_ip').value != "") {
				if (!v_info_host_ip('_f_to_ip', quiet, false)) 
					return 0;
			} else {
				to_ip = "0.0.0.0";	
			}
				
			if (!v_info_host_ip('_f_range_ip', quiet, false)) return 0;
			if (!v_info_netmask('_f_range_mask', quiet, false)) return 0;
		}
	}
	if(ih_sysinfo.oem_name == 'global-ge') {
		if (!v_info_description_ge('_f_desc', quiet, false)) 
			return 0;
	} else {
		if (!v_info_description_ih('_f_desc', quiet, true))	
			return 0;
	}
		
	if(E('_f_snat_type').disabled == 0) {
		trans_type = snat_type;	
	} else if(E('_f_dnat_type').disabled == 0) {
		trans_type = dnat_type;
	} else if(E('_f_nat_type').disabled == 0) {
		trans_type = nat_type;
	}

	if(nat_action != action_json ||
		nat_conn_src != conn_src_json ||
		trans_type != trans_typ_json ||
		from_list != from_list_json ||
		nat_proto != proto_json || 
		from_ip != from_ip_json ||
		from_port != from_port_json ||
		from_mask != from_mask_json ||
		from_if != from_if_json ||
		to_list != to_list_json ||
		to_ip != to_ip_json ||
		to_port != to_port_json ||
		to_mask != to_mask_json ||
		to_if != to_if_json ||
		range_ip != range_ip_json ||
		range_mask != range_mask_json ||
		nat_desc != desc_json) {

		if(action_json == '0') {	//snat
			tmp_action = "snat";
			if(trans_typ_json == '0') {	//IP to IP
				tmp_type = "static "+from_ip_json+" "+to_ip_json;
			} else if(trans_typ_json == '1') {	//IP to INTERFACE
				tmp_type = "static "+from_ip_json+" interface "+to_if_json;
			} else if(trans_typ_json == '3') {	//IP Port to IP Port
				tmp_type = "static "+((proto_json == '1')?"tcp ":"udp ")+from_ip_json+" "+from_port_json+" "+to_ip_json+" "+to_port_json;
			} else if(trans_typ_json == '4') {	//Network to Network
				tmp_type = "static network "+from_ip_json+" "+to_ip_json+" "+from_mask_json;
			} else if(trans_typ_json == '5') {	//ACL to INTERFACE
				tmp_type = "list "+from_list_json+" interface "+to_if_json;
			} else if (trans_typ_json == '7') { //ACL to IP
				tmp_type = "list " + from_list_json + " " + to_ip_json; 	
			}

		} else if(action_json == '1') {	//dnat
			tmp_action = "dnat";
			if(trans_typ_json == '0') {	//IP to IP
				tmp_type = "static "+from_ip_json+" "+to_ip_json;
			} else if(trans_typ_json == '2') {	//INTERFACE to IP
				tmp_type = "static interface "+from_if_json+" "+to_ip_json;
			} else if(trans_typ_json == '3') {	//IP Port to IP Port
				tmp_type = "static "+((proto_json == '1')?"tcp ":"udp ")+from_ip_json+" "+from_port_json+" "+to_ip_json+" "+to_port_json;
			} else if(trans_typ_json == '4') {	//Network to Network
				tmp_type = "static network "+from_ip_json+" "+to_ip_json+" "+from_mask_json;
			} else if(trans_typ_json == '6') {	// INTERFACE PORT to IP PORT
				tmp_type = "static "+((proto_json == '1')?"tcp ":"udp ")+ "interface " + from_if_json+" "+from_port_json+" "+to_ip_json+" "+to_port_json;
			} else if (trans_type_json == '7') {  // ACL TO IP
				tmp_type = "list " + from_list_json + " " + to_ip_json; 	
			} else if (trans_type_json == '8') {  // ACL to IP PORT
				tmp_type = "list " + from_list_json + " " + to_ip_json + " " + to_port_json; 	
			}
		} else if(action_json == '2') {	//nat
			tmp_action = "nat";
			if(trans_typ_json == '0') {	//IP to IP
				tmp_type = "static "+from_ip_json+" "+to_ip_json;
			} else if(trans_typ_json == '1') {	//IP to INTERFACE
				tmp_type = "static "+from_ip_json+" interface "+to_if_json;
			} else if (trans_typ_json == '9') { // VIP
				tmp_type = "static " + from_ip_json + " network " + to_ip_json + to_mask_json;	
			} else if (trans_typ_json == '10') {
				tmp_type = "static " + from_ip_json + " vip " + to_ip_json + " " + range_ip_json + " " + range_mask_json;	
			}
			
		}

		if(conn_src_json == '0') {
			tmp_conn_src = 'inside';
		} else if(conn_src_json == '1') {
			tmp_conn_src = 'outside';
		}

		if(desc_json !='') {
			tmp_desc = "description " + desc_json;
		} else {
			tmp_desc = '';
		}

		if(dest_nat) {
			if(action_json == '2') {
				cmd += "no ip " + tmp_action + " " + tmp_type+ " " + tmp_desc + "\n";
			} else {
				cmd += "no ip " + tmp_action + " " + tmp_conn_src + " " + tmp_type + " " + tmp_desc + "\n";
			}
		}
		tmp_action = "";
		tmp_conn_src = "";
		tmp_type = "";
		tmp_desc = "";

		if(nat_action == '0') {	//snat
			tmp_action = "snat";
			if(snat_type == '0') {	//IP to IP
				tmp_type = "static "+from_ip+" "+to_ip;
			} else if(snat_type == '1') {	//IP to INTERFACE
				tmp_type = "static "+from_ip+" interface "+to_if;
			} else if(snat_type == '3') {	//IP Port to IP Port
				tmp_type = "static "+((nat_proto == '1')?"tcp ":"udp ")+from_ip+" "+from_port+" "+to_ip+" "+to_port;
			} else if(snat_type == '4') {	//Network to Network
				tmp_type = "static network "+from_ip+" "+to_ip+" "+from_mask;
			} else if(snat_type == '5') {	//ACL to INTERFACE
				tmp_type = "list "+from_list+" interface "+to_if;
			} else if (snat_type == '7') {  //ACL to IP
				tmp_type = "list " + from_list + " " + to_ip; 	
			}

		} else if(nat_action == '1') {	//dnat
			tmp_action = "dnat";
			if(dnat_type == '0') {	//IP to IP
				tmp_type = "static "+from_ip+" "+to_ip;
			} else if(dnat_type == '2') {	//INTERFACE to IP
				tmp_type = "static interface "+from_if+" "+to_ip;
			} else if(dnat_type == '3') {	//IP Port to IP Port
				tmp_type = "static "+((nat_proto == '1')?"tcp ":"udp ")+from_ip+" "+from_port+" "+to_ip+" "+to_port;
			} else if(dnat_type == '4') {	//Network to Network
				tmp_type = "static network "+from_ip+" "+to_ip+" "+from_mask;
			} else if(dnat_type == '6') {	// INTERFACE PORT to IP PORT
				tmp_type = "static "+((nat_proto == '1')?"tcp ":"udp ")+ "interface " + from_if+" "+from_port+" "+to_ip+" "+to_port;
			} else if (dnat_type == '7') {
				tmp_type = "list " + from_list + " " + to_ip; 	
			} else if (dnat_type == '8') {
				tmp_type = "list " + from_list + " " + to_ip + " " + to_port; 	
			}
		} else if(nat_action == '2') {	//nat
			tmp_action = "nat";
			if(nat_type == '0') {	//IP to IP
				tmp_type = "static "+from_ip+" "+to_ip;
			} else if(nat_type == '1') {	//IP to INTERFACE
				tmp_type = "static "+from_ip+" interface "+to_if;
			} else if (nat_type == '9') { // VIP
				tmp_type = "static " + from_ip + " network " + to_ip + " " + to_mask;	
			} else if (nat_type == '10') {
				tmp_type = "static " + from_ip + " vip " + to_ip + " " + range_ip + " " + range_mask;	
			}
			
		}

		if(nat_conn_src == '0') {
			tmp_conn_src = 'inside';
		} else if(nat_conn_src == '1') {
			tmp_conn_src = 'outside';
		}

		if(nat_desc !='') {
			tmp_desc = "description " + nat_desc;
		} else {
			tmp_desc = '';
		}

		if(nat_action == '2') {
			cmd += "ip "+ tmp_action + " " + tmp_type + " " + tmp_desc + "\n";
		} else {
			cmd += "ip " + tmp_action + " " + tmp_conn_src + " " + tmp_type + " " + tmp_desc + "\n";
		}
	}
	//alert(cmd);
	if (user_info.priv < operator_priv) {
		elem.display('save-button', false);
	}else{
		elem.display('save-button', true);
		fom._web_cmd.value = cmd;
		E('save-button').disabled = (cmd=="");	
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

function earlyInit()
{
	
	verifyFields(null, true);
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

var nat_tb = [
				{ title: ui.nat_action, name: 'f_action', type: 'select', options:[['0', 'SNAT'], ['1', 'DNAT'], ['2', '1:1NAT']], value: action_json},
				{ title: ui.nat_conn_src, name: 'f_conn_src', type: 'select', options:[['0', 'Inside'], ['1', 'Outside']], value: conn_src_json},
				{ title: ui.nat_trans_type, name: 'f_snat_type', type: 'select', 
					options:[['0', 'IP to IP'], ['1', 'IP to INTERFACE'], ['3', 'IP PORT to IP PORT'], 
						  ['4', 'NETWORK to NETWORK'], ['5', 'ACL to INTERFACE'], ['7', 'ACL to IP']], value: trans_typ_json},
				{ title: ui.nat_trans_type, name: 'f_dnat_type', type: 'select', 
					options:[['0', 'IP to IP'], ['2', 'INTERFACE to IP'], ['3', 'IP PORT to IP PORT'], 
						  ['4', 'NETWORK to NETWORK'], ['6', 'INTERFACE PORT to IP PORT'], 
						  ['7', 'ACL to IP'], ['8', 'ACL to IP PORT']], value: trans_typ_json},
				{ title: ui.nat_trans_type, name: 'f_nat_type', type: 'select', 
					options:[['0', 'IP to IP'], ['1', 'IP to INTERFACE'],['10', 'Vitural IP to IP']], value: trans_typ_json},
				{ title: ui.proto, name: 'f_proto', type: 'select', options:[['1', 'TCP'], ['2', 'UDP']], value:proto_json },
				{ title: ui.nat_untrans, name: 'f_trans_from' },
				{ title: ui.acl_list, indent: 2, name: 'f_from_list', type: 'text', maxlen: 3, size: 10, value: from_list_json},
				{ title: ui.iface, indent: 2, name: 'f_from_iface', type: 'select', options:interface_options, value: from_if_json},
				{ title: ui.ip, indent: 2, name: 'f_from_ip', type: 'text', maxlen: 16, size: 16, value: from_ip_json},
				{ title: port.port, indent: 2, name: 'f_from_port', type: 'text', maxlen: 5, size: 10, value: from_port_json},
				{ title: ui.netmask, indent: 2, name: 'f_from_mask', type: 'text', maxlen: 16, size: 16, value: from_mask_json},
				
				{ title: ui.nat_trans, name: 'f_trans_to' },
				{ title: ui.acl_list, indent: 2, name: 'f_to_list', type: 'text', maxlen: 3, size: 10, value: to_list_json},
				{ title: ui.ip, indent: 2, name: 'f_to_ip', type: 'text', maxlen: 16, size: 16, value: to_ip_json == "0.0.0.0" ? "" : to_ip_json},
				{ title: port.port, indent: 2, name: 'f_to_port', type: 'text', maxlen: 5, size: 10, value: to_port_json},
				{ title: ui.netmask, indent: 2, name: 'f_to_mask', type: 'text', maxlen: 16, size: 16, value: to_mask_json},
				{ title: ui.iface, indent: 2, name: 'f_to_iface', type: 'select', options:interface_options, value: to_if_json},

				{ title: ui.nat_src_range, name: 'f_src_range', rid: "_f_src_range"},
				{ title: ui.ip, indent: 2, name: 'f_range_ip', type: 'text', maxlen: 16, size: 16, value: range_ip_json},
				{ title: ui.netmask, indent: 2, name: 'f_range_mask', type: 'text', maxlen: 16, size: 16, value: range_mask_json},

				{ title: ui.nat_desc, name: 'f_desc', type: 'text', maxlen: 128, size: 50, value: desc_json}
				
			];

createFieldTable('', nat_tb);

</script>
</div>

<script type='text/javascript'>
init();
if(cookie.get('autosave') == 1)
	ui.aply=ui.aply_save;
genStdFooterWithBack("");
</script>

<script type='text/javascript'>earlyInit()</script>
</form>
</body>
</html>
