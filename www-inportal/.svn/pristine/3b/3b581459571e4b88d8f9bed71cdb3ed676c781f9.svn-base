var def_dir_span_str = "";

/*
*@ 初始化 树形菜单
*/
function initNewTreeHtml(containerID,xmlData)//树形结构创建方法
{
	var container = document.getElementById(containerID); //取得容器对象

	if(container == null) return null; 
	container.id = "";
	container.innerHTML = "";
	container.onclick = null;  //初始化 容器

	var father = document.createElement("DIV");  //创建一级(父)DIV层
	var child=null;  // 二级(儿)DIV层
	var grandson=null; //三级(孙)DIV层
	
	father.innerHTML = xmlData; //将xmlData里的数据 放入 一级层内 创建 三层DIV 嵌套结构
	var treeUL="";  //将三层循环提取出的信息 整合成HTML 存到 treeData 对象中
	treeUL+="<ul class='MenuBarHorizontal MenuBarActive' id='menuContainer' onmouseout='resetDirSpanOnMouseOut();'>";
	
	//一级菜单
	for(var i=0;i<father.childNodes.length;i++)  //一级(父)DIV 循环
	{
		childP=father.childNodes[i];
		var p_id=childP.getAttribute("id");
		var p_value=childP.getAttribute("value");
		var p_label=childP.getAttribute("label");
		var dirString=p_label;
		
		 treeUL+="<li data-flexmenu='"+p_id+"' onmouseover='updateDirSpanOnMouseOver(this);'>";
		 treeUL+="<a value='"+p_value+"' label='"+p_label+"' str='"+dirString+"' id='ulLista_"+p_id+"' class='MenuBarItemSubmenu' style='color:#e20001'><span>"+p_label+"</span>";
		 if(childP.childNodes.length>=1){
		 	treeUL+="<img style='border: 0pt none;' class='rightarrowclass' src='../css/arrow.gif'>";
		 }
		 treeUL+="</a>";
		 
		 if(childP.childNodes.length>=1){
		 		treeUL+="<ul id='"+p_id+"' style='margin-left: 150px;' class='flexdropdownmenu'   onmouseout='resetDirSpanOnMouseOut();'>";
			
			//二层菜单	
		 	for(var j=0;j<childP.childNodes.length;j++){
				var dirStr="";
		 		childF=childP.childNodes[j]; 
		 		var f_id=childF.getAttribute("id");     
				var f_value=childF.getAttribute("value");
				var f_label=childF.getAttribute("label");
				dirStr=p_label+" >> "+f_label;

                createFatherDivs(childF);
					if(true){ //调试时
					treeUL+="<li onclick='menuClick(this)' style='cursor:pointer' onMouseOver='updateDirSpanOnMouseOver(this)'>";
					treeUL+="<a value='"+f_value+"' label="+f_label+" id='"+f_id+"' str='"+dirStr+"' class=''>"+f_label+"</a>";
					treeUL+="</li>";
					}else{
						treeUL+="<li><a value='"+f_value+"' label="+f_label+" id='"+f_id+"' str='"+dirStr+"' class=''>"+f_label+"</a>";
						treeUL+="<ul>";
						   
						   //三级菜单
							for(var k=0;k<childF.childNodes.length;k++ ){
								childC = childF.childNodes[k];
								var c_id=childC.getAttribute("id");     
								var c_value=childC.getAttribute("value");
								var c_label=childC.getAttribute("label");
								dirStr=dirStr+" >> "+c_label; 
								var str=dirStr;

								     if(childC.childNodes.length<1){
												treeUL+="<li onclick='menuClick(this)'>";
												treeUL+="<a value='"+c_value+"' label="+c_label+" id='"+c_id+"'  str='"+str+"'  class=''>"+c_label+"</a>";
												treeUL+="</li>";
												}else{
													treeUL+="<li><a value='"+c_value+"' label="+c_label+" id='"+c_id+"'  str='"+str+"'  class=''>"+c_label+"</a>";
													treeUL+="<ul>";
														//四级菜单
														for(var r=0;r<childC.childNodes.length;r++ ){
															childR = childC.childNodes[r];
															var r_id=childR.getAttribute("id");     
															var r_value=childR.getAttribute("value");
															var r_label=childR.getAttribute("label");
															dirStr=dirStr+" >> "+r_label;
															
															var r_str=dirStr;
															treeUL+="<li onclick='menuClick(this)'>";
															treeUL+="<a value='"+r_value+"' label="+r_label+" id='"+r_id+"'  str='"+r_str+"'  class=''>"+r_label+"</a>";
															treeUL+="</li>";
															dirStr=p_label+" >> "+r_label;
														}
														treeUL+="</ul>";
													  treeUL+="</li>";
												  }
												  	
								dirStr=p_label+" >> "+f_label;
							}
							treeUL+="</ul>";
						  treeUL+="</li>";
					  }
		 	}
		 	treeUL+="</ul>";
		}
		treeUL+="</li>";	
	}
	    //添加trap栏入口
		/*treeUL+="<li data-flexmenu='trap_li' onClick='openTrapWindow()' onMouseOver='updateDirSpanOnMouseOver(this)'>";
		treeUL+="<a str='TRAP' id='trap_li_a' class='MenuBarItemSubmenu'><span>TRAP</span>";
		treeUL+="</a>";
		treeUL+="</li>";
	
	    //添加帮助栏入口
		treeUL+="<li data-flexmenu='help_li' onClick='openHelpWindow()' onMouseOver='updateDirSpanOnMouseOver(this)'>";
		treeUL+="<a str='"+ui.help+"'><span>"+ui.help+"</span></a>";
		treeUL+="</li>";*/
		
	treeUL+="</ul>";	
		container.innerHTML=treeUL;  //将treeData数据存入 container 对象中
}

 /*
 *@当鼠标在树形菜单上移动时,更新页面顶部路径
 */
