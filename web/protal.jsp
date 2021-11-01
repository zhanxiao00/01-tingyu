<%--
  Created by IntelliJ IDEA.
  User: 25499
  Date: 2020/2/24
  Time: 15:16
  To change this template use File | Settings | File Templates.
--%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <base href="<%=basePath %>"/>
    <title>Title</title>
    <%--引入easyUI的资源--%>
    <link rel="stylesheet" type="text/css" href="static/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="static/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="static/themes/demo.css">
    <script type="text/javascript" src="static/jquery.min.js"></script>
    <script type="text/javascript" src="static/jquery.easyui.min.js"></script>
    <%--声明js代码域--%>
    <script type="text/javascript">
        /*给登录按钮增加单击事件*/
        $(function () {
            $("#userLogin").click(function () {
                //显示登录对话框
                $("#loginDialog").dialog('open');
            })
        })
        /*新人登录*/
        $(function () {
            //给点击登录按钮添加单击事件
            $("#loginBtn").click(function () {
                //提交表单
                $("#ff").form('submit',{
                    url:"marriedPerson/personLogin",
                    success:function (data) {
                        if(data){
                           eval("var p="+data)
                            $("#userLogin").html("欢迎&nbsp;&nbsp;"+p.pname+"");
                            $("#loginDialog").dialog('close');

                        }else{
                            $.messager.alert("提示","手机号或者密码不正确","info");
                        }

                    }
                })
            })
        })

    </script>
    <%--声明css样式--%>
    <style type="text/css">
        /*声明菜单栏效果*/
            ul{position: relative;bottom: 40px;left: 150px;}
            ul li{float: left;list-style: none;margin-right: 40px;font-size: 20px;line-height: 36px; color: #fff;text-align: center;padding: 0 20px;
                height: 36px;    margin: 0 20px;    width: 140px ;   box-sizing: border-box;    border-radius: 10px;
            }
            .active{
                border-radius: 10px;
                color: #fff;
                border: 2px solid #fff;
                line-height: 31px;}
            ul li a{text-decoration: none;cursor: pointer;color: #fff;}
    </style>
</head>
<body class="easyui-layout">
    <div data-options="region:'north',split:false" style="height:150px;background-image: url('static/images/top_bg.png')">
        <%--创建头部工具栏--%>
        <div style="width: 1008px;height: 120px;margin: auto;">
            <%--设置网站欢迎语--%>
                <p style="color: #666666;float: left;line-height: 44px;position: relative;bottom: 10px;font-size: 14px;">
                    Ting域主持人欢迎您！ 客服：13601371065（卓越老师）
                </p>
                <span style="float: right;position: relative;top:10px;">
                        <span><a id="userLogin" href="javascript:void(0)" style="color: #666666;text-decoration: none;">登录</a></span> |
                        <span><a href="reg.jsp" style="color: #666666;text-decoration: none;">注册</a></span>
                </span>
                <br>
                <%--声明网站logo--%>
                <a href="" style="cursor: pointer;">
                    <img src="static/images/protal_logo.png" alt="Ting域" style="height: 80px;position: relative;right: 370px;top:20px;">
                </a>
                <%--声明网站横向菜单栏--%>
                <ul>
                    <li class="active"><a href="">首页</a></li>
                    <li class="active"><a href="">主持人</a></li>
                    <li class="active"><a href="">加入我们</a></li>
                    <li class="active"> <a href="">关于我们</a></li>
                </ul>
        </div>
    </div>
    <div data-options="region:'center'" style="padding:5px;background:#eee;">
        <%--声明网站图片--%>
        <div>
            <img src="static/images/tingyu-1.jpg" width="100%" alt="">
        </div>
            <%--声明网站图片--%>
            <div>
                <img src="static/images/ting_2.png" width="100%" alt="">
            </div>
    </div>
    <%--创建登录对话框--%>
            <div class="easyui-dialog" id="loginDialog" data-options="closed:true" title="欢迎登录Ting域主持人平台" style="width:400px;padding:50px 60px">
                <form method="post" id="ff">
                <div style="margin-bottom:20px">
                    <input class="easyui-textbox" name="phone" prompt="请输入手机号" iconWidth="28" style="width:100%;height:34px;padding:10px;">
                </div>
                <div style="margin-bottom:20px">
                    <input id="pass" class="easyui-passwordbox" name="ppwd" prompt="请输入密码" iconWidth="28" style="width:100%;height:34px;padding:10px">
                </div>
                <a id="loginBtn" href="javascript:void(0)" class="easyui-linkbutton" style="width:120px">点击登录</a>&nbsp;&nbsp;&nbsp;&nbsp;
                <input class="easyui-checkbox" name="fruit" value="Apple"> 记住密码
                </form>
            </div>
    </div>
    <script type="text/javascript">
        $('#pass').passwordbox({
            inputEvents: $.extend({}, $.fn.passwordbox.defaults.inputEvents, {
                keypress: function(e){
                    var char = String.fromCharCode(e.which);
                    $('#viewer').html(char).fadeIn(200, function(){
                        $(this).fadeOut();
                    });
                }
            })
        })
    </script>
    <style>
        #viewer{
            position: relative;
            padding: 0 60px;
            top: -70px;
            font-size: 54px;
            line-height: 60px;
        }
    </style>
</body>
</html>
