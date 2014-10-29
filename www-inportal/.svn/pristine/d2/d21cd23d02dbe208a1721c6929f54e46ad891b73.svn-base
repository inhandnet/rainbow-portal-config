<% pagehead(menu.cert_mgr) %>

<script type='text/javascript'>

<% ih_sysinfo() %>
<% ih_user_info() %>

<% web_exec('show running-config cert-enroll') %>
<% web_exec('show crypto ca certificate') %>

var operator_priv = 12;

var scep_status = '';

if (cert_status[0][0] == 2 )
	scep_status = 'Regenrate';
else if (cert_status[0][0] == 3) 
	scep_status = 'Enrolling';
else if (cert_status[0][0] == 1)
	scep_status = 'Completion';
else if (cert_status[0][0] == 4)
	scep_status = 'Re-enrolling';
else if (cert_status[0][0] == 0
		|| cert_status[0][0] == 5)
	scep_status = 'Initiation';

var scep_export_passwd = cert_config[0];
var scep_domain_json = cert_config[1];
var scep_enable_json = cert_config[2][0];
var scep_re_enroll_json = cert_config[2][1];
var scep_key_len_json = cert_config[2][2];
var scep_cn_json = cert_config[2][3][0][0];
var scep_url_json = cert_config[2][3][0][1];
var scep_fqdn_json = cert_config[2][3][0][2];
var scep_sn_json = cert_config[2][3][0][3];
var scep_challenge_passwd_json = cert_config[2][3][0][4];
var scep_ou1_json = cert_config[2][3][0][5];
var scep_ou2_json = cert_config[2][3][0][6];
var scep_tp_ip_json = cert_config[2][3][0][7];
var scep_poll_count_json = cert_config[2][3][0][8];
var scep_poll_period_json = cert_config[2][3][0][9];

function fix(name)
{
	var i;
	if (((i = name.lastIndexOf('/')) > 0) || ((i = name.lastIndexOf('\\')) > 0))
		name = name.substring(i + 1, name.length);
	return name;
}

ca_uploaded = [];

function backupButton(typ, suffix)
{
	var fom = E(typ + '_form');
	var name;	
	
	name = fix(fom.filename.value);	
	if (name.length == 0) {
		//alert(errmsg.invalid_fname);
		//return;
		name = typ;
	}
	
	location.href = name + suffix + '?type=cert_' + typ;
}

function importButton(typ, suffix)
{
    var fom = E(typ + '_form');
	var name, i;

	name = fix(fom.filename.value);	
	name = name.toLowerCase();
	
//	if((typ == 'pkcs12') && (E('_fom').f_cert_key.value.length==0)) {
//		show_alert(errmsg.pkcs12_key);
//		return;
//	}
	if ((name.length <= 4) || (name.substring(name.length - 4, name.length).toLowerCase() != suffix)) {
		alert(errmsg.invalid_fname);
		return;
	}
	if (!show_confirm(infomsg.confm)) return;
	fom.import_button.disabled = 1;
	//E(typ + '-import-button').disabled = 1;
    //form.submit(fom, 1);
   
    //cookie.set('upload_cert_' + typ, original_name);
    fom.submit();

}

