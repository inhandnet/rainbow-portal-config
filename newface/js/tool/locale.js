/**
 * Created by kkzhou on 14-9-9.
 */
define(function(require){
    var enPackage=require("lang/en/lang");
    var zhPackage=require("lang/zh_CN/lang");
    var locale={
        defaultLanguage:"zh_CN",
//    defaultLanguage:"en",
        english:enPackage,
        chinese:zhPackage,
        render:function(){
            var self=this;
            var langDom=$("[data-lang]");
            self._setInner(langDom);
        },
        set:function(obj){
            var self=this;
            if(obj.lang){
                self.defaultLanguage=obj.lang;
            }
            self.render();
        },
        get:function(keyStr){
            var self=this;
            if(self.defaultLanguage=="zh_CN"){
                return self.chinese[keyStr];
            }else if(self.defaultLanguage=="en"){
                return self.english[keyStr];
            }
        },
        setLocalStorage:function(langstr){
            var self=this;
            localStorage.setItem("language",langstr);
            return this;
        },
        _setInner:function(langDom){
            var self=this;
            var languagePack;
            self.defaultLanguage=localStorage.getItem("language");
            if(self.defaultLanguage=="zh_CN"){
                languagePack=self.chinese;
            }else if(self.defaultLanguage=="en"){
                languagePack=self.english;
            }
            langDom.each(function(one){
                var domCur=$(langDom[one]);
                var currentIndex=domCur.attr("data-lang");
                var lastLg=currentIndex.lastIndexOf("}");
                var tempStr=currentIndex.slice(1,lastLg);
                var tempArr_1=tempStr.split(",");
                tempArr_1.each(function(two){
                    var smTempArr=two.split(":");
                    var index=smTempArr[0];
                    if(smTempArr[1].indexOf("+")!=-1){
                        var xsTempArr=smTempArr[1].split("+");
                    }
                    switch (index){
                        case "text":
                            var str="";
                            if(xsTempArr){
                                xsTempArr.each(function(one){
                                    if(languagePack[one]){
                                        str+=languagePack[one];
                                    }else{
                                        str+=one;
                                    }
                                });
                            }else{
                                str=languagePack[smTempArr[1]];
                            }
                            domCur.html(str);
                            break;
                        case "placeholder":
                            var str="";
                            if(xsTempArr){
                                xsTempArr.each(function(one){
                                    if(languagePack[one]){
                                        str+=languagePack[one];
                                    }else{
                                        str+=one;
                                    }
                                });
                            }else{
                                str=languagePack[smTempArr[1]];
                            }
                            domCur.attr({"placeholder":str});
                            break;
                    }
                })
            });
        }
    };
    return locale;
});

