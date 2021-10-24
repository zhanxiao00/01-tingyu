<%--
  Created by IntelliJ IDEA.
  User: zhanxiao
  Date: 2021-10-24
  Time: 18:05
  To change this template use File | Settings | File Templates.
--%>
<%
    String path = request.getContextPath() + "/";
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <base href="<%=basePath%>"/>
    <%--引入EasyUI的资源--%>
    <link rel="stylesheet" type="text/css" href="static/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="static/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="static/themes/demo.css">
    <link rel="stylesheet" type="text/css" href="static/themes/color.css">
    <script type="text/javascript" src="static/jquery.min.js"></script>
    <script type="text/javascript" src="static/jquery.easyui.min.js"></script>
</head>
<body>
    <%--创建主持人管理面板组件--%>
    <div id="p" class="easyui-panel" title="My Panel"
         style="width:500px;height:150px;padding:10px;background:#fafafa;"
         data-options="iconCls:'icon-save',closable:true,
    collapsible:true,minimizable:true,maximizable:true">
        <p>panel content.</p>
        <p>panel content.</p>
    </div>



</body>
</html>
