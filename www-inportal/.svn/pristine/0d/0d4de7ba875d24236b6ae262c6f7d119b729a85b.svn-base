<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="application/xhtml+xml; charset=utf-8" />
		<meta name='robots' content='noindex,nofollow'>
		<title><% ident() %> -> <% get_text(ui.login_timeout) %></title>
<style>
body {
	color: #770000;
	background: #B6D6F5;
}

.timeout {
	margin: auto;
	margin-top: 150px;
  padding:10px;
  text-align:center;
  float:center;
  width:380px;
  height: 100px;
	background: #ffffff;
	border: 1px solid #aa4444;
  font-size:20px;
  color:#0000FF;
}
</style>

<script type='text/javascript'>
var wait = 3;

function E(e) {
	return (typeof(e) == 'string') ? document.getElementById(e) : e;
}

function reloadPage()
{	
	wait--;
	if (wait==0) {
		top.document.location.replace("login.jsp");
	} else {
		E('prog').innerHTML = "<% get_text(infomsg.wait) %>" + " " + wait + "s...";
		setTimeout(reloadPage, 1000);
	}
}

function init()
{
	setTimeout(reloadPage, 0);
}
</script>

</head>

<body onload="init()">
	<div class="timeout">
			<% get_text(ui.login_timeout) %>
			<br><br>
		<div id="prog"/>
	</div>
</body>
</html>

