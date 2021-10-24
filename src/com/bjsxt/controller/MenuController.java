package com.bjsxt.controller;


import com.bjsxt.pojo.Admin;
import com.bjsxt.pojo.TreeResult;
import com.bjsxt.service.IMenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.TreeMap;

/**
 * <p>
 * 前端控制器
 * </p>
 *
 * @author ${author}
 * @since 2021-10-16
 */
@Controller
@RequestMapping("/menu")
public class MenuController {

    //声明业务层属性
    @Autowired
    private IMenuService menuService;

    //声明单元方法:加载菜单信息
    @ResponseBody//因为该方法时AJAX方法
    @RequestMapping("/menuInfo")
    public List<TreeResult> MenuController(@RequestParam(defaultValue = "0") String id, HttpSession session) {
        //处理请求
        //获取session中的用户id
        Admin admin = (Admin) session.getAttribute("admin");
        Integer aid = admin.getAid();
        //调用业务层获取当前登录的用户的菜单信息
        List<TreeResult> list = menuService.selMenuInfoService(id,aid);
        //响应结果
        return list;
    }


}

