<% pagehead(menu.setup_traffic) %>

<style tyle='text/css'>

#tcl-grid {
	text-align: center;
	width: 870px;
}
#tcl-grid .co1 {
	width: 80px;
}
#tcl-grid .co2 {
	width: 30px;
}
#tcl-grid .co3 {
	width: 240px;
}
#tcl-grid .co4 {
	width: 240px;
}

#tpl-grid {
	text-align: center;
	width: 870px;
}

#tif-grid {
	text-align: center;
	width: 870px;
}

</style>

<script type='text/javascript'>

<% ih_sysinfo(); %>
<% ih_user_info(); %>

/*tc_classes = [name, any, acl, [src-ip, src-mask], [dst-ip, dst-mask], [protocols]] */
/*tc_policies: [policy-name, class-name, gbw, mbw, prio]*/
/*tc_ifaces = [type, slot, port, ibw,obw, ipolicy, opolicy]*/
<% web_exec('show running-config traffic') %>



var tcl_idx = 0;
var tcl_name_idx = tcl_idx++;
var tcl_any_idx = tcl_idx++;
var tcl_acl_idx = tcl_idx++;
var tcl_src_idx = tcl_idx++;
var tcl_dst_idx = tcl_idx++;
var tcl_proto_idx = tcl_idx++;



var tcl_tb_idx = 0;
var tcl_tb_name_idx =tcl_tb_idx++;
var tcl_tb_any_idx =tcl_tb_idx++;
var tcl_tb_srcip_idx =tcl_tb_idx++;
var tcl_tb_srcmask_idx =tcl_tb_idx++;
var tcl_tb_dstip_idx =tcl_tb_idx++;
var tcl_tb_dstmask_idx =tcl_tb_idx++;
var tcl_tb_proto_idx =tcl_tb_idx++;

var tpl_idx = 0;
var tpl_name_idx = tpl_idx++;
var tpl_class_idx = tpl_idx++;
var tpl_gbw_idx = tpl_idx++;
var tpl_mbw_idx = tpl_idx++;
var tpl_prio_idx = tpl_idx++;

var tpl_tb_idx = 0;
var tpl_tb_name_idx = tpl_tb_idx++;
var tpl_tb_class_idx = tpl_tb_idx++;
var tpl_tb_gbw_idx = tpl_tb_idx++;
var tpl_tb_mbw_idx = tpl_tb_idx++;
var tpl_tb_prio_idx = tpl_tb_idx++;

var tc_protocols = ['icmp','igmp', 'tcp', 'udp', 'gre', 'esp', 'ah', 'ospf', 'vrrp', 'l2tp'];

function proto_matched(protocols, protocols_list)
{
	var i;
	for (i = 0; i < protocols_list.length; i++){
		if (protocols_list[i] == protocols)
			return 1;
	}
	return 0;
}


var tc_prio_opts = [[0, ''],[1,'highest'],[2,'high'],[3,'medium'],[4,'low'], [5, 'lowest']];

var tif_idx = 0;
var tif_name_idx = tif_idx++;
var tif_ibw_idx =  tif_idx++;
var tif_obw_idx =  tif_idx++;
var tif_ipol_idx =  tif_idx++;
var tif_opol_idx =  tif_idx++;


//////////////////////////////////////////////////////////////////////////////////////////////
//Get (L3)  interfaces list 
<% web_exec('show interface') %>
var vifs = [].concat(cellular_interface, eth_interface, sub_eth_interface, svi_interface,xdsl_interface, gre_interface, vp_interface, dot11radio_interface);
var now_vifs_options = new Array();
now_vifs_options = grid_list_all_vif_opts(vifs);
//alert(now_vifs_options);
//////////////////////////////////////////////////////////////////////////////////////////////////////////////

var tc_class = new webGrid();

tc_class.notExist = function(f, v, quiet)
{
	if ((e = E(v)) == null) return 0;
	var data = this.getAllData();
	for (var i = 0; i < data.length; ++i) {
		if (data[i][f] == e.value) {
			ferror.set(e, '"'+e.value +'" ' + errmsg.generExist, quiet);
			return 0;
		}
	}
	ferror.clear(e);
	return 1;
}


