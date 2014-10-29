<% pagehead(menu.setup_com) %>

<script type='text/javascript'>

<% nvram("_model_name,gps_enable,com0_config,com0_hw_flow,com0_sw_flow"); %>

function verifyFields(focused, quiet)
{
	var b;
/*
	if(nvram.gps_enable=='1'){
		if(E('_f_com0_baud').value!='9600' || E('_f_com0_databit').value!='8' 
			|| E('_f_com0_parity').value!='N' || E('_f_com0_stopbit').value!='1'
			|| E('_f_com0_hw_flow').value!='0'
			|| E('_f_com0_sw_flow').value!='0'){
			if(!confirm(infomsg.com)){
				return 0;
			}else{
				E('_f_com0_baud').value='9600';
				E('_f_com0_databit').value='8';
				E('_f_com0_parity').value='N';
				E('_f_com0_stopbit').value='1';
				E('_f_com0_hw_flow').value='0';
				E('_f_com0_sw_flow').value='0';
			}
		}
	}
*/	
	return 1;
}

function save()
{
	if (!verifyFields(null, false)) return;

	var fom = E('_fom');
	
	fom.com0_config.value = E('_f_com0_baud').value + ' ' + E('_f_com0_databit').value + E('_f_com0_parity').value + E('_f_com0_stopbit').value;
	fom.com0_hw_flow.value = E('_f_com0_hw_flow').checked ? '1' : '0';
	fom.com0_sw_flow.value = E('_f_com0_sw_flow').checked ? '1' : '0';
	
	form.submit(fom, 1);
}
</script>

</head>
<body>
<form id='_fom' method='post' action='apply.cgi'>
<input type='hidden' name='_service' value='com0-restart'\>
<input type='hidden' name='com0_config'\>
<input type='hidden' name='com0_hw_flow'\>
<input type='hidden' name='com0_sw_flow'\>

<div class='section-title'></div> 
<div class='section'>
<script type='text/javascript'>
	var com0_config = nvram.com0_config;;
	var v;
		
	if (com0_config.length==0) com0_config = "115200 8N1";
	
	v = com0_config.split(' ');
	com0_baud = v[0];
	com0_databit = v[1].substr(0,1);
	com0_parity = v[1].substr(1,1);
	com0_stopbit = v[1].substr(2,2);
		
createFieldTable('', [
	{ title: serial.baud, name: 'f_com0_baud', type: 'select', options: 
		[['2400','2400'],['4800','4800'],['9600','9600'],['19200','19200'],['38400','38400'],['57600','57600'],['115200','115200'],['230400','230400']],
		value: com0_baud },
	{ title: serial.databit, name: 'f_com0_databit', type: 'select', options: 
		[['8','8'],['7','7'],['6','6']],
		value: com0_databit },
	{ title: serial.parity, name: 'f_com0_parity', type: 'select', options: 
		[['N',serial.parity_none],['E',serial.parity_even],['O',serial.parity_odd]],
		value: com0_parity },
	{ title: serial.stopbit, name: 'f_com0_stopbit', type: 'select', options: 
//		[['2','2'],['1','1'],['0','0']],
		[['1','1'],['2','2']],
		value: com0_stopbit },
	{ title: serial.hw_flow, name: 'f_com0_hw_flow', type: 'checkbox', value: nvram.com0_hw_flow == '1' },
	{ title: serial.sw_flow, name: 'f_com0_sw_flow', type: 'checkbox', value: nvram.com0_sw_flow == '1' }
]);
</script>
</div>
<script type='text/javascript'>genStdFooter("");</script>
</form>
<script type='text/javascript'>verifyFields(null, 1);</script>
</body>
</html>

