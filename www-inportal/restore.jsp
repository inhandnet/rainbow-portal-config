<% pagehead(infomsg.restore_def_cfg) %>

<body>
<script type='text/javascript'>
	var wait = 10;
	function reloadPage()
	{
		top.document.location.replace("login.jsp");
	}
	
	show_info(infomsg.restore_def_cfg + " ..." + "<br>" + infomsg.relogin, wait);
	setTimeout(reloadPage, wait*1000);
</script>
</body>
</html>

