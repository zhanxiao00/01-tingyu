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
    <%--声明js代码域--%>
    <script type="text/javascript">
        /********************初始化加载主持人信息的DataGrid组件*************************/
        $(function () {
            //初始化DataGrid
            $("#hostDataGrid").datagrid({
                url:"host/hostInfo",//设置远程加载数据的地址
                pagination:true,//该属性默认是ajax请求,设置为true后,改为发送分页的ajax请求.
                rownumbers:true,//显示行号
                pageNumber:1,//设置ajax分页查询的默认页码数
                pageSize:2,//设置每页的数量
                pageList:[2,4,6],//设置每页数据下拉框中的数据
                title:"查询结果",//显示标题
                toolbar:"#hostToolBar",//增加工具栏
                columns: //设置表格的列以及每列和加载的数据的映射关系
                    [[
                        {field:"aa",checkbox:true},//每列显示一个多选框的效果
                        {title:"权重",field:"strong",width:100},//表示一列,并且设置该列和数据的映射关系
                        {title:"姓名",field:"hname",width:100},
                        {title:"手机号",field:"hphone",width:100},
                        {title:"开通时间",field:"starttime",width:100},
                        {title:"价格",field:"hpprice",width:100},
                        {title:"订单量",field:"ordernumber",width:100},
                        {title:"折扣",field:"hpdiscount",width:100},
                        {title:"星推荐",field:"hpstar",width:100},
                        {title:"账号状态",field:"status",width:100}
                    ]]

            })
        })
    </script>

</head>
<body>
    <%--创建主持人管理面板组件--%>
    <div id="p" class="easyui-panel" title="主持人管理"
         style="width:1100px;height:500px;padding:10px;background:#fafafa;"
         data-options="closable:false,collapsible:false,minimizable:false,maximizable:false">

        <%--创建检索组件--%>
        <div style="margin: auto; width:700px;" >
            <%--创建检索条件表单--%>
            <form action="">
                <input class="easyui-textbox" prompt="姓名" name="hname" style="width:100px"><%--姓名条件--%>

                <select class="easyui-combobox" data-options="editable:false,value:'账号状态' " name="status" style="width: 100px;"><%--账号状态条件--%>
                    <option value="1">正常</option>
                    <option value="0">禁用</option>
                </select>

                <select class="easyui-combobox" data-options="editable:false,value:'权重排序' " name="strong" style="width: 100px;"><%--权重排序条件--%>
                    <option value="asc">升序</option>
                    <option value="desc">降序</option>
                </select>

                <select class="easyui-combobox" data-options="editable:false,value:'星推荐' " name="hastar" style="width: 100px;"><%--星推荐条件--%>
                    <option value="1">不推荐</option>
                    <option value="0">推荐</option>
                </select>

                <select class="easyui-combobox" data-options="editable:false,value:'折扣条件' " name="hpdiscount" style="width: 100px;"><%--折扣条件--%>
                    <option value="6">6</option>
                    <option value="7">7</option>
                    <option value="8">8</option>
                    <option value="9">9</option>
                </select>

                <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:false">查询</a>
                <a href="javascript:void(0)" class="easyui-linkbutton"  data-options="iconCls:'icon-ok',plain:false">导出</a>
            </form>
        </div>


        <%--创建主持人信息加载的DataGrid组件,并使用js的方式初始化--%>
        <table id="hostDataGrid"></table>
    </div>

    <%--创建主持人的工具栏--%>
    <div id="hostToolBar">
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true">添加主持人</a>
        <a href="javascript:void(0)" class="easyui-linkbutton"  data-options="iconCls:'icon-add',plain:true">权限设置</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true">账号禁用</a>
        <a href="javascript:void(0)" class="easyui-linkbutton"  data-options="iconCls:'icon-remove',plain:true">批量操作</a>
    </div>


</body>
</html>