function verifyFields(focused, quiet)
{
	var ok = 1;
	var i, v;
	var change = 0;
	var cmd = "";
	E('save-button').disabled = true;

	var enable = E('_f_scep_enable').checked;
	var force = E('_f_scep_force').checked;
	var url = E('_f_scep_url').value;
	var common_name = E('_f_scep_common_name').value;
	var fqdn = E('_f_scep_fqdn').value;
	var unit1 = E('_f_scep_unit1').value;
	var unit2 = E('_f_scep_unit2').value;
	var domain = E('_f_scep_domain').value;
	var serialno = E('_f_scep_serialno').value;
	var challenge = E('_f_scep_challenge').value;
	var challenge2 = E('_f_scep_challenge2').value;
	var trustpoint = E('_f_scep_unaddr').value;
	var cert_key = E('_f_cert_key').value;
	var key_len = E('_f_scep_key_len').value;
	var poll_interval = E('_f_scep_poll_interval').value; 
	var poll_timeout = E('_f_scep_poll_timeout').value; 

	elem.display_and_enable(('_f_scep_url'), 
				('_f_scep_common_name'), ('_f_scep_fqdn'), ('_f_scep_unit1'), ('_f_scep_unit2'),
				('_f_scep_domain'), ('_f_scep_serialno'), ('_f_scep_challenge'), ('_f_scep_challenge2'), 
				('_f_scep_unaddr'), ('_f_scep_key_len'), ('_f_scep_poll_interval'), ('_f_scep_poll_timeout'), 
				('_f_scep_force'), 
				enable);
	elem.display(('f_scep_status'), enable);

	if (enable){		
		elem.display_and_enable(('_f_scep_force'), enable);
		if((scep_status=='Completion') && !force ){
			elem.enable(('_f_scep_url'), 
				('_f_scep_common_name'), ('_f_scep_fqdn'), ('_f_scep_unit1'), ('_f_scep_unit2'),
				('_f_scep_domain'), ('_f_scep_serialno'), ('_f_scep_challenge'), ('_f_scep_challenge2'), 
				('_f_scep_unaddr'), ('_f_scep_key_len'), ('_f_scep_poll_interval'), ('_f_scep_poll_timeout'), 
				('_f_cert_key'), ('_f_cert_key2'),
				false);
		}else {
			elem.enable(('_f_scep_url'), 
				('_f_scep_common_name'), ('_f_scep_fqdn'), ('_f_scep_unit1'), ('_f_scep_unit2'),
				('_f_scep_domain'), ('_f_scep_serialno'), ('_f_scep_challenge'), ('_f_scep_challenge2'), 
				('_f_scep_unaddr'), ('_f_scep_key_len'), ('_f_scep_poll_interval'), ('_f_scep_poll_timeout'), 
				('_f_cert_key'), ('_f_cert_key2'),
				true);
		}
	} else {
		elem.display_and_enable(('_f_scep_force'), false);
		elem.enable('_f_cert_key', '_f_cert_key2', true);		
	}

	v = ['ca', 'crl', 'public', 'private', 'pkcs12' ];
	for (i = 0; i < v.length; i++){
		var fom = E( v[i] + '_form');
		fom.filename.disabled = fom.backup_button.disabled = enable && (scep_status!='Completion');
		fom.import_button.disabled = enable;
	}
	
	if (!v_length('_f_cert_key', quiet, (enable ? 1 : 0), 32)) {
		return 0;
	} else if (E('_f_cert_key').value.length!=0 
		&& (E('_f_cert_key').value.length != E('_f_cert_key2').value.length)){
			ferror.set('_f_cert_key', cert.bad_key, quiet);
			return 0;
	} else {
		ferror.clear('_f_cert_key');
	}
	if (enable) {
		if (cert_key != scep_export_passwd)	{
			if( cert_key != '') {
				cmd += "crypto ca import abc pem null " + cert_key + "\n";
				cmd += "crypto ca import abc pkcs12 null " + cert_key + "\n";
			} else {
				cmd +="crypto ca import abc pem null\n";
			}
			change = 1;
		}
	} else {
		if( cert_key != '') {
			cmd += "crypto ca import abc pem null " + cert_key + "\n";
			cmd += "crypto ca import abc pkcs12 null " + cert_key + "\n";
		} else {
			cmd +="crypto ca import abc pem null\n";
		}
		change = 1;
	}

	if (enable) {
		ferror.clear('_f_scep_url');
		if (!v_length('_f_scep_url', quiet, 1, 128)){
				return 0;
		}

		ferror.clear('_f_scep_common_name');
		if (!v_length('_f_scep_common_name', quiet, 1, 64)){
				return 0;
		}

		ferror.clear('_f_scep_fqdn');
		if (!v_length('_f_scep_fqdn', quiet, 0, 128)){
				return 0;
		}

		ferror.clear('_f_scep_unit1');
		if (!v_length('_f_scep_unit1', quiet, 0, 64)){
				return 0;
		}
		
		ferror.clear('_f_scep_unit2');
		if (!v_length('_f_scep_unit2', quiet, 0, 64)){
				return 0;
		}
		
		ferror.clear('_f_scep_domain');
		if (!v_length('_f_scep_domain', quiet, 0, 64)){
				return 0;
		}
		
		ferror.clear('_f_scep_serialno');
		if (!v_length('_f_scep_serialno', quiet, 0, 64)){
				return 0;
		}

		if(E('_f_scep_challenge').value.length!=0 
			&& (E('_f_scep_challenge').value.length != E('_f_scep_challenge2').value.length)){
			ferror.set('_f_scep_challenge', scep.bad_challenge, quiet);
			ok = 0;
		}else{
			ferror.clear('_f_scep_challenge');
		}

		ferror.clear('_scep_unaddr');
		if (!v_info_host_ip('_f_scep_unaddr', quiet, false)){
				return 0;
		}

		ferror.clear('_scep_key_len');
		if (!v_info_num_range('_f_scep_key_len', quiet, false, 128, 2048)){
				return 0;
		}
			
		ferror.clear('_f_scep_poll_interval');
		if (!v_info_num_range('_f_scep_poll_interval', quiet, false, 30, 3600)){
				return 0;
		}
		
		ferror.clear('_f_scep_poll_timeout');
		if (!v_info_num_range('_f_scep_poll_timeout', quiet, false, 30, 86400)){
				return 0;
		}
	}

	if(scep_enable_json != enable){
		cmd += "!\n";
		if(enable){
			cmd += "crypto ca enable\n";
		}else {
			cmd += "no crypto ca enable\n";
		}

		change = 1;
	}

	cmd += "!\n";
	if (force)
		cmd += "crypto ca re-enroll\n";
	else 
		cmd += "no crypto ca re-enroll\n";

	if(force != 0 || (!force && scep_re_enroll_json)){
		change = 1;
	}

	if(scep_key_len_json != key_len){
		cmd += "!\n";
		cmd += "crypto key generate rsa general-keys modulus " + key_len + "\n";
		change = 1;
	}
	if( scep_export_passwd != cert_key){
		if (cert_key)
			cmd += "crypto key encrypt rsa passphrase " + cert_key + "\n";
		else 
			cmd += "no crypto key encrypt rsa\n"
		change = 1;
	}
	if(scep_domain_json!= domain){
		cmd += "!\n";
		if(domain)	
			cmd += "crypto ca domain-name " + domain + "\n";
		else 
			cmd += "no crypto ca domain-name\n";
		change = 1;
	}
	if( scep_tp_ip_json != trustpoint){
		cmd += "!\n";
		if (scep_tp_ip_json != "")
			cmd += "no crypto ca trustpoint " + scep_tp_ip_json + "\n";
		cmd += "crypto ca trustpoint " + trustpoint + "\n";
		change = 1;
	}
	if(scep_url_json !=url ){
		cmd += "!\n";
		cmd += "crypto ca trustpoint " + trustpoint + "\n";
		if(url){		
			cmd += "enrollment " + "url " + url + "\n";
		}else {
			cmd += "no enrollment url\n";
		}
		change = 1;
	}
	if(common_name != scep_cn_json){
		
		cmd += "!\n";
		cmd += "crypto ca trustpoint " + trustpoint + "\n";
		if(common_name){		
			cmd += "subject-name " + common_name + "\n";
		}else {
			cmd += "no subject-name\n";
		}
		change = 1;
	}
	if(unit1  != scep_ou1_json){
		cmd += "!\n";
		cmd += "crypto ca trustpoint " + trustpoint + "\n";
		if(unit1 ){		
			cmd += "subject-name " +  + common_name +" "+unit1 + "\n";
		}else {
			cmd += "no subject-name\n";
			cmd += "subject-name " + common_name + "\n";
		}
		change = 1;
	}
	
	if(unit2  != scep_ou2_json){
		cmd += "!\n";
		cmd += "crypto ca trustpoint " + trustpoint + "\n";
		if(unit2 ){		
			cmd += "subject-name " + common_name + " " + unit1 + " " + unit2 + "\n";
		}else {
			cmd += "no subject-name\n";
			cmd += "subject-name " + common_name + "\n";
		}
		change = 1;
	}

	if (fqdn != scep_fqdn_json ){
		cmd += "!\n";
		cmd += "crypto ca trustpoint " + trustpoint + "\n";
		if(fqdn){
			cmd += "fqdn " + fqdn + "\n";
		}else {
			cmd += "no fqdn " + fqdn + "\n";
		}
		change = 1;
	}

	if (serialno !=  scep_sn_json){
		cmd += "!\n";
		cmd += "crypto ca trustpoint " + trustpoint + "\n";
		if(serialno){
			cmd += "serial-number " + serialno + "\n";
		}else {
			cmd += "no serial-number\n";
		}
		change = 1;
	}	

	if (challenge != scep_challenge_passwd_json ){
		cmd += "!\n";
		cmd += "crypto ca trustpoint " + trustpoint + "\n";
		if(challenge){
			cmd += "password " + challenge + "\n";
		}else {
			cmd += "no password\n";
		}
		change = 1;

	}
	if( poll_interval != scep_poll_count_json ){
		cmd += "!\n";
		cmd += "crypto ca trustpoint " + trustpoint + "\n";
		cmd += "enrollment retry count " + poll_interval + "\n";
		change = 1;
	}
	if( poll_timeout != scep_poll_period_json ){
		cmd += "!\n";
		cmd += "crypto ca trustpoint " + trustpoint + "\n";
		cmd += "enrollment retry period " + poll_timeout + "\n";
		change = 1;
	}

	//alert(cmd);
	if (user_info.priv < operator_priv) {
		elem.display('save-button', false);
	}else{
		elem.display('save-button', true);
		E('_fom')._web_cmd.value = cmd;
		E('save-button').disabled = !change;	
	}
	return 1;
}

