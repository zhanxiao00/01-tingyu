<%--
  Created by IntelliJ IDEA.
  User: zyp
  Date: 2020/3/26
  Time: 9:21
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
        /**************增加菜单信息*************************************/
        $(function () {
            //初始化菜单增加对话框时，添加监听事件，当对话框关闭时，清空表单内容
            $("#addMenuDialog").dialog({
                onClose:function () {
                    //清空表单信息
                    $("#menuAddForm").form('reset');
                }
            })
            //给增加菜单按钮添加单击事件
            $("#menuAdd").click(function () {
                //获取用户选择的要增加子菜单的上级菜单的ID
                var node=$("#menuTree").tree('getSelected');
                if(node!=null){
                    $("#pid").val(node.id);//记录要增加的菜单的上级
                }
                //显示菜单增加的对话框
                $("#addMenuDialog").dialog('open')
            })
            //给完成增加按钮添加单击事件完成表单的异步提交
            $("#addMenuFrom").click(function () {
                //异步提交表单
                $("#menuAddForm").form('submit',{
                    url:'menu/menuAdd',
                    success:function (data) {
                        //转换数据
                        eval("var d="+data);
                        //判断结果
                        if(d.success){
                            $.messager.alert("提示","增加成功","info");
                            //刷新异步树，重新加载菜单资源
                            $("#menuTree").tree('reload');
                            //关闭对话框
                            $("#addMenuDialog").dialog('close')
                        }else{
                            $.messager.alert("提示","增加失败","info");
                        }
                    }
                })
            })

        })
        /**************编辑菜单信息*************************************/
        $(function () {
            //给编辑菜单按钮增加单击事件
            $("#menuEdit").click(function () {
                //判断用户是否选择要编辑的菜单信息
                    var node=$("#menuTree").tree('getSelected');+
                    console.log(node)
                    if(node!=null){
                        //回显菜单数据到表单中
                        $("#menuEditForm").form('load',{
                            mid:node.id,
                            mname:node.text,
                            url:node.attributes.url,
                            mdesc:node.attributes.mdesc
                        })
                        //显示菜单编辑的对话框
                        $("#EditMenuDialog").dialog('open');
                    }else{
                        $.messager.alert("提示","请选择要编辑的菜单","info");
                    }

            })
            //给完成更新按钮增加单击事件，完成更新表单的异步提交
            $("#editMenuFrom").click(function () {
                //异步提交表单
                $("#menuEditForm").form('submit',{
                    url:'menu/menuEdit',
                    success:function (data) {
                        //转换数据
                        eval("var d="+data);
                        //判断结果
                        if(d.success){
                            $.messager.alert("提示","更新成功","info");
                            //刷新异步树，重新加载菜单资源
                            $("#menuTree").tree('reload');
                            //关闭对话框
                            $("#EditMenuDialog").dialog('close')
                        }else{
                            $.messager.alert("提示","更新失败","info");
                        }
                    }
                })
            })
        })
        /**************删除菜单信息*************************************/
        $(function () {
            //给删除菜单按钮增加单击事件
            $("#menuDel").click(function () {
                //判断是否选择要删除的菜单信息
                    var node=$("#menuTree").tree('getSelected');
                    if(node!=null){
                        //提示用户是否要删除
                        $.messager.confirm("删除提示","你确定要删除吗",function (r) {
                            if(r){
                                //发起ajax请求完成删除
                                $.get("menu/menuDel",{mid:node.id,pid:node.attributes.pid},function (data) {
                                    //判断
                                    if(data.success){
                                        $.messager.alert("提示","删除成功","info");
                                        //重新加载菜单树
                                        $("#menuTree").tree('reload');
                                    }else{
                                        $.messager.alert("提示","删除失败","info");
                                    }
                                })
                            }
                        })
                    }else{
                        $.messager.alert("提示","请选择要删除的菜单","info");
                    }

            })
        })

    </script>