tc_class.dataToView = function(data) 
{
	var v = [];
	var p = '';

	v.push(data[tcl_tb_name_idx]);//name
	v.push((data[tcl_tb_any_idx] == 1?ui.yes_p:ui.no_p));
	if (data[tcl_tb_srcip_idx] != '')
		v.push(data[tcl_tb_srcip_idx]+'/'+data[tcl_tb_srcmask_idx]);
	else 
		v.push('any');
	if (data[tcl_tb_dstip_idx] != '')		
		v.push(data[tcl_tb_dstip_idx]+'/'+data[tcl_tb_dstmask_idx]);
	else
		v.push('any');

	for (var i = 0; i < tc_protocols.length; i++){
		if (data[tcl_tb_proto_idx+i])
			p += ' '+tc_protocols[i]+';';
	}
	if (p == '')
		p = 'any';
	v.push(p);
	return v;
}


tc_class.fieldValuesToData = function(row) {
	var f, data;

	data = [];
	f = fields.getAll(row);
	data.push(f[tcl_tb_name_idx].value);
	data.push((f[tcl_tb_any_idx].checked?1:0));
	data.push(f[tcl_tb_srcip_idx].value);
	data.push(f[tcl_tb_srcmask_idx].value);
	data.push(f[tcl_tb_dstip_idx].value);
	data.push(f[tcl_tb_dstmask_idx].value);
	for (var i = 0; i < tc_protocols.length; i++){
		data.push((f[tcl_tb_proto_idx+i].checked?1:0));
	}

	return data;
}

tc_class.resetNewEditor = function() {
	var f = fields.getAll(this.newEditor);
	ferror.clearAll(f);
	f[tcl_name_idx].value = '';
	f[tcl_any_idx].checked = 0;
	for (var i = 0; i < tc_protocols.length; i++){
		f[tcl_tb_proto_idx+i].checked = 0;
	}	
}

	
tc_class.verifyFields = function(row, quiet)
{
	var f = fields.getAll(row);
    ferror.clearAll(f);

	if (!v_info_word(f[tcl_tb_name_idx], quiet, false)) return 0;
	if (!tc_class.notExist(tcl_tb_name_idx, f[tcl_tb_name_idx],  quiet)) return 0;

	if (f[tcl_any_idx].checked ){
		f[tcl_tb_srcip_idx].disabled = true;
		f[tcl_tb_srcmask_idx].disabled = true;
		f[tcl_tb_dstip_idx].disabled = true;
		f[tcl_tb_dstmask_idx].disabled = true;	
		for(var i = 0; i < tc_protocols.length; i++){
			f[tcl_tb_proto_idx + i].disabled = true;		
		}
	}else{
		f[tcl_tb_srcip_idx].disabled = false;
		f[tcl_tb_srcmask_idx].disabled = false;
		f[tcl_tb_dstip_idx].disabled = false;
		f[tcl_tb_dstmask_idx].disabled = false;	
		for(var i = 0; i < tc_protocols.length; i++){
			f[tcl_tb_proto_idx + i].disabled = false;		
		}		
		
		if (!v_info_ip(f[tcl_tb_srcip_idx], quiet, true)) return 0;
		if (!v_info_netmask(f[tcl_tb_srcmask_idx], quiet, true)) return 0;
		
		if ((f[tcl_tb_srcip_idx].value != '') && (f[tcl_tb_srcmask_idx].value == ''))
			f[tcl_tb_srcmask_idx].value = '255.255.255.0';

		if (!v_info_ip(f[tcl_tb_dstip_idx], quiet, true)) return 0;
		if (!v_info_netmask(f[tcl_tb_dstmask_idx], quiet, true)) return 0;

		if ((f[tcl_tb_dstip_idx].value != '') && (f[tcl_tb_dstmask_idx].value == ''))
			f[tcl_tb_dstmask_idx].value = '255.255.255.0';
	}
	
	return 1;
}
tc_class.onDataChanged = function() {
 	verifyFields(null, 1);
}