function earlyInit()
{
    verifyFields(null, true);
    //E(typ + '_form');
    typ_list = ['ca','crl','public','private','pkcs12'];
    
    for(var i=0;i<typ_list.length;i++){
        E(typ_list[i]+ '_form').backup_button.disabled = 1;
    }
}

function init()
{
	if((cookie.get('autosave')) == null){
		cookie.set('autosave', 1);
	}
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

	//E('_f_scep_force').value = '0';
}

</script>

</head>
<body onload='init()'>
<form id='_fom' method='post' action='apply.cgi'>
<input type='hidden' name='_web_cmd' value=''>

<div class='section-title'><script type='text/javascript'>W(menu.cert_mgr)</script></div>
<div class='section'>
<script type='text/javascript'>

createFieldTable('', [
	{ title: scep.enable, name: 'f_scep_enable', type: 'checkbox', value: scep_enable_json},
	{ title: scep.force, name: 'f_scep_force', type: 'checkbox', value: 0},
	{ title: scep.stat, rid: 'f_scep_status', text: '<b>' + scep_status + '</b>'},
	{ title: cert.key, name: 'f_cert_key', type: 'password', maxlen: 32, size: 32, value: scep_export_passwd },
	{ title: cert.key + ui.sep + ui.confm, name: 'f_cert_key2', type: 'password', maxlen: 128, size: 32, value: scep_export_passwd },
	{ title: scep.url, name: 'f_scep_url', type: 'text', maxlen: 128, size: 64, value: scep_url_json },
	{ title: scep.common_name, name: 'f_scep_common_name', type: 'text', maxlen: 32, size: 32, value: scep_cn_json},
	{ title: scep.fqdn, name: 'f_scep_fqdn', type: 'text', maxlen: 128, size: 32, value: scep_fqdn_json},
	{ title: scep.unit + " 1", name: 'f_scep_unit1', type: 'text', maxlen: 128, size: 32, value: scep_ou1_json },
	{ title: scep.unit + " 2", name: 'f_scep_unit2', type: 'text', maxlen: 128, size: 32, value: scep_ou2_json },
	{ title: scep.dmain, name: 'f_scep_domain', type: 'text', maxlen: 128, size: 32, value: scep_domain_json },
	{ title: scep.serialno, name: 'f_scep_serialno', type: 'text', maxlen: 128, size: 32, value: scep_sn_json },
	{ title: scep.challenge, name: 'f_scep_challenge', type: 'password', maxlen: 128, size: 32, value: scep_challenge_passwd_json },
	{ title: scep.challenge + ui.sep + ui.confm, name: 'f_scep_challenge2', type: 'password', maxlen: 128, size: 32, value: scep_challenge_passwd_json },
	{ title: scep.unstructured_address, name: 'f_scep_unaddr', type: 'text', maxlen: 16, size: 32, value: scep_tp_ip_json },
	{ title: scep.key_len, name: 'f_scep_key_len', type: 'text', maxlen: 32, size: 16, suffix: ui.bit, value: scep_key_len_json },
	{ title: scep.poll_int, name: 'f_scep_poll_interval', type: 'text', maxlen: 32, size: 16, suffix: ui.seconds, value: scep_poll_count_json },
	{ title: scep.poll_timeout, name: 'f_scep_poll_timeout', type: 'text', maxlen: 32, size: 16, suffix: ui.seconds, value: scep_poll_period_json }
]);

