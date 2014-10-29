<% pagehead(menu.dtu1) %>

<style type='text/css'>
#vlan_grid  {
	width: 1130px;
	text-align: center;
}

</style>

<script type='text/javascript'>

<% ih_sysinfo() %>
<% ih_user_info() %>
<% web_exec('show running-config serial')%>
//serial_config =[['1','0', '0', '1', '0', '0', '1','serial1'],['2','1', '3', '1', '0', '0', '1','serial2']];

//define option list
var type_list = [['1', 'RS232'],['2','RS485']];
var speed_list = [['230400', '230400'],['115200', '115200'],['57600', '57600'],['38400', '38400'],['19200', '19200'],['9600','9600'],['4800', '4800'], ['2400','2400'],  ['1200','1200'],['300', '300']];
var speed_list2 = [['115200', '115200'],['57600', '57600'],['38400', '38400'],['19200', '19200'],['9600','9600'],['4800', '4800'], ['2400','2400'],  ['1200','1200'],['300', '300']];
var parity_list = [['0', serial.parity_none],['1', serial.parity_odd],['2', serial.parity_even]];
var stop_list = [['1','1 bit'], ['2','2 bits']];
var data_list = [['7', '7 bits'],['8', '8 bits']];

var serial1_id_json = serial_config[0][0];
var serial1_type_json = serial_config[0][1];
var serial1_speed_json = serial_config[0][2];
var serial1_data_json = serial_config[0][3];
var serial1_parity_json = serial_config[0][4];
var serial1_stop_json = serial_config[0][5];
var serial1_xonxoff_json = serial_config[0][6];
var serial1_desc_json = serial_config[0][7];

var serial2_id_json = serial_config[1][0];
var serial2_type_json = serial_config[1][1];
var serial2_speed_json = serial_config[1][2];
var serial2_data_json = serial_config[1][3];
var serial2_parity_json = serial_config[1][4];
var serial2_stop_json = serial_config[1][5];
var serial2_xonxoff_json = serial_config[1][6];
var serial2_desc_json = serial_config[1][7];

