<% pagehead(menu.config_security) %>

<style type='text/css'>
#security_grid {
	width: 300px;
	text-align: center;
}
#port_grid {
	width: 300px;
	text-align: center;
}

</style>

<script type='text/javascript'>

<% ih_sysinfo() %>
<% ih_user_info(); %>
var ports_security=[[1,1,1,1,3,maclist=[["0000.0000.0007",1],["0000.0000.0006",1]]],[1,1,2,0,0,maclist=[]],[1,1,3,0,0,maclist=[]],[1,1,4,0,0,maclist=[]],[1,1,5,0,0,maclist=[]],[1,1,6,0,0,maclist=[]],[1,1,7,0,0,maclist=[]],[1,1,8,0,0,maclist=[]],[2,1,1,0,0,maclist=[]],[2,1,2,0,0,maclist=[]]];

<% web_exec('show port-security') %>



var port_type = ['undefine','FE','GE'];


var port_cmd_list = [];
var port_title = [];

for(var i=0;i<ports_security.length;++i){

	if(ports_security[i][0] == 1){
		port_cmd_list.push("fastethernet "+ ports_security[i][1] + "/" + ports_security[i][2]);
		port_title.push("FE"+ ports_security[i][1] + "/" + ports_security[i][2]);
	}else if(ports_security[i][0] == 2){
		port_cmd_list.push("gigabitethernet "+ ports_security[i][1] + "/" + ports_security[i][2]);
		port_title.push("GE"+ ports_security[i][1] + "/" + ports_security[i][2]);
	}
}



var security_ports = new webGrid();
security_ports.onClick = function(cell) {
	var q = PR(cell);
	var port_index = q.rowIndex - 1;


	//alert("onClick: rowIndex = "+ (q.rowIndex - 1) +"\n");
	
	E('_port_security_index').value = port_index;
	E('_fom').submit();	
}

security_ports.verifyFields = function(row, quiet) 
{
	var f = fields.getAll(row);
}

security_ports.setup = function(){
	this.init('security_grid', 
		'readonly', 
		80, 
		[{ type: 'text'}, { type: 'text'}, { type: 'text'}, { type: 'text'}	]);
	this.headerSet([port.port, security.security, security.max_mac, security.mac_num]);


	for (var i = 0; i < ports_security.length; ++i) {
		this.insertData(-1, [port_title[i],['off','on'][ports_security[i][3]], ports_security[i][4], ports_security[i][5].length]);
	}


}




function verifyFields(focused, quiet){

}

function save()
{

}


function earlyInit()
{
	verifyFields(null,1);
}

function init()
{

}
</script>
</head>
<body onload='init()'>
<form id='_fom' method='post' action='setup-port-security-detail.jsp'>
<input type='hidden' name='port_security_index' id='_port_security_index'/>

<div class='section'>
	<table class='web-grid' cellspacing=1 id='security_grid'></table>
	<script type='text/javascript'>security_ports.setup();</script>
</div>
<div class='section'>
<script type='text/javascript'>
W("<tr>");W("<td>" + ui.note + "</td>");W("</tr>");
W("<tr>");W("<td indent=2>" + security.help1 + "</td>");W("</tr>");
</script>
</div>


</form>
<script type='text/javascript'>earlyInit();</script>
</body>
</html>
