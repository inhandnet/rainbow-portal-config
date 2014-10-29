<% pagehead(menu.status_log) %>
<style type='text/css'>
#log-grid .co1 {
	width: 30px;
}
#log-grid .co2 {
	width: 100px;
}
#log-grid .co3 {
	width: 100px;
}

#slog-grid .co1 {
	width: 30px;
}
#slog-grid .co2 {
	width: 100px;
}


</style>

<script type='text/javascript'>
<% ih_user_info(); %>
<% web_exec('show mibs') %>

function download_file()
{
	var select_file_name = E('_snmp_mib_file').value;
//	alert(select_file_name);
	location.href = "/snmp/mibs/" + select_file_name;
}

function creatSelect(options,value,name)
{
	var string = '<td width="100px" align="left"><select onchange=verifyFields(null,1) id=_'
		+name+' >';

	for(var i = 0;i < options.length;i++){
		if(value == options[i]){
			string +='<option value='
				+ options[i]
				+ ' selected>'
				+ options[i]
				+ '</option>';
		}else{
			string +='<option value='
				+ options[i]
				+ '>'
				+ options[i]
				+ '</option>';
		}
	}

	string +="</select></td>";
	return string;
}

function createButton(value, id) 
{
	var string = '';

	string += '<td width="200px" '
		+ ' align="left"> <input id="_button" onClick="download_file()" type="button"'
		+ ' value="'
		+ value
		+ '" id="'
		+ id
		+ '" </td>';
//	alert(string);
	return string;
}

function verifyFields(focused, quiet)
{
	return true;
}

function init()
{
}
function save()
{
}

function earlyinit()
{
}

</script>

</head>
<body onload='init()'>
<form id='_fom' action='javascript:{}'>


<div class='section'>
<script type='text/javascript'>
                        W("<tr>");
                                W("<td width='200px' align='center'>" + "Please select mib file: " + "</td>");
                                W(creatSelect(snmp_mib_file, 0, 'snmp_mib_file'));
                                W(createButton('download', 'download'));
                        W("</tr>");
			var button = document.getElementById("download-file");  
    			button.addEventListener("click",download_file);  
</script>
</div>

<script type='text/javascript'>verifyFields(null, 1)</script>
</form>
</body>
</html>
