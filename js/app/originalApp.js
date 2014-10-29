/**
 * Created by kkzhou on 14-8-26.
 */
define(function(require){
    require("lib/jquery.blockUI");
    var locale=require("tool/locale");
    var App=Class.create({
          initialize:function(options){
              this.elementId=options.elementId;
              this.options=options;
              this.events=options.events;
              this.viewContainer=$("#"+options.elementId);
          },
          ajax:function(obj){
            var self=this;
              if(obj.showBlock){
                  $.blockUI({
                      css: {
                          border: 'none',
                          padding: '15px',
                          backgroundColor: "#1A1A1A",
                          '-webkit-border-radius': '10px',
                          '-moz-border-radius': '10px',
//                      opacity: .5,
                          color: '#fff',
                          width:"20%",
                          left:"40%"
                      },
                      message:"<div><div class='mask_block table-cell'></div><div class='table-cell'>"+locale.get("please_wait")+"</div></div>"
                  });
              }
              var success=obj.success;
              var success_f=function(data,textStatus){
                  setTimeout(
                      function(){
                          $.unblockUI();
                          success(data,textStatus);
                      }, 1500)
              };
              var error=obj.error;
              var error_f=function(xhr,err){
              setTimeout(function(){$.unblockUI();error(xhr,err);}, 1500);
              };
              $.ajax({
                  url:obj.url,
                  type:obj.type,
                  contentType:obj.contentType,
                  data:obj.data,
                  processData:obj.processData,
                  success:success_f,
                  error:error_f
              });
          },
          fire:function(eventStr){
            var self=this;
              self.events[eventStr].call(self.events.scope || self);
          },
          destroy:function(){
              var self=this;
              self.viewContainer.empty();
          }
    });
    return App;
});