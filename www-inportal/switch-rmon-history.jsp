<% pagehead(menu.switch_rmon_history) %>

<style type='text/css'>
#history_grid {
	width: 630px;
}
#history_grid .co1 {
	width: 80px;
	text-align: center;
}
#history_grid .co2 {
	width: 100px;
	text-align: center;
}
#history_grid .co3 {
	width: 100px;
	text-align: center;	
}
#history_grid .co4 {
	width: 100px;
	text-align: center;	
}
#history_grid .co5 {
	width: 100px;
	text-align: center;	
}
#history_grid .co6 {
	width: 150px;
	text-align: center;	
}

</style>

<script type='text/javascript'>

<% ih_sysinfo() %>
<% ih_user_info(); %>

<% web_exec('show rmon history') %>
<% web_exec('show running-config interface') %>

//var port_config=[['1','1','1',1,3,2,1,0,0,0,0,0,0,1,0,0,0,'abc1,23'],['1','1','2',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],['1','1','3',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],['1','1','4',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],['1','1','5',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],['1','1','6',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],['1','1','7',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],['1','1','8',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],['2','1','1',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],['2','1','2',1,3,2,1,0,0,0,0,0,0,1,0,0,0,''],['2','1','3',1,3,2,1,0,0,0,0,0,0,1,0,0,0,'']];

//var histCtrl_config = [[2,[1,1,2],40,40,30,'abc'],[3,[1,1,3],50,50,30,'abc']];



var tmp_old_config = [];
var switch_interface = [];
var port_title_list = [];
var port_cmd_list = [];

for(var i=0;i<port_config.length;++i){

	if(port_config[i][0] == 1){
		port_title_list.push("FE"+ port_config[i][1] + "/" + port_config[i][2]);
		port_cmd_list.push("fastethernet "+ port_config[i][1] + "/" + port_config[i][2]);
	}else if(port_config[i][0] == 2){
		port_title_list.push("GE"+ port_config[i][1] + "/" + port_config[i][2]);
		port_cmd_list.push("gigabitethernet "+ port_config[i][1] + "/" + port_config[i][2]);
	}
	switch_interface.push([i, port_title_list[i]]);
}

var history_rmon = new webGrid();

history_rmon.jump = function(row)
{
	var send_cmd = [];
	
	var f = fields.getAll(this.editor);
	
	send_cmd.push("show rmon history "+port_cmd_list[f[1].value]);
	
	E('_send_cmd').value = send_cmd;
	E('_send_index').value = f[0].value;
	E('_detail').submit();
}

history_rmon.createControls = function(which, rowIndex) 
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

history_rmon.onDataChanged = function()
{
	verifyFields();
}

history_rmon.exist = function(f, v)
{
	var data = this.getAllData();
	for (var i = 0; i < data.length; ++i) {
		if (data[i][f] == v) return true;
	}
	return false;
}

history_rmon.existName = function(name)
{
	return this.exist(0, name);
}


history_rmon.dataToView = function(data) {
	return [data[0], port_title_list[data[1]], data[2], data[3], data[4],data[5]];
}

history_rmon.fieldValuesToData = function(row) {
	var f = fields.getAll(row);
	return [f[0].value, f[1].value, f[2].value, f[3].value, f[4].value,f[5].value];
}

history_rmon.verifyFields = function(row, quiet) {
	var f = fields.getAll(row);
	var s;

	ferror.clearAll(f);
	/*
	if(history_rmon.getAllData().length >= 10){
		show_alert(errmsg.no_more);
		history_rmon.resetNewEditor();
		return 0;
	}
	*/
	//index
	if (!v_f_number(f[0], quiet, false, 1, 65535)) return 0;
	
	if (this.existName(f[0].value)) {
		ferror.set(f[0], errmsg.bad_id, quiet);
		return 0;
	}else{
		ferror.clear(f[0]);
	}
	//buckets
	if(f[2].value == ''){
		ferror.set(f[2], errmsg.adm3, quiet);
		return 0;
	}else{
		if((f[2].value < 1 )||(f[2].value > 100)||(!isDigit(f[2].value))){
			ferror.set(f[2], errmsg.rmon_history_buckets, quiet);
			return 0;
		}
		ferror.clear(f[2], errmsg.adm3);
	}
	//granted buckets
	f[3].disabled = true;
	//f[3].value = f[2].value;
	//interval
	if(!v_f_number(f[4], quiet, false, 5, 3600)) return 0;

	//owner
	//owner string
	if(!v_f_text(f[5], quiet, 0, 32)) return 0;
	
	return 1;
}

history_rmon.resetNewEditor = function() {
	var f = fields.getAll(this.newEditor);
//	f[0].value = '';
	f[1].selected = '';
	f[2].value = '';
	f[3].value = '';
	f[4].value = '';
	f[5].value = 'Monitor';
	
	f[3].disabled = true;
	ferror.clearAll(fields.getAll(this.newEditor));
}

