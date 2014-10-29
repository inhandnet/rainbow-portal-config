<% pagehead(menu.switch_rmon_event) %>

<style type='text/css'>
#event_grid {
	width: 800px;
}
#event_grid .co1 {
	width: 80px;
	text-align: center;
}
#event_grid .co2 {
	width: 80px;
	text-align: center;
}
#event_grid .co3 {
	width: 150px;
	text-align: center;	
}
#event_grid .co4 {
	width: 150px;
	text-align: center;	
}
#event_grid .co5 {
	width: 150px;
	text-align: center;	
}
#event_grid .co6 {
	width: 150px;
	text-align: center;	
}

</style>

<script type='text/javascript'>

<% ih_sysinfo() %>
<% ih_user_info(); %>

<% web_exec('show rmon events') %>

//var event_config = [[1,2,3,4,5,6],[6,3,4,3,2,1]];

var tmp_old_config = [];
var event_type = ['','none','log','trap','log-trap'];
var rmon_event = new webGrid();


rmon_event.jump = function(row)
{
	//var send_cmd = [];
	var send_cmd = "";
	
	var f = fields.getAll(this.editor);

	//send_cmd.push("show rmon eventlog "+f[0].value);
	send_cmd += "show rmon eventlog "+f[0].value +"";
	
	//E('_send_cmd').value = send_cmd;
	E('_detail').send_cmd.value = send_cmd;
	E('_detail').submit();
	//form.submit('_detail', 1);
}

rmon_event.createControls = function(which, rowIndex) 
{
	var r, c;

	r = this.tb.insertRow(rowIndex);
	r.className = 'controls';

	c = r.insertCell(0);
	c.colSpan = this.header.cells.length;
	if (which == 'edit') {
		c.innerHTML =
			'<input type=button value=' + ui.del + ' onclick="TGO(this).onDelete()"> &nbsp; ' +
			'<input type=button value=' + ui.ok + ' onclick="TGO(this).onOK()"> ' +
			'<input type=button value=' + ui.cancel + ' onclick="TGO(this).onCancel()">' +
			'<input type=button value=' + ui.view + ' onclick="TGO(this).jump()">';
	}
	else {
		c.innerHTML =
			'<input type=button value=' + ui.add + ' onclick="TGO(this).onAdd()">';
	}
	return r;
}



rmon_event.onDataChanged = function()
{
	verifyFields();
}

rmon_event.exist = function(f, v)
{
	var data = this.getAllData();
	for (var i = 0; i < data.length; ++i) {
		if (data[i][f] == v) return true;
	}
	return false;
}

rmon_event.existName = function(name)
{
	return this.exist(0, name);
}


rmon_event.dataToView = function(data) {
	return [data[0], event_type[data[1]], data[2], data[3], data[4], data[5]];
}

rmon_event.fieldValuesToData = function(row) {
	var f = fields.getAll(row);
	return [f[0].value, f[1].value, f[2].value, f[3].value, f[4].value, f[5].value];
}


rmon_event.verifyFields = function(row, quiet) {
	var f = fields.getAll(row);
	var s;

	ferror.clearAll(f);
	//last time
	f[3].disabled =true;
	
	//index
	if (v_f_number(f[0], quiet, false, 1, 65535) == 0) return 0;

	if (this.existName(f[0].value)) {
		ferror.set(f[0], errmsg.bad_id, quiet);
		return 0;
	}else{
		ferror.clear(f[0], errmsg.bad_id, quiet);
	}

	//type
	if((f[1].value == 1)||(f[1].value == 2)){
		f[2].disabled = true;
		f[2].value = '';
	}else{
		f[2].disabled = false;
		if (!v_f_text(f[2], quiet, 1, 32)) return 0;
	}
	//description
	if(f[4].value != ''){
		if(v_f_text(f[4], quiet, 0, 128) == 0) return 0;
		/*
		if(f[4].value .indexOf(" ") >= 0){
			ferror.set(f[4], errmsg.bad_description, quiet);
			return 0;
		}else{
			ferror.clear(f[4],errmsg.adm3, quiet);
		}
		*/
	}

	//owner string
	if(v_f_text(f[5], quiet, 0, 32) == 0) return 0;

	return 1;
}

rmon_event.resetNewEditor = function() {
	var f = fields.getAll(this.newEditor);
//	f[0].value = 0;
	f[1].selected = '';
	f[2].value = '';
	f[3].value = '';
	f[4].value = '';
	f[5].value = 'Monitor';
			
	ferror.clearAll(fields.getAll(this.newEditor));
}

