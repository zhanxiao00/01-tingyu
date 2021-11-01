package com.bjsxt.controller;


import com.bjsxt.pojo.Company;
import com.bjsxt.pojo.PageResult;
import com.bjsxt.pojo.Result;
import com.bjsxt.service.ICompanyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ResponseBody;

import java.time.LocalDateTime;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author ${author}
 * @since 2020-03-20
 */
@Controller
@RequestMapping("/company")
public class CompanyController {
    //声明业务层属性
    @Autowired
    private ICompanyService companyService;
    //声明单元方法:分页加载公司信息
    @ResponseBody
    @RequestMapping("companyInfo")
    public PageResult<Company> companyInfo(Integer page,Integer rows,String cname,String status,String ordernumber){
        //处理请求
            PageResult<Company> pageResult=companyService.selCompanyInfoService(page,rows,cname,status,ordernumber);
        //响应结果
            return  pageResult;

    }
    //声明单元方法:增加公司信息
    @ResponseBody
    @RequestMapping("companyAdd")
    public Result companyAdd(Company company){
        //处理请求
            company.setStarttime(LocalDateTime.now());
            company.setStatus("1");
            company.setOrdernumber(0);
            boolean insert = company.insert();
        //响应结果
        return  new Result(insert,insert?"成功":"失败");

    }
    //声明单元方法:更新公司信息
    @ResponseBody
    @RequestMapping("companyEdit")
    public Result companyEdit(Company company){
        //处理请求
        boolean up = company.updateById();
        //响应结果
        return  new Result(up,"");

    }
    //声明单元方法:更新公司账号状态
    @ResponseBody
    @RequestMapping("companyAccountUp")
    public Result companyAccountUp(String cids,String statuss){
        //处理请求
            //获取要修改的公司ID的数组
            String[] cidStr = cids.split(",");
            //获取要修改的公司当前的账号状态数组
            String[] statusStr = statuss.split(",");
            //创建Company对象使用AR模式完成更新
            Company company=new Company();
            //修改公司账号状态
            for(int i=0;i<cidStr.length;i++){
                company.setCid(Integer.valueOf(cidStr[i]));
                company.setStatus("1".equals(statusStr[i])?"0":"1");
                company.updateById();
            }
        //响应结果
            return new Result(true,"");

    }


}

