<% pagehead(infomsg.saved) %>

<body>
<script type='text/javascript'>
	var wait = parseInt('<% cgi_get("_nextwait"); %>', 10);
	if (isNaN(wait)) wait = 5;
	
	function reloadPage()
	{
		document.location.replace('<% cgi_get("_nextpage"); %>');
	}
	
	show_info(infomsg.saved + " ...", wait);
	setTimeout(reloadPage, wait*1000);
</script>
</body>
</html>