function updateDirSpanOnMouseOver(obj){
	var m = obj.getElementsByTagName("A")[0];
	var str = m.getAttribute("str");
	document.getElementById("dir_span").innerHTML=str;
}

 /*
 *@当鼠标离开树形菜单时，恢复页签路径信息内容
 */
function resetDirSpanOnMouseOut(){
	document.getElementById("dir_span").innerHTML=def_dir_span_str;
}

function setDefaultDirSpanOnMouseClick(str){
	def_dir_span_str = str;
}

 /*
 *@初始化建立标签栏目
 */
function createFatherDivs(currentfather){
    var f_id=currentfather.getAttribute("id");
	var divTable="<table height='22px' name='label_table' id='table_"+f_id+"' style='display: none;' border='0' cellspacing='2'>";
	divTable+="<tr>";
	for(var i=0;i<currentfather.childNodes.length;i++)
	{
				var childC=currentfather.childNodes[i];           
				var c_id=childC.getAttribute("id");     
				var c_value=childC.getAttribute("value");
				var c_label=childC.getAttribute("label");
				var initTabColor="";
				if(i==0){
					initTabColor="#E2001A";
				}else{
					initTabColor="#dedede";
				}
		divTable+="<td  height='22px' valign='bottom'>";		
		divTable+="<table  height='22px'  border='0' cellpadding='0' cellspacing='0'>";
		divTable+="<tr>";
		divTable+="<td width='5px' style=' background-color: #ffffff' ></td>";		
		divTable+="<td  style='padding-left:2px;padding-right:4px;cursor:pointer' id='td"+c_id+"' label="+c_label+" value="+c_value+" f_id="+f_id+" onclick='tdClick(this)' ><span id='Span_"+f_id+"_td"+c_id+"' name='labelTdName'  style='font-size:12px; font-weight:bold;color:"+initTabColor+"'>"+c_label+"</span></td>";
	    divTable+="<td width='1px' style=' background-color:#ffffff' ></td>";
	    divTable+="</tr>";
	    divTable+="</table>";
	    divTable+="</td>";    
	    
	}
		divTable+="</tr>";
		divTable+="</table>";
		document.getElementById("frameLabels").innerHTML+=divTable;
}

 /*
 *@简化document.write函数
 */
function w(m) {

	m = "" + m + ""; 
	if ("undefined" != m) { 
	   document.write(m);
	   }

}

 /*
 *@点击标签,执行函数
 */
function tdClick(obj){
	var elts=document.getElementById("frameLabels").getElementsByTagName("span");
	for(var i=0;i<elts.length;i++){
     if(elts[i].getAttribute("name")=='labelTdName'){
        elts[i].style.color="#dedede";
      }
      }
    var f_id=obj.getAttribute("f_id");
    var id=obj.getAttribute("id");

	document.getElementById('Span_'+f_id+'_'+id).style.color="#E2001A";
	var url = obj.getAttribute("value");
	var label = obj.getAttribute("label");
	if(url != null) showContent(label, url);
	var term = "menu." + obj.getAttribute("id");
	findHelp(term);
}