</head>
<body>
    <%--创建编辑菜单信息的对话框--%>
    <div id="EditMenuDialog" class="easyui-dialog" title="编辑菜单" style="width:400px;height:300px;"
         data-options="iconCls:'icon-save',resizable:false,modal:true,closed:true">
        <%--创建菜单增加的表单--%>
        <form id="menuEditForm"  method="post">
            <%--创建隐藏标签，记录要更新的菜单的ID--%>
                <input type="hidden" name="mid">
            <%--菜单名称--%>
            <div style="margin-bottom:20px;margin-top:25px;text-align: center">
                <input class="easyui-textbox" name="mname" prompt="请输入菜单名称" iconWidth="28" style="width:300px;height:34px;padding:10px;">
            </div>
            <%--菜单的url地址--%>
            <div style="margin-bottom:20px;text-align: center">
                <input  class="easyui-textbox" name="url" prompt="请输入资源地址" iconWidth="28" style="width:300px;height:34px;padding:10px">
            </div>
            <%--菜单的描述--%>
            <div style="margin-bottom:20px;text-align: center">
                <input class="easyui-textbox" name="mdesc" prompt="请输入菜单描述" iconWidth="28" style="width:300px;height:34px;padding:10px;">
            </div>
            <%--操作按钮--%>
            <div style="margin-bottom:20px;text-align: center">
                <a href="javascript:void(0)" id="editMenuFrom" class="easyui-linkbutton c3" style="width:120px">完成更新</a>
            </div>
        </form>
    </div></div>
    <%--创建增加菜单信息的对话框--%>
    <div id="addMenuDialog" class="easyui-dialog" title="增加菜单" style="width:400px;height:300px;"
         data-options="iconCls:'icon-save',resizable:false,modal:true,closed:true">
        <%--创建菜单增加的表单--%>
        <form id="menuAddForm"  method="post">
            <%--创建隐藏标签记录要增加的菜单的上级ID--%>
                <input type="hidden" id="pid" name="pid" value="">
            <%--菜单名称--%>
            <div style="margin-bottom:20px;margin-top:25px;text-align: center">
                <input class="easyui-textbox" name="mname" prompt="请输入菜单名称" iconWidth="28" style="width:300px;height:34px;padding:10px;">
            </div>
            <%--菜单的url地址--%>
            <div style="margin-bottom:20px;text-align: center">
                <input  class="easyui-textbox" name="url;" prompt="请输入资源地址" iconWidth="28" style="width:300px;height:34px;padding:10px">
            </div>
            <%--菜单的描述--%>
            <div style="margin-bottom:20px;text-align: center">
                <input class="easyui-textbox" name="mdesc" prompt="请输入菜单描述" iconWidth="28" style="width:300px;height:34px;padding:10px;">
            </div>
            <%--操作按钮--%>
            <div style="margin-bottom:20px;text-align: center">
                <a href="javascript:void(0)" id="addMenuFrom" class="easyui-linkbutton c3" style="width:120px">完成增加</a>
            </div>
        </form>
    </div></div>
    <%--创建菜单管理面板，并完成嵌套布局效果--%>
    <div class="easyui-panel"  style="width:700px;height:500px;padding:10px;">
        <div class="easyui-layout" data-options="fit:true">
            <div data-options="region:'west',split:false,title:'操作',collapsible:false" style="width:200px;padding:10px;text-align: center">
                    <a id="menuAdd" href="javascript:void(0)" class="easyui-linkbutton c1" style="width:120px;margin: 15px;">增加菜单</a><br>
                    <a id="menuEdit" href="javascript:void(0)" class="easyui-linkbutton c2" style="width:120px;margin: 15px;">编辑菜单</a><br>
                    <a id="menuDel" href="javascript:void(0)" class="easyui-linkbutton c3" style="width:120px;margin: 15px;">删除菜单</a><br>
                    <a href="javascript:void(0)" class="easyui-linkbutton c4" style="width:120px;margin: 15px;">刷新菜单</a><br>
            </div>
            <div data-options="region:'center',title:'当前系统菜单'" style="padding:10px">
                <%--创建ul组件加载所有的菜单信息--%>
                    <ul class="easyui-tree" id="menuTree" data-options="url:'menu/menuAllInfo'"></ul>
            </div>
        </div>
    </div>
</body>
</html>
