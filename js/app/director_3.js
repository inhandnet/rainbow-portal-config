/**
 * Created by kkzhou on 14-8-28.
 */
define(function(require){
    var App=require("app/originalApp");
    var html=require("text!partials/director_3.html");
    var locale=require("tool/locale");
    var validator=require("tool/validator");
    var DirectorThree=Class.create(App,{
        initialize:function($super,options){
            $super(options);
            this.preBrotherApp=options.appObj;
            this.mainApp=options.mainApp;
            this.rowArr=[];
            this.render();
        },
        render:function(){
            var self=this;
            self.viewContainer.html(html);
//            self.addClass();
            self.bindEvents();
            self.getMacWhiteList();
//            self.getTableData();
            locale.render();
        },
        addClass:function(){
            var self=this;
            $(document).find("p.footer-company").addClass("footer-margin-top");
        },
        removeClass:function(){
            var self=this;
            $(document).find("p.footer-company").removeClass("footer-margin-top");
        },
        getMacWhiteList:function(){
            var self=this;
            self.ajax({
                type:"GEt",
                url:"js/app/director_3.jsx",
                success:function(data,textstatus){
//                    eval(data);
                    var portalConfig=portal_wd_config;
                    var arr=portalConfig.wd_trusted_mac_list;
                    self.setFormData(arr);
                },
                error:function(xhr,err){

                }
            })
        },
        setFormData:function(arr){
            var self=this;
            arr.each(function(one,i){
                $("#white-mac-"+(i+1)).val(one);
            })
        },
        getTableData:function(){
            var self=this;
            $.ajax({
                url:"json/device.json",
                type:"get",
                contentType:"application/json",
                success:function(data,textstatus){
                    if(typeof data=="string"){
                        data=JSON.parse(data);
                    }
                    data.each(function(one){
                        var row=$("<tr></tr>");
                        row.data=one;
                        var col1=$("<td><input type='checkbox' class='my-table-checkbox '></td>").appendTo(row);
                        var col2=$("<td></td>").text(one.mac).appendTo(row);
                        var col3=$("<td></td>").text(one.name).appendTo(row);
                        self.viewContainer.find("table tbody").append(row);
//                        self.rowArr.push(row);
                    });
                }
            })
        },
        bindEvents:function(){
            var self=this;
            self.viewContainer .find("#pre-step").bind("click",function(e){
                self.destroySelfAll();
//                self.removeClass();
                self.fire("afterClick");
            }).end()
                .find("#apply-config").bind("click",function(e){
//                    self.destroySelfAll();

                    var callback=function(data){
                        this.ajax({
                            url:"../apply.cgi",
                            type:"POST",
                            data:data,
                            processData:false,
                            contentType:"text/plain;charset=utf-8",
                            success:function(data,textStatus){
                                self.destroySelfAll();
                                $("#return-to-homepage").trigger("click");
                            },
                            error:function(xhr,err){
                            },
                            showBlock:true
                        });
                    };
                    if(validator.result("#inner-view-container")){
                        self.mergeAndSendFormData(callback);
                    }
                }).end()
                .find("#th-check-all").bind("click",function(e){
                    if(e.target.checked){
                        self.viewContainer.find("table tbody td input[type='checkbox']").prop("checked",true);
                    }else{
                        self.viewContainer.find("table tbody td input[type='checkbox']").prop("checked",false);
                    }
                }).end();
        },
        mergeAndSendFormData:function(callback){
            var self=this;
            var data=[];
            for(var i=0;i<5;i++){
                var str="white-mac-"+(i+1);
                var arrEle=$("#"+str).val();
                data.push(arrEle);
            }
            var template_part="\nportal trusted-mac ";
            var iterateTemplate="";
            var flag=false;
            data.each(function(one){
                if(one){
                    iterateTemplate+=template_part+one;
                    flag=true;
                }
            });
            if(!flag){
                iterateTemplate="";
            }
            var result="!"+iterateTemplate+"\nportal enable";
            var str="_ajax=1&_web_cmd="+encodeURIComponent(result);
            callback.call(self,str);
        },
        rebuild:function(){
            var self=this;
            self.render();
        },
        destroySelfAll:function(){
            var self=this;
            self.viewContainer.find("#pre-step").unbind().end().find("#next-step").unbind();
            self.destroy();
        }
    });
    return DirectorThree;
})