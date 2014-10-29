<% pagehead(infomsg.logout) %>
<body>
	<form>
		<p>
        <script type='text/javascript'>
<% ih_sysinfo(); %>

	function authLogout()
	{
		var agt=navigator.userAgent.toLowerCase();
		//alert('agt='+agt);
		if (agt.indexOf("msie") != -1) {
			// IE clear HTTP Authentication
			//alert('clear');
			document.execCommand("ClearAuthenticationCache");
		}else{
			//firefox, chrome and others
			// Let's create an xmlhttp object
			var xmlhttp = createXMLObject();
			// Let's get the force page to logout for mozilla
			//xmlhttp.open("GET",".force_logout_offer_login_mozilla",true,user_info.name+'_logout',"");
			//var oem = "/www/products/"+ih_sysinfo.oem_name + "/index.jsp";	
			//xmlhttp.open("GET", oem, false,'_logout',"");
			xmlhttp.open("GET","index.jsp",false,'_logout',"");
			xmlhttp.send();  			    
		}	  
	}

	function createXMLObject() {
		var xmlhttp;
	    try {
	        if (window.XMLHttpRequest) {
	            xmlhttp = new XMLHttpRequest();
	        }
	        // code for IE
	        else if (window.ActiveXObject) {
	            xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	        }
	    } catch (e) {
	        xmlhttp=false
	    }
	    return xmlhttp;
	}

        


		document.write(infomsg.logout);
        	authLogout();
		//var oem = "/www/products/"+ih_sysinfo.oem_name + "/index.jsp";	
		//window.location = oem; 
		window.location = "index.jsp";
		</script>
		</p>
		<!--
		<script type='text/javascript'>
		document.write("<input type='button' value='" + ui.close + "' onclick='window.close()' style='font:12px sans-serif;width:200px;margin-left:10px'>");
		</script>
		-->
        
	</form>
</body>
</html>
