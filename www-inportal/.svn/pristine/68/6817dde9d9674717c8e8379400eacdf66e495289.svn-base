<% pagehead(menu.create_a_user) %>

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
var uv_passwd ="******";

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

var user_passwd = new webGrid();

user_passwd.setup = function() {
	this.init('userg-grid', 
		['readonly'], 
		10, 
		[{ type: 'text', maxlen: 15 },
	     { type: 'text', maxlen: 15 }]);
	this.headerSet([ui.username, ui.privilege]);
	this.insertData(-1, [adm_user, 15]);
	
	for (var i = 0; i < adm_users.length; ++i) {
		this.insertData(-1, [adm_users[i][0],
			adm_users[i][2]]);
	}
//	this.showNewEditor();
//	this.resetNewEditor();
}

function init_verifyFields(focused, quiet)
{
    var a, b, u;
    
    E('save-button').disabled = true;

    if (user_info.priv < admin_priv) {
	    elem.display('save-button', 'cancel-button', false);
    }else{
	    elem.display('save-button', 'cancel-button', true);
	    E('save-button').disabled = false;	
    }

    if (user_passwd.getAllData().length >= 9){
		E('_f_adm_user').disabled = true;
		E('_f_adm_passwd_1').disabled = true;
        E('_f_adm_passwd_2').disabled = true;
        return 0;
    }else{
		E('_f_adm_user').disabled = false;
		E('_f_adm_passwd_1').disabled = false;
		E('_f_adm_passwd_2').disabled = false;
	}
	
    ferror.clear('_f_adm_user');
	ferror.clear('_f_adm_passwd_1');
	ferror.clear('_f_adm_passwd_2');

	u = E('_f_adm_user');
	u.value = u.value.trim();
	if(u.value.length==0){
		ferror.set(u, errmsg.adm2, quiet);	
		return 0;
	}

	if (haveChineseChar(u.value)){
		ferror.set(u, errmsg.cn_chars, false);	
		return 0;
	}

	a = E('_f_adm_passwd_1');
	b = E('_f_adm_passwd_2');
	if (a.value.length == 0){
		ferror.set(a, errmsg.pw_empty, quiet);
		return 0;
	}

	if (b.value.length == 0){
		ferror.set(b, errmsg.pw_empty, quiet);
		return 0;
	}
	
	return 1;
}

function verifyFields(focused, quiet)
{
	var a, b, u;
	var priv;
	var cmd = "";

	E('save-button').disabled = true;
	u = E('_f_adm_user');
	u.value = u.value.trim();
	if(u.value.length==0){
		ferror.set(u, errmsg.adm2, false);	
		return 0;
	}

	if (!verityUserName(u, quiet)) return 0;

	if(is_user_exist(u.value)){
		ferror.set(u, errmsg.exist_user, false);	
		return 0;
	}
	
	a = E('_f_adm_passwd_1');
	b = E('_f_adm_passwd_2');

	if (!v_password(a, quiet, 1)) return 0;
	if (!v_password(b, quiet, 1)) return 0;
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
	
	if (!verifyFields(null, false)) 
		return;	

	if((E('_fom')._web_cmd.value != '')&&(cookie.get('autosave') == 1)){
		E('_fom')._web_cmd.value += "copy running-config startup-config"+"\n";	
	}

	if (cookie.get('debugcmd') == 1)
		alert(E('_fom')._web_cmd.value);

	form.submit('_fom', 1);
}

function earlyInit()
{

    user_passwd.setup();
	init_verifyFields(null, 1);
	E('save-button').disabled = true;

}

function init()
{

}
</script>
</head>
<body onload="init()">
<form id='_fom' method='post' action='apply.cgi'>
<input type='hidden' name='_web_cmd' value=''>

<div class='section-title'><script type='text/javascript'>W(ui.create_a_user);</script></div>
<div class='section'>
<script type='text/javascript'>
createFieldTable('', [
	{ title: ui.username, name: 'f_adm_user', type: 'text', maxlen: 31, value:  ''},
	{ title: ui.privilege, name: 'f_privilege', type: 'select', options: privilege_list, value: 1},
	{ title: ui.nw + ui.sep + ui.password, name: 'f_adm_passwd_1', type: 'password', maxlen: 64, value: '' },
	{ title: ui.confm + ui.sep + ui.nw + ui.sep + ui.password, name: 'f_adm_passwd_2', type: 'password', maxlen: 64, value: '' }
]);
</script>
</div>
<div><script type='text/javascript'>if(adm_users.length >= 8){ GetText(ui.note+infomsg.maxusers);}</script></div>

<script type='text/javascript'>
if(cookie.get('autosave') == 1)
	ui.aply=ui.aply_save;
genStdFooter("");
</script>


</form>

<br>
<br>


<form id='_fom' method='post' >
<div class='section-title'><script type='text/javascript'>W(ui.user_summary);</script></div>
<div class='section'>
	<table class='web-grid' id='userg-grid'></table>	
</div>
</form>
<script type='text/javascript'>earlyInit();</script>
</body>
</html>