rmon_event.setup = function() {

	this.init('event_grid', 'move', 80, [
		{ type: 'text', maxlen: 5 },
		{ type: 'select', options: [[1,'none'],[2,'log'],[3,'trap'],[4,'log-trap']]},
		{ type: 'text', maxlen: 32},
		{ type: 'text'},
		{ type: 'text', maxlen: 128},
		{ type: 'text', maxlen: 32}
		]);
	this.headerSet([rmon.index,rmon.type,rmon.community,rmon.last_time,rmon.description,rmon.owner_string]);

	for(var i=0;i<event_config.length;++i){
		tmp_old_config[i] = [];
		//index
		tmp_old_config[i][0] = event_config[i][0].toString();
		//type
		tmp_old_config[i][1] = event_config[i][1].toString();
		//community
		tmp_old_config[i][2] = event_config[i][2].toString();
		//last Time sent
		tmp_old_config[i][3] = event_config[i][3].toString();
		//description
		tmp_old_config[i][4] = event_config[i][4].toString();
		//owner
		tmp_old_config[i][5] = event_config[i][5].toString();


		rmon_event.insertData(-1,tmp_old_config[i]);
	}

	rmon_event.showNewEditor();
	rmon_event.resetNewEditor();
}

function isDigit(str)
{ 
  var reg = /^\d*$/; 

  return reg.test(str); 
 }

function creat_event(tmp_data)
{
	var cmd = '';

	cmd += "rmon event " + tmp_data[0] + " ";
	//description
	if(tmp_data[4] != ''){
		cmd += "description " + tmp_data[4] + " ";
	}
	//type
	cmd += event_type[tmp_data[1]] + " ";
	//community
	if(tmp_data[2] != ''){
		cmd += tmp_data[2] + " ";
	}
	//owner
	if(tmp_data[5] != ''){
		cmd += "owner " + tmp_data[5] + " ";
	}
	
	cmd += "\n";
	
	return cmd;
}

function verifyFields(focused, quiet)
{

	var cmd = "";
	var fom = E('_fom');
	var view_flag = 1;
	  
	E('save-button').disabled = true;	
	if (rmon_event.isEditing()) return;	
	
	var tmp_data = rmon_event.getAllData();
	//check if add or change
	if(tmp_old_config.length > 0){
		for(var i=0;i<tmp_data.length;++i){
			for(var j=0;j<tmp_old_config.length;){
				if(tmp_data[i][0] == tmp_old_config[j][0]){
					for(var k=1;k<tmp_old_config[j].length;++k){
						if(k == 3) continue;
						if(tmp_data[i][k] != tmp_old_config[j][k]){
							if(view_flag){
								cmd += "!" + "\n";
								view_flag = 0;
							}
							cmd += creat_event(tmp_data[i]);
							break;
						}
					}
					
					break;
				}else{
					j++;
					if(j == tmp_old_config.length){
						if(view_flag){
							cmd += "!" + "\n";
							view_flag = 0;
						}
						cmd += creat_event(tmp_data[i]);		
					}
				}
			}
		}
	}else{
		//add all
		for(var i=0;i<tmp_data.length;++i){
			if(view_flag){
				cmd += "!" + "\n";
				view_flag = 0;
			}
			cmd += creat_event(tmp_data[i]);
		}
	}

	//delete
	if(tmp_data.length > 0){
		for(var i=0;i<tmp_old_config.length;++i){
			for(var j=0;j<tmp_data.length;){
				if(tmp_old_config[i][0] == tmp_data[j][0]){
					break;
				}else{
					j++;
					if(j == tmp_data.length){
						if(view_flag){
							cmd += "!" + "\n";
							view_flag = 0;
						}
						cmd += "no rmon event " + tmp_old_config[i][0]+ "\n";
					}
				}
			}
		}
	}else{
		//delete all
		for(var i=0;i<tmp_old_config.length;++i){
			if(view_flag){
				cmd += "!" + "\n";
				view_flag = 0;
			}
			cmd += "no rmon event " + tmp_old_config[i][0]+ "\n";
		}
	}
	
	//alert(cmd);
	if (user_info.priv < admin_priv) {
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
	//alert(E('_fom')._web_cmd.value);	
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
	//event.recolor();
	//event.resetNewEditor();
}
</script>
</head>
<body onload='init()'>
<form id='_detail' method='post' action='status-rmon-event.jsp'>
<input type='hidden' name='send_cmd' id='_send_cmd'/>
</form>
<form id='_fom' method='post' action='apply.cgi'>
<input type='hidden' name='_web_cmd' value=''>

<div class='section'>
	<table class='web-grid' cellspacing=1 id='event_grid'></table>
	<script type='text/javascript'>rmon_event.setup();</script>
</div>

<script type='text/javascript'>
init();
if(cookie.get('autosave') == 1)
	ui.aply=ui.aply_save;
genStdFooter("");
</script>
<script type='text/javascript'>verifyFields();</script>
</form>
</body>
</html>
