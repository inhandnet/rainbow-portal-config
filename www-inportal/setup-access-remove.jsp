<% pagehead(menu.remove_users) %>

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


var row_to_remove = 0;


var user_passwd = new webGrid();


user_passwd.onClick = function(cell) {
	user_passwd.recolor();
	var q = PR(cell);
	row_to_remove = q.rowIndex;	
	if (row_to_remove > 1){
		var o = this.tb.rows[row_to_remove];
		o.className = 'selected';
	}
	
	if(row_to_remove <= 1 || row_to_remove > (adm_users.length + 1))
		E('save-button').disabled = true;
	else
		E('save-button').disabled = false;

	//alert(row_to_remove);	
}

user_passwd.verifyFields = function(){
	verifyFields(null, true);
}
user_passwd.setup = function() {
	this.init('userg-grid', 
		['readonly'], 
		10, 
		[{ type: 'text', maxlen: 15 }
	/*, { type: 'text', maxlen: 15 }*/]);
	//this.headerSet([ui.username, ui.password]);
	this.headerSet([ui.username]);
	this.insertData(-1, [adm_user
		/*, uv_passwd*/]);
	
	for (var i = 0; i < adm_users.length; ++i) {
		this.insertData(-1, [adm_users[i][0]
			/*, uv_passwd*/]);
	}
//	this.showNewEditor();
//	this.resetNewEditor();
}



function verifyFields(focused, quiet)
{
	var somebody_removed = false;
	
	E('save-button').disabled = true;
	
	if (user_info.priv < admin_priv) {
		elem.display('save-button', 'cancel-button', false);
	}else{
		elem.display('save-button', 'cancel-button', true);
	}	

	return 1;
}



function save()
{	
	var user_name ='';

	//alert(row_to_remove);

	if (row_to_remove < 1
		|| row_to_remove > 1+adm_users.length){
		return 0;
	}else{
		if (row_to_remove == 1){
			user_name = adm_user;
		}else
			user_name = adm_users[row_to_remove - 2][0];
	}

	E('_fom')._web_cmd.value = "!\n" + "no username "+ user_name + "\n"

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
	verifyFields(null, 1);
}

function init()
{

}
</script>
</head>
<body onload="init()">
<form id='_fom' method='post' action='apply.cgi'>
<input type='hidden' name='_web_cmd' value=''>

<div class='section-title'><script type='text/javascript'>W(ui.user_summary);</script></div>
<div class='section'>
	<table class='web-grid' id='userg-grid'></table>	
</div>

<script type='text/javascript'>
//if(cookie.get('autosave') == 1)
//	ui.aply=ui.aply_save;
ui.aply=ui.del;
genStdFooter("");
</script>

</form>

<script type='text/javascript'>earlyInit();</script>
</body>
</html>