tc_class.setup = function()
{
	var tc_proto_tb = [];

	for (var i = 0; i < tc_protocols.length; i++){
		tc_proto_tb.push({type: 'checkbox',style:'width:20px', suffix: tc_protocols[i]+'' });
	}
	
	this.init('tcl-grid', ['sort'], 256,[
		{ type: 'text', maxlen: 31 },//classifier name 
		{ type: 'checkbox'},//ANY
		{ multi2: [{ type: 'text',style:'width:110px', suffix: '/',maxlen: 15 },{ type: 'text',style:'width:110px', maxlen: 15 }]},
		{ multi2: [{ type: 'text',style:'width:110px', suffix: '/',maxlen: 15 },{ type: 'text',style:'width:110px', maxlen: 15 }]},
		{ multi2:tc_proto_tb}//protocols		
	]);

	this.headerSet([ui.nam, traffic.any,traffic.src,traffic.dst, ui.proto]);
	for(var i = 0;i < (tc_classes.length);++i){
		var tmp_tc_class = [];			
		tmp_tc_class.push(tc_classes[i][tcl_name_idx]);
		tmp_tc_class.push(tc_classes[i][tcl_any_idx]);
		tmp_tc_class.push(tc_classes[i][tcl_src_idx][0]);
		tmp_tc_class.push(tc_classes[i][tcl_src_idx][1]);
		tmp_tc_class.push(tc_classes[i][tcl_dst_idx][0]);
		tmp_tc_class.push(tc_classes[i][tcl_dst_idx][1]);
		for (var j = 0; j < tc_protocols.length; j++){
			if (proto_matched(tc_protocols[j], tc_classes[i][tcl_proto_idx]))
				tmp_tc_class.push(1);	
			else
				tmp_tc_class.push(0);	
		}		
		tc_class.insertData(-1,tmp_tc_class);	
	}	
			
	tc_class.showNewEditor();
	tc_class.resetNewEditor();	
}


tc_class.onClick = function(cell) {
	
    if(this.canEdit) {
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
			return;
		}
		this.edit(cell);		
	}
        
    var f = fields.getAll(this.editor);
	f[0].disabled = true;
}

var tc_policy = new webGrid();
tc_policy.classNotExist = function(f_pol, f_cla, quiet)
{
	if ((e1 = E(f_pol)) == null) return 0;
	if ((e2 = E(f_cla)) == null) return 0;
	
	var data = this.getAllData();
	for (var i = 0; i < data.length; ++i) {
		if (data[i][tpl_tb_name_idx] == e1.value
			&& data[i][tpl_tb_class_idx] == e2.value) {
			ferror.set(e2, traffic.cla+' "'+e2.value +'" '+ errmsg.of1 + ' "'+e1.value+'" '+ errmsg.of2 + errmsg.generExist, quiet);
			return 0;
		}
	}
	ferror.clear(e2);
	return 1;
}


tc_policy.dataToView = function(data) 
{
	var v = [];
	var p = '';
	v.push(data[tpl_tb_name_idx]);
	v.push(data[tpl_tb_class_idx]);
	v.push(data[tpl_tb_gbw_idx]);
	v.push(data[tpl_tb_mbw_idx]);
	v.push( tc_prio_opts[ data[tpl_tb_prio_idx]][1]+'');

	return v;
}

	
tc_policy.verifyFields = function(row, quiet)
{
		var f = fields.getAll(row);
		ferror.clearAll(f);
		f[tpl_tb_prio_idx].disabled = true;

  	if (!v_info_word(f[tpl_tb_name_idx], quiet, false)) return 0;
  	if (!v_info_word(f[tpl_tb_class_idx], quiet, false)) return 0;
		if (!tc_policy.classNotExist(f[tpl_tb_name_idx],f[tpl_tb_class_idx],quiet)) return 0;
		if (!v_info_num_range(f[tpl_tb_gbw_idx], quiet, true, 1, 100000)) return 0;
		if (!v_info_num_range(f[tpl_tb_mbw_idx], quiet, true, 1, 100000)) return 0;	
 
  	if (f[tpl_tb_gbw_idx].value == '' 
		 	&& f[tpl_tb_mbw_idx].value == '') {
	  	ferror.set(f[tpl_tb_gbw_idx],'Guaranteed Bandwidth or Max Bandwidth at least one not empty', quiet);
	  	ferror.set(f[tpl_tb_mbw_idx],'Guaranteed Bandwidth or Max Bandwidth at least one not empty', quiet);
	  	return 0;
		}
		ferror.clear(f[tpl_tb_gbw_idx]);
		ferror.clear(f[tpl_tb_mbw_idx]);

		if (f[tpl_tb_gbw_idx].value > 0
		 	|| f[tpl_tb_mbw_idx].value > 0){
			f[tpl_tb_prio_idx].disabled = false;
		}
 	
		return 1;
}