</script>
</div>
</form>

<div class='section' id='ca_section'>
	<form id='ca_form' method='post' action='upload.cgi' encType='multipart/form-data'>
		<input type='hidden' name='type' value='cert_ca' />
		<input type='file' size='40' id='ca_import' name='filename' value='ca.crt'>
		<script type='text/javascript'>
			W("<input type='button' name='import_button' style='width:200px' value='" + ui.impt + ui.sep + cert.ca + "' onclick='importButton(\"ca\", \".crt\")' id='ca-import-button'>");
			W("<input type='button' name='backup_button' onclick='backupButton(\"ca\", \".crt\")' style='width:200px' value='" + ui.expt + ui.sep + cert.ca + "'>");
		</script>
	</form>
</div>

<div class='section' id='crl_section'>
	<form id='crl_form' method='post' action='upload.cgi' encType='multipart/form-data'>
		<input type='hidden' name='type' value='cert_ca' />
		<input type='file' size='40' id='crl_import' name='filename' value='ca.crl'>
		<script type='text/javascript'>
			W("<input type='button' name='import_button' style='width:200px' value='" + ui.impt + ui.sep + cert.crl + "' onclick='importButton(\"crl\", \".crl\")' id='crl-import-button'>");
			W("<input type='button' name='backup_button' onclick='backupButton(\"crl\", \".crl\")' style='width:200px' value='" + ui.expt + ui.sep + cert.crl + "'>");
		</script>
	</form>
