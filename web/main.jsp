<%--
  Created by IntelliJ IDEA.
  User: zyp
  Date: 2020/3/20
  Time: 14:16
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
    <%--引入EasyUI的资源--%>
    <link rel="stylesheet" type="text/css" href="static/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="static/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="static/themes/demo.css">
    <link rel="stylesheet" type="text/css" href="static/themes/color.css">
    <script type="text/javascript" src="static/jquery.min.js"></script>
    <script type="text/javascript" src="static/jquery.easyui.min.js"></script>
</head>
<body class="easyui-layout">
<%--创建主页面布局--%>
    <%--布局:网站头部--%>
    <div data-options="region:'north',split:false" style="height:75px;">
        <%--使用layout的嵌套布局，将头部分为，西，中，东三部分--%>
            <div class="easyui-layout" data-options="fit:true">
                <div data-options="region:'west',border:false" style="width:20%;text-align: center;background-image: url('static/images/bg.png')">
                    <%--显示网站的logo--%>
                        <img src="static/images/logo.png" style="margin-top: 16px;">
                </div>
                <div data-options="region:'center',border:false" style="background-image: url('static/images/bg.png');text-align: center">
                    <%--声明网站的标题--%>
                    <span style="color: white;font-size: 25px;position: relative;top:17px;">
                        Ting&nbsp;&nbsp;&nbsp;域&nbsp;&nbsp;&nbsp;主&nbsp;&nbsp;&nbsp;持&nbsp;&nbsp;&nbsp;人&nbsp;&nbsp;&nbsp;
                        后&nbsp;&nbsp;&nbsp;台&nbsp;&nbsp;&nbsp;管&nbsp;&nbsp;&nbsp;理&nbsp;&nbsp;&nbsp;系&nbsp;&nbsp;&nbsp;统
                    </span>
                </div>
                <div data-options="region:'east',border:false" style="width:20%;background-image: url('static/images/bg.png');">
                    <%--设置网站登录信息--%>
                    <span style="position: relative;top:40px;font-size:15px;">
                        <span style="color: white">您好，${sessionScope.admin.aname}</span>
                        &nbsp;&nbsp;&nbsp;
                        <span><a href="#"  style="color: white">退出</a></span>
                    </span>
                </div>
            </div>
    </div>
    <%--布局:网站底部--%>
    <div data-options="region:'south',split:false" style="height:50px;"></div>
    <%--布局:网站菜单部分--%>
    <div data-options="region:'west',title:'系统菜单',split:false,collapsible:false" style="width:150px;">
        <%--声明异步树组件--%>
            <ul class="easyui-tree" data-options="url:'menu/menuInfo'"></ul>
    </div>
    <%--布局:网站中心区域(内容区域)--%>
    <div data-options="region:'center'" style="padding:5px;background:#eee;"></div>
</body>
</html>
