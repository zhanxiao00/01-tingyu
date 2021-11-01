package com.bjsxt.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.bjsxt.pojo.Company;
import com.bjsxt.mapper.CompanyMapper;
import com.bjsxt.pojo.PageResult;
import com.bjsxt.service.ICompanyService;
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
public class CompanyServiceImpl extends ServiceImpl<CompanyMapper, Company> implements ICompanyService {
    //分页加载公司信息
    @Override
    public PageResult<Company> selCompanyInfoService(Integer page, Integer rows, String cname, String status, String ordernumber) {
        //1.创建分页对象存储分页信息
        IPage<Company> p=new Page<>(page,rows);
        //2.分页查询
            //创建条件构造器
            QueryWrapper<Company> queryWrapper=new QueryWrapper<>();
            if(cname!=null&&!"".equals(cname)){
                queryWrapper.like("cname",cname);
            }
            if(status!=null&&!"".equals(status)){
                queryWrapper.eq("status",status);
            }
            if("asc".equals(ordernumber)){
                queryWrapper.orderByAsc("ordernumber");
            }else if("desc".equals(ordernumber)){
                queryWrapper.orderByDesc("ordernumber");
            }
            //查询
            IPage<Company> companyIPage = baseMapper.selectPage(p, queryWrapper);
        //3.将结果封装PageResult
            PageResult pageResult=new PageResult(companyIPage.getTotal(),companyIPage.getRecords());
        //4.返回
        return pageResult;
    }
}
