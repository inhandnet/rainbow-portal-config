<% pagehead(menu.setup_mgmt_service) %>

<style type='text/css'>
#http-grid {
	text-align: center;
	width: 240px;
}
#http-grid .co1 {
	width: 120px;
}
#http-grid .co2 {
	width: 120px;
}

#https-grid {
	text-align: center;
	width: 240px;
}
#https-grid .co1 {
	width: 120px;
}
#https-grid .co2 {
	width: 120px;
}

#telnet-grid {
	text-align: center;
	width: 240px;
}
#telnet-grid .co1 {
	width: 120px;
}
#telnet-grid .co2 {
	width: 120px;
}

#ssh-grid {
	text-align: center;
	width: 240px;
}
#ssh-grid .co1 {
	width: 120px;
}
#ssh-grid .co2 {
	width: 120px;
}

</style>
<script type='text/javascript'>

<% ih_sysinfo() %>
<% ih_user_info(); %>

var sshd_config = { 
	enable: 1,
	mode: 0,
	length: 1024,
	retries: 1,
	timeout: 20
};

<% web_exec('show running-config web') %>
<% web_exec('show running-config telnet') %>
<% web_exec('show running-config ssh-server') %>
<% web_exec('show running-config ftp-server') %>
<% web_exec('show running-config access-list') %>

var options_status = [[0,'generate'],[1,'zeroize']];
//var options_length = [[0,'512'],[1,'1024'],[2,'2048'],[3,'4096']];
var options_length = [[0,'512'],[1,'1024']];
var options_mode = [[0,'RSA']];

var options_http = new Array();
for (var i = 0; i < 10; i++) {
	options_http[i] = new Array();
}

var options_https = new Array();
for (var i = 0; i < 10; i++) {
	options_https[i] = new Array();
}

var options_telnet = new Array();
for (var i = 0; i < 10; i++) {
	options_telnet[i] = new Array();
}

var options_ssh = new Array();
for (var i = 0; i < 10; i++) {
	options_ssh[i] = new Array();
}

var http_flag = 0;
var https_flag = 0;
var telnet_flag = 0;
var ssh_flag = 0;

var http_rule_num = 0;
var https_rule_num = 0;
var telnet_rule_num = 0;
var ssh_rule_num = 0;

for (var i = 0; i < acl_config.length; i++) {
	if (acl_config[i][3][3] == http_config.port && acl_config[i][2][0] != "any")
		options_http[http_rule_num++] = acl_config[i][2];
	else if (acl_config[i][3][3] == https_config.port && acl_config[i][2][0] != "any") 
		options_https[https_rule_num++] = acl_config[i][2];
	else if (acl_config[i][3][3] == telnetd_config.port && acl_config[i][2][0] != "any") 
		options_telnet[telnet_rule_num++] = acl_config[i][2];
	else if (acl_config[i][3][3] == sshd_config.port && acl_config[i][2][0] != "any") 
		options_ssh[ssh_rule_num++] = acl_config[i][2];
}

var key_length;
switch(sshd_config.length){
	case 512: key_length = 0; break;
	case 1024: key_length = 1;break;
//	case 2048: key_length = 2;break;
//	case 4096: key_length = 3;break;
	default : key_length = 1;break;
}

