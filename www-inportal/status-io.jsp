<% pagehead(menu.stat) %>
<script type="text/javascript" src="status-io.jsx"></script>

<script type='text/javascript'>

<% ih_user_info(); %>

var input_val = [ui.io_low, ui.io_high];
var relay_val = [ui.io_off, ui.io_on];

var relay_action = ['off', 'on', 'off-pluse'];
var off_button = " <input type='button' style='width:100px' value='" + ui.io_off + "' onclick='relay_act(0)' id='off-button'>";

var on_button = " <input type='button' style='width:100px' value='" + ui.io_on + "' onclick='relay_act(1)' id='on-button'>";

var off_on_button = " <input type='button' style='width:100px' value='" + ui.io_off+' -> '+ui.io_on + "' onclick='relay_act(2)' id='off-on-button'>";

function verifyFields(focused, quiet)
{
	E('off-on-button').disabled = true;
	if (!v_info_num_range('_f_rel_tm', quiet, false, 100, 3600000)) return 0;
	E('off-on-button').disabled = false;
	return 1;
}

function relay_act(action)
{
	 E('_fom')._web_cmd.value = "!\n"+"io output 1 " + relay_action[action];
	 if (action == 2) {
	 	E('_fom')._web_cmd.value += " " + E('_f_rel_tm').value;
	 }
	 E('_fom')._web_cmd.value += "\n";
	 form.submit('_fom', 1);
}

var ref = new webRefresh('status-io.jsx', '', 0, 'status_io_refresh');

ref.refresh = function(text)
{
	try {
		eval(text);
	}
	catch (ex) {
	}
	c('io_in1', input_val[input]);
	c('io_rel1', relay_val[output]);
}


function c(id, htm)
{
	E(id).cells[1].innerHTML = htm;
}

function earlyInit()
{
	c('io_in1', input_val[input]);
	c('io_rel1', relay_val[output]);
	if (user_info.priv < admin_priv) {
		E('off-on-button').disabled = true;
		E('on-button').disabled = true;
		E('off-button').disabled = true;
	} 
}

function init()
{
	ref.initPage(3000, 0);
}

</script>

</head>
<body onload='init()'>
<form id='_fom' method='post' action='apply.cgi'>
<input type='hidden' name='_web_cmd' value=''>

<script type='text/javascript'>	
W("<div class='section-title' id='io-title'>" + ui.io_in + "</div>");
W("<div class='section' id='io-section'>");

createFieldTable('', [
	{ title: ui.io_in+' 1', rid: 'io_in1'},
]);
W("</div>");

W("<div class='section-title' id='io-title'>" + ui.io_rel + "</div>");
W("<div class='section' id='io-section'>");
createFieldTable('', [
	{ title: ui.io_rel+' 1', rid: 'io_rel1'},
	{ title: ui.acl_action, indent:2, text:off_button},
	{ title: ' ', indent:2, text:on_button},
	{ title: ' ', indent:2, name: 'f_rel_tm',type: 'text', prefix:off_on_button + " "+ui.io_off_delay+":",suffix:ui.mseconds, maxlen: 7, size: 7, value: 1000 }
]);
W("</div>");
</script>
</div>

<div id='footer'>
	<script type='text/javascript'>genStdRefresh(1,0,'ref.toggle()');</script>
</div>
</form>

<script type='text/javascript'>earlyInit();</script>
</body>
</html>
