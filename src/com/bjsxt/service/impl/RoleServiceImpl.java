package com.bjsxt.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.bjsxt.mapper.AdminRoleMapper;
import com.bjsxt.mapper.RoleMenuMapper;
import com.bjsxt.pojo.*;
import com.bjsxt.mapper.RoleMapper;
import com.bjsxt.service.IRoleService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.List;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author ${author}
 * @since 2020-03-20
 */
@Service
public class RoleServiceImpl extends ServiceImpl<RoleMapper, Role> implements IRoleService {
    //声明AdminRoleMapper属性
    @Autowired
    private AdminRoleMapper adminRoleMapper;
    //声明roleMenuMapper属性
    @Autowired
    private RoleMenuMapper roleMenuMapper;
    //删除角色信息
    @Override
    public Result delRoleInfoService(String rids) {
        //获取要删除的角色的ID数组
        String[] ridStr = rids.split(",");
        //1.删除角色
        int i = baseMapper.deleteBatchIds(Arrays.asList(ridStr));
        //2.删除角色菜单对应数据和用户角色数据
            for(String rid:ridStr){
                //删除角色菜单对应数据
                    //创建条件构造器
                    QueryWrapper<RoleMenu> queryWrapper=new QueryWrapper<>();
                    queryWrapper.eq("rid",rid);
                    roleMenuMapper.delete(queryWrapper);
               //删除用户角色数据
                    QueryWrapper<AdminRole> queryWrapper2=new QueryWrapper<>();
                    queryWrapper2.eq("rid",rid);
                    adminRoleMapper.delete(queryWrapper2);
            }
        return new Result(i>0?true:false,"");
    }

    //更新角色信息
    @Override
    public Result upRoleInfoService(Role role, String mids) {
        //1.更新角色信息
            boolean b = role.updateById();
        //2.更新角色的菜单权限信息
            //删除原有的菜单权限
                //创建条件构造器
                QueryWrapper<RoleMenu> queryWrapper=new QueryWrapper<>();
                queryWrapper.eq("rid",role.getRid());
                roleMenuMapper.delete(queryWrapper);
            //增加新的菜单权限
            if(!"".equals(mids) && mids!=null){
                String[] midStr = mids.split(",");
                //遍历完成增加
                for(String mid:midStr){
                    RoleMenu roleMenu=new RoleMenu(role.getRid(),Integer.parseInt(mid));
                    roleMenu.insert();
                }

            }
        return new Result(b,"");
    }

    //增加角色
    @Override
    public Result insRoleInfoService(Role role, String mids) {
        //1.增加角色信息
        int insert = baseMapper.insert(role);
        //2.增加角色和菜单的关联
        if(!"".equals(mids) && mids!=null){
            String[] midStr = mids.split(",");
            //遍历完成增加
            for(String mid:midStr){
                RoleMenu roleMenu=new RoleMenu(role.getRid(),Integer.parseInt(mid));
                roleMenu.insert();
            }

        }
        return new Result(insert>0?true:false,"");
    }

    //分页加载角色信息
    @Override
    public PageResult<Role> selRoleInfoService(Integer page, Integer rows) {
        //1.创建分页对象存储分页条件
        IPage<Role> p=new Page<>(page,rows);
        //2.分页查询
        IPage<Role> roleIPage = baseMapper.selectPage(p, null);
        //获取分页的角色信息
        List<Role> rs = roleIPage.getRecords();
        //遍历获取角色的菜单的Id集合
        for(Role r:rs){
            //创建条件构造器
            QueryWrapper<RoleMenu> queryWrapper=new QueryWrapper<>();
            queryWrapper.select("mid").eq("rid",r.getRid());
            List<Object> list = roleMenuMapper.selectObjs(queryWrapper);
            //将菜单ID的集合存储到角色中
            r.setMids(list);
        }
        //3.封装结果并返回
        return new PageResult<Role>(roleIPage.getTotal(),roleIPage.getRecords());
    }
}
