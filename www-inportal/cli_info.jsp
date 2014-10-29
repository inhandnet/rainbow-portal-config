<% pagehead(infomsg.info) %>
<body>
	<form>
		<p>
		<div align='center'>
		<script type='text/javascript'>
		<% cli_info() %>
		document.write('Got error while executing command: ' + cli_cmd + '<br>');
		document.write('The system said: ' + cli_result + '<br>');
		</script>
		</p>
		<script type='text/javascript'>
		document.write("<input type='button' value='" + ui.cls + "' onclick='top.hideError()' style='font:12px sans-serif;width:80px;margin-left:10px'>");
		</script>
		</div>
	</form>
</body>
</html>