function isDigit(str)
{ 
  var reg = /^\d*$/; 

  return reg.test(str); 
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

//----------- HTTP ACL --------------
var http = new webGrid();

function display_disable_http(e)
{	
	var x = e?"":"none";

	E('http-grid').style.display = x;
	E('http-grid').disabled = !e;

	return 1;
}

http.onDataChanged = function() {
	verifyFields(null, 1);
}

http.verifyFields = function(row, quiet) 
{
	var f = fields.getAll(row);
	ferror.clearAll(f);

	if(!v_ip(f[0],quiet)) 
		return 0;

	if (!v_info_wildcard(f[1], quiet, true)) 
		return 0;

	return 1;
}

http.dataToView = function(data) 
{	
	return [data[0], data[1]];   
}

http.fieldValuesToData = function(row) 
{
	var f = fields.getAll(row);
	return [f[0].value, f[1].value];
}

http.resetNewEditor = function() {
	var f, c;

	f = fields.getAll(this.newEditor);
	ferror.clearAll(f);
	
	f[0].value = '';
	f[1].value = '';
}

http.setup = function() {
	this.init('http-grid', 'move', 128, [
		{ type: 'text', maxlen: 15 },
		{ type: 'text', maxlen: 15 } 
	]);

	//this.headerSet([ui.access_enable, ui.allowed_addr, ui.addr_wildcard]);
	this.headerSet([ui.svr_acl_source, ui.svr_acl_netmask]);
    
	for (var i = 0; i < http_rule_num; ++i) {
		this.insertData(-1, [options_http[i][0], options_http[i][1]]);
	}

	this.showNewEditor();
	this.resetNewEditor();
}

//----------- HTTPS ACL --------------
var https = new webGrid();

function display_disable_https(e)
{	
	var x = e?"":"none";

	E('https-grid').style.display = x;
	E('https-grid').disabled = !e;

	return 1;
}

https.onDataChanged = function() {
	verifyFields(null, 1);
}

https.verifyFields = function(row, quiet) 
{
	var f = fields.getAll(row);
	ferror.clearAll(f);

	if(!v_ip(f[0],quiet)) 
		return 0;

	if (!v_info_wildcard(f[1], quiet, true)) 
		return 0;

	return 1;
}

https.dataToView = function(data) 
{	
	return [data[0], data[1]];   
}

https.fieldValuesToData = function(row) 
{
	var f = fields.getAll(row);
	return [f[0].value, f[1].value];
}

https.resetNewEditor = function() {
	var f, c;

	f = fields.getAll(this.newEditor);
	ferror.clearAll(f);
	
	f[0].value = '';
	f[1].value = '';
}

https.setup = function() {
	this.init('https-grid', 'move', 128, [
		{ type: 'text', maxlen: 15 },
		{ type: 'text', maxlen: 15 } 
	]);

	this.headerSet([ui.svr_acl_source, ui.svr_acl_netmask]);
    
	for (var i = 0; i < https_rule_num; ++i) {
		this.insertData(-1, [options_https[i][0], options_https[i][1]]);
	}

	this.showNewEditor();
	this.resetNewEditor();
}

//----------- TELNET ACL --------------
var telnet = new webGrid();

function display_disable_telnet(e)
{	
	var x = e?"":"none";

	E('telnet-grid').style.display = x;
	E('telnet-grid').disabled = !e;

	return 1;
}

telnet.onDataChanged = function() {
	verifyFields(null, 1);
}

telnet.verifyFields = function(row, quiet) 
{
	var f = fields.getAll(row);
	ferror.clearAll(f);

	if(!v_ip(f[0],quiet)) 
		return 0;

	if (!v_info_wildcard(f[1], quiet, true)) 
		return 0;

	return 1;
}

telnet.dataToView = function(data) 
{	
	return [data[0], data[1]];   
}

telnet.fieldValuesToData = function(row) 
{
	var f = fields.getAll(row);
	return [f[0].value, f[1].value];
}

telnet.resetNewEditor = function() {
	var f, c;

	f = fields.getAll(this.newEditor);
	ferror.clearAll(f);
	
	f[0].value = '';
	f[1].value = '';
}

telnet.setup = function() {
	this.init('telnet-grid', 'move', 128, [
		{ type: 'text', maxlen: 15 },
		{ type: 'text', maxlen: 15 } 
	]);

	this.headerSet([ui.svr_acl_source, ui.svr_acl_netmask]);
    
	for (var i = 0; i < telnet_rule_num; ++i) {
		this.insertData(-1, [options_telnet[i][0], options_telnet[i][1]]);
	}

	this.showNewEditor();
	this.resetNewEditor();
}

//----------- SSH ACL --------------
var ssh = new webGrid();

function display_disable_ssh(e)
{	
	var x = e?"":"none";

	E('ssh-grid').style.display = x;
	E('ssh-grid').disabled = !e;

	return 1;
}

ssh.onDataChanged = function() {
	verifyFields(null, 1);
}

ssh.verifyFields = function(row, quiet) 
{
	var f = fields.getAll(row);
	ferror.clearAll(f);

	if(!v_ip(f[0],quiet)) 
		return 0;

	if (!v_info_wildcard(f[1], quiet, true)) 
		return 0;

	return 1;
}

ssh.dataToView = function(data) 
{	
	return [data[0], data[1]];   
}

ssh.fieldValuesToData = function(row) 
{
	var f = fields.getAll(row);
	return [f[0].value, f[1].value];
}

ssh.resetNewEditor = function() 
{
	var f, c;

	f = fields.getAll(this.newEditor);
	ferror.clearAll(f);
	
	f[0].value = '';
	f[1].value = '';
}

ssh.setup = function() {
	this.init('ssh-grid', 'move', 128, [
		{ type: 'text', maxlen: 15 },
		{ type: 'text', maxlen: 15 } 
	]);

	this.headerSet([ui.svr_acl_source, ui.svr_acl_netmask]);
    
	for (var i = 0; i < ssh_rule_num; ++i) {
		this.insertData(-1, [options_ssh[i][0], options_ssh[i][1]]);
	}

	this.showNewEditor();
	this.resetNewEditor();
}

function verifyFields(focused, quiet)
{
	var a;
	var ok = 1;
	var view_flag = 1;
	var cmd = "";
	var fom = E('_fom');
	var cfg_changed = 0;
	var dup_prt = 0;

	var http_acl_enable = 0;
	var https_acl_enable = 0;
	var telnet_acl_enable = 0;
	var ssh_acl_enable = 0;

	var services_acl_num = 0;
	
	E('save-button').disabled = true;

	if (ih_sysinfo.oem_name == 'global-ge') {
		var http_data = http.getAllData();
		if(http_data.length >= 5) {
			http.disableNewEditor(true);
		} else {
			http.disableNewEditor(false);
		}

		var https_data = https.getAllData();
		if(https_data.length >= 5) {
			https.disableNewEditor(true);
		} else {
			https.disableNewEditor(false);
		}

		var telnet_data = telnet.getAllData();
		if(telnet_data.length >= 5) {
			telnet.disableNewEditor(true);
		} else {
			telnet.disableNewEditor(false);
		}

		var ssh_data = ssh.getAllData();
		if(ssh_data.length >= 5) {
			ssh.disableNewEditor(true);
		} else {
			ssh.disableNewEditor(false);
		}
	}

	E('_f_http_port').disabled = true;
	if (ih_sysinfo.oem_name == 'global-ge') {
		E('_f_http_acl').disabled = true;
		display_disable_http(0);
	} 
	if (E('_f_http_enable').checked == 1) {
		E('_f_http_port').disabled = false;
		if (ih_sysinfo.oem_name == 'global-ge') {
			E('_f_http_acl').disabled = false;
			if (E('_f_http_acl').checked == 1)
				display_disable_http(1);
			} 
	}

	E('_f_https_port').disabled = true;
	if (ih_sysinfo.oem_name == 'global-ge') {
		E('_f_https_acl').disabled = true;
		display_disable_https(0);
	} 
	if (E('_f_https_enable').checked == 1) {
		E('_f_https_port').disabled = false;	
		if (ih_sysinfo.oem_name == 'global-ge') {
			E('_f_https_acl').disabled = false;
			if (E('_f_https_acl').checked == 1)
				display_disable_https(1);
		} 
	}

	E('_f_telnet_port').disabled = true;
	if (ih_sysinfo.oem_name == 'global-ge') {
		E('_f_telnet_acl').disabled = true;
		display_disable_telnet(0);
	}
	if (E('_f_telnet_enable').checked == 1) {
		E('_f_telnet_port').disabled = false;
		if (ih_sysinfo.oem_name == 'global-ge') {
			E('_f_telnet_acl').disabled = false;
			if (E('_f_telnet_acl').checked == 1)
				display_disable_telnet(1);
		} 
	}

	if (ih_sysinfo.oem_name == 'global-ge')
		display_disable_ssh(0);
	if ((E('_f_ssh_status').checked == 0)){
		E('_f_key_length').value = key_length;
		E('_f_key_length').disabled = true;
		E('_f_key_mode').disabled = true;
		E('_f_timeout').disabled = true;		
		E('_f_ssh_port').disabled = true;
		if (ih_sysinfo.oem_name == 'global-ge')
			E('_f_ssh_acl').disabled = true;
	}else{
		E('_f_ssh_port').disabled = false;
		E('_f_key_length').disabled = false;
		E('_f_key_mode').disabled = false;
		E('_f_timeout').disabled = false;
		if (ih_sysinfo.oem_name == 'global-ge') {
			E('_f_ssh_acl').disabled = false;
			if (E('_f_ssh_acl').checked == 1)
				display_disable_ssh(1);
		}
	}


	////////////http verify//////////////////////////////////////////////////////
	if (E('_f_http_enable').checked == 1){
		if (!v_f_number(E('_f_http_port'), quiet, false, 1, 65535)) return 0;
	}	
	//////////////////////////////////////////////////////////////////////////

	////////////https verify//////////////////////////////////////////////////////
	if (E('_f_https_enable').checked == 1){
		if (!v_f_number(E('_f_https_port'), quiet, false, 1, 65535)) return 0;
	}	
	//////////////////////////////////////////////////////////////////////////

	////////////telnet verify//////////////////////////////////////////////////////
	if (E('_f_telnet_enable').checked == 1){
		if (!v_f_number(E('_f_telnet_port'), quiet, false, 1, 65535)) return 0;
	}	
	//////////////////////////////////////////////////////////////////////////

/*
	if((E('_f_recertification').value < 1)||(E('_f_recertification').value > 5)
		||(!isDigit(E('_f_recertification').value))){
		ferror.set(E('_f_recertification'), errmsg.ssh_retries, quiet);
		return 0;
	}else{
		ferror.clear(E('_f_recertification'));
	}
*/
	//////////// ssh verify//////////////////////////////////////////////////////
	if (E('_f_ssh_status').checked == 1){
		if (!v_f_number(E('_f_ssh_port'), quiet, false, 1, 65535)) return 0;
		if (!v_f_number(E('_f_timeout'), quiet, false, 0, 120)) return 0;
	}	
	//////////////////////////////////////////////////////////////////////////


	/////////// port verify ///////////////////////////////////////////////////////
	ferror.clear(E('_f_http_port'));
	ferror.clear(E('_f_https_port'));
	ferror.clear(E('_f_telnet_port'));
	ferror.clear(E('_f_ssh_port'));
	if (E('_f_http_enable').checked == 1){
		if (E('_f_https_enable').checked == 1){
			if (E('_f_http_port').value == E('_f_https_port').value){
				ferror.set(E('_f_http_port'), errmsg.bad_prt, quiet);
				ferror.set(E('_f_https_port'), errmsg.bad_prt, quiet);
				dup_prt = 1;
			}
		}
		if (E('_f_telnet_enable').checked == 1){
			if (E('_f_http_port').value == E('_f_telnet_port').value){
				ferror.set(E('_f_http_port'), errmsg.bad_prt, quiet);
				ferror.set(E('_f_telnet_port'), errmsg.bad_prt, quiet);
				dup_prt = 1;
			}
		}
		if (E('_f_ssh_status').checked == 1){
			if (E('_f_http_port').value == E('_f_ssh_port').value){
				ferror.set(E('_f_http_port'), errmsg.bad_prt, quiet);
				ferror.set(E('_f_ssh_port'), errmsg.bad_prt, quiet);
				dup_prt = 1;
			}
		}		
	}
	if (E('_f_https_enable').checked == 1){
		if (E('_f_telnet_enable').checked == 1){
			if (E('_f_https_port').value == E('_f_telnet_port').value){
				ferror.set(E('_f_https_port'), errmsg.bad_prt, quiet);
				ferror.set(E('_f_telnet_port'), errmsg.bad_prt, quiet);
				dup_prt = 1;
			}
		}
		if (E('_f_ssh_status').checked == 1){
			if (E('_f_https_port').value == E('_f_ssh_port').value){
				ferror.set(E('_f_https_port'), errmsg.bad_prt, quiet);
				ferror.set(E('_f_ssh_port'), errmsg.bad_prt, quiet);
				dup_prt = 1;
			}
		}		
	}
	if (E('_f_telnet_enable').checked == 1){
		if (E('_f_ssh_status').checked == 1){
			if (E('_f_telnet_port').value == E('_f_ssh_port').value){
				ferror.set(E('_f_telnet_port'), errmsg.bad_prt, quiet);
				ferror.set(E('_f_ssh_port'), errmsg.bad_prt, quiet);
				dup_prt = 1;
			}
		}		
	}	
	if (dup_prt)
		return 0;
	/////////////////////////////////////////////////////////////////////////

	////////////generate telnet CMD//////////////////////////////////////////////////////
	if (E('_f_telnet_enable').checked != telnetd_config.enable 
			|| E('_f_telnet_port').value!= telnetd_config.port){
		cmd += "!\n" + ((E('_f_telnet_enable').checked)?(""):("no ")) + "ip telnet server"
			+ ((E('_f_telnet_enable').checked)?(" port " + E('_f_telnet_port').value):("")) +"\n";
	}	

	if (ih_sysinfo.oem_name == 'global-ge') {
		if (E('_f_telnet_enable').checked && E('_f_telnet_acl').checked) {
			telnet_acl_enable = 1;
		}
	}
	
	//////////////////////////////////////////////////////////////////////////	


	////////////generate SSH CMD//////////////////////////////////////////////////////
	if ((E('_f_ssh_status').checked != sshd_config.enable)
		|| (E('_f_ssh_port').value!= sshd_config.port)
		|| (E('_f_timeout').value != sshd_config.timeout)
		|| (E('_f_key_mode').value != sshd_config.mode)
		|| (E('_f_key_length').value != key_length)){

		cmd += "!\n";
		if (E('_f_ssh_status').checked == false){
			cmd += "no ip ssh server\n";
		}else{//ssh enabled
			if(E('_f_timeout').value != sshd_config.timeout){
				if(E('_f_timeout').value != ''){
					cmd += "ip ssh timeout " + E('_f_timeout').value + "\n";
				}else{
					cmd += "no ip ssh timeout" + "\n";
				}
			}
			if (E('_f_key_length').value != key_length
				|| E('_f_key_mode').value != sshd_config.mode){
				cmd += "crypto ssh-key zeroize " + ["rsa"][E('_f_key_mode').value] 
					+ ((E('_f_ssh_status').checked)?(" modulus " + options_length[E('_f_key_length').value][1]):(""))  + "\n";				
				cmd += "crypto ssh-key generate " + ["rsa"][E('_f_key_mode').value] 
					+ ((E('_f_ssh_status').checked)?(" modulus " + options_length[E('_f_key_length').value][1]):(""))  + "\n";
			}
			if ((E('_f_ssh_status').checked != sshd_config.enable)
				|| (E('_f_ssh_port').value!= sshd_config.port))
				cmd += "ip ssh server port " + E('_f_ssh_port').value + "\n";
		}
	}

	if (ih_sysinfo.oem_name == 'global-ge') {
		if (E('_f_ssh_status').checked && E('_f_ssh_acl').checked) {
			ssh_acl_enable = 1;
		}
	}
	//////////////////////////////////////////////////////////////////////////	


	////////////generate http CMD//////////////////////////////////////////////////////
	if (E('_f_http_enable').checked != http_config.enable 
			|| E('_f_http_port').value!= http_config.port){
		cmd += "!\n" + ((E('_f_http_enable').checked)?(""):("no ")) + "ip http server"
			+ ((E('_f_http_enable').checked)?(" port " + E('_f_http_port').value):("")) +"\n";
	}	

	if (ih_sysinfo.oem_name == 'global-ge') {
		if (E('_f_http_enable').checked && E('_f_http_acl').checked) {
			http_acl_enable = 1;
		}
	}
	//////////////////////////////////////////////////////////////////////////


	////////////generate https CMD//////////////////////////////////////////////////////
	if (E('_f_https_enable').checked != https_config.enable 
			|| E('_f_https_port').value!= https_config.port){
		cmd += "!\n" + ((E('_f_https_enable').checked)?(""):("no ")) + "ip https server"
			+ ((E('_f_https_enable').checked)?(" port " + E('_f_https_port').value):("")) +"\n";

	}	

	if (ih_sysinfo.oem_name == 'global-ge') {
		if (E('_f_https_enable').checked && E('_f_https_acl').checked) {
			https_acl_enable = 1;
		}
	}
	
	if (ih_sysinfo.oem_name == 'global-ge') {
		if (http_acl_enable || https_acl_enable
				|| telnet_acl_enable || ssh_acl_enable) {
			cmd += "!\n";
			cmd += "no access-list 182\n";

			if (http_acl_enable) {
				var http_acl = http.getAllData();
				cmd += "ip http access enable\n";
				for(var i = 0; i < http_acl.length; i++) {
					cmd += "access-list 182 permit tcp " + http_acl[i][0] + " " + http_acl[i][1] + " any eq " 
						+ E('_f_http_port').value + "\n"; 
					services_acl_num++;
				}
				if (http_acl.length)
					cmd += "access-list 182 deny tcp any any eq " + E('_f_http_port').value + " log\n";
				else 
					cmd += "no ip http access enable\n";
			} else {
				cmd += "no ip http access enable\n";
			}

			if (https_acl_enable) {
				var https_acl = https.getAllData();
				cmd += "ip https access enable\n";
				for(var i = 0; i < https_acl.length; i++) {
					cmd += "access-list 182 permit tcp " + https_acl[i][0] + " " + https_acl[i][1] + " any eq " 
						+ E('_f_https_port').value + " log\n"; 
					services_acl_num++;
				}
				if (https_acl.length)
					cmd += "access-list 182 deny tcp any any eq " + E('_f_https_port').value + " log\n";
				else 
					cmd += "no ip https access enable\n";
			} else {
				cmd += "no ip https access enable\n";
			}

			if (telnet_acl_enable) {
				var telnet_acl = telnet.getAllData();
				cmd += "ip telnet access enable\n";
				for(var i = 0; i < telnet_acl.length; i++) {
					cmd += "access-list 182 permit tcp " + telnet_acl[i][0] + " " + telnet_acl[i][1] + " any eq " 
						+ E('_f_telnet_port').value + " log\n"; 
					services_acl_num++;
				}
				if (telnet_acl.length)
					cmd += "access-list 182 deny tcp any any eq " + E('_f_telnet_port').value + "\n";
				else 
					cmd += "no ip telnet access enable\n";
			} else {
				cmd += "no ip telnet access enable\n";
			}

			if (ssh_acl_enable) {
				var ssh_acl = ssh.getAllData();
				cmd += "ip ssh access enable\n";
				for(var i = 0; i < ssh_acl.length; i++) {
					cmd += "access-list 182 permit tcp " + ssh_acl[i][0] + " " + ssh_acl[i][1] + " any eq " 
						+ E('_f_ssh_port').value + " log\n"; 
					services_acl_num++;
				}
				if (ssh_acl.length)
					cmd += "access-list 182 deny tcp any any eq " + E('_f_ssh_port').value + " log\n";
				else 
					cmd += "no ip ssh access enable\n";
			} else {
				cmd += "no ip ssh access enable\n";
			}
			
			if (services_acl_num++) {
				cmd += "!\n";
				cmd += "interface cellular 1\n";
				cmd += "ip access-group 182 admin\n";
				cmd += "!\n";
			}
		} else {
			cmd += "!\n";
			cmd += "no access-list 182\n";
			cmd += "no ip http access enable\n";
			cmd += "no ip https access enable\n";
			cmd += "no ip telnet access enable\n";
			cmd += "no ip ssh access enable\n";
			cmd += "interface cellular 1\n";
			cmd += "no ip access-group 182 admin\n";
			cmd += "!\n";
		}
	}

	//////////////////////////////////////////////////////////////////////////	

	/*
	//retries
	if(E('_f_recertification').value != sshd_config.retries){
		if(view_flag){
			cmd += "!" + "\n";
			view_flag = 0;
		}
		if(E('_f_recertification').value != ''){
			cmd += "ip ssh authentication-retries " + E('_f_recertification').value + "\n";
		}else{
			cmd += "no ip ssh authentication-retries" + "\n";
		}

	}
	*/
	
	if (<%ih_license('ip8')%>){
		////////////generate ftp CMD//////////////////////////////////////////////////////
		if (E('_f_ftp_enable').checked != vsftpd_config.enable){ 
			//	|| E('_f_http_port').value!= http_config.port){
			cmd += "!\n" + ((E('_f_ftp_enable').checked)?(""):("no ")) + "ip ftp server"+"\n";
			//	+ ((E('_f_http_enable').checked)?(" port " + E('_f_http_port').value):("")) +"\n";
		}	
	}
	//alert(cmd);
	if (user_info.priv < admin_priv) {
		elem.display('save-button', 'cancel-button', false);
	}else{
		elem.display('save-button', 'cancel-button', true);
		fom._web_cmd.value = cmd;
		//E('save-button').disabled = (!cfg_changed);	
		E('save-button').disabled = (cmd == '');
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
		
	//alert(E('_fom')._web_cmd.value);
	form.submit('_fom', 1);
}

function earlyInit()
{
	if (ih_sysinfo.oem_name == 'global-ge') {
		http.setup();
		https.setup();
		telnet.setup();
		ssh.setup();
	}
	verifyFields(null, 1);
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

<div class='section-title'><script type='text/javascript'>W("HTTP");</script></div>
<div class='section'>
<script type='text/javascript'>
if (ih_sysinfo.oem_name == 'global-ge')
	http_tb = [
		{ title: ui.enable, indent:2, name: 'f_http_enable', type: 'checkbox', value: http_config.enable==1},
		{ title: ui.prt, indent:2, name: 'f_http_port', type: 'text', maxlen:5, size: 10, value: http_config.port},
		{ title: ui.svr_acl_enable, indent:2, name: 'f_http_acl', type: 'checkbox', value: http_config.acl_enable==1}
	];
else 
	http_tb = [
		{ title: ui.enable, indent:2, name: 'f_http_enable', type: 'checkbox', value: http_config.enable==1},
		{ title: ui.prt, indent:2, name: 'f_http_port', type: 'text', maxlen:5, size: 10, value: http_config.port}
	];
	
createFieldTable('', http_tb);
</script>
</div>

<div id='http_body' class='section'>
	<table class='web-grid' id='http-grid'></table>
</div>

<div class='section-title'><script type='text/javascript'>W("HTTPS");</script></div>
<div class='section'>
<script type='text/javascript'>
if (ih_sysinfo.oem_name == 'global-ge')
	https_tb = [
		{ title: ui.enable, indent:2, name: 'f_https_enable', type: 'checkbox', value: https_config.enable==1},
		{ title: ui.prt, indent:2, name: 'f_https_port', type: 'text', maxlen:5, size: 10, value: https_config.port},
		{ title: ui.svr_acl_enable, indent:2, name:  'f_https_acl', type: 'checkbox', value: https_config.acl_enable==1}
	];
else 
	https_tb = [
		{ title: ui.enable, indent:2, name: 'f_https_enable', type: 'checkbox', value: https_config.enable==1},
		{ title: ui.prt, indent:2, name: 'f_https_port', type: 'text', maxlen:5, size: 10, value: https_config.port}
	];

createFieldTable('', https_tb);
</script>
</div>

<div id='https_body' class='section'>
	<table class='web-grid' id='https-grid'></table>
</div>

<div class='section-title'><script type='text/javascript'>W("TELNET");</script></div>
<div class='section'>
<script type='text/javascript'>
if (ih_sysinfo.oem_name == 'global-ge')
	telnet_tb = [
		{ title: ui.enable, indent:2, name: 'f_telnet_enable', type: 'checkbox', value: telnetd_config.enable==1},
		{ title: ui.prt, indent:2, name: 'f_telnet_port', type: 'text', maxlen:5, size: 10, value: telnetd_config.port},
		{ title: ui.svr_acl_enable, indent:2, name: 'f_telnet_acl', type: 'checkbox', value: telnetd_config.acl_enable==1}
	]; 
else 
	telnet_tb = [
		{ title: ui.enable, indent:2, name: 'f_telnet_enable', type: 'checkbox', value: telnetd_config.enable==1},
		{ title: ui.prt, indent:2, name: 'f_telnet_port', type: 'text', maxlen:5, size: 10, value: telnetd_config.port}
	]; 

createFieldTable('', telnet_tb);
</script>
</div>

<div id='telnet_body' class='section'>
	<table class='web-grid' id='telnet-grid'></table>
</div>


<div class='section-title'><script type='text/javascript'>W("SSH");</script></div>
<div class='section'>
<script type='text/javascript'>
if (ih_sysinfo.oem_name == 'global-ge')
	ssh_tb = [
		{ title: ui.enable, indent:2,name: 'f_ssh_status', type: 'checkbox', value: sshd_config.enable==1},
		{ title: ui.prt, indent:2, name: 'f_ssh_port', type: 'text', maxlen:5, size: 10, value: sshd_config.port},
		{ title: ui.timeout , indent:2,name: 'f_timeout', type: 'text', suffix: ' '+ui.seconds + '(0-120)', size: 10, value: sshd_config.timeout},
		{ title: ui.key_mode , indent:2,name: 'f_key_mode', type: 'select', size: 7, options:[[0,'RSA']], value: sshd_config.mode},
		{ title: ui.key_len , indent:2,name: 'f_key_length', type: 'select', size: 7, options: options_length, value: key_length},
		{ title: ui.svr_acl_enable, indent:2, name: 'f_ssh_acl', type: 'checkbox', value: sshd_config.acl_enable==1}
	]; 
else 
	ssh_tb = [
		{ title: ui.enable, indent:2,name: 'f_ssh_status', type: 'checkbox', value: sshd_config.enable==1},
		{ title: ui.prt, indent:2, name: 'f_ssh_port', type: 'text', maxlen:5, size: 10, value: sshd_config.port},
		{ title: ui.timeout , indent:2,name: 'f_timeout', type: 'text', suffix: ' '+ui.seconds + '(0-120)', size: 10, value: sshd_config.timeout},
		{ title: ui.key_mode , indent:2,name: 'f_key_mode', type: 'select', size: 7, options:[[0,'RSA']], value: sshd_config.mode},
		{ title: ui.key_len , indent:2,name: 'f_key_length', type: 'select', size: 7, options: options_length, value: key_length}
	]; 
createFieldTable('', ssh_tb);
</script>
</div>


<div id='ssh_body' class='section'>
	<table class='web-grid' id='ssh-grid'></table>
</div>


<div class='section-title'><script type='text/javascript'>
if (<%ih_license('ip8')%>){
	W("FTP");
}
</script></div>
<div class='section'>
<script type='text/javascript'>
if (<%ih_license('ip8')%>){
createFieldTable('', [
	{ title: ui.enable, indent:2, name: 'f_ftp_enable', type: 'checkbox', value: vsftpd_config.enable==1}
//	{ title: ui.prt, indent:2, name: 'f_telnet_port', type: 'text', maxlen:5, size: 10, value: telnetd_config.port}
	]);
}
</script>
</div>

<script type='text/javascript'>
init();
if(cookie.get('autosave') == 1)
	ui.aply=ui.aply_save;
genStdFooter("");
</script>
</form>
<script type='text/javascript'>earlyInit()</script>
</body>
</html>

