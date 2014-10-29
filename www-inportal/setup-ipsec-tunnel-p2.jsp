<% pagehead(menu.ipsec_p2) %>

<style type='text/css'>

#transform-grid {
	width: 700px;
}
#transform-grid .co1 {
	width: 120px;
	text-align: center;
}
#transform-grid .co2 {
	text-align: center;
}
#transform-grid .co3 {
	text-align: center;
}
#transform-grid .co4 {
	text-align: center;
}
#transform-grid .co5 {
	text-align: center;
}

</style>

<script type='text/javascript'>

<% ih_sysinfo() %>
<% ih_user_info() %>

<% web_exec('show running-config crypto')%>

//var transform_config = [['test1', '0', '0', '1', '1'],['test2', '1', '1', '1', '1']];

var transform = new webGrid();

//test if the transform-set name is in the ipsec profile grid
transform.existTrans1 = function(trans1)
{
	for(var i = 0; i < ipsec_prof_config.length; i++) {
		//transform-set name in the ipsec_prof_config
		if(trans1 == ipsec_prof_config[i][2]) return true;
	}
	return false;
}

//test if the transform-set name is in the map grid
transform.existTrans2 = function(trans2)
{
	for(var i = 0; i < map_config.length; i++) {
		//transform-set name in the map_config
		if(trans2 == map_config[i][5]) return true;
	}
	return false;
}

transform.exist = function(f, v)
{
	var data = this.getAllData();
	for (var i = 0; i < data.length; ++i) {
		if (data[i][f] == v) return true;
	}
	return false;
}

transform.existName = function(name)
{
	return this.exist(0, name);
}

transform.dataToView = function(data) {
	var encrypt;
/*
	if(data[2] == '0') {
		encrypt = 'NULL';
	} else if(data[2] == '1') {
		encrypt = 'DES';
	} else if(data[2] == '2') {
		encrypt = '3DES';
	} else if(data[2] == '3') {
		encrypt = 'AES128';
	} else if(data[2] == '4') {
		encrypt = 'AES192';
	} else if(data[2] == '5') {
		encrypt = 'AES256';
	}
*/

	if(data[2] == '0') {
		encrypt = '3des';
	} else if(data[2] == '1') {
		encrypt = 'des';
	} else if(data[2] == '2') {
		encrypt = 'aes128';
	} else if(data[2] == '3') {
		encrypt = 'aes192';
	} else if(data[2] == '4') {
		encrypt = 'aes256';
	} else if(data[2] == '5') {
		encrypt = 'null';
	}


	return [data[0],
			(data[1] == '0')?"esp":"ah",
			encrypt,
			(data[3] == '0')?"md5":"sha",
			(data[4] == '0')?ipsec.tunnel_mode:ipsec.transport_mode];
}

transform.fieldValuesToData = function(row) {
	var f = fields.getAll(row);
	return [f[0].value, f[1].value, f[2].value, f[3].value, f[4].value];
}

transform.onDataChanged = function() {
	verifyFields(null, 1);
}

transform.verifyDelete = function(data)
{
	var mydata = transform.getAllData();

	if (this.existTrans1(data[0])){
		show_alert("Transform-set "+data[0]+" is in used by IPSec Profile!");		
		return 0;
	} 

	if (this.existTrans2(data[0])){
		show_alert("Transform-set "+data[0]+" is in used by IPSec Map!");
		return 0;
	} 
	return true;
}

transform.verifyFields = function(row, quiet) {
	var f = fields.getAll(row);

	if(haveChineseChar(f[0].value)) {
		ferror.set(f[0], errmsg.cn_chars, quiet);
		return 0;	
	} else if(!v_length(f[0], quiet, 1, 64)) {
		return 0;
	} else if(f[0].value.indexOf(" ") >= 0) {
		ferror.set(f[0], errmsg.bad_description, quiet);
		return 0;
	} else if(this.existName(f[0].value)) {
		ferror.set(f[0], errmsg.bad_name4, quiet);
		return 0;
	} else {
		ferror.clear(f[0]);
	}

	if(f[1].value == '1') {
		f[2].value = 0;
		f[2].disabled = true;
	} else {
		f[2].disabled = false;
	}
	
	return 1;
}

transform.createControls = function(which, rowIndex) {
	var r, c;

	r = this.tb.insertRow(rowIndex);
	r.className = 'controls';

	c = r.insertCell(0);
	c.colSpan = this.header.cells.length;
	if (which == 'edit') {
		c.innerHTML =
			'<input type=button id="del_row_button" value=' + ui.del + ' onclick="TGO(this).onDelete()"> &nbsp; ' +
			'<input type=button id="ok_row_button" value=' + ui.ok + ' onclick="TGO(this).onOK()"> ' +
			'<input type=button id="cancel_row_button" value=' + ui.cancel + ' onclick="TGO(this).onCancel()">';
	}
	else {
		c.innerHTML =
			'<input type=button id="add_new_row_button" value=' + ui.add + ' onclick="TGO(this).onAdd()">';
	}
	return r;
}

transform.onClick = function(cell)
{
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
			onDataChanged();
			return;
		}
		this.edit(cell);		
	}
	var f = fields.getAll(this.editor);
	//test if transform-set is in use
	if((this.existTrans1(f[0].value)) || (this.existTrans2(f[0].value))) {
		E('del_row_button').disabled = true;
//		E('ok_row_button').disabled = true;
//		for(var i = 0;i < f.length;i++)
//			f[i].disabled = true;
		f[0].disabled = true;
	}
}

