<% pagehead(ui.create_a_user) %>

<style type='text/css'>
#adm-head{
	Text-align: left;
	background: #e7e7e7;
}
#userg-grid {
	Text-align:center;
	width: 200px;
}
#userg-grid .co1 {
	width: 100px;
}
#userg-grid .co2 {
	width: 100px;
}

#adm-grid{
	width:140px;
}
#adm-grid.co1{
	Text-align:center;
	width:40px;
}
#adm-grid.co2{
	Text-align:center;
	width:100px;
}


</style>

<script type='text/javascript'>

//var adm_user = 'adm';
//var adm_passwd = '123456';
//var adm_users = [['zhengyb', '666666', 0]];

<% ih_sysinfo() %>
<% ih_user_info(); %>
<% web_exec('show running-config users') %>

var privilege_list = [
[0, " "],
[1, "1"],
[2, "2"],
[3, "3"],
[4, "4"],
[5, "5"],
[6, "6"],
[7, "7"],
[8, "8"],
[9, "9"],
[10,"10"],
[11,"11"],
[12,"12"],
[13,"13"],
[14,"14"],
[15,"15"]
];

var user_to_modify = 0;

cookie.unset('web_clr_this_user');
function is_user_exist(username)
{
	if (username == adm_user){
		return true;
	}

	for (var i = 0; i < adm_users.length; i++){
		if (adm_users[i][0] == username){
			return true;
		}
	}

	return false;
}

function get_user_name(row_index)
{
	var user_name = '';
	
	if(user_to_modify < 1 || user_to_modify > (adm_users.length + 1))
		return user_name;

	if (row_index == 1){
		user_name = adm_user;
	}else{
		user_name = adm_users[row_index - 2][0];
	}

	return user_name;
}

function get_user_priv(row_index)
{
	var user_priv = "";
	
	if(user_to_modify < 1 || user_to_modify > (adm_users.length + 1))
		return user_priv;

	if (row_index == 1){
		user_priv = 15;
	}else{
		user_priv = adm_users[row_index - 2][2];
	}

	return user_priv;
}

var user_passwd = new webGrid();

user_passwd.onClick = function(cell) {
	var q = PR(cell);
	var user_name = '';
	var user_priv = "";
	user_to_modify = q.rowIndex;	
		
	E('_f_adm_user').disabled = false;	
	E('_f_privilege').disabled = false;	
	
	if(user_to_modify < 1 || user_to_modify > (adm_users.length + 1))
		return 0;
	user_passwd.recolor();
	var o = this.tb.rows[user_to_modify];
	o.className = 'selected';
	
	user_name = get_user_name(user_to_modify);
	user_priv = get_user_priv(user_to_modify);
	if (user_name != ''){
		E('_f_adm_user').value = user_name;
	}else{
		E('_f_adm_user').value = adm_user;
	}

	E('_f_privilege').value = user_priv;

	if(E('_f_adm_user').value == adm_user) {
		E('_f_adm_user').disabled = true;	
		E('_f_privilege').disabled = true;	
	}

//	alert(user_name);	
}

function verifyFields(focused, quiet)
{
	var a, b, u;

	E('save-button').disabled = true;
	E('_f_adm_user').disabled = true;	
	E('_f_privilege').disabled = true;
	a = E('_f_adm_passwd_1');
	b = E('_f_adm_passwd_2');	
	u = E('_f_adm_user');
	u.value = u.value.trim();

		
	if (user_info.priv < admin_priv) {
		elem.display('save-button', 'cancel-button', false);
	}else{
		elem.display('save-button', 'cancel-button', true);
		if (u.value.length == 0
			|| a.value.length == 0
			|| b.value.length == 0)
			E('save-button').disabled = true;	
		else {
			E('save-button').disabled = false;	
			ferror.clear('_f_adm_passwd_1');
			ferror.clear('_f_adm_passwd_2');
			ferror.clear('_f_adm_user');
		}

		if (haveChineseChar(u.value)){
			ferror.set(u, errmsg.cn_chars, false);	
			return 0;
		}else{
			ferror.clear('_f_adm_user');
		}
	}	

	return 1;
}

user_passwd.verifyFields = function(){
	verifyFields(null, 1);
}

