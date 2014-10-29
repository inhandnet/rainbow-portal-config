<% pagehead(infomsg.wait) %>

<script type='text/javascript'>

var __info_msg;
var __info_timeout;

function buildMsg()
{
	return __info_msg + "<br/><br/>" + infomsg.wait + __info_timeout + " " + ui.seconds + " ...";
}

function infoTimeout() {
	__info_timeout--; 
	if (__info_timeout >0) {
		top.Dialog.setInfoMessage(buildMsg());
		setTimeout(infoTimeout, 1000) 
	}
	else { 
		top.Dialog.closeInfo();
		top.document.location.replace("running-config.cnf?type=running-config2&cnt=100");
		document.location = 'admin-config.jsp';	
	}
}


function show_info(content, timeout)
{	
	__info_msg = content;
	__info_timeout = timeout;
	
	top.Dialog.closeInfo();
	top.Dialog.info(buildMsg(), {width:250, height:100, showProgress: true});
			
	setTimeout(infoTimeout, 1000);
}


function init()
{
	show_info(infomsg.watcnf, 3);
}
</script>

</head>

<body onload="init()">

</body>
</html>

