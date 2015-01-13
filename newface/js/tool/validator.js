define(function(require){
    require("lib/jquery.validationEngine");
    var validator={
        storageLang:null,
        langPacks:{},
        element:null,
        elements:[],
        validation:null,
        render:function(element,paramObj){
            this._cacheElements(element,paramObj);
            this._cacheStorageLang();
//			this.hideAll();
//			this._destroy();
            this._render();
        },
        _cacheStorageLang:function(){
            var lang = this._returnStorageLang();
            if(!this.storageLang){
                this.storageLang = lang ? lang : "zh_CN";
            }else{
                if(this.storageLang != lang){
                    this.storageLang = lang ? lang : "zh_CN";
                }
            }
        },
        _cacheElements:function(element,paramObj){
            var self = this;
            this.element = element;
            var elements = this.elements;
            var defaultObj = {
                fadeDuration: 0,
                showOneMessage:true,
                focusFirstField:true,
                customFunctions:{
                    cloudInput:function(field, rules, i, options){
                        var nohtml  = new RegExp("(<[^>]+>)|(&gt|&lt|&amp|&quot|&nbsp)");
                        if( nohtml.test(field.val()) ){
                            return options.allrules.nohtml.alertText;
                        }
                        return true;
                    }
                }
            };
            paramObj = $.extend(paramObj,defaultObj);
            if(elements.length > 0){
                var count = 0;
                $.each(elements,function(index,obj){
                    if(element == obj.element){
                        var currentParamObj = obj.paramObj;
                        var newParamObj = $.extend(currentParamObj,paramObj);
                        self.elements[index]["paramObj"] = newParamObj;
                        count++;
                    }
                });
                if(count === 0){
                    this.elements.push({element:element,paramObj:paramObj});
                }
            }else{
                this.elements.push({element:element,paramObj:paramObj});
            }
        },
        result:function(element){
            if(this.validation){
                if(element){
                    return $(element).validationEngine('validate');
                }else{
                    return $(this.element).validationEngine('validate');
                }
            }
        },
        prompt:function(element,obj){
            $(element).validationEngine("showPrompt",obj.text,"load",obj.promptPosition?obj.promptPosition:"topLeft",true);
        },
        hide:function(element){
            if(element){
                $(element).validationEngine('hide');
            }else{
                $(this.element).validationEngine('hide');
            }
        },
        hideAll:function(element){
            if(element){
                $(element).validationEngine('hideAll');
            }else{
                var elements = this.elements;
                if(this.validation){
                    $.each(elements,function(index,obj){
                        $(obj.element).validationEngine('hideAll');
                    });
                }
            }
        },
        _destroy:function(){
            var elements = this.elements;
            if(this.validation){
                this.validation = null;
                $.each(elements,function(index,obj){
                    $(obj.element).validationEngine('detach');
                });
            }
        },
        _render:function(){
            var storageLang = this.storageLang;
            var hasPack = function(){
                var langPacks = self.langPacks;
                for(var attr in langPacks){
                    if(attr == storageLang){
                        return true;
                    }
                }
            };
            if(hasPack()){
                this._renderForm();
            }else{
                this._loadPack();
            }
        },
        _returnStorageLang:function(){
            return localStorage.getItem("language");
        },
        _renderForm:function(){
            var self = this;
            var elements = this.elements;
            self._returnAllRules();
            $.each(elements,function(index,obj){
                self.validation = $(obj.element).validationEngine('attach',obj.paramObj);
            });
        },
        _loadPack:function(){
            var self = this;
            var url = "lang/"+ self.storageLang + "/validationengine.lang.js";
            $.getScript(url,function(data){
                self._cacheLangPacks();
                self._renderForm();
            });
        },
        _returnAllRules:function(){
            var self = this;
            var returnAllRules = function(){
                $.validationEngineLanguage.allRules = self.langPacks[self.storageLang];
            };
            return returnAllRules();
        },
        _cacheLangPacks:function(){
            var self = this;
            var lang = $.validationEngineLanguage;
            var langName,langObj;
            for(var attr in lang){
                langName = attr;
                langObj = lang[attr];
            }
            self.langPacks[langName] = langObj;
        }
    };
    return validator;
})
