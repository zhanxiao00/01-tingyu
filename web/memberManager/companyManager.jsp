<%--
  Created by IntelliJ IDEA.
  User: zyp
  Date: 2020/3/24
  Time: 10:14
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
        /***************初始化加载公司信息的DataGrid组件************************************************/
        $(function () {
            //初始化DataGrid
            $("#companyDataGrid").datagrid({
                url:"company/companyInfo",//设置远程加载数据的地址
                pagination:true,//在表格中显示分页工具栏，将此属性设置为true，就会发送ajax分页请求获取要加载的数据
                rownumbers:true,//显示行号
                pageNumber:1,//设置ajax分页查询的默认页码数
                pageSize:2,//设置每页显示的数量
                checkOnSelect:false,//设置点击行的任意位置不会选择该行，只有点击复选框时菜单选择
                pageList:[2,4,6],//设置每页数据量下拉框框中的数据
                title:"查询结果",//显示标题
                toolbar:"#companyToolBar",//增加工具栏效果
                columns:    //设置表格的列以及每列和加载的数据的映射关系
                    [[
                     //表示一列，并且设置该列和数据的映射关系
                        {field:"aa",checkbox:true},
                        {title:"公司名称",field:"cname",width:150},
                        {title:"公司法人",field:"ceo",width:100},
                        {title:"手机号",field:"cphone",width:100},
                        {title:"开通时间",field:"starttime",width:150,
                            formatter:function (value,rows,rowIndex) {
                                return value.year+"-"+value.monthValue+"-"+value.dayOfMonth+" "
                                    +value.hour+":"+value.minute+":"+value.second;
                            }
                        },
                        {title:"订单量",field:"ordernumber",width:100},
                        {title:"账号状态",field:"status",width:100,
                            formatter:function (value,rows,rowIndex) {
                                return value=="1"?"正常":"禁用"
                            }
                        }
                    ]]
            })
        })
        /**************查询按钮完成公司信息的筛选分页查询***********************************************/
        $(function () {
            //给查询按钮增加单击时间
            $("#search").click(function () {
                //dataGrid按照条件重新分页加载主持人信息
                $("#companyDataGrid").datagrid('load',{
                    cname:$("#cname").val(),
                    status:$("#status").val(),
                    ordernumber:$("#ordernumber").val()
                })
            })
        })
        /**********************增加公司信息功能实现****************************************************/
        $(function () {
            //给增加按钮添加单击事件
            $("#addCompany").click(function () {
                //显示公司增加的对话框
                $("#addCompanyDialog").dialog('open');
            })
            //给主持人增加的表单按钮添加单击事件
            $("#addCompanyFrom").click(function () {
                //发起ajax请求完成主持人增加的请求发送
                $("#companyForm").form('submit',{
                    url:'company/companyAdd',//请求地址
                    success:function (data) {//回调函数，data为原始的json数据，需要自己使用eval完成数据的转换
                        //使用eval转换data
                        eval("var d="+data);
                        //提示用户
                        if(d.success){
                            $.messager.alert("增加公司信息",d.message,"info");
                            //关闭增加的对话框
                            $("#addCompanyDialog").dialog('close');
                            //重新记载DataGird中的数据
                            $("#companyDataGrid").datagrid('reload');
                        }else{
                            $.messager.alert("增加公司信息",d.message,"error");
                        }
                    }
                })
            })
        })
        /**********************编辑公司信息功能实现****************************************************/
        $(function () {
            //给编辑按钮增加单击事件
            $("#editCompany").click(function () {
                //判断是否选择了要编辑的公司信息
                var tr=$("#companyDataGrid").datagrid('getChecked');
                //判断
                if(tr.length==1){
                    //将要编辑的公司信息回显到编辑对话框中
                    $("#companyEditForm").form('load',tr[0]);
                    //弹出编辑对话框
                    $("#editCompanyDialog").dialog('open');
                }else if(tr.length>1){
                    $.messager.alert("提示","每次只能编辑一条数据","info");
                }else{
                    $.messager.alert("提示","请选择要编辑的数据","info");
                }
            })
            //给更新按钮增加单击事件
            $("#editCompanyFrom").click(function () {
                //异步提交表单
                $("#companyEditForm").form('submit',{
                    url:'company/companyEdit',
                    success:function (data) {
                        //使用eval转换data
                        eval("var d="+data);
                        //提示用户
                        if(d.success){
                            $.messager.alert("提示","编辑成功","info");
                            //关闭增加的对话框
                            $("#editCompanyDialog").dialog('close');
                            //重新记载DataGird中的数据
                            $("#companyDataGrid").datagrid('reload');
                        }else{
                            $.messager.alert("提示","编辑失败","error");
                        }
                    }
                })
            })
        })
        /**********************查看公司策划师信息****************************************************/
        $(function () {
            //初始化设置策划师的DataGrid
            $("#plannerCompanyDataGrid").datagrid({
                url:"planner/plannerInfo",//设置远程加载数据的地址
                title:"查询结果",
                columns:    //设置表格的列以及每列和加载的数据的映射关系
                    [[
                        //表示一列，并且设置该列和数据的映射关系
                        {title:"策划师姓名",field:"nname",width:150},
                        {title:"手机号",field:"nphone",width:150},
                        {title:"加入时间",field:"addtime",width:150,
                            formatter:function (value,rows,rowIndex) {
                                return value.year+"-"+value.monthValue+"-"+value.dayOfMonth+" "
                                    +value.hour+":"+value.minute+":"+value.second;
                            }
                        },
                        {title:"账号状态",field:"status",width:150,
                            formatter:function (value,rows,rowIndex) {
                                return value=="1"?"正常":"禁用"
                            }
                        },
                        {title:"订单量",field:"ordernumber",width:150}
                    ]]
            })
            //给策划师按钮增加单击事件
            $("#plannerList").click(function () {
                //判断是否选择公司
                var tr=$("#companyDataGrid").datagrid('getChecked');
                //判断
                if(tr.length==1){
                    //让策划师的dataGrid发起ajax请求，加载数据
                   $("#plannerCompanyDataGrid").datagrid('load',{
                        cid:tr[0].cid//设置ajax请求数据
                    })
                    //显示策划师列表的对话框
                    $("#plannerCompanyDialog").dialog('open');
                }else if(tr.length>1){
                    $.messager.alert("提示","只能选择一个公司信息","info");
                }else{
                    $.messager.alert("提示","请选择公司","info");
                }
            })
        })
        /**********************公司账号操作************************************************************************/
        $(function () {
            //给账号按钮增加单击事件
            $("#accountStatus").click(function () {
                //获取选择的行
                var trs=$("#companyDataGrid").datagrid('getChecked');
                //判断是否选择要修改的行
                if(trs.length>0){
                    //获取要修改的主持人信息的ID
                    var cids="";
                    //获取要修改的主持人信息的账号的状态
                    var statuss="";
                    for(var i=0;i<trs.length;i++){
                        cids+=trs[i].cid+",";
                        statuss+=trs[i].status+",";
                    }
                    //发起ajax请求完成账号状态更新
                    $.post("company/companyAccountUp",{cids:cids,statuss:statuss},function (data) {
                        if(data.success){
                            $.messager.alert("提示","修改成功","info");
                            //重新加载数据
                            $("#companyDataGrid").datagrid('reload');
                        }else{
                            $.messager.alert("提示","修改失败","error");
                        }
                    })
                }else{
                    $.messager.alert("提示","请选择要修改的公司信息","info");
                }
            })
        })

    </script>
