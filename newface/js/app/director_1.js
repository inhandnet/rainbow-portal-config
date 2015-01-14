/**
 * Created by kkzhou on 14-8-26.
 */
define(function(require){
    var html=require("text!partials/director_1.html");
    var App=require("app/originalApp");
    var DirectorTwo=require("app/director_2");
    var locale=require("tool/locale");
    var validator=require("tool/validator");
//    var MainApp=require("app/mainApp");
    var DirectorOne=Class.create(App,{
        initialize:function($super,options){
            $super(options);
            this.wanRowClassArray=["","cell-row","adsl-row","dhcp-row","static-ip-address-row"];
            this.mainApp=options.mainApp;
            this.render();
        },
        render:function(){
            var self=this;
            self.viewContainer.html(html);
            self.bindEvents();
            self.getTemplate();
            self.getCurrentConfig();
            validator.render("#inner-view-container",{
                promptPosition:"topRight",
                scroll:false
            });
            locale.render();
        },
        setFormData:function(obj){
            var self=this;
            var cellular=obj.cellularConfig;
            var adsl=obj.adslConfig;
            var dhcp=obj.staticIpConfig;
            //3g
            $("#cellular-apn").val(cellular.apn);
            $("#cellular-dial-number").val(cellular.dialNumber);
            $("#cellular-username").val(cellular.username);
            $("#cellular-password").val(cellular.password);
            //adsl
            if(adsl){
                $("#adsl-username").val(adsl.username);
                $("#adsl-password").val(adsl.password);
            }
            //staticip
            $("#static-ip-address-main-ip").val(dhcp.staticIp);
            if(dhcp.subnetMask){
                $("#static-ip-address-subnet-mask").val(dhcp.subnetMask);
            }else{
                $("#static-ip-address-subnet-mask").val("255.255.255.0");
            }
            $("#static-ip-address-gateway").val(dhcp.gateway);
            $("#static-ip-address-preferred-domain").val(dhcp.dns_1);
            $("#static-ip-address-alternate-domain").val(dhcp.dns_2);
            self.setSelect();
        },
        setSelect:function(){
            var self=this;
            switch (self.wanPort){
                case "cellular 1":
                    $("select#wan_port").val(1).trigger("change");
                    break;
                case "dialer 10":
                    $("select#wan_port").val(2).trigger("change");
                    break;
                case "vlan 10":
                    if(self.distinguish==1){
                        $("select#wan_port").val(3).trigger("change");
                    }else if(self.distinguish==0){
                        $("select#wan_port").val(4).trigger("change");
                    }
                    break;
                default :
                    break;
            }
        },
        getCurrentConfig:function(){
            var self=this;
            var date1=new Date();
            console.log("开始");
            self.ajax({
                type:"get",
                url:"js/app/director_1.jsx",
//                contentType:""
                success:function(data,textStatus){
//                    data=""
//                    eval(data);
                    var date2=new Date();
                    console.log("请求成功，经过"+(date2.getTime()-date1.getTime())/1000+"s");
                    static_route_config.each(function(one){
                        if(one[0]=="0.0.0.0"&&one[1]=="0.0.0.0"){
                            self.wanPort=one[2];
                            self.gateway=one[3];
                        }
                    });
                    //3g配置
                    var cellularConfig={};
                    var arr_1=cellular1_config.profiles[0];
                    cellularConfig.apn=arr_1[2];
                    cellularConfig.dialNumber=arr_1[3];
                    cellularConfig.username=arr_1[5];
                    cellularConfig.password=arr_1[6];
                    //adsl配置
                    if(dialer_config.length!=0){
                        var adslConfig={};
                        var arr_2=dialer_config[0];
                        adslConfig.username=arr_2[4];
                        adslConfig.password=arr_2[5];
                    }
                    //dhcp和静态ip
                    var dhcpConfig={};
                    var staticIpConfig={};
                    var arr_3=svi_interface.find(function(one){
                        return one[0]=="vlan 10";
                    });
                    if(arr_3){
                        self.distinguish=arr_3[6];
                        staticIpConfig.staticIp=arr_3[3];
                        staticIpConfig.subnetMask=arr_3[4];
                    }
                    staticIpConfig.gateway=self.gateway;
                    staticIpConfig.dns_1=dns_server.dns_1;
                    staticIpConfig.dns_2=dns_server.dns_2;
                    var obj={};
                    obj.cellularConfig=cellularConfig;
                    obj.adslConfig=adslConfig;
                    obj.staticIpConfig=staticIpConfig;
                    self.setFormData(obj);
                    var date3=new Date();
                    console.log("渲染完毕"+(date3.getTime()-date1.getTime())/1000+"s");
                }
            })
        },
        getTemplate:function(){
            var self=this;
            self.ajax({
                type:"get",
                url:"json/cliCommand.json",
                contentType:"application/json",
                success:function(data,textStatus){
                    if(typeof data=="string"){
                        data=JSON.parse(data);
                    }
                    self.cellularPostTemplate=data.cellular.cli_cmd_post;
                    self.adslPostTemplate=data.adsl.cli_cmd_post;
                    self.dhcpPostTemplate=data.dhcp.cli_cmd_post;
                    self.staticIpPostTemplate=data.staticip.cli_cmd_post;
                }
            })
        },
        mergeAndSendFormData:function(callback){
            var self=this;
            var index=$("select#wan_port").val();
            index=parseInt(index);
            switch (index){
                case 1:
                    var obj={};
                    obj.number=1;
                    obj.apn=$("#cellular-apn").val();
                    obj.dialNumber=$("#cellular-dial-number").val();
                    obj.username=$("#cellular-username").val();
                    obj.password=$("#cellular-password").val();
                    var template=new Template(self.cellularPostTemplate);
                    var result=template.evaluate(obj);
//                    var temp={};
                    var str="_ajax=1&_web_cmd="+encodeURIComponent(result);
                    callback.call(self,str);
                    break;
                case 2:
                    var obj={};
//                    obj.number=1;
                    obj.username=$("#adsl-username").val();
                    obj.password=$("#adsl-password").val();
                    var template=new Template(self.adslPostTemplate);
                    var result=template.evaluate(obj);
                    var str="_ajax=1&_web_cmd="+encodeURIComponent(result);
                    callback.call(self,str);
                    break;
                case 3:
//                    var template=new Template(self.dhcpPostTemplate);
                    var result=self.dhcpPostTemplate;
                    var str="_ajax=1&_web_cmd="+encodeURIComponent(result);
                    callback.call(self,str);
                    break;
                case 4:
                    var obj={};
//                    obj.number=1;
                    obj.staticIp=$("#static-ip-address-main-ip").val();
                    obj.subnetMask=$("#static-ip-address-subnet-mask").val();
                    obj.gateway=$("#static-ip-address-gateway").val();
                    obj.dns_1=$("#static-ip-address-preferred-domain").val();
                    obj.dns_2=$("#static-ip-address-alternate-domain").val();
                    if(obj.dns_2){
                        self.staticIpPostTemplate=self.staticIpPostTemplate.replace(/8\.8\.8\.8/g,obj.dns_2);
                    }
                    var template=new Template(self.staticIpPostTemplate);
                    var result=template.evaluate(obj);
                    var str="_ajax=1&_web_cmd="+encodeURIComponent(result);
                    callback.call(self,str);
                    break;
                default :
                    break;
            }
        },
        bindEvents:function(){
            var self=this;
            self.allCellRows=self.viewContainer.find("div.cell-row");
            self.allAdslRows=self.viewContainer.find("div.adsl-row").hide();
            self.allDhcpRows=self.viewContainer.find("div.dhcp-row").hide();
            self.allStaticIpRows=self.viewContainer.find("div.static-ip-address-row").hide();
            self.rowsElementArray=["",self.allCellRows,self.allAdslRows,self.allDhcpRows,self.allStaticIpRows];
            self.viewContainer.find("#return-to-homepage").bind("click",function(e){
                self.destroySelfAll();
                self.fire("afterClick");
            }).end()
                .find("#pre-step").bind("click",function(e){
                    self.destroySelfAll();
                    self.fire("afterClick");
                }).end()
                .find("#next-step").bind("click",function(e){
                    var callback=function(data){
                        self.destroySelfAppButContainer();
                        self.directorTwo=new DirectorTwo({
                            elementId:"inner-view-container",
                            events:{
                                "afterClick":function(){
                                    this.rebuild();
                                },
                                scope:self
                            }
                        });
                        this.ajax({
                            url:"../apply.cgi",
                            type:"POST",
                            data:data,
                            processData:false,
                            contentType:"text/plain;charset=utf-8",
                            success:function(data,textStatus){
                            },
                            error:function(xhr,err){
                            }
                        });
                    };
                    if(validator.result("#inner-view-container")){
                        self.mergeAndSendFormData(callback);
                    }
                }).end()
                .find("select#wan_port").bind("change",function(e){
                    var value=$(this).val();
                    value=parseInt(value);
                    self.selectValue=value;
                    validator.hideAll();
                    switch (value){
                        case 1:
                            self.renderWanRow(1);
                            break;
                        case 2:
                            self.renderWanRow(2);
                            break;
                        case 3:
                            self.renderWanRow(3);
                            break;
                        case 4:
                            self.renderWanRow(4);
                            break;
                        default :

                    }
                });
        },
        renderWanRow:function(index){
            var self=this;
            switch (index){
                case 1:
                    self.hideAndShow(1);
                    break;
                case 2:
                    self.hideAndShow(2);
                    break;
                case 3:
                    self.hideAndShow(3);
                    break;
                case 4:
                    self.hideAndShow(4);
                    break;
                default :

            }
        },
        hideAndShow:function(index){
            var self=this;
            switch (index){
                case 1:
                   self._hideAndShow(1);
                    break;
                case 2:
                    self._hideAndShow(2);
                    break;
                case 3:
                    self._hideAndShow(3);
                    break;
                case 4:
                    self._hideAndShow(4);
                    break;
                default:

            }
        },
        _hideAndShow:function(index){
            var self=this;
            self.rowsElementArray.each(function(one,i){
                if(index==i){
                    one.show();
                }else if(i!=0){
                    one.hide();
                }
            })
        },
        destroySelfAppButContainer:function(){
            var self=this;
            self.viewContainer.find("#inner-view-container").empty();
        },
        destroySelfAll:function(){
            var self=this;
            self.viewContainer.find("#return-to-homepage").unbind().end()
                .find("#pre-step").unbind().end().find("#next-step").unbind();
            self.destroy();
        },
        rebuild:function(){
            var self=this;
            self.render();
        }
    });
    return DirectorOne;
})