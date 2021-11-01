<%--
  Created by IntelliJ IDEA.
  User: zyp
  Date: 2020/3/21
  Time: 10:32
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
        /***************初始化加载主持人信息的DataGrid组件************************************************/
         $(function () {
            //初始化DataGrid
            $("#hostDataGrid").datagrid({
                url:"host/hostInfo",//设置远程加载数据的地址
                pagination:true,//在表格中显示分页工具栏，将此属性设置为true，就会发送ajax分页请求获取要加载的数据
                rownumbers:true,//显示行号
                pageNumber:1,//设置ajax分页查询的默认页码数
                pageSize:2,//设置每页显示的数量
                checkOnSelect:false,//设置点击行的任意位置不会选择该行，只有点击复选框时菜单选择
                pageList:[2,4,6],//设置每页数据量下拉框框中的数据
                title:"查询结果",//显示标题
                toolbar:"#hostToolBar",//增加工具栏效果
                columns:    //设置表格的列以及每列和加载的数据的映射关系
                    [[
                        {field:"aa",checkbox:true},//每列显示一个多选框的效果
                        {title:"权重",field:"strong",width:100,
                            formatter:function (value,rows,rowIndex) {
                                return "<input type='text' value='"+value+"' style='width:50px;' onblur='changeStrong(this,"+rows.hid+")'  >";
                            }

                        },//表示一列，并且设置该列和数据的映射关系
                        {title:"姓名",field:"hname",width:100},
                        {title:"手机号",field:"hphone",width:100},
                        {title:"开通时间",field:"starttime",width:200,
                            formatter:function (value,rows,rowIndex) {
                                return value.year+"-"+value.monthValue+"-"+value.dayOfMonth+" "
                                    +value.hour+":"+value.minute+":"+value.second;
                            }
                        },
                        {title:"价格",field:"hpprice",width:100,
                            formatter:function (value,rows,rowIndex) {
                                if(rows.hostPower){
                                    return rows.hostPower.hpprice
                                }else{
                                    return "";
                                }

                            }
                        },
                        {title:"订单量",field:"ordernumber",width:100},
                        {title:"折扣",field:"hpdiscount",width:100,
                            formatter:function (value,rows,rowIndex) {
                                if(rows.hostPower){
                                    return rows.hostPower.hpdiscount
                                }else{
                                    return "";
                                }

                            }
                        },
                        {title:"星推荐",field:"hpstar",width:100,
                            formatter:function (value,rows,rowIndex) {
                                if(rows.hostPower){
                                    return rows.hostPower.hpstar=="1"?"是":"否"
                                }else{
                                    return "";
                                }

                            }
                        },
                        {title:"账号状态",field:"status",width:100,
                            formatter:function (value,rows,rowIndex) {
                                return value=="1"?"正常":"禁用"
                            }
                        }
                    ]]
            })
         })
        /**************查询按钮完成主持人信息的筛选分页查询***********************************************/
        $(function () {
            //给查询按钮增加单击时间
            $("#search").click(function () {
                //dataGrid按照条件重新分页加载主持人信息
                $("#hostDataGrid").datagrid('load',{
                     hname:$("#hname").val(),
                    status:$("#status").val(),
                    strong:$("#strong").val(),
                    hpstar:$("#hpstar").val(),
                    hpdiscount:$("#hpdiscount").val()
                })
            })
        })
        /**********************增加主持人信息功能实现****************************************************/
        $(function () {
            //给增加按钮添加单击事件
            $("#addHost").click(function () {
               //显示主持人增加的对话框
                 $("#addHostDialog").dialog('open');
            })
            //给主持人增加的表单按钮添加单击事件
            $("#addHostFrom").click(function () {
                //发起ajax请求完成主持人增加的请求发送
                $("#hostForm").form('submit',{
                    url:'host/hostAdd',//请求地址
                    success:function (data) {//回调函数，data为原始的json数据，需要自己使用eval完成数据的转换
                               //使用eval转换data
                                eval("var d="+data);
                                //提示用户
                                if(d.success){
                                    $.messager.alert("增加主持人信息",d.message,"info");
                                    //关闭增加的对话框
                                    $("#addHostDialog").dialog('close');
                                    //重新记载DataGird中的数据
                                    $("#hostDataGrid").datagrid('reload');
                                }else{
                                    $.messager.alert("增加主持人信息",d.message,"error");
                                }
                    }
                })
            })
        })
        /**********************主持人账号操作************************************************************************/
        $(function () {
            //给账号按钮增加单击事件
            $("#hostAccount").click(function () {
                //获取选择的行
                var trs=$("#hostDataGrid").datagrid('getChecked');
                //判断是否选择要修改的行
                if(trs.length>0){
                    //获取要修改的主持人信息的ID
                    var hids="";
                    //获取要修改的主持人信息的账号的状态
                    var statuss="";
                    for(var i=0;i<trs.length;i++){
                        hids+=trs[i].hid+",";
                        statuss+=trs[i].status+",";
                    }
                    //发起ajax请求完成账号状态更新
                    $.post("host/hostAccountUp",{hids:hids,statuss:statuss},function (data) {
                        if(data.success){
                            $.messager.alert("提示","修改成功","info");
                            //重新加载数据
                            $("#hostDataGrid").datagrid('reload');
                        }else{
                            $.messager.alert("提示","修改失败","error");
                        }
                    })
                }else{
                    $.messager.alert("提示","请选择要修改的主持人信息","info");
                }
            })
        })
        /**********************修改主持人权重************************************************************************/
        function changeStrong(inp,hid) {
           //发起ajax请求完成权重的修改
            $.post("host/hostStrongUp",{hid:hid,strong:inp.value},function (data) {
                if(data.success){
                    $.messager.alert("提示","权重修改成功","info");
                    //重新加载数据
                    $("#hostDataGrid").datagrid('reload');
                }else{
                    $.messager.alert("提示","权重修改失败","error");
                }
            })
        }
        /**********************主持人权限设置***********************************************************************/
        $(function () {
            //设置权限对话框关闭时，清空表单数据
            $("#hostPowerDialog").dialog({
                onClose:function () {
                    //清空表单
                    $("#hostPowerForm").form('clear')
                }
            })
            //给权限设置按钮增加单击事件 回显权限信息以及弹出对话框
            $("#hostPower").click(function () {
                //校验是否选择要进行设置的主持人
                var tr=$("#hostDataGrid").datagrid('getChecked');
                //判断
                if(tr.length==1){
                    //获取要修改的主持人的原有权限数据
                    var hpower=tr[0].hostPower;
                    console.log(hpower)
                    //将要信息权限设置的主持人的ID使用隐藏标签记录下来
                    $("#hostid").val(tr[0].hid);
                    //判断hpower是否有值
                    if(hpower){
                        //回显
                        //将当前权限的ID记录在隐藏标签中，更新使用
                        $("#hpid").val(hpower.hpid);
                        //是否星推荐的回显
                        hpower.hpstar=="1"?$("#hpstart_yes").radiobutton({checked:true}):$("#hpstart_no").radiobutton({checked:false})
                        //星推荐日期回显示
                        $("#hpstar_begindate").datebox('setValue',jsonToDate(hpower.hpstartBegindate));
                        $("#hpstar_enddate").datebox('setValue',jsonToDate(hpower.hpstarEnddate));
                        //星推荐时间回显
                        $("#hpstar_begintime").timespinner('setValue',jsonToTime(hpower.hpstarBegintime))
                        $("#hpstar_endtime").timespinner('setValue',jsonToTime(hpower.hpstarEndtime))
                        //自填写订单
                        hpower.hpOrderPower=="1"?$("#hpOrderPower_yes").radiobutton({checked:true}):$("#hpOrderPower_no").radiobutton({checked:false})
                        //折扣
                        $("#hp_discount").textbox('setValue',hpower.hpdiscount)
                        //折扣日期
                        $("#hp_dis_starttime").datebox('setValue',jsonToDate(hpower.hpDisStarttime));
                        $("#hp_dis_endtime").datebox('setValue',jsonToDate(hpower.hpDisEndtime));
                        //价格
                        $("#hpprice").textbox('setValue',hpower.hpprice);
                        //管理费
                        $("#hpcosts").textbox('setValue',hpower.hpcosts);
                    }
                    //显示权限设置的对话框
                    $("#hostPowerDialog").dialog('open');
                }else if(tr.length>1){
                    $.messager.alert("提示","只能选择一个主持人信息","info")
                }else{
                    $.messager.alert("提示","请选择一个主持人信息","info")
                }

            })
            //异步提交权限表单
            $("#hostPowerFromSubmit").click(function () {
                $("#hostPowerForm").form('submit',{
                    url:'hostPower/hostPowerOper',
                    success:function (data) {
                        //转换数据
                        eval("var d="+data);
                        //判断结果
                        if(d.success){
                            $.messager.alert("提示",d.message,"info");
                            //关闭对话框
                            $("#hostPowerDialog").dialog('close');
                            //刷新表格数据
                            $("#hostDataGrid").datagrid('reload');
                        }
                    }
                })
            })
        })
        /*******************声明函数将json类型的时间转换为日期*********************************/
            //日期转换
            function jsonToDate(obj) {
                return obj.year+"-"+obj.monthValue+"-"+obj.dayOfMonth;
            }
            //时间转换
            function jsonToTime(obj) {
                //return "17:45:00"
               var h=obj.hour<10?("0"+obj.hour):obj.hour;
               var m=obj.minute<10?"0"+obj.minute:obj.minute;
               var s=obj.second<0?"0"+obj.second:obj.second;
                return h+":"+m+":"+s;
            }
        /**********************主持人权限批量设置***********************************************************************/
        $(function () {
            //给批量设置按钮增加单击事件
            $("#hostPowerBatch").click(function () {
                //判断是否选择要进行权限设置的主持人信息
                var trs=$("#hostDataGrid").datagrid('getChecked');
                //判断
                if(trs.length>0){
                    //将选择的主持人的ID存储在隐藏标签中
                    var hids="";
                    for(var i=0;i<trs.length;i++){
                        hids+=trs[i].hid+",";
                    }
                    $("#hostids").val(hids);
                    //弹出权限设置对话框
                    $("#hostPowerBatchDialog").dialog('open');

                }else{
                    $.messager.alert("提示","请选择要进行权限设置的主持人信息","info")
                }
            })
            //给批量设置权限信息的表单的提交按钮增加单击事件
            $("#hostPowerBatchFromSubmit").click(function () {
                //异步提交表单
                $("#hostPowerBatchForm").form('submit',{
                    url:'hostPower/hostPowerBatchOper',
                    success:function (data) {
                        eval("var d="+data);
                        if(d.success){
                            $.messager.alert("提示","批量操作成功","info");
                            //关闭对话框
                            $("#hostPowerBatchDialog").dialog('close');
                            //刷新dataGrid
                            $("#hostDataGrid").datagrid('reload');
                        }else{
                            $.messager.alert("提示","批量操作失败","error");
                        }
                    }
                })
            })
        })
    </script>
    <%--设置日期框的格式--%>
    <script type="text/javascript">
        //设置日期的格式
        function myformatter(date){
            var y = date.getFullYear();
            var m = date.getMonth()+1;
            var d = date.getDate();
            return y+'-'+(m<10?('0'+m):m)+'-'+(d<10?('0'+d):d);
        }
        function myparser(s) {
            if (!s) return new Date();
            var ss = (s.split('-'));
            var y = parseInt(ss[0], 10);
            var m = parseInt(ss[1], 10);
            var d = parseInt(ss[2], 10);
            if (!isNaN(y) && !isNaN(m) && !isNaN(d)) {
                return new Date(y, m - 1, d);
            } else {
                return new Date();
            }
        }
    </script>
