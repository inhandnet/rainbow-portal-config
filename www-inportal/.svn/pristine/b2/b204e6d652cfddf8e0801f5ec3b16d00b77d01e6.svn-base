<% pagehead(menu.fw_acl_detail) %>
<style type='text/css'>

</style>
<script type='text/javascript'>
<% ih_sysinfo() %>
<% ih_user_info() %>

var operator_priv = 12;

var ace_type = [[ui.acl_std, ui.acl_std],[ui.acl_ext, ui.acl_ext]];
var ace_act = [[ui.permit, ui.permit],[ui.deny,ui.deny]];
var ace_protocols = [['ip', 'ip'],['tcp', 'tcp'],['udp', 'udp'],['icmp', 'icmp']];
var ace_icmp = [[ui.acl_icmp_desc, ui.acl_icmp_desc], [ui.acl_icmp_tc, ui.acl_icmp_tc]];
var ace_operators = [['any','any'],['=','='],['!=','!='],['<', '<'],['>','>'],['between','between']];

var  icmp_names = ["all","address-mask-reply", "address-mask-request",  "communication-prohibited",  "destination-unreachable",
					"echo-reply",  "echo-request","fragmentation-needed", "host-precedence-violation", "host-prohibited",
					"host-redirect", "host-unknown", "host-unreachable", "ip-header-bad", "network-prohibited", "network-redirect",
					"network-unknown", "network-unreachable", "parameter-problem", "port-unreachable", "precedence-cutoff","protocol-unreachable",
					"redirect", "required-option-missing", "router-advertisement", "router-solicitation","source-quench",
					"source-route-failed", "time-exceeded","timestamp-reply","timestamp-request","tos-host-redirect",
					"tos-host-unreachable", "tos-network-redirect","tos-network-unreachable","ttl-zero-during-transit",
					"ttl-zero-during-reassembly"];

var icmp_name_options = [];
for (var i = 0; i < icmp_names.length; i++){
	icmp_name_options.push([icmp_names[i], icmp_names[i]]);
}


function tb_is_ext_acl()
{
	if (E('_f_type').value == ui.acl_ext)
		return 1;
	return 0;
}

function tb_is_permit()
{
	if (E('_f_act').value == ui.permit)
		return 1;
	return 0;
}

function tb_is_icmp_by_name()
{
	if (E('_f_icmp_by').value == ui.acl_icmp_desc)
		return 1;
	return 0;
}

var opt_args = ['_f_proto', '_f_icmp','_f_icmp_by', '_f_name', '_f_type_code',
				'_f_src_prt_op', '_f_src_prt1', '_f_src_prt2',
				'_f_dst_ip', '_f_dst_wild', 
				'_f_dst_prt_op', '_f_dst_prt1', '_f_dst_prt2',
				'_f_est', '_f_frag'];

var ext_args = ['_f_proto','_f_dst_ip', '_f_dst_wild'];
var tcp_args = ['_f_src_prt_op', 
				'_f_dst_prt_op', 
				'_f_est', '_f_frag'];
var udp_args = ['_f_src_prt_op', 
				'_f_dst_prt_op', 
				'_f_frag'];
function hid_opt_args()
{
	elem.display_and_enable('_f_proto', '_f_icmp_by', '_f_name', '_f_icmp_type','_f_icmp_code',
				'_f_src_prt_op', '_f_src_prt1', '_f_src_prt2',
				'_f_dst_ip', '_f_dst_wild', 
				'_f_dst_prt_op', '_f_dst_prt1', '_f_dst_prt2',
				'_f_est', '_f_frag', false);
}

function display_ext_args()
{
	elem.display_and_enable('_f_proto','_f_dst_ip', '_f_dst_wild', true);		
}

function display_icmp_args()
{
	elem.display_and_enable('_f_icmp_by', true);	
}
function display_icmp_name_args()
{
	elem.display_and_enable('_f_name', true);	
}

function display_icmp_type_args()
{
	elem.display_and_enable('_f_icmp_type', true);	
	elem.display_and_enable('_f_icmp_code', true);	
}

function display_tcp_args()
{
	elem.display_and_enable('_f_src_prt_op', 
				'_f_dst_prt_op', 
				'_f_est', true);
}

function display_udp_args()
{
	elem.display_and_enable('_f_src_prt_op', 
				'_f_dst_prt_op', true);	
}

function display_ip_args()
{
	elem.display_and_enable('_f_frag', true);	
}

function display_port_args(dir, op)
{
	if (op == 'between'){
		elem.display_and_enable('_f_'+dir+'_prt1', 
				'_f_'+dir+'_prt2', true);			
	}else if (op == '='
		|| op == '!=' || op == '>' || op == '<'){
		elem.display_and_enable('_f_'+dir+'_prt1', true);	
	}
}



function back()
{
	document.location = 'setup-acl.jsp';	
}