</div>

<div class='section' id='public_section'>
	<form id='public_form' method='post' action='upload.cgi' encType='multipart/form-data'>
		<input type='hidden' name='type' value='cert_public' />
		<input type='file' size='40' id='public_import' name='filename' value='public.crt'>
		<script type='text/javascript'>
			W("<input type='button' name='import_button' style='width:200px' value='" + ui.impt + ui.sep + cert.pub + "' onclick='importButton(\"public\", \".crt\")' id='public-import-button'>");
			W("<input type='button' name='backup_button' onclick='backupButton(\"public\", \".crt\")' style='width:200px' value='" + ui.expt + ui.sep + cert.pub + "'>");
		</script>
	</form>
</div>

<div class='section' id='private_section'>
	<form id='private_form' method='post' action='upload.cgi' encType='multipart/form-data'>
		<input type='hidden' name='type' value='cert_private' />
		<input type='file' size='40' id='private_import' name='filename' value='private.crt'>
		<script type='text/javascript'>
			W("<input type='button' name='import_button' style='width:200px' value='" + ui.impt + ui.sep + cert.privt + "' onclick='importButton(\"private\", \".key\")' id='private-import-button'>");
			W("<input type='button' name='backup_button' onclick='backupButton(\"private\", \".key\")' style='width:200px' value='" + ui.expt + ui.sep + cert.privt + "'>");
		</script>
	</form>
</div>

<div class='section' id='pkcs12_section'>
	<form id='pkcs12_form' method='post' action='upload.cgi' encType='multipart/form-data'>
		<input type='hidden' name='type' value='cert_pkcs12' />
		<input type='hidden' name='pkcs12_cert_key' value='' >
		<input type='file' size='40' id='pkcs12_import' name='filename' value='pkcs12.p12'>
		<script type='text/javascript'>
			W("<input type='button' name='import_button' style='width:200px' value='" + ui.impt + ui.sep + cert.pkcs12 + "' onclick='importButton(\"pkcs12\", \".p12\")' id='pkcs12-import-button'>");
			W("<input type='button' name='backup_button' onclick='backupButton(\"pkcs12\", \".p12\")' style='width:200px' value='" + ui.expt + ui.sep + cert.pkcs12 + "'>");
		</script>
	</form>
</div>

<script type='text/javascript'>
init();
if(cookie.get('autosave') == 1)
	ui.aply=ui.aply_save;
genStdFooter("");
</script>

<script type='text/javascript'>earlyInit()</script>
</body>
</html>
