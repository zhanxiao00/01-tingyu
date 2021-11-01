package com.bjsxt.service;

import com.bjsxt.pojo.Company;
import com.baomidou.mybatisplus.extension.service.IService;
import com.bjsxt.pojo.PageResult;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author ${author}
 * @since 2020-03-20
 */
public interface ICompanyService extends IService<Company> {
    //分页加载公司信息
    PageResult<Company> selCompanyInfoService(Integer page, Integer rows, String cname, String status, String ordernumber);
}
