package com.bjsxt.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.bjsxt.pojo.Admin;
import com.bjsxt.service.IAdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.stereotype.Controller;

import javax.servlet.http.HttpSession;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author ${author}
 * @since 2020-03-20
 */
@Controller
@RequestMapping("/admin")
public class AdminController {
    //声明业务层属性
    @Autowired
    private IAdminService adminService;
    //声明单元方法:处理登录请求
    @RequestMapping("userLogin")
    public String userLogin(String aname, String apwd, HttpSession session){
        //处理登录
            //创建条件构造器
                QueryWrapper<Admin> queryWrapper=new QueryWrapper<>();
                queryWrapper.eq("aname",aname).eq("apwd",apwd);
             //查询
                 Admin admin=adminService.getOne(queryWrapper);
        //响应结果
            if(admin!=null){
                //登录成功
                    session.setAttribute("admin",admin);
                 //重定向到主页面
                    return "redirect:/main.jsp";
            }else{
                //登录失败
                    session.setAttribute("flag","loginFail");
                //重定向到登录页面
                    return "redirect:/login.jsp";
            }
    }

}