</head>
<body>
    <%--创建公司策划师列表的对话框--%>
    <div id="plannerCompanyDialog" class="easyui-dialog" title="策划师信息" style="width:800px;height:400px;"
         data-options="iconCls:'icon-save',resizable:false,modal:true,closed:true">
        <%--创建测试师的dataGrid--%>
        <table id="plannerCompanyDataGrid"></table>
    </div>
    <%--创建编辑公司信息的对话框--%>
    <div id="editCompanyDialog" class="easyui-dialog" title="编辑公司" style="width:400px;height:400px;"
         data-options="iconCls:'icon-save',resizable:false,modal:true,closed:true">
        <%--创建主持人增加的表单--%>
        <form id="companyEditForm"  method="post">
            <input type="hidden" name="cid" value="">
            <%--公司名称--%>
            <div style="margin-bottom:20px;margin-top:25px;text-align: center">
                <input class="easyui-textbox" name="cname" prompt="请输入公司名称" label="公司名称" iconWidth="28" style="width:300px;height:34px;padding:10px;">
            </div>
            <%--公司密码--%>
            <div style="margin-bottom:20px;text-align: center">
                <input  class="easyui-passwordbox" name="cpwd" prompt="请输入公司密码" label="公司密码" iconWidth="28" style="width:300px;height:34px;padding:10px">
            </div>
            <%--公司手机号--%>
            <div style="margin-bottom:20px;text-align: center">
                <input class="easyui-textbox" name="cphone" prompt="请输入公司手机号" label="公司手机号"  iconWidth="28" style="width:300px;height:34px;padding:10px;">
            </div>
            <%--公司法人--%>
            <div style="margin-bottom:20px;text-align: center">
                <input class="easyui-textbox" name="ceo" prompt="请输入公司法人" label="公司法人" iconWidth="28" style="width:300px;height:34px;padding:10px;">
            </div>
            <%--公司邮箱--%>
            <div style="margin-bottom:20px;text-align: center">
                <input class="easyui-textbox" name="cmail" prompt="请输入公司邮箱" label="公司邮箱" iconWidth="28" style="width:300px;height:34px;padding:10px;">
            </div>
            <%--操作按钮--%>
            <div style="margin-bottom:20px;text-align: center">
                <a href="javascript:void(0)" id="editCompanyFrom" class="easyui-linkbutton c3" style="width:120px">完成更新</a>
            </div>
        </form>
    </div>
    <%--创建增加公司信息的对话框--%>
    <div id="addCompanyDialog" class="easyui-dialog" title="增加公司" style="width:400px;height:400px;"
         data-options="iconCls:'icon-save',resizable:false,modal:true,closed:true">
        <%--创建主持人增加的表单--%>
        <form id="companyForm"  method="post">
            <%--公司名称--%>
            <div style="margin-bottom:20px;margin-top:25px;text-align: center">
                <input class="easyui-textbox" name="cname" prompt="请输入公司名称" iconWidth="28" style="width:300px;height:34px;padding:10px;">
            </div>
            <%--公司密码--%>
            <div style="margin-bottom:20px;text-align: center">
                <input id="pass" class="easyui-passwordbox" name="cpwd" prompt="请输入公司密码" iconWidth="28" style="width:300px;height:34px;padding:10px">
            </div>
            <%--公司手机号--%>
                <div style="margin-bottom:20px;text-align: center">
                    <input class="easyui-textbox" name="cphone" prompt="请输入公司手机号" iconWidth="28" style="width:300px;height:34px;padding:10px;">
                </div>
            <%--公司法人--%>
                <div style="margin-bottom:20px;text-align: center">
                    <input class="easyui-textbox" name="ceo" prompt="请输入公司法人" iconWidth="28" style="width:300px;height:34px;padding:10px;">
                </div>
            <%--公司邮箱--%>
                <div style="margin-bottom:20px;text-align: center">
                    <input class="easyui-textbox" name="cmail" prompt="请输入公司邮箱" iconWidth="28" style="width:300px;height:34px;padding:10px;">
                </div>
            <%--操作按钮--%>
            <div style="margin-bottom:20px;text-align: center">
                <a href="javascript:void(0)" id="addCompanyFrom" class="easyui-linkbutton c3" style="width:120px">完成增加</a>
            </div>
        </form>
   </div>
    <%--创建公司管理面板组件--%>
    <div id="p" class="easyui-panel" title="公司管理"
         style="width:900px;height:500px;padding:10px;background:#fafafa;"
         data-options="closable:false,collapsible:false,minimizable:false,maximizable:false">
        <%--创建检索条件组件效果--%>
        <div style="margin: auto;width: 700px;">
            <%--创建检索条件表单--%>
            <form action="">
                <input class="easyui-textbox" prompt="公司名称" id="cname" name="cname" style="width:150px"><%--姓名条件--%>
                <select class="easyui-combobox" id="status"  data-options="editable:false,value:'账号状态'" name="status" style="width: 150px;"><%--账号状态条件--%>
                    <option value="0">禁用</option>
                    <option value="1">正常</option>
                </select>
                <select class="easyui-combobox" id="ordernumber" data-options="editable:false,value:'订单量排序'" name="ordernumber" style="width: 150px;"><%--权重排序条件--%>
                    <option value="asc">升序</option>
                    <option value="desc">降序</option>
                </select>
                <a id="search" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:false">查询</a>
            </form>
        </div>
        <%--创建主持人信息加载的DataGrid组件--%>
        <table id="companyDataGrid"></table>
    </div>
    <%--创建公司DataGrid的工具栏--%>
    <div id="companyToolBar">
        <a id="addCompany" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true">添加公司</a>
        <a id="editCompany" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true">编辑公司</a>
        <a id="plannerList" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true">策划师列表</a>
        <a id="accountStatus" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true">账号状态</a>
    </div>
</body>
</html>