function verify_wildcard(e)
{
	var ip, a, n, i;
	ip = _fmt_ip(e.value);
	if (ip == null) return 0;

	a = ip.split('.');
	for (i = 0; i < 4; ++i) {
		n = a[i] * 1;
		a[i] = n;
	}
	/* 检查二进制值是否合法 */
	//拼接二进制字符串
	var ip_binary = _checkIput_fomartIP(a[0]) + _checkIput_fomartIP(a[1]) + _checkIput_fomartIP(a[2]) + _checkIput_fomartIP(a[3]);
	if(-1 != ip_binary.indexOf("10"))return 0;
	e.value = ip;
	return 1;
}

/*校验地址反掩码，允许全0 和全1掩码*/
function v_info_wildcard(e, quiet, can_empty)
{
	if ((e = E(e)) == null) return 0;
	e.value = e.value.trim();/*去掉字符串中的空格*/

	if (e.value.length == 0){
		if (can_empty) {ferror.clear(e);return 1;}
		ferror.set(e, errmsg.empty, quiet);
		return 0;		
	}
	if (!verify_wildcard(e)){
		ferror.set(e, errmsg.wild, quiet);
		return 0;
	}
	ferror.clear(e);
	return 1;	
}


function verifyFields(focused, quiet)
{
	var cmd = "";
	var fom = E('_fom');
    var port_op_map = [];
    port_op_map['>'] = 'gt';
    port_op_map['<'] = 'lt';
    port_op_map['!='] = 'neq';
    port_op_map['='] = 'eq';
    port_op_map['between'] = 'range';
    port_op_map['any'] = 'any';

	
	E('save-button').disabled = true;	
	hid_opt_args();
	if (tb_is_ext_acl()) {
		display_ext_args();
		if ((E('_f_proto').value == 'ip')){
			display_ip_args();
		}else if (E('_f_proto').value == 'icmp'){
			display_icmp_args();
			if (tb_is_icmp_by_name())
				display_icmp_name_args();
			else
				display_icmp_type_args();
		}else if (E('_f_proto').value == 'tcp'){
			display_tcp_args();
			display_port_args('src', E('_f_src_prt_op').value)
			display_port_args('dst', E('_f_dst_prt_op').value);
		}else if (E('_f_proto').value == 'udp'){
			display_udp_args();
			display_port_args('src', E('_f_src_prt_op').value)
			display_port_args('dst', E('_f_dst_prt_op').value);
		}
	}
	if (tb_is_ext_acl()){
		if (!v_info_num_range('_f_no', quiet, false, 100, 199)) return 0;
	}else{
		if (!v_info_num_range('_f_no', quiet, false, 1, 99)) return 0;
	}
	if (!v_info_host_ip('_f_src_ip', quiet, true)) return 0;
	if (!v_info_wildcard('_f_src_wild', quiet, true)) return 0;
	if (E('_f_proto').value == 'tcp'
		|| E('_f_proto').value == 'udp'){
		if (E('_f_src_prt_op').value != 'any'){
			if (!v_info_num_range('_f_src_prt1', quiet, false, 1, 65535)) return 0;
		}
		if (E('_f_src_prt_op').value == 'between'){
			if (!v_info_num_range('_f_src_prt2', quiet, false, 1, 65535)) return 0;

		}
	}
	if (tb_is_ext_acl()){
		if (!v_info_host_ip('_f_dst_ip', quiet, true)) return 0;
		if (!v_info_wildcard('_f_dst_wild', quiet, true)) return 0;
		if (E('_f_proto').value == 'tcp'
			|| E('_f_proto').value == 'udp'){
			if (E('_f_dst_prt_op').value != 'any'){
				if (!v_info_num_range('_f_dst_prt1', quiet, false, 1, 65535)) return 0;
			}
			if (E('_f_dst_prt_op').value == 'between'){
				if (!v_info_num_range('_f_dst_prt2', quiet, false, 1, 65535)) return 0;

			}
		}else if (E('_f_proto').value == 'icmp'){
			if (E('_f_icmp_by').value == ui.acl_icmp_tc){
				if (!v_info_num_range('_f_icmp_type', quiet, true, 0, 255)) return 0;
				if (!v_info_num_range('_f_icmp_code', quiet, true, 0, 255)) return 0;
			}
		}
	}		
	if (!v_info_description('_f_desc', quiet, true)) return 0;

	cmd += "!\n";	
	cmd += "access-list "+ E('_f_no').value + (tb_is_permit()?" permit ":" deny ");

	if (tb_is_ext_acl()){
		cmd += E('_f_proto').value + " ";
	}
	if (E('_f_src_ip').value.length == 0){
		cmd += "any ";
	}else {
		cmd += E('_f_src_ip').value + " " + ((E('_f_src_wild').value.length == 0)?"0.0.0.0":E('_f_src_wild').value) + " ";
	}	
	if (tb_is_ext_acl()){
		if (E('_f_proto').value == 'tcp'
			|| E('_f_proto').value == 'udp'){
			if (E('_f_src_prt_op').value != 'any'){
				cmd += port_op_map[E('_f_src_prt_op').value] + " " + E('_f_src_prt1').value + " " 
					+ ((E('_f_src_prt_op').value == 'between')?(E('_f_src_prt2').value + " ") :" ");
			}
		}
		if (E('_f_dst_ip').value.length == 0){
			cmd += "any ";
		}else {
			cmd += E('_f_dst_ip').value + " " + ((E('_f_dst_wild').value.length == 0)?"0.0.0.0":E('_f_dst_wild').value) + " ";
		}
		if (E('_f_proto').value == 'tcp'
			|| E('_f_proto').value == 'udp'){
			if (E('_f_dst_prt_op').value != 'any'){
				cmd += port_op_map[E('_f_dst_prt_op').value] + " " + E('_f_dst_prt1').value + " " 
					+ ((E('_f_dst_prt_op').value == 'between')?(E('_f_dst_prt2').value + " ") :" ");
			}
		}

		if (E('_f_proto').value == 'icmp'){
			if (E('_f_icmp_by').value == ui.acl_icmp_desc){
				if (E('_f_name').value != 'all'){
					cmd += E('_f_name').value + " ";
				}
			}else{
				if (E('_f_icmp_type').value.length != 0){
					cmd += E('_f_icmp_type').value + " ";
					if (E('_f_icmp_code').value.length != 0){
						cmd += E('_f_icmp_code').value + " ";
					}
				}
			}
		}else if (E('_f_proto').value == 'tcp'){
			if (E('_f_est').checked)
				cmd += "established ";
		}else if (E('_f_proto').value == 'ip'){
			if (E('_f_frag').checked)
				cmd += "fragments ";
		}
	}	
	if (E('_f_log').checked)
				cmd += "log";
	cmd += "\n";
	
	if (E('_f_desc').value.length != 0)
		cmd += "access-list "+ E('_f_no').value + " remark " + E('_f_desc').value +"\n";
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
var ace_tb = [
	{ title: ui.acl_type, name: 'f_type', type: 'select', options:ace_type, value: ui.acl_ext},
	{ title: ui.id, name: 'f_no', type: 'text', maxlen: 3, size: 16, value: ''},
	{ title: ui.acl_action, name: 'f_act', type: 'select', options:ace_act, value: ui.permit},
	{ title: ui.acl_match},
		{ title: ui.acl_protocols, indent: 2, name: 'f_proto', type: 'select', options:ace_protocols, value: 'ip'},
		/* Source IP*/
		{ title: ui.acl_src_ip, indent: 2, name:'f_src_ip', type: 'text', maxlen:16, size: 16, value: ''},
		{ title: ui.acl_src_wild,  indent: 2,name:'f_src_wild', type: 'text', maxlen:16, size: 16, value: ''},
		{ title: ui.acl_src_port, indent: 2, multi:[{ name:'f_src_prt_op', type: 'select', options:ace_operators, value: 'any'},
											 { name:'f_src_prt1', type: 'text', maxlen:5, size: 6, value: ''},
											 { name:'f_src_prt2', type: 'text', maxlen:5, size: 6,prefix: '~', value: ''}]},
											 
		/* Destination IP */
		{ title: ui.acl_dest_ip,  indent: 2,name:'f_dst_ip', type: 'text', maxlen:16, size: 16, value: ''},
		{ title: ui.acl_dst_wild, indent: 2, name:'f_dst_wild', type: 'text', maxlen:16, size: 16, value: ''},
		
		{ title: ui.acl_dest_port, indent: 2,multi:[{ name:'f_dst_prt_op', type: 'select', options:ace_operators, value: 'any'},
											 { name:'f_dst_prt1', type: 'text', maxlen:5, size: 6, value: ''},
											 { name:'f_dst_prt2', type: 'text', maxlen:5, size: 6,prefix: '~', value: ''}]},
	
		/*ICMP */
		{ title: ui.acl_icmp_args, indent: 2,name: 'f_icmp_by', type: 'select', options:ace_icmp, value: ui.acl_icmp_desc},
		{ title: '',  indent: 2,name: 'f_name', type: 'select', options:icmp_name_options, value: 'all'},
		{ title: '',indent: 2, multi:[{ name: 'f_icmp_type', type: 'text', maxlen: 3, size: 5, prefix:ui.acl_icmp_type, value: ''},
							{ name: 'f_icmp_code', type: 'text', maxlen: 3, size: 5, prefix:ui.acl_icmp_Code, value: ''}
							]},
		
		/* More Conditions*/
		{ title: ui.acl_est,  indent: 2,name: 'f_est', type: 'checkbox', value: 0},
		{ title: ui.acl_frag, indent: 2, name: 'f_frag', type: 'checkbox', value: 0},
	{ title: ui.acl_log, name: 'f_log', type: 'checkbox', value: 0},			
	/* Description*/
	{ title: ui.desc, name: 'f_desc', type: 'text', maxlen: 128, size: 24, value: ''}
];
createFieldTable('', ace_tb);

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
