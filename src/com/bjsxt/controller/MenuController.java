package com.bjsxt.controller;


import com.bjsxt.pojo.Admin;
import com.bjsxt.pojo.Menu;
import com.bjsxt.pojo.Result;
import com.bjsxt.pojo.TreeResult;
import com.bjsxt.service.IMenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author ${author}
 * @since 2020-03-20
 */
@Controller
@RequestMapping("/menu")
public class MenuController {
    //声明业务层属性
    @Autowired
    private IMenuService menuService;
    //声明单元方法:加载菜单信息
    @ResponseBody
    @RequestMapping("menuInfo")
    public List<TreeResult> menuInfo(@RequestParam(defaultValue = "0") String id, HttpSession session){
        //处理请求
            //获取session中的用户的Id
            Admin admin= (Admin) session.getAttribute("admin");
            Integer aid=admin.getAid();
            //调用业务层获取当前登录的用户的菜单信息
            List<TreeResult> list=menuService.selMenuInfoService(id,aid);
        //响应结果
            return list;
    }
    //声明单元方法:加载所有的菜单信息
    @ResponseBody
    @RequestMapping("menuAllInfo")
    public List<TreeResult> menuAllInfo(@RequestParam(defaultValue = "0") String id){
        //处理请求
            //调用业务层获取当前登录的用户的菜单信息
            List<TreeResult> list=menuService.selMenuAllInfoService(id);
        //响应结果
        return list;
    }
    //声明单元方法:加载所有的菜单信息2,响应所有的菜单信息，按照层级关系组装好后返回
    @ResponseBody
    @RequestMapping("menuAllInfo2")
    public List<TreeResult> menuAllInfo2(){
        //处理请求
            //调用业务层获取当前登录的用户的菜单信息
            List<TreeResult> list=menuService.selMenuAllInfoService2();
        //响应结果
            return list;
    }
    //声明单元方法:新增菜单信息
    @ResponseBody
    @RequestMapping("menuAdd")
    public Result menuAdd(Menu menu){
        //处理请求
            //调用业务层获取当前登录的用户的菜单信息
        Result result=menuService.insMenuInfoService(menu);
        //响应结果
        return result;
    }
    //声明单元方法:编辑菜单信息
    @ResponseBody
    @RequestMapping("menuEdit")
    public Result menuEdit(Menu menu){
        //处理请求
        boolean b = menu.updateById();
        //响应结果
        return new Result(b,"");
    }
    //声明单元方法:删除菜单信息
    @ResponseBody
    @RequestMapping("menuDel")
    public Result menuDel(Menu menu){
        //处理请求
            Result result=menuService.delMenuInfoService(menu);
        //响应结果
            return result;
    }

}

