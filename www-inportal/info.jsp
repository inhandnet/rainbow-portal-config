<% pagehead(infomsg.info) %>
<body>
	<form>
		<p>
		<script type='text/javascript'>
		<% resmsg() %>
		document.write(eval(resmsg));
		</script>
		</p>
		<script type='text/javascript'>
		document.write("<input type='button' value='" + ui.bk + "' onclick='top.hideError()' style='font:12px sans-serif;width:80px;margin-left:10px'>");
		</script>
	</form>
</body>
</html>
