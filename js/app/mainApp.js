define(function(require){
    var html=require("text!partials/mainApp.html");
    var App=require("app/originalApp");
    require("text!../../css/mainApp.css");
    var locale=require("tool/locale");
    var validator=require("tool/validator");
    var DirectorOne=require("app/director_1");
    function timeFormate(seconds){
        if(seconds>0&&seconds<60){
            return seconds+locale.get("seconds");
        }else if(seconds>=60&&seconds<3600){
            var leftSeconds=seconds%60;
            var minutes=(seconds-leftSeconds)/60;
            return minutes+locale.get("minutes")+leftSeconds+locale.get("seconds");
        }else if(seconds>=3600&&seconds<86400){
            var leftSeconds=seconds%3600;
            var hours=(seconds-leftSeconds)/3600;
            var tempLeftSeconds=leftSeconds%60;
            var minutes=(leftSeconds-tempLeftSeconds)/60;
            return hours+locale.get("hours")+minutes+locale.get("minutes")+tempLeftSeconds+locale.get("seconds");
        }else if(seconds>=86400){
            var leftSeconds=seconds%86400;
            var days=(seconds-leftSeconds)/86400;
            var tempLeftSeconds=leftSeconds%3600;
            var hours=(leftSeconds-tempLeftSeconds)/3600;
            var finaLeftSeconds=tempLeftSeconds%60;
            var minutes=(tempLeftSeconds-finaLeftSeconds)/60;
            return days+locale.get("days")+hours+locale.get("hours")+minutes+locale.get("minutes")+finaLeftSeconds+locale.get("seconds");
        }
    }
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
            self.getUserData();
            self.interval=setInterval(function(){
                self.ajaxInterval();
            },3000);
            //self.getSummaryConfig();
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
            //退出按钮
            $("#config-quit").bind("click",function(e){
                sweetAlert({
                        title: locale.get("awayFromConfig"),
                        //text: "You will not be able to recover this imaginary file!",
                        type: "warning",
                        showCancelButton: true,
                        cancelButtonText:locale.get("cancell"),
                        confirmButtonColor: "#3F9B40",
                        confirmButtonText: locale.get("confirm"),
                        closeOnConfirm: false
                    },

                    function () {
                        //退出操作在此进行
                        window.location.href="logout.jsp";
                    })
            });
        },
        rebuild:function(){
            var self=this;
            self.render();
            clearInterval(self.interval);
        },
        ajaxInterval: function () {
            var self=this;
            self.ajax({
                url:"js/app/mainApp.jsx",
                type:"get",
                success:function(data,textStatus){
                    eval(data);
                    $("#nav-row").find("#user-name").text(user_info.name);
                    static_route_config.each(function(one){
                        if(one[0]=="0.0.0.0"&&one[1]=="0.0.0.0"){
                            self.wanPort=one[2];
                        }
                    });
                    var data=self.formatData();
                    if(!data.statusComment){
                        data.statusComment=locale.get("unknown");
                    }
                    if(!data.wanPort){
                        data.wanPort=locale.get("unknown");
                    }
                    if(!data.connectTime){
                        data.connectTime=locale.get("unknown");
                    }
                    self.viewContainer.find("#network-state").text(data.statusComment+","+data.wanPort).end()
                        .find("#network-period").text(data.connectTime).end();
                    var language=ih_sysinfo.lang.toLowerCase();
                    if(language=="chinese"){
                        localStorage.setItem("language","zh_CN");
                    }else{
                        localStorage.setItem("language","en");
                    }
                    locale.render();
                }
            })
        },
        getUserData:function(){
            var self=this;
            self.ajaxInterval();
        },
        formatData: function () {
            var self=this;
            var network=new Object();
            //switch (self.wanPort){
            //    case "cellular 1":
            if(self.wanPort.indexOf("cellular")!=-1){
                network.wanPort="3G/LTE";
                var cellular_arr=cellular_interface.find(function(one){
                    return one[0]=="cellular 1";
                });
                var posSt=cellular_arr[2];
                if(posSt==1){
                    network.statusComment=locale.get("connected");
                }else if(posSt==0){
                    network.statusComment=locale.get("disconnected")
                }
                var posTime=cellular_arr[8];
                if(posTime==0){
                    network.connectTime=locale.get("disconnected");
                }else if(posTime>0){
                    network.connectTime=timeFormate(posTime);
                }
            }else if(self.wanPort.indexOf("dialer")!=-1){
                network.wanPort="ADSL";
                var arr_adsl=xdsl_interface.find(function (one) {
                    return one[0].indexOf("dialer")!=-1;
                });
                var posSt=arr_adsl[2];
                if(posSt=="1"){
                    network.statusComment=locale.get("connected");
                }else if(posSt=="0"){
                    network.statusComment=locale.get("disconnected");
                }
                var posTime=arr_adsl[8];
                if(posTime==0){
                    network.connectTime=locale.get("disconnected");
                }else if(posTime>0){
                    network.connectTime=timeFormate(posTime);
                }
            }else if(self.wanPort.indexOf("vlan")!=-1){
                var arr_vlan=svi_interface.find(function(one){
                    return one[0]=="vlan 10";
                });
                if(arr_vlan) {
                    //self.distinguish = arr_3[6];
                    if(arr_vlan[6]=="1"){
                        network.wanPort="DHCP";
                    }else if(arr_vlan[6]=="0"){
                        network.wanPort="Static IP"
                    }
                    var posSt=arr_vlan[2];
                    if(posSt=="1"){
                        network.statusComment=locale.get("connected");
                    }else if(posSt=="0"){
                        network.statusComment=locale.get("disconnected");
                    }
                    var posTime=arr_vlan[9];
                    if(posTime==0){
                        network.connectTime=locale.get("disconnected");
                    }else if(posTime>0){
                        network.connectTime=timeFormate(posTime);
                    }
                }
            }
                //case "dialer xxx":
                //    break;
                //case "vlan 10":

            //        break;
            //    default :
            //}
            return network;
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
            clearInterval(self.interval);
        }
    });
    return MainApp;
})/**
 * Created by kkzhou on 14-8-26.
 */
