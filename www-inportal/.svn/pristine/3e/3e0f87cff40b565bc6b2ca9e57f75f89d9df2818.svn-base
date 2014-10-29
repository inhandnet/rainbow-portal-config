<html>
	<head>
		<meta http-equiv="Content-Type" content="application/xhtml+xml; charset=<%get_text(ui.lang_charset)%>">
		<meta name='robots' content='noindex,nofollow'>
		<script type="text/javascript" src="js/misc.js"></script>
		<link type="text/css" rel="stylesheet" href="css/welotec.css">
		<script type="text/javascript" src="<%get_language()%>.res"></script>
		<script type="text/javascript" src="js/inrouter.js"></script>
		<title>Router Web Console</title>

<link type="text/css" rel="stylesheet" href="css/flexdropdown_welotec.css">
<script src="js/menu.jsx" type="text/javascript"></script>
<script src="js/create_menu_welotec.js" type="text/javascript"></script>
<script src="js/jquery.min.js" type="text/javascript"></script>
<script src="js/flexdropdown.js" type="text/javascript"></script>

<script type="text/javascript">
	var do_logout = 1;
	var userSave = 0;
	<% ih_user_info(); %>

	function authLogout(){
		try{
		  var agt=navigator.userAgent.toLowerCase();
		  //alert('agt='+agt);
		  if (agt.indexOf("msie") != -1) {
		    // IE clear HTTP Authentication
			//alert('clear');
		    document.execCommand("ClearAuthenticationCache");
			window.location = "index.jsp"; 
		  }else{//firefox, chrome and others
		    // Let's create an xmlhttp object
		    var xmlhttp = createXMLObject();
		    // Let's get the force page to logout for mozilla
		   
			//xmlhttp.open("GET",".force_logout_offer_login_mozilla",true,user_info.name+'_logout',"");
			xmlhttp.open("GET","index.jsp",false,user_info.name+'_logout',"");
		    xmlhttp.send();  			    
		  }	  
		} catch(e) {
			// There was an error
			alert("There was an error");
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




	function logout()
	{		
		if(!do_logout) return;
		if(show_confirm(ui.confm + " " + menu.logout + " ?")){
            window.location="logout.jsp";
            //do logout on 'logout.jsp',not here
	    //authLogout();
		}
	}
	
	function saveConfig()
	{
		if(!confirm(infomsg.to_save + "?")) return;

		E('save_form')._web_cmd.value = "!"+"\n"+ "copy running-config startup-config"+"\n";

		userSave = 1;
//		alert(E('save_form')._web_cmd.value);
		form.submit('save_form', 1);
	}

</script>
</head>
<body  onLoad="windowInit()" onBeforeUnload="return CloseEvent();" onUnload="cleanup()" class="body_index">
<!-- form for save config  -->
<form id='save_form' method='post' action='apply.cgi'>
<input type='hidden' name='_web_cmd' value=''>
</form>


<div style="width:18px; height:64px; position:absolute;right:0px; top:77px;cursor:pointer" id="extraButton" onclick="openExtraDiv()">
 <img src="images/extraInterface.png" border="0"/>	
</div>

<table border="0" cellpadding="0" cellspacing="0"  width="100%" height="100%">
	 <tr>
	   <td height="100%" width="160px">

		      <table border="0" cellpadding="0" cellspacing="0"  width="160px" height="100%">
		      	<!-- LOGO  -->
			     <tr>
				   <td height="75" width="100%">
				   		    	        <div id="logo">
											<script type="text/javascript">
											W('<img border=0 src="products/<%logo()%>" alt="' + product.company + '"' + '"title="' + product.company + '"' + '/>');
											</script>
										</div>
				   	</td>
				 </tr>
				 <tr>
				 	<!-- 左边区背景图片  -->
				   <td height="100%" width="100%"  align="left" valign="top"  style=" background-color:#ffffff">

					   	  <table border="0" cellpadding="0" cellspacing="0"  width="100%" height="100%">
					   	  	<!-- 目录区 -->
					   	    <tr>
					   	    	 <td height="70%" width="100%" valign="top">
					   	    	 	<div style="" id="Container" type="MenuBarHorizontal" menuClick="menuClick"></div>
					   	    	 </td>
					   	    </tr>
					   	    <tr>
					   	    	 <td height="30%" width="100%" valign="top">

											   	  <table border="0" cellpadding="0" cellspacing="0"  width="100%" height="100%">
											   	  	<!-- 保存配置按钮 -->
											   	    <tr>
											   	    	 <!--<td height="15%" width="100%" valign="top" align="left"  style="padding-left:30px;">-->
											   	    	 <td height="15%" width="100%" valign="top" align="center">
											   	    	 	<a href="#" style="text-decoration:underline;color:#E20001;"><span style="font-size:12px; font-weight:bold;cursor:pointer" id="button_saveConfig" onclick="saveConfig();"></span></a>
											   	    	 </td>
											   	    </tr>
											   	    <!-- 版权信息 -->
											   	    <tr>
											   	    	 <td height="80%" width="100%" align="center"  valign="bottom"  style="padding-bottom:15px">
											   	    	 	<table border="0" cellpadding="0" cellspacing="0"  width="100%" height="40px">
											   	    	 	 	  <tr><td align="center"><span style="font-size:12px;" id="tab_copyright1">	</span></td></tr>
											   	    	 	 	 <tr><td align="center"><span style="font-size:12px;" id="tab_copyright2">	</span></td></tr>
											   	    	 	 	 <tr><td align="center"><span style="font-size:12px;" id="tab_copyright3">	</span></td></tr>
											   	    	 	</table>
											   	    	 </td>
											   	    </tr>											   	    											   	    
											   	  </table>

					   	    	 </td>
					   	    </tr> 
					   	  </table>

				   	</td>
				 </tr>
			  </table>

	   </td>
	   <td height="100%">

				   <table border="0" cellpadding="0" cellspacing="0"  width="100%" height="100%">
					 <tr>
						 <!-- 上边区背景图片  -->
					   <td height="75" width="100%"  valign="bottom"  style=" background-color:#ffffff">

							  <table border="0" cellpadding="0" cellspacing="0"  width="100%" height="50px">
							  	<!-- 当前用户  -->
								 <tr>
								   <td height="32" width="90%" valign="bottom"><span id="dir_span" style="font-size:14px; font-weight:bold;"></span></td>
								   <td width="10%"><span style="font-size:12px;font-weight:bold;" id="currentUser"></span></td>
								 </tr>
								 <!-- 退出按钮  -->
								 <tr>
								   <td height="32" width="90%" valign=""><div id="frameLabels"></div></td>
								   <td width="10%"><img src="images/exit_img.png"  style="cursor:pointer" align="absmiddle" onclick="logout();"/><span style="font-size:12px; font-weight:bold;cursor:pointer" id="button_exit" onclick="logout();"></span></td>
								 </tr>
							  </table>

					   </td>
					 </tr>
					 <tr>
					   <td height="100%" width="100%" align="center">

							   	  	<table border="1" cellpadding="0" cellspacing="0"  width="100%" height="100%" style="border-top-color:#000000; border-left-color:#000000;border-bottom-color:#eaeaea;border-right-color:#eaeaea;">
										 <tr>
										 	<td style="padding-left:10px;padding-top:15px;"> 

													   	 <iframe height="100%" width="100%" frameborder="0" scrolling="AUTO" src="" id="window_content" name="window_content">
									 			         </iframe>
										   	</td>
										   	<td width="15%" id="extraDiv" style="display:none">

										   				<table border="0" cellpadding="0" cellspacing="0"  width="100%" height="100%">
															 <tr>
															   <td height="25" width="100%">
	
																	<table height="22px" width="100%" cellspacing="2" border="0">
																		<tr>
																			<td width="80%" align="left">
		
																			 		<table height="22px" cellspacing="2" border="0">
																						<tbody>
																							<tr>
																								<td height="22px" valign="bottom">
																										<table height="22px" cellspacing="0" cellpadding="0" border="0" style="display:none">
																											<tbody>
																												<tr>
																													<td width="5px" style="background-color: #ffffff"></td>
																													<td onclick="openExtraWindow('help')" style="background-color:#ffffff; cursor: pointer;">
																														<span style="font-size: 12px; font-weight: bold; color: #ffffff;">/锟斤拷</span></td>
																													<td width="1px" style="background-color: #ffffff);"></td>
																												</tr>
																											</tbody>
																										</table>
																								</td>
																								<td height="22px" valign="bottom">
																										<table height="22px" cellspacing="0" cellpadding="0" border="0">
																											  <tbody>
																											  	<tr>
																											  		<td width="5px" style="background-color:#ffffff"></td>
																											  		<td onclick="openExtraWindow('trap')" style="background-color: #ffffff; cursor: pointer;">
																											  			<span style="font-size: 12px; font-weight: bold; color: #E20001A;"><%get_text(ui.alarm)%></span></td>
																											  		<td width="1px" style="background-color: #ffffff;"></td>
																												</tr>
																											</tbody>
																										</table>
																						        </td>
																						    </tr>																					
																						</tbody>
																					</table>
											
																			</td>
																			<td width="20%" align="right"><img src="css/alphacube/button-min-focus.gif" style="cursor:pointer" border="0" onclick="closeExtraWindow()" />	</td>
																		</tr>
																	</table>
													
															   </td>
															 </tr>
															 <tr>
															   <td height="100%" width="100%">
										
															   			<table border="0" cellpadding="0" cellspacing="0"  width="100%" height="100%">
																		 <tr>
																		   <td height="100%" width="100%">
																		      <div id="div_helpWindow" style="height:50%" style="display:none">
																		      			<table border="1" cellpadding="0" cellspacing="0"  width="100%" height="100%">
																						        <tr>
																						        	<td height="10px" align="right" style="border:0px;">
																						        		<img src="css/alphacube/button-close-focus.gif" border="0"  style="cursor:pointer" onClick="closeIframeWins('help')" />
																						        		</td>
																						        </tr>
																						        <tr>
																						        	<td style="border:0px;"><iframe height="100%" width="100%" frameborder="0" scrolling="AUTO" src=""  id="helpWindow"  name="helpWindow">
																						                    </iframe></td>
																						        </tr>
																						       </table>
																		      	</div>
																		      <div id="div_trapWindow" style="height:50%">
																		      			<table border="1" cellpadding="0" cellspacing="0"  width="100%" height="100%">
																				        <tr>
																				        	<td height="10px" align="right" style="border:0px;">
																					        		<img src="css/alphacube/button-close-focus.gif" border="0"  style="cursor:pointer;display:none;" onClick="closeIframeWins('trap')" />							        		
																				        	</td>
																				        </tr>
																				        <tr>
																				        	<td style="border:0px;"><iframe height="100%" width="100%" frameborder="0" scrolling="AUTO" src="" id="trapWindow" name="trapWindow">
																			                        </iframe></td>
																				        </tr>
																				       </table>
																		      	</div>
																		   </td>
																		 </tr>
																	  </table>
															   </td>
															 </tr>
														  </table>
				
										   	</td>
										 </tr>
									  </table>
					   </td>
					 </tr>
				  </table>
	   </td>
	 </tr>
</table>

<script type="text/javascript">
	var helpWindow = null;
	var contentWindow = null;
	var trapWindow=null;
	var upgrading = 0;

	var alarmWindow = null;
	var consoleWindow = null;	
	var curent_url = '';
	
	function confirmUnload()
	{
		return infomsg.upgrade4;
	}
	

	function showContent(title, url)
	{
		document.getElementById("window_content").src=url+'?'+Math.random();
		//alert(url);//only for test
		curent_url = url;
	}
	
	
	function findHelp (term) 
	{
		var v = "help_id=" + term;
		document.getElementById("helpWindow").src="help.jsp?" + v;
	}
	
	function  findTrap(url){
		document.getElementById("trapWindow").src=url;
	}
	
	function showResult (result, wait) 
	{
		top.Dialog.closeInfo();
		if (result=='infomsg.cli_fail'){
			//consoleWindow.show();
			//showContent('', 'cli_info.jsp');
			document.getElementById("window_content").src='cli_info.jsp';
			//consoleWindow.show();
			//consoleWindow.setURL('cli_info.jsp');
		}else{
			var rest_cnf;
			if ((rest_cnf = cookie.get('reset_config')) == null){
				rest_cnf = 0;
			}
			if (rest_cnf == '1'){
				cookie.set('reset_config', 0);
				rest_cnf = 1;
			}

			var test_email;
			if ((test_email = cookie.get('testemail')) == null){
				test_email = 0;
			}
			if (test_email == '1'){
				cookie.set('testemail', 0);
				test_email = 1;
			}
			if ((result=='infomsg.saved') && (rest_cnf == 1)){
				result = 'infomsg.reset_ok';
			}else if ((result=='infomsg.saved') && (test_email == 1)){
				result = 'infomsg.emailok';
			}else if ((result=='infomsg.saved') 
				&& cookie.get('autosave') == 0
				&& !userSave){
				result = 'infomsg.done';
			}
			if (userSave) userSave = 0;
			if (curent_url == 'setup-system.jsp'){
				top.document.location.replace('index.jsp');
				showContent('', curent_url);
			}else showContent('', curent_url);
			show_info(eval(result), wait);
		}
	}
	
	
	function showError () 
	{
		top.Dialog.closeInfo();
		
		if(!consoleWindow) return;
			
		consoleWindow.show();
		consoleWindow.setURL("cli_info.jsp");
	}

	function hideError ()
	{
		//consoleWindow.hide();
		showContent('', curent_url);
	} 

	
function closeIframeWins(win_){
 		var help_win=document.getElementById("div_helpWindow");
		var trap_win=document.getElementById("div_trapWindow");
		if(win_=="help"){
		 help_win.style.display="none";
		   if(trap_win.style.display==""){
		   	  trap_win.style.height="100%";
		   	}
		}else{
		 trap_win.style.display="none";	
		 if(help_win.style.display==""){
		   	  help_win.style.height="100%";
		   	}
		}
		if(help_win.style.display==trap_win.style.display){
		document.getElementById("extraDiv").style.display="none";
		document.getElementById("extraButton").style.display="";
		}	
}	
	
	
	function closeExtraWindow(){
	document.getElementById("extraDiv").style.display="none";
  	document.getElementById("extraButton").style.display="";
	}

  function openExtraDiv(){
  	document.getElementById("extraDiv").style.display="";
  	document.getElementById("extraButton").style.display="none";
  	var help_win=document.getElementById("div_helpWindow");
    var trap_win=document.getElementById("div_trapWindow");
    help_win.style.display="none";
    trap_win.style.display="";
    //help_win.style.height="50%";
  	trap_win.style.height="100%";
  }


function openExtraWindow(win_){
	 	var help_win=document.getElementById("div_helpWindow");
		var trap_win=document.getElementById("div_trapWindow");
		if(win_=="help"){
			if(help_win.style.display=="none"){
				help_win.style.display="";
		 		help_win.style.height="50%";
		 		trap_win.style.height="50%";
			}
		}else{
			if(trap_win.style.display=="none"){
				 trap_win.style.display="";
		 		help_win.style.height="50%";
		 		trap_win.style.height="50%";
		}
		}
}

function cookiesInit()
{
	//config auto save
	if((cookie.get('autosave')) == null)
		cookie.set('autosave', 1);

	cookie.unset('web_clr_this_user');
}
	
	function windowInit(){
		showContent(ui.sys_status, "status-system.jsp");
		findHelp("ui.help");
		findTrap('alarm.jsp');
		
		document.getElementById("button_exit").innerHTML=""+ui.exit+"";
		document.getElementById("button_saveConfig").innerHTML=""+ui.save_config+"";
		if (user_info.priv < admin_priv){
			document.getElementById("button_saveConfig").style.display="none";
		}
		//document.getElementById("tab_copyright1").innerHTML=""+ui.copyRight1+"\n"+ui.copyRight2+"\n"+ui.copyRight3+"";
		document.getElementById("tab_copyright1").innerHTML=""+product.cprstr+" &copy;"+product.cprtime+"";
		document.getElementById("tab_copyright2").innerHTML=""+product.cprcom+""; 
		document.getElementById("tab_copyright3").innerHTML=""+product.cprrsvd+"";

		document.getElementById("table_status_system").style.display="block";

		document.getElementById("dir_span").innerHTML=menu.administration+" >> "+menu.system;
		setDefaultDirSpanOnMouseClick(menu.administration+" >> "+menu.system);
		document.getElementById("currentUser").innerHTML=ui.username+": "+user_info.name;

		openExtraDiv();//S

		cookiesInit();
		
	}

	var show_count=0;
	function show_help()
	{
	    show_count++;
		if(show_count%2!=0){helpWindow.show();
		helpWindow.setLocation(0, (size.windowWidth-200-15));}
		else{helpWindow.hide();}
		
	}
	function CloseEvent()
	{
		//alert('before unload2');
		//authLogout();
		
	}
	
	function cleanup()
	{
		//logout();
		if(helpWindow) delete helpWindow;
		if(contentWindow) delete contentWindow;
		helpWindow = null;
		contentWindow = null;
		//alert('unload');
		//authLogout();
	}




//////////////////////////////////////////////////////////////////	
	
	var MenuBar = initNewTreeHtml("Container",divData);

	function menuClick(obj)
	{

		var m = obj.getElementsByTagName("A")[0];
		var term = "menu." + m.getAttribute("id");
		var label = m.getAttribute("label");
		var url = m.getAttribute("value");
		var str = m.getAttribute("str");
		var id = m.getAttribute("id");
		
		//
		var labelTables=document.getElementById("frameLabels").getElementsByTagName("table");
		for(var i=0;i<labelTables.length;i++){
	     if(labelTables[i].getAttribute("name")=='label_table'){
				labelTables[i].style.display="none";
	      }
	      }
		
		
		//
	    var elts=document.getElementById("frameLabels").getElementsByTagName("span");
		for(var i=0;i<elts.length;i++){
	     if(elts[i].getAttribute("name")=='labelTdName'){
	        elts[i].style.color="#dedede";
	      }
	      }
		
		var Spantd_Fid_Id;
		if(document.getElementById("Span_"+id+"_td"+id)!=null){
			Spantd_Fid_Id=document.getElementById("Span_"+id+"_td"+id);
			Spantd_Fid_Id.style.color="#E2001a";
		}
		
		document.getElementById("table_"+id).style.display="block";
		//
//		document.getElementById("dir_span").innerHTML=str;
//		alert(str);
		setDefaultDirSpanOnMouseClick(str);
		if(upgrading){
			if(!confirm(infomsg.upgrade4 + infomsg.confm)) return;			
		}
	
		
		if(url=="logout.cgi"){
//			if(show_confirm(ui.confm + " " + menu.logout + " ?")){
//				window.location.replace(url);
//			}
			logout();
		}else if(url=="reboot.cgi"){
			if(show_confirm(ui.confm + " " + menu.reboot + " ?")){
				window.location.replace(url);
				do_logout = 0;
			}			
		}else if(url=="restore.cgi"){
			if(show_confirm(ui.confm + " " + menu.restore + " ?\n" + infomsg.relogin)){
				window.location.replace(url);
				do_logout = 0;
			}			
		}else{
			//findHelp(term);
			//if(url != null) showContent(label + ' --> ' + url, url);
			if(url != null) showContent(label, url);
			
			
		}		
	}

	function startUpgrade()
	{
		upgrading = 1;
		window.onbeforeunload=confirmUnload;
	}
	
	function stopUpgrade()
	{
		upgrading = 0;
		window.onbeforeunload=null; 
	}
</script>
</body>
</html>
