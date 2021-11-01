package com.bjsxt.controller;


import com.bjsxt.pojo.PageResult;
import com.bjsxt.pojo.Result;
import com.bjsxt.pojo.Role;
import com.bjsxt.service.IRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author ${author}
 * @since 2020-03-20
 */
@Controller
@RequestMapping("/role")
public class RoleController {
    //声明业务层属性
    @Autowired
    private IRoleService roleService;
    //声明单元方法:删除角色信息
    @ResponseBody
    @RequestMapping("roleDel")
    public Result roleDel(String rids){
        //处理请求
        Result result=roleService.delRoleInfoService(rids);
        //响应结果
        return result;
    }
    //声明单元方法:更新角色信息
    @ResponseBody
    @RequestMapping("roleEdit")
    public Result roleEdit(Role role,String mids){
        //处理请求
        Result result=roleService.upRoleInfoService(role,mids);
        //响应结果
        return result;
    }
    //声明单元方法:增加角色信息
    @ResponseBody
    @RequestMapping("roleAdd")
    public Result roleAdd(Role role,String mids){
        //处理请求
            Result result=roleService.insRoleInfoService(role,mids);
        //响应结果
            return result;
    }
    //声明单元方法:分页加载角色信息
    @ResponseBody
    @RequestMapping("roleInfo")
    public PageResult<Role> roleInfo(Integer page,Integer rows){
        //处理请求
            PageResult<Role> result=roleService.selRoleInfoService(page,rows);
        //响应结果
            return result;

    }
}

