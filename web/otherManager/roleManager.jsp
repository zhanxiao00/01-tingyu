<%--
  Created by IntelliJ IDEA.
  User: zyp
  Date: 2020/3/26
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
    <%--声明js代码域--%>
    <script type="text/javascript">
        /***************初始化加载角色信息的DataGrid组件************************************************/
        $(function () {
            //初始化DataGrid
            $("#roleDataGrid").datagrid({
                url:"role/roleInfo",//设置远程加载数据的地址
                pagination:true,//在表格中显示分页工具栏，将此属性设置为true，就会发送ajax分页请求获取要加载的数据
                rownumbers:true,//显示行号
                pageNumber:1,//设置ajax分页查询的默认页码数
                pageSize:2,//设置每页显示的数量
                checkOnSelect:false,//设置点击行的任意位置不会选择该行，只有点击复选框时菜单选择
                pageList:[2,4,6],//设置每页数据量下拉框框中的数据
                title:"查询结果",//显示标题
                toolbar:'#roleToolBar',//增加工具栏
                columns:    //设置表格的列以及每列和加载的数据的映射关系
                    [[
                        //表示一列，并且设置该列和数据的映射关系
                        {field:"aa",checkbox:true},
                        {title:"角色编号",field:"rid",width:150},
                        {title:"角色名称",field:"rname",width:150},
                        {title:"角色描述",field:"rdesc",width:150}
                    ]]
            })
        })
        /***************增加角色************************************************/
        $(function () {
            //给增加角色按钮添加单击事件
            $("#addRole").click(function () {
                //显示角色增加的对话框
                $("#addRoleDialog").dialog('open');
            })
            //给表单提交按钮增加单击事件
            $("#addRoleFrom").click(function () {
                //获取当前角色分配的菜单的Id数据
                var nodes = $('#menuTree').tree('getChecked', ['checked','indeterminate']);
                var mids="";
                if(nodes.length>0){
                    for(var i=0;i<nodes.length;i++){
                        mids+=nodes[i].id+",";
                    }
                }
                //将Id数据记录在表单的隐藏标签中
                $("#mids").val(mids);
                //异步提交表单
                $("#roleAddForm").form('submit',{
                    url:'role/roleAdd',
                    success:function (data) {
                        //转换
                        eval("var d="+data);
                        //判断
                        if(d.success){
                            $.messager.alert("提示","角色增加成功","info");
                            //关闭角色增加对话框
                            $("#addRoleDialog").dialog('close');
                            //重新加载角色的DataGrid数据
                            $("#roleDataGrid").datagrid('reload');
                        }else{
                            $.messager.alert("提示","角色增加失败","info");
                        }
                    }
                })
            })
        })
        /***************更新角色************************************************/
        $(function () {
            //给更新角色按钮增加单击事件
            $("#editRole").click(function () {
                //校验用户是否选择要更新的角色信息
                var tr=$("#roleDataGrid").datagrid('getChecked');
                console.log(tr)
                if(tr.length==1){
                    //将角色的菜单置为选择状态
                        //获取当前角色的菜单的ID数组
                        var m=tr[0].mids;
                        //将菜单树中为角色的菜单置为选择状态
                        for(var i=0;i<m.length;i++){
                            var node = $('#menuEditTree').tree('find', m[i]);
                            if(node!=null){
                                $('#menuEditTree').tree('check', node.target);
                            }

                        }
                    //将角色信息回显到表单中
                    $("#roleEditForm").form('load',tr[0]);
                    //显示角色更新的对话框
                    $("#editRoleDialog").dialog('open');
                }else if(tr.length>1){
                    $.messager.alert("提示","只能选择一个角色信息","info");
                }else{
                    $.messager.alert("提示","请选择角色","info");
                }
            })
            //给完成更新按钮增加单击事件
            $("#editRoleFrom").click(function () {
                //获取当前角色分配的菜单的Id数据
                var nodes = $('#menuEditTree').tree('getChecked', ['checked','indeterminate']);
                var mids="";
                if(nodes.length>0){
                    for(var i=0;i<nodes.length;i++){
                        mids+=nodes[i].id+",";
                    }
                }
                //将Id数据记录在表单的隐藏标签中
                $("#midsEdit").val(mids);
                //异步提交表单
                $("#roleEditForm").form('submit',{
                    url:'role/roleEdit',
                    success:function (data) {
                        //转换
                        eval("var d="+data);
                        //判断
                        if(d.success){
                            $.messager.alert("提示","角色更新成功","info");
                            //关闭角色增加对话框
                            $("#editRoleDialog").dialog('close');
                            //重新加载角色的DataGrid数据
                            $("#roleDataGrid").datagrid('reload');
                        }else{
                            $.messager.alert("提示","角色更新失败","info");
                        }
                    }
                })

            })
        })
        /***************删除角色************************************************/
        $(function () {
            //给角色删除按钮增加单击事件
            $("#delRole").click(function () {
                //获取要删除的角色
                var trs=$("#roleDataGrid").datagrid('getChecked');
                if(trs.length>0){
                    $.messager.confirm("删除","你确定要删除吗?",function (r) {
                        if(r){
                            //获取要删除的角色的ID
                            var rids="";
                            for(var i=0;i<trs.length;i++){
                                rids+=trs[i].rid+",";
                            }
                            //发起ajax请求完成删除
                            $.get("role/roleDel",{rids:rids},function (data) {
                                //判断
                                if(data.success){
                                    $.messager.alert("提示","删除成功","info");
                                    //重新记载dataGrid中的数据
                                    $("#roleDataGrid").datagrid('reload');
                                }
                            })
                        }
                    })

                }else{
                    $.messager.alert("提示","请选择要删除的角色","info");
                }
            })
        })
    </script>
