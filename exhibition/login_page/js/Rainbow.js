/**
 * Created by zhouyunkui on 14-7-2.
 */
    var packages={
            default:"base",
            base:"language"
        };
    Rainbow={
        locale:{
            en:{
                "free_wifi_access":"Free Wifi Access",
                "access_wifi":"Login",
                "enter_mobile_number":"Enter your mobile number",
                "enter_password":"Enter your password",
                "get_code":"Get Code",
                "login":"Login",
                "other_login_way":"Other Access",
                "sina":"Sina",
                "qq":"QQ",
                "remember_me":"Remember me,Log in automatically",
                "conditions_terms":"CONDITIONS&TERMS",
                "agree":"Agree",
                "seconds":"S",
                "phone_number_format_error":"Phone number format error",
                "password_invalid":"Password can not be empty",
                "return_back":"Return",
                "qr_code":"Scanning QR code,add attention,not only the Internet,but also to get more information!",
                "rquest_timeout":"",
                "one_click":"A key Login",
                10001:"System error",
                21324:"Invalid client",
                60001:"Mac address error or blacklist",
                60002:"Wifi User does not exist",
                60003:"SmsCodeId format error or empty",
                60004:"SmsCode expired",
                60005:"SmsCode does not exist",
                60006:"WifiUser's password error",
                60007:"WifiUser's username in blacklist",
                60008:"One WifiUser can only login at 10 terminals.",
                60009:"Phone number error",
                60010:"Oauth2 authorization code error or expired",
                60011:"Wifi User's group name repeated",
                60012:"Blacklist or Whitelist name repeated",
                60013:"Party 3rd username can not login by this way",
                60014:"This phone number is not the authenticated one",
                60250:"Sms frequency error by mac or phone",
                70001:"Gateway error",
                70002:"AuthServer is not connected",
                70003:"Param error, see doc for more info"
            },
            zh_CN:{
                "free_wifi_access":"免费wifi接入",
                "access_wifi":"WIFI登入",
                "enter_mobile_number":"请输入手机号",
                "enter_password":"请输入验证码",
                "get_code":"获取验证码",
                "login":"登录",
                "other_login_way":"其他登入方式",
                "sina":"新浪微博",
                "qq":"QQ",
                "remember_me":"记住我,下次自动登录",
                "conditions_terms":"服务协议",
                "agree":"同意",
                "seconds":"秒",
                "phone_number_format_error":"手机号码格式错误",
                "password_invalid":"密码不能为空",
                "return_back":"返回",
                "qr_code":"微信扫一扫,点击关注就上网！",
                "rquest_timeout":"",
                "one_click":"一键登录",
                10001:"系统错误",
                21324:"未注册的设备",
                60001:"MAC地址存在于黑名单中",
                60002:"用户不存在",
                60003:"验证码错误",
                60004:"验证码过期",
                60005:"验证码不存在",
                60006:"用户密码错误",
                60007:"用户存在于黑名单中",
                60008:"一个账号最多只能同时登录10个终端",
                60009:"手机号码错误",
                60010:"授权码错误或过期",
                60011:"用户组名已存在",
                60012:"已存在该名单中",
                60013:"第三方账号不能通过此种方式登录",
                60014:"手机号账号未授权",
                60250:"获取验证码过于频繁",
                70001:"网关错误",
                70002:"未连接授权服务器",
                70003:"请求错误"//"请求参数错误"
            },
            set:function(opt){
                var self=this;
                switch (opt.lang){
                    case "en":
                    case "zh_CN":
                        self.language=opt.lang;
                        break;
                    default :
                        self.language="zh_CN";
                        break;
                }
            },
            get:function(str){
                var self=this;
                if(self.language=="en"){
                    return self.en[str];
                }else if(self.language=="zh_CN"){
                    return self.zh_CN[str]
                }else{
                    return "未知参数"
                }
            }
        },
        cloud:{
            //返回按钮的url
            url:"../index.html",
            //设置请求的域名或ip(如果有端口，则也应该加上)
            inPortalApiHost:"http://api.m.inhand.com.cn:5280",
            //阿里云
//            platformApiHost:"http://182.92.159.210",
//            organId:"53BA4E43C9211E47D000000C",//阿里云上,liwei@inhand.com.cn的机构，测试用
            //优途云
//            platformApiHost:"http://42.96.188.34",
//            organId:"53DEEEA7E826667304000716",//优途云上的机构
           //设置手机账号登录时，需要向平台发送的client_id和client_secret
            clientId:"539ea49d3273d8193c353ecc",
            clientSecret:"08E9EC6793125651287CB8BAE52615E2",
            //设置手机账号登录(区别于第三方登录方式)成功后的，应该跳转到的页面(可自定义)
            afterLoginSucessPage:"http://www.baidu.com",
            //此为密码加密的前缀
            preStr:"rainbow",
            //获取机构id、后台ip和会员认证方式
            getStaticParamUri:"/api/gateway/gateway_info",
            //(client-gateway)获取手机码api的uri
            getSmsCodeApiUri:"/api/gateway/sms_code",
            //(client-Authserver)手机账号登录授权api的uri
            phoneLoginCodeApiUri:"/api/wifi_authenticate",
            //(client-gateway)手机账号登录获取token api的uri
            phoneLoginTokenApiUri:"/api/gateway/access_token",
            //(client-gateway)一键登录api
            oneKeyLoginApiUri:"/api/gateway/validate_code",
            md5:(function(str) {
                var hex_chr = "0123456789abcdef";
                function rhex(num) {
                    str = "";
                    for ( var j = 0; j <= 3; j++) {
                        str += hex_chr.charAt((num >> (j * 8 + 4)) & 15)+ hex_chr.charAt((num >> (j * 8)) & 15);
                    }
                    return str;
                }
                function str2blks_MD5(str) {
                    nblk = ((str.length + 8) >> 6) + 1;
                    blks = new Array(nblk * 16);
                    for ( var i = 0; i < nblk * 16; i++) {
                        blks[i] = 0;
                    }
                    for (i = 0; i < str.length; i++) {
                        blks[i >> 2] |= str.charCodeAt(i) << ((i % 4) * 8);
                    }
                    blks[i >> 2] |= 128 << ((i % 4) * 8);
                    blks[nblk * 16 - 2] = str.length * 8;
                    return blks;
                }
                function add(x, y) {
                    var lsw = (x & 65535) + (y & 65535);
                    var msw = (x >> 16) + (y >> 16) + (lsw >> 16);
                    return (msw << 16) | (lsw & 65535);
                }
                function rol(num, cnt) {
                    return (num << cnt) | (num >>> (32 - cnt));
                }
                function cmn(q, a, b, x, s, t) {
                    return add(rol(add(add(a, q), add(x, t)), s), b);
                }
                function ff(a, b, c, d, x, s, t) {
                    return cmn((b & c) | ((~b) & d), a, b, x, s, t);
                }
                function gg(a, b, c, d, x, s, t) {
                    return cmn((b & d) | (c & (~d)), a, b, x, s, t);
                }
                function hh(a, b, c, d, x, s, t) {
                    return cmn(b ^ c ^ d, a, b, x, s, t);
                }
                function ii(a, b, c, d, x, s, t) {
                    return cmn(c ^ (b | (~d)), a, b, x, s, t);
                }
                function MD5(str) {
                    x = str2blks_MD5(str);
                    var a = 1732584193;
                    var b = -271733879;
                    var c = -1732584194;
                    var d = 271733878;
                    for ( var i = 0; i < x.length; i += 16) {
                        var olda = a;
                        var oldb = b;
                        var oldc = c;
                        var oldd = d;
                        a = ff(a, b, c, d, x[i + 0], 7, -680876936);
                        d = ff(d, a, b, c, x[i + 1], 12, -389564586);
                        c = ff(c, d, a, b, x[i + 2], 17, 606105819);
                        b = ff(b, c, d, a, x[i + 3], 22, -1044525330);
                        a = ff(a, b, c, d, x[i + 4], 7, -176418897);
                        d = ff(d, a, b, c, x[i + 5], 12, 1200080426);
                        c = ff(c, d, a, b, x[i + 6], 17, -1473231341);
                        b = ff(b, c, d, a, x[i + 7], 22, -45705983);
                        a = ff(a, b, c, d, x[i + 8], 7, 1770035416);
                        d = ff(d, a, b, c, x[i + 9], 12, -1958414417);
                        c = ff(c, d, a, b, x[i + 10], 17, -42063);
                        b = ff(b, c, d, a, x[i + 11], 22, -1990404162);
                        a = ff(a, b, c, d, x[i + 12], 7, 1804603682);
                        d = ff(d, a, b, c, x[i + 13], 12, -40341101);
                        c = ff(c, d, a, b, x[i + 14], 17, -1502002290);
                        b = ff(b, c, d, a, x[i + 15], 22, 1236535329);
                        a = gg(a, b, c, d, x[i + 1], 5, -165796510);
                        d = gg(d, a, b, c, x[i + 6], 9, -1069501632);
                        c = gg(c, d, a, b, x[i + 11], 14, 643717713);
                        b = gg(b, c, d, a, x[i + 0], 20, -373897302);
                        a = gg(a, b, c, d, x[i + 5], 5, -701558691);
                        d = gg(d, a, b, c, x[i + 10], 9, 38016083);
                        c = gg(c, d, a, b, x[i + 15], 14, -660478335);
                        b = gg(b, c, d, a, x[i + 4], 20, -405537848);
                        a = gg(a, b, c, d, x[i + 9], 5, 568446438);
                        d = gg(d, a, b, c, x[i + 14], 9, -1019803690);
                        c = gg(c, d, a, b, x[i + 3], 14, -187363961);
                        b = gg(b, c, d, a, x[i + 8], 20, 1163531501);
                        a = gg(a, b, c, d, x[i + 13], 5, -1444681467);
                        d = gg(d, a, b, c, x[i + 2], 9, -51403784);
                        c = gg(c, d, a, b, x[i + 7], 14, 1735328473);
                        b = gg(b, c, d, a, x[i + 12], 20, -1926607734);
                        a = hh(a, b, c, d, x[i + 5], 4, -378558);
                        d = hh(d, a, b, c, x[i + 8], 11, -2022574463);
                        c = hh(c, d, a, b, x[i + 11], 16, 1839030562);
                        b = hh(b, c, d, a, x[i + 14], 23, -35309556);
                        a = hh(a, b, c, d, x[i + 1], 4, -1530992060);
                        d = hh(d, a, b, c, x[i + 4], 11, 1272893353);
                        c = hh(c, d, a, b, x[i + 7], 16, -155497632);
                        b = hh(b, c, d, a, x[i + 10], 23, -1094730640);
                        a = hh(a, b, c, d, x[i + 13], 4, 681279174);
                        d = hh(d, a, b, c, x[i + 0], 11, -358537222);
                        c = hh(c, d, a, b, x[i + 3], 16, -722521979);
                        b = hh(b, c, d, a, x[i + 6], 23, 76029189);
                        a = hh(a, b, c, d, x[i + 9], 4, -640364487);
                        d = hh(d, a, b, c, x[i + 12], 11, -421815835);
                        c = hh(c, d, a, b, x[i + 15], 16, 530742520);
                        b = hh(b, c, d, a, x[i + 2], 23, -995338651);
                        a = ii(a, b, c, d, x[i + 0], 6, -198630844);
                        d = ii(d, a, b, c, x[i + 7], 10, 1126891415);
                        c = ii(c, d, a, b, x[i + 14], 15, -1416354905);
                        b = ii(b, c, d, a, x[i + 5], 21, -57434055);
                        a = ii(a, b, c, d, x[i + 12], 6, 1700485571);
                        d = ii(d, a, b, c, x[i + 3], 10, -1894986606);
                        c = ii(c, d, a, b, x[i + 10], 15, -1051523);
                        b = ii(b, c, d, a, x[i + 1], 21, -2054922799);
                        a = ii(a, b, c, d, x[i + 8], 6, 1873313359);
                        d = ii(d, a, b, c, x[i + 15], 10, -30611744);
                        c = ii(c, d, a, b, x[i + 6], 15, -1560198380);
                        b = ii(b, c, d, a, x[i + 13], 21, 1309151649);
                        a = ii(a, b, c, d, x[i + 4], 6, -145523070);
                        d = ii(d, a, b, c, x[i + 11], 10, -1120210379);
                        c = ii(c, d, a, b, x[i + 2], 15, 718787259);
                        b = ii(b, c, d, a, x[i + 9], 21, -343485551);
                        a = add(a, olda);
                        b = add(b, oldb);
                        c = add(c, oldc);
                        d = add(d, oldd);
                    }
                    return rhex(a) + rhex(b) + rhex(c) + rhex(d);
                }

                if (!String.prototype.md5) {
                    String.prototype.md5 = function() {
                        return MD5(this).toUpperCase();
                    };
                }
                return function(str){
                    return MD5(str).toUpperCase();
                };
            })()
        }
    };