</head>
<body>
    <%--创建主持人权限批量操作的对话框--%>
    <div id="hostPowerBatchDialog" class="easyui-dialog" title="权限批量设置" style="width:500px;height:550px;"
         data-options="iconCls:'icon-save',resizable:false,modal:true,closed:true,left:300,top:10">
        <%--创建主持人增加的表单--%>
        <form id="hostPowerBatchForm"  method="post">
            <%--创建隐藏标签存储要进行数据权限更新的主持人的ID--%>
            <input type="hidden" name="hostids" id="hostids" value="">
            <%--创建表格--%>
            <table cellpadding="10px" style="margin: auto;margin-top: 20px;">
                <tr>
                    <td>是否星推荐:</td>
                    <td>
                        <input class="easyui-radiobutton"  name="hpstar" value="1" label="是" labelPosition="after">
                        <input class="easyui-radiobutton"  name="hpstar" value="0" label="否" labelPosition="after">
                    </td>
                </tr>
                <tr>
                    <td>星推荐日期:</td>
                    <td>
                        <input   data-options="formatter:myformatter,parser:myparser"  data-options="showSeconds:true" name="hpstartBegindate" type="text" class="easyui-datebox">
                        -
                        <input  data-options="formatter:myformatter,parser:myparser"  name="hpstarEnddate" type="text" class="easyui-datebox">
                    </td>
                </tr>
                <tr>
                    <td>星推荐时间:</td>
                    <td>
                        <input name="hpstarBegintime" type="text" data-options="showSeconds:true" class="easyui-timespinner">
                        -
                        <input  name="hpstarEndtime" type="text" data-options="showSeconds:true" class="easyui-timespinner">
                    </td>
                </tr>
                <tr>
                    <td>自填订单:</td>
                    <td>
                        <input class="easyui-radiobutton"  name="hpOrderPower" value="1" label="是" labelPosition="after">
                        <input class="easyui-radiobutton"  name="hpOrderPower" value="0" label="否" labelPosition="after">
                    </td>
                </tr>
                <tr>
                    <td>折扣:</td>
                    <td>
                        <input class="easyui-textbox"  name="hpdiscount" prompt="请输入折扣" iconWidth="28" style="width:300px;height:34px;padding:10px;">
                    </td>
                </tr>
                <tr>
                    <td>折扣日期:</td>
                    <td>
                        <input  data-options="formatter:myformatter,parser:myparser" name="hpDisStarttime" type="text" class="easyui-datebox">
                        -
                        <input  data-options="formatter:myformatter,parser:myparser" name="hpDisEndtime" type="text" class="easyui-datebox">
                    </td>
                </tr>
                <tr>
                    <td>价格:</td>
                    <td>
                        <input class="easyui-textbox"  name="hpprice" prompt="请输入价格" iconWidth="28" style="width:300px;height:34px;padding:10px;">
                    </td>
                </tr>
                <tr>
                    <td>管理费:</td>
                    <td>
                        <input class="easyui-textbox"  name="hpcosts" prompt="请输入管理费" iconWidth="28" style="width:300px;height:34px;padding:10px;">
                    </td>
                </tr>
                <tr>
                    <td colspan="2" align="center">
                        <a href="javascript:void(0)" id="hostPowerBatchFromSubmit" class="easyui-linkbutton c3" style="width:120px">点击完成</a>
                    </td>
                </tr>
            </table>
        </form>
    </div></div>
    <%--创建主持人权限设置的对话框--%>
    <div id="hostPowerDialog" class="easyui-dialog" title="权限设置" style="width:500px;height:550px;"
         data-options="iconCls:'icon-save',resizable:false,modal:true,closed:true,left:300,top:10">
        <%--创建主持人增加的表单--%>
        <form id="hostPowerForm"  method="post">
            <%--创建隐藏标签存储要进行数据权限更新的ID--%>
                <input type="hidden" name="hpid" id="hpid" value="">
            <%--创建隐藏标签存储要进行数据权限更新的主持人的ID--%>
                <input type="hidden" name="hostid" id="hostid" value="">
            <%--创建表格--%>
                <table cellpadding="10px" style="margin: auto;margin-top: 20px;">
                    <tr>
                        <td>是否星推荐:</td>
                        <td>
                            <input class="easyui-radiobutton" id="hpstart_yes" name="hpstar" value="1" label="是" labelPosition="after">
                            <input class="easyui-radiobutton" id="hpstart_no" name="hpstar" value="0" label="否" labelPosition="after">
                        </td>
                    </tr>
                    <tr>
                        <td>星推荐日期:</td>
                        <td>
                            <input id="hpstar_begindate"  data-options="formatter:myformatter,parser:myparser"  data-options="showSeconds:true" name="hpstartBegindate" type="text" class="easyui-datebox">
                            -
                            <input id="hpstar_enddate" data-options="formatter:myformatter,parser:myparser"  name="hpstarEnddate" type="text" class="easyui-datebox">
                        </td>
                    </tr>
                    <tr>
                        <td>星推荐时间:</td>
                        <td>
                            <input id="hpstar_begintime" name="hpstarBegintime" type="text" data-options="showSeconds:true" class="easyui-timespinner">
                            -
                            <input id="hpstar_endtime" name="hpstarEndtime" type="text" data-options="showSeconds:true" class="easyui-timespinner">
                        </td>
                    </tr>
                    <tr>
                        <td>自填订单:</td>
                        <td>
                            <input class="easyui-radiobutton" id="hpOrderPower_yes" name="hpOrderPower" value="1" label="是" labelPosition="after">
                            <input class="easyui-radiobutton" id="hpOrderPower_no" name="hpOrderPower" value="0" label="否" labelPosition="after">
                        </td>
                    </tr>
                    <tr>
                        <td>折扣:</td>
                        <td>
                            <input class="easyui-textbox" id="hp_discount" name="hpdiscount" prompt="请输入折扣" iconWidth="28" style="width:300px;height:34px;padding:10px;">
                        </td>
                    </tr>
                    <tr>
                        <td>折扣日期:</td>
                        <td>
                            <input id="hp_dis_starttime" data-options="formatter:myformatter,parser:myparser" name="hpDisStarttime" type="text" class="easyui-datebox">
                            -
                            <input id="hp_dis_endtime" data-options="formatter:myformatter,parser:myparser" name="hpDisEndtime" type="text" class="easyui-datebox">
                        </td>
                    </tr>
                    <tr>
                        <td>价格:</td>
                        <td>
                            <input class="easyui-textbox" id="hpprice" name="hpprice" prompt="请输入价格" iconWidth="28" style="width:300px;height:34px;padding:10px;">
                        </td>
                    </tr>
                    <tr>
                        <td>管理费:</td>
                        <td>
                            <input class="easyui-textbox" id="hpcosts" name="hpcosts" prompt="请输入管理费" iconWidth="28" style="width:300px;height:34px;padding:10px;">
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center">
                            <a href="javascript:void(0)" id="hostPowerFromSubmit" class="easyui-linkbutton c3" style="width:120px">点击完成</a>
                        </td>
                    </tr>
                </table>
        </form>
    </div></div>
    <%--创建增加主持人信息的对话框--%>
    <div id="addHostDialog" class="easyui-dialog" title="增加主持人" style="width:400px;height:300px;"
         data-options="iconCls:'icon-save',resizable:false,modal:true,closed:true">
        <%--创建主持人增加的表单--%>
            <form id="hostForm"  method="post">
                <%--主持人姓名--%>
                    <div style="margin-bottom:20px;margin-top:25px;text-align: center">
                        <input class="easyui-textbox" name="hname" prompt="请输入用户名" iconWidth="28" style="width:300px;height:34px;padding:10px;">
                    </div>
                <%--主持人密码--%>
                    <div style="margin-bottom:20px;text-align: center">
                        <input id="pass" class="easyui-passwordbox" name="hpwd" prompt="请输入密码" iconWidth="28" style="width:300px;height:34px;padding:10px">
                    </div>
                <%--主持人手机号--%>
                    <div style="margin-bottom:20px;text-align: center">
                        <input class="easyui-textbox" name="hphone" prompt="请输入手机号" iconWidth="28" style="width:300px;height:34px;padding:10px;">
                    </div>
                <%--操作按钮--%>
                    <div style="margin-bottom:20px;text-align: center">
                        <a href="javascript:void(0)" id="addHostFrom" class="easyui-linkbutton c3" style="width:120px">完成增加</a>
                    </div>
            </form>
        </div></div>
    <%--创建主持人管理面板组件--%>
    <div id="p" class="easyui-panel" title="主持人管理"
         style="width:1100px;height:500px;padding:10px;background:#fafafa;"
         data-options="closable:false,collapsible:false,minimizable:false,maximizable:false">
        <%--创建检索条件组件效果--%>
        <div style="margin: auto;width: 700px;">
            <%--创建检索条件表单--%>
                <form action="">
                    <input class="easyui-textbox" prompt="姓名" id="hname" name="hname" style="width:100px"><%--姓名条件--%>
                    <select class="easyui-combobox" id="status"  data-options="editable:false,value:'账号状态'" name="status" style="width: 100px;"><%--账号状态条件--%>
                        <option value="0">禁用</option>
                        <option value="1">正常</option>
                    </select>
                    <select class="easyui-combobox" id="strong" data-options="editable:false,value:'权重排序'" name="strong" style="width: 100px;"><%--权重排序条件--%>
                        <option value="asc">升序</option>
                        <option value="desc">降序</option>
                    </select>
                    <select class="easyui-combobox" id="hpstar" data-options="editable:false,value:'星推荐'" name="hpstar" style="width: 100px;"><%--星推荐条件--%>
                        <option value="0">不推荐</option>
                        <option value="1">推荐</option>
                    </select>
                    <select class="easyui-combobox" id="hpdiscount" data-options="editable:false,value:'折扣条件'" name="hpdiscount" style="width: 100px;"><%--折扣条件--%>
                        <option value="6">6</option>
                        <option value="7">7</option>
                        <option value="8">8</option>
                        <option value="9">9</option>
                    </select>
                    <a id="search" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:false">查询</a>
                    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-ok',plain:false">导出</a>
                </form>
        </div>

        <%--创建主持人信息加载的DataGrid组件--%>
        <table id="hostDataGrid"></table>
    </div>
    <%--创建主持人DataGrid的工具栏--%>
    <div id="hostToolBar">
        <a id="addHost" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true">添加主持人</a>
        <a id="hostPower" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true">权限设置</a>
        <a id="hostAccount" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true">账号禁用|启用</a>
        <a id="hostPowerBatch" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true">批量操作</a>
    </div>


</body>
</html>