</head>
<body>
    <%--创建更新增加的对话框--%>
    <div id="editRoleDialog" class="easyui-dialog" title="更新角色" style="width:550px;height:500px;"
         data-options="iconCls:'icon-save',resizable:false,modal:true,closed:true">
        <%--声明对话框的布局，左边填写角色的信息，右边显示当前项目的树状菜单--%>
        <div class="easyui-layout" data-options="fit:true">
            <div data-options="region:'west',split:false,title:'角色信息',collapsible:false" style="width:300px;padding:10px;text-align: center">
                <%--创建角色更新的表单--%>
                <form id="roleEditForm"  method="post">
                    <%--创建隐藏标签，记录更新的角色的Id--%>
                    <input type="hidden" name="rid"  />
                    <%--创建隐藏标签，记录更新的角色的菜单Id--%>
                        <input type="hidden" name="mids" id="midsEdit"  />
                    <%--角色名称--%>
                    <div style="margin-bottom:20px;margin-top:25px;text-align: center">
                        <input class="easyui-textbox" name="rname" prompt="请输入角色名称" iconWidth="28" style="width:200px;height:34px;padding:10px;">
                    </div>
                    <%--角色描述--%>
                    <div style="margin-bottom:20px;text-align: center">
                        <input class="easyui-textbox" name="rdesc" prompt="请输入角色描述" iconWidth="28" style="width:200px;height:34px;padding:10px;">
                    </div>
                    <%--操作按钮--%>
                    <div style="margin-bottom:20px;text-align: center">
                        <a href="javascript:void(0)" id="editRoleFrom" class="easyui-linkbutton c3" style="width:120px">完成更新</a>
                    </div>
                </form>
            </div>
            <div data-options="region:'center',title:'当前系统菜单'" style="padding:10px">
                <%--创建ul组件加载所有的菜单信息--%>
                <ul class="easyui-tree" id="menuEditTree" checkbox="true" data-options="url:'menu/menuAllInfo2'"></ul>
            </div>
        </div>
    </div>
    <%--创建角色增加的对话框--%>
    <div id="addRoleDialog" class="easyui-dialog" title="增加角色" style="width:550px;height:500px;"
         data-options="iconCls:'icon-save',resizable:false,modal:true,closed:true">
        <%--声明对话框的布局，左边填写角色的信息，右边显示当前项目的树状菜单--%>
            <div class="easyui-layout" data-options="fit:true">
                <div data-options="region:'west',split:false,title:'角色信息',collapsible:false" style="width:300px;padding:10px;text-align: center">
                    <%--创建角色增加的表单--%>
                    <form id="roleAddForm"  method="post">
                        <%--创建隐藏标签，记录增加的角色的菜单Id--%>
                        <input type="hidden" name="mids" id="mids"  />
                        <%--角色名称--%>
                        <div style="margin-bottom:20px;margin-top:25px;text-align: center">
                            <input class="easyui-textbox" name="rname" prompt="请输入角色名称" iconWidth="28" style="width:200px;height:34px;padding:10px;">
                        </div>
                        <%--角色描述--%>
                        <div style="margin-bottom:20px;text-align: center">
                            <input class="easyui-textbox" name="rdesc" prompt="请输入角色描述" iconWidth="28" style="width:200px;height:34px;padding:10px;">
                        </div>
                        <%--操作按钮--%>
                        <div style="margin-bottom:20px;text-align: center">
                            <a href="javascript:void(0)" id="addRoleFrom" class="easyui-linkbutton c3" style="width:120px">完成增加</a>
                        </div>
                    </form>
                </div>
                <div data-options="region:'center',title:'当前系统菜单'" style="padding:10px">
                    <%--创建ul组件加载所有的菜单信息--%>
                    <ul class="easyui-tree" id="menuTree" checkbox="true" data-options="url:'menu/menuAllInfo2'"></ul>
                </div>
            </div>
    </div>
    <%--创建角色管理面板组件--%>
    <div id="p" class="easyui-panel" title="角色管理"
         style="width:900px;height:500px;padding:10px;background:#fafafa;"
         data-options="closable:false,collapsible:false,minimizable:false,maximizable:false">
        <%--创建主持人信息加载的DataGrid组件--%>
        <table id="roleDataGrid"></table>
    </div>
    <%--创建角色管理DataGrid的工具栏--%>
    <div id="roleToolBar">
        <a id="addRole" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true">添加角色</a>
        <a id="editRole" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true">更新角色</a>
        <a id="delRole" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true">删除角色</a>
    </div>
</body>
</html>
