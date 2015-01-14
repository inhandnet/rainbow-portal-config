<% pagehead(infomsg.logout) %>
<body>
    <script type="text/javascript" src="js/lib/jquery-1.11.1.min.js"></script>
    <script type="text/javascript">
        var linkEle_1=$("<link/>").attr({
        "rel":"stylesheet",
        "type":"text/css",
        "href":"css/bootstrap.min.css"
        });
        var linkEle_2=$("<link/>").attr({
        "rel":"stylesheet",
        "type":"text/css",
        "href":"css/logout.css"
        });
        $(document.head).append(linkEle_1).append(linkEle_2);
    </script>
    <script type="text/javascript">
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
        xmlhttp.open("GET","",false,'_logout',"");
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
        authLogout();
    </script>
    <div class="container-fluid">
    <div class="row">
    <div style="margin-top:100px" class="col-lg-offset-3 col-lg-5 col-md-offset-4 col-md-7 col-sm-offset-3 col-sm-9 col-xs-offset-1 col-xs-13 div_box_shadow">
    <div class="row text-center">
    <span class="login_success_tip">退出成功</span>
    </div>
    </div>
    </div>
    <div class="row" style="margin-top: 25px">
    <div class="col-lg-offset-3 col-lg-5 col-md-offset-4 col-md-7 col-sm-offset-3 col-sm-9 col-xs-offset-1 col-xs-13">
    <div class="row">
    <!--<div class="col-lg-8 col-sm-8 col-xs-7">-->
    <!--<a href="http://wifi.go/login_page/index.html" class='btn btn-primary btn-raised btn-lg padding_self'>返回登录页</a>-->
    <!--</div>-->
    <div class="col-lg-15 col-sm-15 col-xs-15 text-right">
    <a style="width:100%" href="./index.html" class='btn btn-success btn-raised btn-lg padding_self'>返回配置页面</a>
    </div>
    </div>
    </div>
    </div>
    </div>
</body>
</html>
