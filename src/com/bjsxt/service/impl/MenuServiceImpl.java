package com.bjsxt.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.bjsxt.mapper.AdminRoleMapper;
import com.bjsxt.mapper.RoleMenuMapper;
import com.bjsxt.pojo.AdminRole;
import com.bjsxt.pojo.Menu;
import com.bjsxt.mapper.MenuMapper;
import com.bjsxt.pojo.RoleMenu;
import com.bjsxt.pojo.TreeResult;
import com.bjsxt.service.IMenuService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author ${author}
 * @since 2021-10-16
 */
@Service
public class MenuServiceImpl extends ServiceImpl<MenuMapper, Menu> implements IMenuService {
    //声明用户角色表的mapper
    @Autowired
    private AdminRoleMapper adminRoleMapper;
    //声明角色菜单表的mapper
    @Autowired
    private RoleMenuMapper roleMenuMapper;
    //声明菜单表的mapper
    @Autowired
    private  MenuMapper menuMapper;

    //加载当前用户的菜单信息
    /**
     *
     * @param pid  当前要查询的菜单的上级ID
     * @param aid   当前用户的Id
     * @return
     */
    @Override
    public List<TreeResult> selMenuInfoService(String pid, Integer aid) {

        //1.获取当前用户的角色id集合
            //创建条件构造器
            QueryWrapper<AdminRole> queryWrapper = new QueryWrapper<>();
            queryWrapper.eq("aid",aid).select("rid");
            //查询
            List<Object> rid = adminRoleMapper.selectObjs(queryWrapper);
        //2.获取角色对应的菜单的id集合
            //创建条件构造器
            QueryWrapper<RoleMenu> queryWrapper2 = new QueryWrapper<>();
            queryWrapper2.in("rid",rid).select("mid");
            //查询
            List<Object> mids = roleMenuMapper.selectObjs(queryWrapper2);
        //3.获取上级ID为pid的菜单信息
            //创建条件构造器
            QueryWrapper<Menu> queryWrapper3 = new QueryWrapper<>();
            queryWrapper3.in("mid",mids).eq("pid",pid);
            //查询
            List<Menu> menus = menuMapper.selectList(queryWrapper3);
        //4.将List<Menu>转换为List<TreeResult>
            //创建List<TreeResult>集合
            List<TreeResult> results = new ArrayList<>();
            for(Menu menu:menus){
                //创建TreeResult对象
                TreeResult treeResult = new TreeResult();
                //赋值
                treeResult.setId(menu.getMid());
                treeResult.setText(menu.getMname());
                treeResult.setState("1".equals(menu.getIsparent())?"closed":"open");
                    //创建map集合,存储自定义数据
                    Map<String,Object> map = new HashMap<>();
                    map.put("isparent",menu.getIsparent());
                    map.put("url",menu.getUrl());
                treeResult.setAttributes(map);
                //将对象放到results集合中
                results.add(treeResult);
            }
        //返回结果集
        return results;

    }
}
