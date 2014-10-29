define(function(require){
    var html=require("text!partials/mainApp.html");
    var App=require("app/originalApp");
    require("../../css/mainApp.css");
    var locale=require("tool/locale");
    var validator=require("tool/validator");
    var DirectorOne=require("app/director_1");
    var MainApp=Class.create(App,{
        initialize:function($super,options){
            $super(options);
//            this.viewElement=$("#"+self.elementId);
            this.render();
        },
        render:function(){
            var self=this;
            self.viewContainer.html(html);
            self.bindEvents();
            locale.render();
            self.getUserData();
            self.getSummaryConfig();
        },
        bindEvents:function(){
            var self=this;
            self.viewContainer.find("#config-director").bind("click",function(e){
                self.destroys();
                self.directorOne=null;
                self.directorOne=new DirectorOne({
                    elementId:"page-view",
                    events:{
                        "afterClick":function(){
                            self.rebuild();
//                            $(document).find("p.footer-company").removeClass("footer-margin-top");
                        },
                        scope:self
                    }
                });
//                self=null;
            });
        },
        rebuild:function(){
            var self=this;
            self.render();
        },
        getUserData:function(){
            var self=this;
            self.ajax({
                url:"json/user.json",
                type:"get",
                contentType:"application/json",
                success:function(data,textStatus){
                    if(typeof data=="string"){
                        data=JSON.parse(data);
                    }
                    $("#nav-row").find("#user-name").text(data.name);
//                    console.log(data);
                }
            })
        },
        getSummaryConfig:function(){
            var self=this;
            self.ajax({
                url:"json/summary.json",
                type:"get",
                contentType:"application/json",
                success:function(data,textStatus){
                    if(typeof data=="string"){
                        data=JSON.parse(data);
                    }
                    self.viewContainer.find("#network-state").text(data.network.state).end()
                        .find("#network-period").text(data.network.period).end()
                        .find("#network-flow").text(data.network.flow).end()
                        .find("#wifi-ssid").text(data.wifi.ssid).end()
                        .find("#wifi-devices").text(data.wifi.devices).end()
                        .find("#wifi-users").text(data.wifi.users).end()
                        .find("#sync-html").text(data.sync.html).end()
                        .find("#sync-scripts").text(data.sync.scripts).end()
                        .find("#sync-conf").text(data.sync.conf);
                }
            })
        },
        destroys:function(){
            var self=this;
            self.destroy();
            self.viewContainer.find("#config-director").unbind();
        }
    });
    return MainApp;
})/**
 * Created by kkzhou on 14-8-26.
 */
