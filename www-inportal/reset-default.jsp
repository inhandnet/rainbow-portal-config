<% pagehead(infomsg.reset_default) %>

<body>
<script type='text/javascript'>
	var wait = 30;
	function reloadPage()
	{
		top.document.location.replace("login.jsp");
	}
	
	show_info(infomsg.reset_default + " ...", wait);
	setTimeout(reloadPage, wait*1000);
</script>
</body>
</html>