history_rmon.setup = function() {

	this.init('history_grid', 'move', 120, [
		{ type: 'text'},
		{ type: 'select', options: switch_interface},
		{ type: 'text'},
		{ type: 'text'},
		{ type: 'text'},
		{ type: 'text'}
		]);
	this.headerSet([rmon.index,port.port,rmon.bucket_request,rmon.bucket_granted,rmon.interval,rmon.owner_string]);

	for(var i= 0;i<histCtrl_config.length;++i){
		tmp_old_config[i] = [];
		//index
		tmp_old_config[i][0] = histCtrl_config[i][0].toString();
		//port
		for(var j=0;j<port_config.length;){
			if((port_config[j][0] == histCtrl_config[i][1][0])&&(port_config[j][1] == histCtrl_config[i][1][1])&&(port_config[j][2] == histCtrl_config[i][1][2])){
				tmp_old_config[i][1]  = j.toString();
				break;
			}else{
				j++;
				if(j == port_config.length)
					alert("Port Error!");
			}
		}
		//bucketsReq
		tmp_old_config[i][2] = histCtrl_config[i][2].toString();
		//bucketsGrant
		tmp_old_config[i][3] = histCtrl_config[i][3].toString();
		//interval
		tmp_old_config[i][4] = histCtrl_config[i][4].toString();
		//owner
		tmp_old_config[i][5] = histCtrl_config[i][5].toString();
		
		history_rmon.insertData(-1,tmp_old_config[i]);
	}


	history_rmon.showNewEditor();
	history_rmon.resetNewEditor();
}

function isDigit(str)
{ 
  var reg = /^\d*$/; 

  return reg.test(str); 
 }

function creatHistory(tmp_data)
{
	var cmd = '';
	
	cmd += "!" + "\n";
	cmd += "interface " + port_cmd_list[tmp_data[1]]+ "\n";

	cmd += "rmon collection history " + tmp_data[0] + " buckets " + tmp_data[2] 
		+ " interval " + tmp_data[4] + ((tmp_data[5] != '')?(" owner " + tmp_data[5] ):(" ")) + "\n";

	return cmd;
}

function deleteHistory(tmp_data)
{
	var cmd = '';
	cmd += "!" + "\n";
	cmd += "interface " + port_cmd_list[tmp_data[1]]+ "\n";

	cmd += "no rmon collection history " + tmp_data[0] + "\n";

	return cmd;
}

function verifyFields(focused, quiet)
{

	var cmd = "";
	var fom = E('_fom');
	  
	E('save-button').disabled = true;	

	var tmp_data = history_rmon.getAllData();
	if (history_rmon.isEditing()) return;	
	
	//check if add or change
	if(tmp_old_config.length > 0){
		for(var i=0;i<tmp_data.length;++i){
			for(var j=0;j<tmp_old_config.length;){
				if(tmp_data[i][0] == tmp_old_config[j][0]){
					if(tmp_data[i][1] != tmp_old_config[j][1]){
						//delete first
						cmd += deleteHistory(tmp_old_config[j]);
					}
					if((tmp_data[i][1] != tmp_old_config[j][1])||(tmp_data[i][2] != tmp_old_config[j][2])||(tmp_data[i][4] != tmp_old_config[j][4])||(tmp_data[i][5] != tmp_old_config[j][5]))
						cmd += creatHistory(tmp_data[i]);
					break;
				}else{
					j++;
					if(j == tmp_old_config.length){
						cmd += creatHistory(tmp_data[i]);			
					}
				}
			}
		}
	}else{
		//add all
		for(var i=0;i<tmp_data.length;++i){
			cmd += creatHistory(tmp_data[i]);
		}
	}

	//delete
	if(tmp_data.length > 0){
		for(var i=0;i<tmp_old_config.length;++i){
			for(var j=0;j<tmp_data.length;){
				if(tmp_old_config[i][0] == tmp_data[j][0]){
					break;
				}
				j++;
				if(j == tmp_data.length)
					cmd += deleteHistory(tmp_old_config[i]);
			}
		}
	}else{
		//delete all
		for(var i=0;i<tmp_old_config.length;++i){
			cmd += deleteHistory(tmp_old_config[i]);
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
	//history_rmon.recolor();
	//history_rmon.resetNewEditor();
}
</script>
</head>
<body onload='init()'>
<form id='_detail' method='post' action='status-rmon-history.jsp'>
<input type='hidden' name='send_cmd' id='_send_cmd'/>
<input type='hidden' name='send_index' id='_send_index'/>
</form>
<form id='_fom' method='post' action='apply.cgi'>
<input type='hidden' name='_web_cmd' value=''>


<div class='section'>
	<table class='web-grid' cellspacing=1 id='history_grid'></table>
	<script type='text/javascript'>history_rmon.setup();</script>
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
