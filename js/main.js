/**
 * Created by kkzhou on 14-8-26.
 */
require.config({
    baseUrl:"js",
    paths:{
        "jquery":"lib/jquery-1.11.1.min",
        "prototype":"lib/prototype",
        "lang":"../lang",
        "text":"lib/text",
        "sweet":"lib/sweet-alert.min"
    },
    shim:{
        "lib/jquery.validationEngine":["jquery"],
        "lib/jquery.blockUI":["jquery"],
        "tool/locale":["jquery"],
        "tool/validator":["jquery"]
    }
});
require(["jquery","prototype","app/mainApp","sweet"],function($,prototype,mainApp){
        $(document).ready(function($){
            //var language=navigator.language?navigator.language:navigator.userLanguage;
            //if(language.toLowerCase()=="zh-cn"){
            //    localStorage.setItem("language","zh_CN");
            //}else{
            //    localStorage.setItem("language","en");
            //}
            var app=new mainApp({
                elementId:"page-view"
            });
            $("img.my-title-img").prop("src","images/Logo-InHand.png");
        });
        //$("#config-quit").bind("click",function(e){
        //    sweetAlert({
        //            title: /*locale.get("awayFromConfig")*/"确定离开？",
        //            //text: "You will not be able to recover this imaginary file!",
        //            type: "warning",
        //            showCancelButton: true,
        //            cancelButtonText:/*locale.get("cancell")*/"取消",
        //            confirmButtonColor: "#3F9B40",
        //            confirmButtonText: /*locale.get("confirm")*/"确定",
        //            closeOnConfirm: false
        //        },
        //        function () {
        //            window.location.href="./logout.jsp";
        //        })
        //})
    }
)