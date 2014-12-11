/**
 * Created by kkzhou on 14-8-28.
 */
define(function(require){
//    var DirectorOne=require("app/director_1");
    var html=require("text!partials/director_2.html");
    var App=require("app/originalApp");
    //var DirectorThree=require("app/director_3");
    var locale=require("tool/locale");
    var validator=require("tool/validator");
    var DirectorTwo=Class.create(App,{
        initialize:function($super,options){
            $super(options);
            this.preBrotherApp=options.appObj;
            this.mainApp=options.mainApp;
            this.render();
        },
        render:function(){
            var self=this;
            self.viewContainer.html(html);
            self.bindEvents();
            self.getTemplate();
            self.getRainbowConfig();
            validator.render("#inner-view-container",{
                promptPosition:"topLeft",
                scroll:false
            });
            locale.render();
        },
        getTemplate:function(){
            var self=this;
            self.ajax({
                type:"GET",
                url:"json/cliCommand.json",
                success:function(data,textStatus){
                    if(typeof data=="string"){
                        data=JSON.parse(data);
                    }
                    self.rainbowPostTemplate=data.rainbowconfig.cli_cmd_post;
                },
                error:function(xhr,err){

                }
            })
        },
        getRainbowConfig:function(){
            var self=this;
            self.ajax({
                type:"GET",
                url:"js/app/director_2.jsx",
                success:function(data,textstatus){
//                    eval(data);
                    var rainbowConfig=rainbow_config;
                    self.setFormData(rainbowConfig);
                },
                error:function(xhr,err){

                }
            })
        },
        setFormData:function(obj){
            var self=this;
            $("#rainbow_address").val(obj.server);
            $("#rainbow_port").val(obj.port);
            if(obj.enable){
                $("#check-mode").prop({
                    "checked":true
                });
            }
        },
        bindEvents:function(){
            var self=this;
            self.viewContainer .find("#pre-step").bind("click",function(e){
                self.destroySelfAll();
//                self.preBrotherApp.rebuild();
                self.fire("afterClick");
            }).end()
                .find("#next-step").bind("click",function(e){
                    var callback=function(data){
                        //self.destroySelfAll();
                        //self.directorThree=new DirectorThree({
                        //    elementId:"inner-view-container",
                        //    events:{
                        //        "afterClick":function(){
                        //            self.rebuild();
                        //        },
                        //        scope:self
                        //    }
                        //});
                        this.ajax({
                            url:"../apply.cgi",
                            type:"POST",
                            data:data,
                            processData:false,
                            contentType:"text/plain;charset=utf-8",
                            success:function(data,textStatus){
                                //self.destroySelfAll();
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
                .find("#rainbow_port").bind("change",function(e){
                    var temp=$(this).val();
                    var regex=/^\d+$/;
                    if(regex.test(temp)){
                        temp=parseInt(temp);
                        $(this).val(temp);
                    }
                });
        },
        mergeAndSendFormData:function(callback){
            var self=this;
            var data={};
            data.server=$("#rainbow_address").val();
            data.port=$("#rainbow_port").val();
            if($("#check-mode").prop("checked")){
                data.mode=1;
            }else{
                data.mode=0;
            }
            var template=new Template(self.rainbowPostTemplate);
            var result=template.evaluate(data);
            var str="_ajax=1&_web_cmd="+encodeURIComponent(result);
            callback.call(self,str);
        },
        destroySelfAll:function(){
            var self=this;
            self.viewContainer.find("#pre-step").unbind().end().find("#next-step").unbind();
            self.destroy();
        },
        rebuild:function(){
            var self=this;
            self.render();
        }
    });
    return DirectorTwo;
})