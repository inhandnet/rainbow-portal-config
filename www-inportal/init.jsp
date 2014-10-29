<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<!-- Note: FIXME: Cannot use standard page head because this page may contains different language chars -->
<html>
	<head>
		<meta http-equiv="Content-Type" content="application/xhtml+xml; charset=gb2312" />
		<meta name='robots' content='noindex,nofollow'>
		<script type="text/javascript" src="lang_pack/<% get_language() %>.res"></script>
		<script type="text/javascript" src="js/misc.js"></script>
		<script type="text/javascript" src="js/inrouter.js"></script>

		<link type="text/css" rel="stylesheet" href="css/inhand.css" />
		<title>�豸��ʼ������</title>

<script type='text/javascript'>
var model_name;
var has_ovdp = 0;

<% nvram("model_name,oem_name,wan0_mac,lan0_mac,serialnum,description"); %>

function verifyFields(focused, quiet)
{
	return 1;
}

function save()
{
	var s;
	
	if (!verifyFields(null, false)) return;
	
	var fom = E('_fom');
	fom.model_name.value = E('_f_model_name').value;
	if(E('_f_ovdp').checked) fom.model_name.value += '-OVDP';
	if(E('_f_hardware_ready').checked) fom.hardware_ready.value = '1';
	else fom.hardware_ready.value = '0';
	
	form.submit('_fom', 1);		
}

function init()
{
	model_name = nvram.model_name.split('-');
	if(model_name.length<1) model_name = ['600UE00'];
	else if(model_name.length>1){
		var i;
		
		for(i=1; i<model_name.length; i++){
			if(model_name[i]=='OVDP') has_ovdp = 1;
		}
	}
	
	E('_f_model_name').value = model_name[0];
	E('_f_ovdp').checked = has_ovdp;
	E('_oem_name').value = nvram.oem_name ? nvram.oem_name : "inhand";
}

</script>
</head>
<body onload="init()">
<form id='_fom' method='post' action='apply.cgi'>
<input type='hidden' name='_service' value='manufacture-restart'>
<input type='hidden' name='model_name'>
<input type='hidden' name='hardware_ready' value='0'>
<input type='hidden' name='_nextwait' value='20'>
<input type='hidden' name='_redirect' value='index.jsp'>

<div class='section-title'>�豸��ʼ��</div>
<div class='section'>
<script type='text/javascript'>
createFieldTable('', [
	{ title: '���ͣ����ͺ󲻿��ٴθ��ģ���', name: 'f_hardware_ready', type: 'checkbox', value: 0},
	{ title: '��Ʒ�ͺ�', name: 'f_model_name', type: 'select', options: 
		[['600HS01', '600HS01'],['600UE00','600UE00'],['600TD01','600TD01'],
		 ['619HS01', '619HS01'],['619UE00','619UE00'],['619TD01','619TD01'],
		 ['620HS01', '620HS01'],['620UE00','620UE00'],['620TD01','620TD01']
		 ],
		value: '600UE00' },
	{ title: 'OVDP֧��', name: 'f_ovdp', type: 'checkbox', value: 0},
	{ title: 'OEM����', name: 'oem_name', type: 'select', options: 
		[['inhand', 'ӳ��ͨ'],['GJJ','������е']],
		value: 'inhand' },
	{ title: '���к�', name: 'serialnum', type: 'text', maxlen: 32, size: 32,
		value: nvram.serialnum },
	{ title: '��Ʒ����', name: 'description', type: 'text', maxlen: 256, size: 32,
		value: nvram.description },
	{ title: 'WAN MAC��ַ', name: 'wan0_mac', type: 'text', maxlen: 17, size: 20,
		value: nvram.wan0_mac },
	{ title: 'LAN MAC��ַ', name: 'lan0_mac', type: 'text', maxlen: 17, size: 20,
		value: nvram.lan0_mac }
]);
</script>
</div>
</form>

<script type='text/javascript'>genStdFooter("");</script>
<script type='text/javascript'>verifyFields(null, true);</script>
</body>
</html>