function verifyFields(focused, quiet)
{
	var cmd = "";
	var fom = E('_fom');
	E('save-button').disabled = true;

	var s1_id =1;
	var s1_type = E('_f_s1_type').value;
	var s1_speed = E('_f_s1_speed').value;
	var s1_data = E('_f_s1_data').value;
	var s1_parity = E('_f_s1_parity').value;
	var s1_data = E('_f_s1_data').value;
	var s1_stop = E('_f_s1_stop').value;
	var s1_xonxoff = E('_f_s1_xonxoff').checked;
	var s1_desc = E('_f_s1_desc').value;

	var s2_id = 2;
	var s2_type = E('_f_s2_type').value;
	var s2_speed = E('_f_s2_speed').value;
	var s2_data = E('_f_s2_data').value;
	var s2_parity = E('_f_s2_parity').value;
	var s2_data = E('_f_s2_data').value;
	var s2_stop = E('_f_s2_stop').value;
	var s2_xonxoff = E('_f_s2_xonxoff').checked;
	var s2_desc = E('_f_s2_desc').value;


	E('_f_s1_type').disabled = true;	
	E('_f_s2_type').disabled = true;

	if(s1_speed != serial1_speed_json){
		cmd += "!\nserial " + s1_id  + "\n";	
		cmd += "speed " + s1_speed + "\n";	
	}
	if(s1_data != serial1_data_json){	
		cmd += "!\nserial " + s1_id  + "\n";	
		cmd += "data-bits " + s1_data + "\n";	
	}
	if(s1_stop != serial1_stop_json){
		cmd += "!\nserial " + s1_id  + "\n";	
		cmd += "stop-bits " + s1_stop + "\n";	
	}
	if(s1_xonxoff != serial1_xonxoff_json){

		if(!s1_xonxoff){
			cmd += "!\nserial " + s1_id  + "\n";	
			cmd += "no xonxoff\n";
		}else {
			cmd += "!\nserial " + s1_id  + "\n";	
			cmd += "xonxoff enable\n";
		}	
	}
	if(s1_desc != serial1_desc_json){
		if(s1_desc){
			cmd += "!\nserial " + s1_id  + "\n";	
			cmd += "description " + s1_desc + "\n";
		}else {
			cmd += "!\nserial " + s1_id  + "\n";	
			cmd += " no description\n";
		}	
	}
	if(s1_parity != serial1_parity_json){
		cmd += "!\nserial " + s1_id + "\n";
		switch(s1_parity){
			case '0':{	
				cmd += "no parity \n";
				break;
			}
			case '1':{	
				cmd += "parity odd\n";
				break;
			}
			case '2':{	
				cmd += "parity even\n";
				break;
			}
			default:{
				cmd += "no parity \n";
				break;
			}
		}	
	}	
	//serial port 2
	if(s2_speed != serial2_speed_json){
		cmd += "!\nserial " + s2_id  + "\n";	
		cmd += "speed " + s2_speed + "\n";	
	}
	if(s2_data != serial2_data_json){	
		cmd += "!\nserial " + s2_id  + "\n";	
		cmd += "data-bits " + s2_data  + "\n";	
	}
	if(s2_stop != serial2_stop_json){
		cmd += "!\nserial " + s2_id  + "\n";	
		cmd += "stop-bits " + s2_stop + "\n";	
	}
	if(s2_xonxoff != serial2_xonxoff_json){

		if(!s2_xonxoff){
			cmd += "!\nserial " + s2_id  + "\n";	
			cmd += "no xonxoff\n";
		}else {
			cmd += "!\nserial " + s2_id  + "\n";	
			cmd += "xonxoff enable\n";
		}	
	}
	if(s2_desc != serial2_desc_json){
		if(s2_desc){
			cmd += "!\nserial " + s2_id  + "\n";	
			cmd += "description " + s2_desc + "\n";
		}else {
			cmd += "!\nserial " + s2_id  + "\n";	
			cmd += " no description\n";
		}	
	}
	if(s2_parity != serial2_parity_json){
		cmd += "!\nserial " + s2_id + "\n";
		switch(s2_parity){
			case '0':{	
				cmd += "no parity \n";
				break;
			}
			case '1':{	
				cmd += "parity odd\n";
				break;
			}
			case '2':{	
				cmd += "parity even\n";
				break;
			}
			default:{
				cmd += "no parity \n";
				break;
			}
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

function earlyInit()
{	
	verifyFields(null, true);
}

function save()
{
	if (!verifyFields(null, false)) return;	
	
	
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
}
</script>
</head>
<body onload='init()'>
<form id='_fom' method='post' action='apply.cgi'>
<input type='hidden' name='_web_cmd' value=''>

<div id='serial1_title' class='section-title'>
<script type='text/javascript'>
	GetText(menu.setup_com1);
</script>
</div>
<div class='section'>
<script type='text/javascript'>
var serial1_tb = [
		{ title: serial.type, name: 'f_s1_type', type: 'select', options: type_list, value: serial1_type_json },
		{ title: serial.baud, name: 'f_s1_speed', type: 'select', options: speed_list, value: serial1_speed_json },
		{ title: serial.databit, name: 'f_s1_data', type: 'select', options: data_list, value: serial1_data_json },
		{ title: serial.parity, name: 'f_s1_parity', type: 'select', options: parity_list, value: serial1_parity_json },
		{ title: serial.stopbit, name: 'f_s1_stop', type: 'select', options: stop_list, value: serial1_stop_json },
		{ title: serial.sw_flow, name: 'f_s1_xonxoff',  type: 'checkbox', value: serial1_xonxoff_json == '1' },
		{ title: serial.desc, name: 'f_s1_desc', type: 'text', maxlen: 16, size: 20, value: serial1_desc_json }
		];
createFieldTable('', serial1_tb);
</script>
</div>

<div id='serial2_title' class='section-title'>
<script type='text/javascript'>
	GetText(menu.setup_com2);
</script>
</div>
<div class='section'>
<script type='text/javascript'>

var serial2_tb = [
		{ title: serial.type, name: 'f_s2_type', type: 'select', options: type_list, value: serial2_type_json },
		{ title: serial.baud, name: 'f_s2_speed', type: 'select', options: speed_list2, value: serial2_speed_json },
		{ title: serial.databit, name: 'f_s2_data', type: 'select', options: data_list, value: serial2_data_json },
		{ title: serial.parity, name: 'f_s2_parity', type: 'select', options: parity_list, value: serial2_parity_json },
		{ title: serial.stopbit, name: 'f_s2_stop', type: 'select', options: stop_list, value: serial2_stop_json },
		{ title: serial.sw_flow, name: 'f_s2_xonxoff', type: 'checkbox', value: serial2_xonxoff_json == '1' },
		{ title: serial.desc, name: 'f_s2_desc', type: 'text', maxlen: 16, size: 20, value: serial2_desc_json }
		];

createFieldTable('', serial2_tb);

</script>
</div>

<script type='text/javascript'>
init();
if(cookie.get('autosave') == 1)
	ui.aply=ui.aply_save;
genStdFooter("");
</script>

<script type='text/javascript'>earlyInit()</script>
</form>
</body>
</html>