tc_policy.onClick = function(cell) {
	
    if(this.canEdit) {
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
			return;
		}
		this.edit(cell);		
	}
        
    var f = fields.getAll(this.editor);
	f[tpl_tb_name_idx].disabled = true;
	f[tpl_tb_class_idx].disabled = true;
}

tc_policy.onDataChanged = function() {
 	verifyFields(null, 1);
}

tc_policy.setup = function()
{
	this.init('tpl-grid', ['sort'], 256,[
		{ type: 'text', maxlen: 31 },//policy name 
		{ type: 'text', maxlen: 31 },//classifier name 
		{ type: 'text', maxlen: 6 },//gbw
		{ type: 'text', maxlen: 6 },//mbw	
		{ type: 'select', options:  tc_prio_opts }//priority
	]);

	this.headerSet([ui.nam, traffic.cla,traffic.gbw,traffic.mbw, traffic.prio]);

	for(var i = 0;i < (tc_policies.length);++i){
		var tmp_tc_policy = tc_policies[i];
		if (tmp_tc_policy[tpl_tb_gbw_idx] == 0)
			tmp_tc_policy[tpl_tb_gbw_idx] = '';
		else
			tmp_tc_policy[tpl_tb_gbw_idx] = tmp_tc_policy[tpl_tb_gbw_idx].toString();
		if (tmp_tc_policy[tpl_tb_mbw_idx] == 0)
			tmp_tc_policy[tpl_tb_mbw_idx] = '';
		else
			tmp_tc_policy[tpl_tb_mbw_idx] = tmp_tc_policy[tpl_tb_mbw_idx].toString();
		tc_policy.insertData(-1,tc_policies[i]);	
	}	
			
	tc_policy.showNewEditor();
	tc_policy.resetNewEditor();
}


var tc_iface = new webGrid();
tc_iface.onDataChanged = function() {
	tc_iface.updateEditorField(0, { type: 'select', maxlen: 15, options: now_vifs_options} );	
    //alert('on data changed');    
 	verifyFields(null, 1);
}