transform.resetNewEditor = function() {
	var f = fields.getAll(this.newEditor);
	f[0].value = '';

	for(var i = 1;i < f.length; i++) {
		f[i].value = 0;
	}
	
	ferror.clearAll(fields.getAll(this.newEditor));
}

transform.setup = function() 
{
	this.init('transform-grid', 'move', 10, [
		{ type: 'text', maxlen: 32 }, 
		{ type: 'select',  options:[
			['0', 'esp'],
			['1', 'ah']
		]},
		{ type: 'select',  options:[
			['0', '3des'],
			['1', 'des'],
			['2', 'aes128'],
			['3', 'aes192'],
			['4', 'aes256'],
			['5', 'null']
		]},
		{ type: 'select', options:[
			['0', 'md5'],
			['1', 'sha']
		]},
		{ type: 'select', options:[
			['0', ipsec.tunnel_mode],
			['1', ipsec.transport_mode]
		]}
	]);
	this.headerSet([ui.nam, ipsec.encap, ipsec.encrypt, ipsec.auth, ipsec.ipsec_mode]);

	for(var i = 0; i < transform_config.length; i++) 
		this.insertData(-1, [transform_config[i][0], transform_config[i][1], transform_config[i][2],
							transform_config[i][3], transform_config[i][4]]);

	this.showNewEditor();
	this.resetNewEditor();
}

function verifyFields(focused, quiet)
{
	var ok = 1;
	var cmd = "";
	var fom = E('_fom');

	E('save-button').disabled = true;

	var data_found = 0;
	var data_changed = 0;

	/* verfiy for the transform grid */
	var datat = transform.getAllData();
	var mtransforms = transform_config;

	//delete the keyring from json which have been deleted from web
	for(var i = 0; i < mtransforms.length; i++) {
		data_found = 0;
		data_changed = 0;

		for(var j = 0; j < datat.length; j++) {
			if(mtransforms[i][0] == datat[j][0]) {
				data_found = 1;
				break;			
			}
		}
		if(!data_found) {
			cmd += "no crypto ipsec transform-set " + mtransforms[i][0] + "\n";
		}
	}

	//add the  keyring into json which have been added or changed by the web
	for(var i = 0; i < datat.length; i++) {
		var encrypt, auth, mode;
		data_found = 0;
		data_changed = 0;

		if(datat[i][1] == '0') {	//esp
			if(datat[i][2] == '0') {	//null
				encrypt = 'esp-3des';
			} else if(datat[i][2] == '1') {	//des
				encrypt = 'esp-des';
			} else if(datat[i][2] == '2') {	//3des
				encrypt = 'esp-aes128';
			} else if(datat[i][2] == '3') {	//aes128
				encrypt = 'esp-aes192';
			} else if(datat[i][2] == '4') {	//aes192
				encrypt = 'esp-aes256';
			} else if(datat[i][2] == '5') {	//aes256
				encrypt = 'esp-null';
			}

			if(datat[i][3] == '0') {
				auth = 'esp-md5-hmac';
			} else if(datat[i][3] == '1') {
				auth = 'esp-sha-hmac';
			}
		} else if(datat[i][1] == '1') {		//ah
			if(datat[i][3] == '0') {
				auth = 'ah-md5-hmac';
			} else if(datat[i][3] == '1') {
				auth = 'ah-sha-hmac';
			}
		}

		if(datat[i][4] == '0') {
			mode = 'tunnel';
		} else if(datat[i][4] == '1') {
			mode = 'transport';
		}

		for(var j = 0; j < mtransforms.length; j++) {
			if(datat[i][0] == mtransforms[j][0]) {
				data_found = 1;
				if((datat[i][1] != mtransforms[j][1]) ||
					(datat[i][2] != mtransforms[j][2]) ||
					(datat[i][3] != mtransforms[j][3]) ||
					(datat[i][4] != mtransforms[j][4])) {
					data_changed = 1;
				}
				break;
			}
		}
		
		if(!data_found || data_changed) {
			cmd += "!\n";
			if(datat[i][1] == '0') {	//esp
				cmd += "crypto ipsec transform-set "+datat[i][0]+" "+encrypt+" "+auth+"\n";
			} else if(datat[i][1] == '1') {	//ah
				cmd += "crypto ipsec transform-set "+datat[i][0]+" "+auth+"\n";
			}
			cmd += "mode "+mode+"\n";
		}
	}

//	alert(cmd);
	if (user_info.priv < admin_priv) {
		elem.display('save-button', 'cancel-button', false);
	}else{
		elem.display('save-button', 'cancel-button', true);
		fom._web_cmd.value = cmd;
		E('save-button').disabled = (cmd=="");	
	}
	
	return 1;
}

function save()
{
	if (!verifyFields(null, false)) return;

	if (transform.isEditing()) return;

	if((E('_fom')._web_cmd.value != '')&&(cookie.get('autosave') == 1)){
		E('_fom')._web_cmd.value += "!"+"\n"+"copy running-config startup-config"+"\n";	
	}
	form.submit('_fom', 1);
}

function earlyInit()
{
	transform.setup();
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

<div id='transform_title' class='section-title'>
<script type='text/javascript'>
	GetText(ipsec.transform_title);
</script>
</div>
<div id="transform_body" class='section'>
	<table class='web-grid' id='transform-grid'></table>	
</div>

<script type='text/javascript'>
init();
if(cookie.get('autosave') == 1)
	ui.aply=ui.aply_save;
genStdFooter("ipsec.transform_title");
</script>
</form>
<script type='text/javascript'>earlyInit()</script>


</body>
</html>

