package com.bjsxt.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.bjsxt.mapper.AdminRoleMapper;
import com.bjsxt.mapper.RoleMenuMapper;
import com.bjsxt.pojo.*;
import com.bjsxt.mapper.MenuMapper;
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
 * @since 2020-03-20
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
    private MenuMapper menuMapper;
    //按照层级关系组装并加载所有菜单信息
    @Override
    public List<TreeResult> selMenuAllInfoService2() {
        //1.获取所有的菜单信息
            List<Menu> menus = baseMapper.selectList(null);
        //2.按照层级关系组装菜单
            List<TreeResult> list=getMenuInfo(menus,0);
        //3.返回结果
        return list;
    }
    //根据pid的值将所有的菜单中上级为pid的菜单全部检索出来，并转换为TreeResult的集合返回
    private List<TreeResult> getMenuInfo(List<Menu> menus, int pid) {
        //1.创建List<TreeResult>存储符合要求的结果
            ArrayList<TreeResult> results=new ArrayList<>();
        //2.遍历list<Menu>获取上级ID为pid的menu
            for(Menu menu:menus){
                //判断
                if(menu.getPid()==pid){
                    //3.将menu转换为TreeResult
                    TreeResult treeResult=new TreeResult();
                    treeResult.setId(menu.getMid());
                    treeResult.setText(menu.getMname());
                    treeResult.setState("1".equals(menu.getIsparent())?"closed":"open");
                    //创建map集合,存自定义数据
                    Map<String ,Object> map=new HashMap<>();
                    map.put("isparent",menu.getIsparent());
                    map.put("url",menu.getUrl());
                    map.put("mdesc",menu.getMdesc());
                    map.put("pid",menu.getPid());
                    treeResult.setAttributes(map);
                    //使用递归
                    if("1".equals(menu.getIsparent())){
                        List<TreeResult> menuInfo = getMenuInfo(menus, menu.getMid());//当前菜单的子菜单集合
                        treeResult.setChildren(menuInfo);//将子菜单存储到父菜单的children属性中
                    }
                    //4.将转换后的TreeResult对象存储到集合中
                    results.add(treeResult);
                }
            }
        //5.返回
        return results;
    }

    //删除菜单信息
    @Override
    public Result delMenuInfoService(Menu menu) {
        //1.获取上级的子菜单的数量
            //创建条件构造器
            QueryWrapper<Menu> queryWrapper=new QueryWrapper<>();
            queryWrapper.eq("pid",menu.getPid());
            Integer count = menuMapper.selectCount(queryWrapper);
        //2.校验子菜单数量是否为1，如果是则更新上级菜单为普通菜单
            if(count==1){
                Menu mp=new Menu();
                mp.setMid(menu.getPid());
                mp.setIsparent("0");
                menuMapper.updateById(mp);
            }
        //3.删除菜单
        boolean b = menu.deleteById();
        //4.返回结果
        return new Result(b,"");
    }

    //增加菜单信息
    @Override
    public Result insMenuInfoService(Menu menu) {
        //0.判断当前增加是否选择了父ID
            Integer pid=menu.getPid();
            if(pid==null){
                menu.setPid(0);
            }else{
                //更新上级菜单为父菜单 isparent的值为1
                Menu mp=new Menu();
                mp.setMid(pid);
                mp.setIsparent("1");
                menuMapper.updateById(mp);
            }
        //1.完成新增的菜单的默认数据
            menu.setIsparent("0");
            menu.setStatus("0");
        //2.完成菜单的新增
        int insert = menuMapper.insert(menu);
        return new Result(insert>0?true:false,"");
    }

    //加载所有的菜单信息
    @Override
    public List<TreeResult> selMenuAllInfoService(String id) {
        //1.获取上级ID为id的菜单信息
            //创建条件构造器
            QueryWrapper<Menu> queryWrapper=new QueryWrapper<>();
            queryWrapper.eq("pid",id);
            List<Menu> menus = menuMapper.selectList(queryWrapper);
        //2.将List<Menu>转换为List<TreeResult>并返回
            //创建List<TreeResult>集合
            List<TreeResult> results=new ArrayList<>();
            //遍历转换
            for(Menu menu:menus){
                //创建TreeResult对象
                TreeResult result=new TreeResult();
                result.setId(menu.getMid());
                result.setText(menu.getMname());
                result.setState("1".equals(menu.getIsparent())?"closed":"open");
                //创建map集合,存自定义数据
                Map<String ,Object> map=new HashMap<>();
                map.put("isparent",menu.getIsparent());
                map.put("url",menu.getUrl());
                map.put("mdesc",menu.getMdesc());
                map.put("pid",menu.getPid());
                result.setAttributes(map);
                //将result对象存储到集合中
                results.add(result);
            }
        return results;
    }
    //加载当前用户的菜单信息
    /**
     * @param pid 当前要查询的菜单的上级ID
     * @param aid 当前用户的Id
     * @return
     */
    @Override
    public List<TreeResult> selMenuInfoService(String pid, Integer aid) {
        //1.获取当前用户的角色ID集合
            //创建条件构造器
            QueryWrapper<AdminRole> queryWrapper=new QueryWrapper<>();
            queryWrapper.eq("aid",aid).select("rid");
            //查询
            List<Object> rids = adminRoleMapper.selectObjs(queryWrapper);
        //2.获取角色对应的菜单的ID集合
            //创建条件构造器
            QueryWrapper<RoleMenu> queryWrapper2=new QueryWrapper<>();
            queryWrapper2.in("rid",rids).select("mid");
            //查询
            List<Object> mids = roleMenuMapper.selectObjs(queryWrapper2);
        //3.获取上级Id为pid的菜单信息
            //创建条件构造器
            QueryWrapper<Menu> queryWrapper3=new QueryWrapper<>();
            queryWrapper3.in("mid",mids).eq("pid",pid);
            //查询
            List<Menu> menus = menuMapper.selectList(queryWrapper3);
        //4.将List<Menu>转换为List<TreeResult>
            //创建List<TreeResult>集合
            List<TreeResult> results=new ArrayList<>();
            //遍历转换
            for(Menu menu:menus){
                //创建TreeResult对象
                TreeResult result=new TreeResult();
                result.setId(menu.getMid());
                result.setText(menu.getMname());
                result.setState("1".equals(menu.getIsparent())?"closed":"open");
                //创建map集合,存自定义数据
                Map<String ,Object> map=new HashMap<>();
                map.put("isparent",menu.getIsparent());
                map.put("url",menu.getUrl());
                result.setAttributes(map);
                //将result对象存储到集合中
                results.add(result);
            }
        return results;
    }
}
