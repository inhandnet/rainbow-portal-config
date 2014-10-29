<% pagehead(ui.saved) %>

<body>
<script type='text/javascript'>
	var wait = parseInt('<% cgi_get("_nextwait"); %>', 10);
	if (isNaN(wait)) wait = 30;
	
	function reloadPage()
	{
		window.location = window.location.protocol + '//<% nv("lan0_ip"); %>/';
	}
	
	var msg = "The router's new IP address is <% nv("lan0_ip"); %>. You may need to release then renew your computer's DHCP lease before continuing.";
	msg = msg + "Please wait while the router restarts... &nbsp;";
	
	show_info(msg+ " ...", wait);
	setTimeout(reloadPage, wait*1000);
</script>
</body>
</html>

