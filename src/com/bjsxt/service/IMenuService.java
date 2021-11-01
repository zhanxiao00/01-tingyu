package com.bjsxt.service;

import com.bjsxt.pojo.Menu;
import com.baomidou.mybatisplus.extension.service.IService;
import com.bjsxt.pojo.Result;
import com.bjsxt.pojo.TreeResult;

import java.util.List;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author ${author}
 * @since 2020-03-20
 */
public interface IMenuService extends IService<Menu> {
    //加载当前用户的菜单信息
    List<TreeResult> selMenuInfoService(String id, Integer aid);
    //加载所有的菜单信息
    List<TreeResult> selMenuAllInfoService(String id);
    //增加菜单信息
    Result insMenuInfoService(Menu menu);
    //删除菜单信息
    Result delMenuInfoService(Menu menu);
    //加载所有的菜单信息2
    List<TreeResult> selMenuAllInfoService2();
}
