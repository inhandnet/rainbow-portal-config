<% pagehead(menu.alarm_map) %>

<style tyle='text/css'>
#alarm-map-grid  {
	width: 400px;
}
#alarm-map-grid .co1{
	width: 150px;
}

#alarm-map-grid .co2{
	width: 50px;
	Text-align: center;
}
#alarm-map-grid .co3{
	width: 50px;
	Text-align: center;
}
#alarm-map-grid .co4{
	width: 50px;
	Text-align: center;
}


</style>

<script type='text/javascript'>

<% ih_sysinfo(); %>
<% ih_user_info(); %>
<% web_exec('show running-config alarm') %>
var alarm_input_title = [['warm-start', alarm.warm_map],
							['cold-start', alarm.cold_map],
							['memory-low', alarm.mem_map],							
							['digital-input-high', ui.io_alarm_high],
							['digital-input-low', ui.io_alarm_low],
							['link-down fastethernet 0/1', 'FE0/1 '+alarm.down_map],
							['link-up fastethernet 0/1', 'FE0/1 '+alarm.up_map],
							['link-down fastethernet 0/2', 'FE0/2 '+alarm.down_map],
							['link-up fastethernet 0/2', 'FE0/2 '+alarm.up_map],
							['link-down fastethernet 1/1', 'FE1/1 '+alarm.down_map],
							['link-up fastethernet 1/1', 'FE1/1 '+alarm.up_map],
							['link-down fastethernet 1/2', 'FE1/2 '+alarm.down_map],
							['link-up fastethernet 1/2', 'FE1/2 '+alarm.up_map],
							['link-down fastethernet 1/3', 'FE1/3 '+alarm.down_map],
							['link-up fastethernet 1/3', 'FE1/3 '+alarm.up_map],
							['link-down fastethernet 1/4', 'FE1/4 '+alarm.down_map],
							['link-up fastethernet 1/4', 'FE1/4 '+alarm.up_map],
							['cellular', menu.setup_wan1+' Up/Down'],
							['dialer', menu.setup_pppoe+' Up/Down'],
							['fastethernet', menu.eth+' Up/Down'],
							['vlan', 'VLAN'+' Up/Down']
							];

var alarm_output_title = [['cli', alarm.cli_map], 
							['email', alarm.email_map], 
							['log', alarm.log_map]];

function get_alarm_input_title(al_json)
{
	for (var i = 0; i < alarm_input_title.length; i++){
		if (al_json == alarm_input_title[i][0]){
			return alarm_input_title[i][1];
		}
	}
	return '';
}

function get_alarm_output_title(al_json)
{
	for (var i = 0; i < alarm_output_title.length; i++){
		if (al_json == alarm_output_title[i][0]){
			return alarm_output_title[i][1];
		}
	}
	return '';
}

var alarm_map = new webGrid();
alarm_map.setup = function()
{
	var tb = [];
	tb.push({ type: 'text', maxlen: 15 });
	for (var i = 0; i < alarm_output_options.length; i++){
		tb.push({ type: 'checkbox' });
	}
	this.init('alarm-map-grid', ['nodelete'], 200,tb);

	var header = [];
	header.push('');
	for (var i = 0; i < alarm_output_options.length; i++){
		header.push(get_alarm_output_title(alarm_output_options[i]));
	}	
	this.headerSet(header);
	
	for (var i = 0; i < alarm_input_options.length; i++){
		var line = [];
		line.push(get_alarm_input_title(alarm_input_options[i]));
		for (var j = 0; j < alarm_output_options.length; j++){
			line.push(alarm_output[j][i]);
		}			
		this.insertData(-1, line);
	}	
}

alarm_map.dataToView = function(data) 
{
	var data_view = [];
	data_view.push(data[0]);
	for (var i = 1; i < data.length; i++) {
		data_view.push(data[i]? ui.yes : '');
	}
	return data_view;
}
alarm_map.fieldValuesToData = function(row) {
	var f = fields.getAll(row);
	
	tmp = [];
	tmp.push(f[0].value);
	for (var i = 1; i < f.length; i++){
		if(f[i].checked == 1){
			tmp.push( 1 );
		}else{
			tmp.push( 0 );
		}
	}
	return tmp;
}

alarm_map.onClick = function(cell)
{
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

alarm_map.onDataChanged = function()
{
	verifyFields(null, 1);
}

function verifyFields(focused, quiet)
{
	var cmd = "";
	var fom = E('_fom');
	var data = alarm_map.getAllData();
	
	E('save-button').disabled = true;
	for (var i = 0; i < data.length; i++) {
		for (var j = 1; j < data[i].length; j++) {
			if (data[i][j] != alarm_output[j - 1][i]) {
				cmd += "!\n" + (data[i][j]?"":"no ") + "alarm "+alarm_output_options[j - 1]+" "+alarm_input_options[i]+"\n";
			}
		}
	}
	
	if (user_info.priv < admin_priv) {
		elem.display('save-button', 'cancel-button', false);
	}else{
		elem.display('save-button', 'cancel-button', true);
		fom._web_cmd.value = cmd;
		E('save-button').disabled = (cmd=="");	
	}
	//alert(fom._web_cmd.value);
	return 1;
}

function save()
{
	if (!verifyFields(null, false)) return;
	if (alarm_map.isEditing()) return;
	
	var fom = E('_fom');

	if((E('_fom')._web_cmd.value != '')&&(cookie.get('autosave') == 1)){
		E('_fom')._web_cmd.value += "!"+"\n"+"copy running-config startup-config"+"\n";	
	}

	form.submit(fom, 1);
}

function earlyInit() 
{
	alarm_map.setup();
	verifyFields(null, 1);
}

function init()
{
}

</script>
</head>
<body onload='init()'>
<form id='_fom' method='post' action='apply.cgi'>
<input type='hidden' name='_web_cmd' value=''>

<div class='section' id='_alarm_map'>
	<table class='web-grid' id='alarm-map-grid'></table>
</div>
</form>
<script type='text/javascript'>
if(cookie.get('autosave') == 1)
	ui.aply=ui.aply_save;
genStdFooter("");
</script>
<script type='text/javascript'>earlyInit();</script>
</body>
</html>