user_passwd.setup = function() {
	this.init('userg-grid', 
		['readonly'], 
		10, 
		[{ type: 'text', maxlen: 15 },
		 { type: 'text', maxlen: 15 }]);
	this.headerSet([ui.username, ui.privilege]);
	this.insertData(-1, [adm_user, 15]);
	
	for (var i = 0; i < adm_users.length; ++i) {
		this.insertData(-1, [adm_users[i][0], adm_users[i][2]]);
	}
//	this.showNewEditor();
//	this.resetNewEditor();
}



function my_verifyFields(focused, quiet)
{
	var a, b, u;
	var priv;
	var cmd = "";
	
	u = E('_f_adm_user');
	u.value = u.value.trim();
	if(u.value.length==0){
		ferror.set(u, errmsg.adm2, false);	
		return 0;
	}

	if(!is_user_exist(u.value)){
		ferror.set(u, errmsg.not_exist_user, false);	
		return 0;
	}

	a = E('_f_adm_passwd_1');
	b = E('_f_adm_passwd_2');
	if (!v_password(a, quiet, 1)) return 0;
	if (!v_password(b, quiet, 1)) return 0;
	/*
	if (a.value.length == 0){
		ferror.set(a, errmsg.pw_empty, false);
		return 0;
	}else{
		ferror.clear('_f_adm_passwd_1');
	}

	if (b.value.length == 0){
		ferror.set(b, errmsg.pw_empty, false);
		return 0;
	}else{
		ferror.clear('_f_adm_passwd_2');
	}
	*/
	if (a.value != b.value) {
		ferror.set(b, errmsg.pw_match, false);
		return 0;
	} else {
		ferror.clear('_f_adm_passwd_1');
		ferror.clear('_f_adm_passwd_2');
	}
	
	priv = E('_f_privilege').value;
		
	cmd += "!"+"\n";
	cmd += "username "+ E('_f_adm_user').value + (priv == 0 ? " " : " privilege " + priv) + " password " + E('_f_adm_passwd_1').value +"\n";

	E('_fom')._web_cmd.value = cmd;
	
	if (user_info.priv < admin_priv) {
		elem.display('save-button', false);
	}else{
		elem.display('save-button', true);
		E('_fom')._web_cmd.value = cmd;
		E('save-button').disabled = (cmd=="");	
	}	

	return 1;
}

function save()
{
	var cmd = "";
	var view_flag = 1;
	
	if (!my_verifyFields(null, false)) return;	

	if((E('_fom')._web_cmd.value != '')&&(cookie.get('autosave') == 1)){
		E('_fom')._web_cmd.value += "copy running-config startup-config"+"\n";	
	}

	if (cookie.get('debugcmd') == 1)
		alert(E('_fom')._web_cmd.value);

	if(E('_f_adm_user').value  == user_info.name)
		cookie.set('web_clr_this_user', 1);

	form.submit('_fom', 1);
}

function earlyInit()
{
	user_passwd.setup();
	verifyFields(null, 1);
	E('save-button').disabled = true;
}

function init()
{

}
</script>
</head>
<body onload="init()">


<form id='_fom_dispaly' method='post' >
<div class='section-title'><script type='text/javascript'>W(ui.user_summary);</script></div>
<div class='section'>
	<table class='web-grid' id='userg-grid'></table>	
</div>

</form>

<br>
<br>

<form id='_fom' method='post' action='apply.cgi'>
<input type='hidden' name='_web_cmd' value=''>

<div class='section-title'><script type='text/javascript'>W(ui.modify_a_user);</script></div>
<div class='section'>
<script type='text/javascript'>
createFieldTable('', [
	{ title: ui.username, name: 'f_adm_user', type: 'text', maxlen: 64, value:  adm_user},
	{ title: ui.privilege, name: 'f_privilege', type: 'select', options: privilege_list, value: 15},
	{ title: ui.nw + ui.sep + ui.password, name: 'f_adm_passwd_1', type: 'password', maxlen: 64, value: '' },
	{ title: ui.confm + ui.sep + ui.nw + ui.sep + ui.password, name: 'f_adm_passwd_2', type: 'password', maxlen: 64, value: '' }
]);
</script>
</div>

<script type='text/javascript'>
if(cookie.get('autosave') == 1)
	ui.aply=ui.aply_save;
genStdFooter("");
</script>


</form>

<script type='text/javascript'>earlyInit();</script>
</body>
</html>
