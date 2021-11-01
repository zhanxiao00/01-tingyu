package com.bjsxt.service;

import com.bjsxt.pojo.PageResult;
import com.bjsxt.pojo.Result;
import com.bjsxt.pojo.Role;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author ${author}
 * @since 2020-03-20
 */
public interface IRoleService extends IService<Role> {
    //分页加载角色信息
    PageResult<Role> selRoleInfoService(Integer page, Integer rows);
    //增加角色
    Result insRoleInfoService(Role role, String mids);
    //更新角色信息
    Result upRoleInfoService(Role role, String mids);
    //删除角色信息
    Result delRoleInfoService(String rids);
}
