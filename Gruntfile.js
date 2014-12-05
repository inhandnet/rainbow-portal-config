/**
 * Created by kkzhou on 2014/12/4.
 */
module.exports=function(grunt){
    grunt.initConfig({
        pkg:grunt.file.readJSON("package.json"),
        concat:{
            options:{
                seperator:";"
            },
            dist:{
                files:[
                    {
                        src:["js/lib/requirejs.js","dist/js/app.rq.js"],dest:"dist/js/app.js"
                    }
                ]
            },
            css:{
                options:{
                    seperator:"\n"
                },
                src:["css/bootstrap.css","css/jquery.validationEngine.css","css/mainApp.css"],
                dest:"dist/css/portal.css"
            }
        },
        uglify:{
            options:{
                banner:"/*<%= pkg.name%><%= grunt.template.today('dd-mm-yyyy')%>*/",
                //不压缩$super
                mangle: {
                    except: ["$super"]
                }
            },
            dist:{
                files:[
                    {
                        src:["<%= concat.dist.files[0].dest%>"],
                        dest:"dist/js/app.min.js"
                    }
                ]
            }
        },
        cssmin:{
            dist:{
                src:["<%= concat.css.dest%>"],
                dest:"dist/css/portal.min.css"
            }
        },
        requirejs:{
            compile:{
                options: {
                        baseUrl:"./js",
                        paths:{
                            "jquery":"lib/jquery-1.11.1.min",
                            "prototype":"lib/prototype",
                            "lang":"../lang",
                            "text":"lib/text"
                        },
                        shim:{
                            "lib/jquery.validationEngine":["jquery"],
                            "lib/jquery.blockUI":["jquery"],
                            "tool/locale":["jquery"],
                            "tool/validator":["jquery"]
                        },
                        mainConfigFile:"js/main.js",
                        optimize: "uglify",
                        uglify: {
                            toplevel: true,
                            ascii_only: true,
                            beautify: true,
                            max_line_length: 1000,
                            defines: {
                                DEBUG: ['name', 'false']
                            },
                            no_mangle: true,
                            //不压缩$super
                            except: ["$super"]
                        },
                        name:"main",
                        out: "dist/js/app.rq.js"
                    //
                    //baseUrl:"seajs/js",
                    //mainConfigFile:"seajs/js/main.js",
                    //optimize:"uglify",
                    //name:"main",
                    //out:"dist/simple.js"
                }
            }
        }
    });
    grunt.loadNpmTasks("grunt-requirejs");
    grunt.loadNpmTasks("grunt-contrib-concat");
    grunt.loadNpmTasks("grunt-contrib-uglify");
    grunt.loadNpmTasks("grunt-contrib-cssmin");
    grunt.registerTask("cu",["concat","uglify"]);
    grunt.registerTask("rq",["requirejs","concat","uglify","cssmin"]);
};