tc_iface.onClick = function(cell) {
	var q = PR(cell);
	var data = this.getAllData();
	var thisData = data[q.rowIndex -1];
	this.updateEditorField(0, { type: 'select', maxlen: 15, options: [[thisData[tif_name_idx], thisData[tif_name_idx]]]} );
	
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

tc_iface.setup = function()
{
	this.init('tif-grid', ['sort'], now_vifs_options.length,[
		{ type: 'select', options: now_vifs_options} ,//interface
		{ type: 'text', maxlen: 6 },//ingress mbw
		{ type: 'text', maxlen: 6 },//ingress policy
		{ type: 'text', maxlen: 31 },//outgress mbw
		{ type: 'text', maxlen: 31 }//outgress policy
	]);

	this.headerSet([ui.iface, traffic.imbw,traffic.ombw,traffic.ipolicy,traffic.opolicy]);

	for(var i = 0;i < (tc_ifaces.length);++i){
		var tmp_tc_iface = [];
		tmp_tc_iface.push(tc_ifaces[i][tif_name_idx]);
		if (tc_ifaces[i][tif_ibw_idx] == 0)
			tmp_tc_iface.push('');
		else 
			tmp_tc_iface.push(tc_ifaces[i][tif_ibw_idx]);
		if (tc_ifaces[i][tif_obw_idx] == 0)
			tmp_tc_iface.push('');
		else 
			tmp_tc_iface.push(tc_ifaces[i][tif_obw_idx]);
		tmp_tc_iface.push(tc_ifaces[i][tif_ipol_idx]);
		tmp_tc_iface.push(tc_ifaces[i][tif_opol_idx]);
		tc_iface.insertData(-1,tmp_tc_iface);
		grid_vif_opts_sub(now_vifs_options, tc_ifaces[i][tif_name_idx]);
	}	
			
	tc_iface.showNewEditor();
	tc_iface.resetNewEditor();
	tc_iface.updateEditorField(0, { type: 'select', maxlen: 15, options: now_vifs_options} );	
}

tc_iface.verifyFields = function(row, quiet)
{
	var f = fields.getAll(row);
    ferror.clearAll(f);

	if (!v_info_num_range(f[tif_ibw_idx], quiet, true, 1, 100000)) return 0;
	if (!v_info_num_range(f[tif_obw_idx], quiet, true, 1, 100000)) return 0;
	grid_vif_opts_sub(now_vifs_options, f[tif_name_idx].value);
	return 1;
}

tc_iface.verifyDelete = function(data) {
	grid_vif_opts_add(now_vifs_options, data[tif_name_idx]);
	return true;
}


function classVerifyFields(focused, quiet)
{
	var ret = "";
	var data = tc_class.getAllData();
	var matched = false;
	var class_entered = false;
	var i,j;
	
	//delete
	for (i = 0; i < tc_classes.length; i++){
		matched = false;
		for (j =0; j < data.length; j++){
			if (tc_classes[i][tcl_name_idx]
				== data[j][tcl_tb_name_idx]){
				matched = true;
				break;
			}
		}
		if (!matched)
			ret += "!\n"+"no traffic classifier "+tc_classes[i][tcl_name_idx]+"\n";
	}

	for (j =0; j < data.length; j++){
		matched = false;
		for (i = 0; i < tc_classes.length; i++){
			if (tc_classes[i][tcl_name_idx]
				== data[j][tcl_tb_name_idx]){
				matched = true;
				break;
			}
		}
		
		if (!matched){	//add
			ret += "!\n"+"traffic classifier "+data[j][tcl_tb_name_idx]+"\n";
			if (data[j][tcl_tb_any_idx]){
				ret += "match any"+"\n";
				continue;
			}
			if (data[j][tcl_tb_srcip_idx] != ""){
				ret += "match source "+data[j][tcl_tb_srcip_idx]+" "+data[j][tcl_tb_srcmask_idx]+"\n";
			}
			if (data[j][tcl_tb_dstip_idx] != ""){
				ret += "match destination "+data[j][tcl_tb_dstip_idx]+" "+data[j][tcl_tb_dstmask_idx]+"\n";
			}
			for (var p = 0; p < tc_protocols.length; p++){
				if (data[j][p + tcl_tb_proto_idx]){
					ret += "match protocol "+tc_protocols[p]+"\n";
				}
			}
		}else{	//modify
			class_entered = false;
			if (tc_classes[i][tcl_any_idx] != data[j][tcl_tb_any_idx]){
				if (!class_entered)
					ret += "!\n"+"traffic classifier "+data[j][tcl_tb_name_idx]+"\n";
				ret += (data[j][tcl_tb_any_idx]?"":"no ")+"match any" + "\n";
			}
			if ((tc_classes[i][tcl_src_idx][0] != data[j][tcl_tb_srcip_idx])
				|| (tc_classes[i][tcl_src_idx][1] != data[j][tcl_tb_srcmask_idx])){
				if (!class_entered)
					ret += "!\n"+"traffic classifier "+data[j][tcl_tb_name_idx]+"\n";
				if (data[j][tcl_tb_srcip_idx] == ""){
					ret += "no match source"+"\n";
				}else{
					ret += "match source "+data[j][tcl_tb_srcip_idx]+" "+data[j][tcl_tb_srcmask_idx]+"\n";
				}
			}
			if ((tc_classes[i][tcl_dst_idx][0] != data[j][tcl_tb_dstip_idx])
				|| (tc_classes[i][tcl_dst_idx][1] != data[j][tcl_tb_dstmask_idx])){
				if (!class_entered)
					ret += "!\n"+"traffic classifier "+data[j][tcl_tb_name_idx]+"\n";
				if (data[j][tcl_tb_dstip_idx] == ""){
					ret += "no match destination"+"\n";
				}else{
					ret += "match destination "+data[j][tcl_tb_dstip_idx]+" "+data[j][tcl_tb_dstmask_idx]+"\n";
				}
			}
			//alert( tc_protocols.length);
			for (var p = 0; p < tc_protocols.length; p++){
				//alert(tc_protocols[p]+":"+data[j][p + tcl_tb_proto_idx]);
				if (data[j][p + tcl_tb_proto_idx]
					&& !proto_matched(tc_protocols[p],tc_classes[i][tcl_proto_idx])){
					if (!class_entered)
						ret += "!\n"+"traffic classifier "+data[j][tcl_tb_name_idx]+"\n";
					ret += "match protocol "+tc_protocols[p]+"\n";
				}else if (!data[j][p + tcl_tb_proto_idx]
					&& proto_matched(tc_protocols[p],tc_classes[i][tcl_proto_idx])){
					if (!class_entered)
						ret += "!\n"+"traffic classifier "+data[j][tcl_tb_name_idx]+"\n";
					ret += "no match protocol "+tc_protocols[p]+"\n";
				}				
			}			
		}
	}
	//alert(ret);
	return ret;
}


function policyVerifyFields(focused, quiet)
{
	var ret = "";
	var data = tc_policy.getAllData();
	var matched = false;
	var i, j;

	//delete
	for (i = 0; i < tc_policies.length; i++){
		matched = false;
		for (j = 0; j < data.length; j++){
			if (tc_policies[i][tpl_name_idx] == data[j][tpl_tb_name_idx]
				&& tc_policies[i][tpl_class_idx] == data[j][tpl_tb_class_idx]){
				matched = true;
				break;
			}		
		}
		if (!matched){			
			ret += "!\n"+"traffic policy "+tc_policies[i][tpl_name_idx]+"\n";
			ret += "no classifier "+tc_policies[i][tpl_class_idx]+"\n";
		}		
	}
	for (j = 0; j < data.length; j++){
		matched = false;
		for (i = 0; i < tc_policies.length; i++){
			if (tc_policies[i][tpl_name_idx] == data[j][tpl_tb_name_idx]
				&& tc_policies[i][tpl_class_idx] == data[j][tpl_tb_class_idx]){
				matched = true;
				break;
			}	
		}
		if (!matched){//add
			ret += "!\n"+"traffic policy "+data[j][tpl_tb_name_idx]+"\n";
			ret += "classifier "+data[j][tpl_tb_class_idx]+" "
					+(data[j][tpl_tb_gbw_idx]!= ""?"gbw "+data[j][tpl_tb_gbw_idx]+" ":"")
					+(data[j][tpl_tb_mbw_idx]!= ""?"mbw "+data[j][tpl_tb_mbw_idx]+" ":"")
					+(data[j][tpl_tb_prio_idx] > 0?"priority "+tc_prio_opts[data[j][tpl_tb_prio_idx]][1]+" ":"")+"\n";
		}else{
			if (tc_policies[i][tpl_gbw_idx] != data[j][tpl_tb_gbw_idx]
				|| tc_policies[i][tpl_mbw_idx] != data[j][tpl_tb_mbw_idx]
				|| tc_policies[i][tpl_prio_idx] != data[j][tpl_tb_prio_idx]){//modify
				ret += "!\n"+"traffic policy "+data[j][tpl_tb_name_idx]+"\n";
				ret += "classifier "+data[j][tpl_tb_class_idx]+" "
						+(data[j][tpl_tb_gbw_idx]!= ""?"gbw "+data[j][tpl_tb_gbw_idx]+" ":"")
						+(data[j][tpl_tb_mbw_idx]!= ""?"mbw "+data[j][tpl_tb_mbw_idx]+" ":"")
						+(data[j][tpl_tb_prio_idx] > 0?"priority "+tc_prio_opts[data[j][tpl_tb_prio_idx]][1]+" ":"")+"\n";
			}
		}
	}
	
	//alert(ret);
	return ret;
}

function applyVerifyFields(focused, quiet)
{
	var ret = "";
	var data = tc_iface.getAllData();
	var matched = false;
	var iface_entered = false;
	var i, j;

	//delete
	for (i = 0; i < tc_ifaces.length; i++){
		matched = false;
		for (j = 0; j < data.length; j++){
			if (data[j][0] == tc_ifaces[i][tif_name_idx]){
				matched = true;
				break;
			}
		}
		if (!matched){
			ret += "!\n"+"interface "+tc_ifaces[i][tif_name_idx]+"\n";
			if (tc_ifaces[i][tif_ibw_idx])
				ret += "no max-bandwidth inbound" + "\n";
			if (tc_ifaces[i][tif_obw_idx])
				ret += "no max-bandwidth outbound" + "\n";
			if (tc_ifaces[i][tif_ipol_idx])
				ret += "no traffic apply policy inbound" + "\n";
			if (tc_ifaces[i][tif_opol_idx])
				ret += "no traffic apply policy outbound" + "\n";
		}
	}
	
	for (j = 0; j < data.length; j++){
		matched = false;
		for (i = 0; i < tc_ifaces.length; i++){
			if (data[j][0] == tc_ifaces[i][tif_name_idx]){
				matched = true;
				break;
			}
		}
		if (!matched){//add
			ret += "!\n"+"interface "+data[j][0]+"\n";
			if (data[j][1])
				ret += "max-bandwidth "+data[j][1]+" inbound" + "\n";
			if (data[j][2])
				ret += "max-bandwidth "+data[j][2]+" outbound" + "\n";
			if (data[j][3])
				ret += "traffic apply policy "+data[j][3]+" inbound" + "\n";
			if (data[j][4])
				ret += "traffic apply policy "+data[j][4]+" outbound" + "\n";
		}else{
			iface_entered = false;
			if ((data[j][1] == "" && tc_ifaces[i][tif_ibw_idx])
				|| (data[j][1] != "" && (tc_ifaces[i][tif_ibw_idx] != data[j][1]))){
				if (!iface_entered){
					ret += "!\n"+"interface "+data[j][0]+"\n";
					iface_entered = true;
				}
				if (data[j][1] == "" && tc_ifaces[i][tif_ibw_idx])
					ret += "no max-bandwidth inbound" + "\n";
				else 
					ret += "max-bandwidth "+data[j][1]+" inbound" + "\n";
			}
			if ((data[j][2] == "" && tc_ifaces[i][tif_obw_idx])
				|| (data[j][2] != "" && (tc_ifaces[i][tif_obw_idx] != data[j][2]))){
				if (!iface_entered){
					ret += "!\n"+"interface "+data[j][0]+"\n";
					iface_entered = true;
				}
				if (data[j][2] == "" && tc_ifaces[i][tif_obw_idx])
					ret += "no max-bandwidth outbound" + "\n";
				else 
					ret += "max-bandwidth "+data[j][2]+" outbound" + "\n";
			}
			if ((data[j][3] == '' && tc_ifaces[i][tif_ipol_idx] != '')
				|| (data[j][3] != '' && (tc_ifaces[i][tif_ipol_idx] != data[j][3]))){
				if (!iface_entered){
					ret += "!\n"+"interface "+data[j][0]+"\n";
					iface_entered = true;
				}
				if (data[j][3] == '' && tc_ifaces[i][tif_ipol_idx])
						ret += "no traffic apply policy inbound" + "\n";
				else 
					ret += "traffic apply policy "+data[j][3]+" inbound" + "\n";
			}
			if ((data[j][4] == '' && tc_ifaces[i][tif_opol_idx] != '')
				|| (data[j][4] != '' && (tc_ifaces[i][tif_opol_idx] != data[j][4]))){
				if (!iface_entered){
					ret += "!\n"+"interface "+data[j][0]+"\n";
					iface_entered = true;
				}
				if (data[j][4] == '' && tc_ifaces[i][tif_opol_idx])
						ret += "no traffic apply policy outbound" + "\n";
				else 
					ret += "traffic apply policy "+data[j][4]+" outbound" + "\n";
			}			
		}
	}
	
	return ret;	
}
function verifyFields(focused, quiet)
{
	var ok = 1;

	var cmd = "";
	var fom = E('_fom');
	var view_flag = 1;

	E('save-button').disabled = true; 
	
	cmd += classVerifyFields(focused, quiet);
	cmd += policyVerifyFields(focused, quiet);
	cmd += applyVerifyFields(focused, quiet);
	//alert(cmd);
	if (user_info.priv < admin_priv) {
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
	//mac_static.recolor();
	//mac_static.resetNewEditor();
}

function earlyInit()
{
	tc_class.setup();
	tc_policy.setup();
	tc_iface.setup();
	verifyFields(null, 1);
}
</script>
</head>
<body onload='init()'>
<form id='_fom' method='post' action='apply.cgi'>
<input type='hidden' name='_web_cmd' value=''>


<div class='section-title'><script type='text/javascript'>GetText(traffic.cla);</script></div>
<div class='section'>	<table class='web-grid' cellspacing=1 id='tcl-grid'></table></div>
<div class='section-title'><script type='text/javascript'>GetText(traffic.pol);</script></div>
<div class='section'>	<table class='web-grid' cellspacing=1 id='tpl-grid'></table></div>
<div class='section-title'><script type='text/javascript'>GetText(traffic.app);</script></div>
<div class='section'>	<table class='web-grid' cellspacing=1 id='tif-grid'></table></div>

<script type='text/javascript'>
init();
if(cookie.get('autosave') == 1)
	ui.aply=ui.aply_save;
genStdFooter("");
</script>
</form>
<script type='text/javascript'>earlyInit(null, 1);</script>
</body>
</html>
