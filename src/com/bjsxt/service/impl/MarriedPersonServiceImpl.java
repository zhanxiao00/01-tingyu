package com.bjsxt.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.bjsxt.pojo.MarriedPerson;
import com.bjsxt.mapper.MarriedPersonMapper;
import com.bjsxt.pojo.PageResult;
import com.bjsxt.service.IMarriedPersonService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author ${author}
 * @since 2020-03-20
 */
@Service
public class MarriedPersonServiceImpl extends ServiceImpl<MarriedPersonMapper, MarriedPerson> implements IMarriedPersonService {
    //分页加载新人信息
    @Override
    public PageResult<MarriedPerson> selMarriedPersonInfoService(Integer page, Integer rows, String pname, String phone) {
        //1.创建分页对象存储分页信息
        IPage<MarriedPerson> p=new Page<>(page,rows);
        //2.分页查询
            //创建条件构造器
            QueryWrapper<MarriedPerson> queryWrapper=new QueryWrapper<>();
            if(pname!=null && !"".equals(pname)){
                queryWrapper.like("pname",pname);
            }
            if (phone!=null&&!"".equals(phone)){
                queryWrapper.eq("phone",phone);
            }
            //查询
            IPage<MarriedPerson> marriedPersonIPage = baseMapper.selectPage(p, queryWrapper);
        //3.封装PageResult并返回
        return new PageResult<MarriedPerson>(marriedPersonIPage.getTotal(),marriedPersonIPage.getRecords());
    }
}
