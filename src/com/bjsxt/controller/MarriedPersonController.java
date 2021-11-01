package com.bjsxt.controller;


import com.aliyuncs.dysmsapi.model.v20170525.SendSmsResponse;
import com.aliyuncs.exceptions.ClientException;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.bjsxt.pojo.MarriedPerson;
import com.bjsxt.pojo.PageResult;
import com.bjsxt.pojo.Result;
import com.bjsxt.service.IMarriedPersonService;
import com.bjsxt.util.AliPhoneUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ResponseBody;

import java.time.LocalDate;
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
@RequestMapping("/marriedPerson")
public class MarriedPersonController {
    //声明业务层属性
    @Autowired
    private IMarriedPersonService marriedPersonService;
    //声明单元方法:分页加载新人信息
    @ResponseBody
    @RequestMapping("marriedPersonInfo")
    public PageResult<MarriedPerson> marriedPersonInfo(Integer page,Integer rows,String pname,String phone){
        //处理请求
        PageResult<MarriedPerson> result=marriedPersonService.selMarriedPersonInfoService(page,rows,pname,phone);
        //响应结果
        return result;

    }
    //声明单元方法：新人注册
    @ResponseBody
    @RequestMapping("reg")
    public Result marriedPersonReg(MarriedPerson marriedPerson){
        //处理请求
            marriedPerson.setMarrydate(LocalDate.now());
            marriedPerson.setRegdate(LocalDateTime.now());
            marriedPerson.setStatus("1");
             boolean insert = marriedPerson.insert();
        //响应结果
            return  new Result(insert,"");
    }
    //声明单元方法:新人登录
    @ResponseBody
    @RequestMapping("personLogin")
    public MarriedPerson personLogin(String phone,String ppwd){
        //处理请求
            //创建条件构造器
            QueryWrapper<MarriedPerson> queryWrapper=new QueryWrapper<>();
            queryWrapper.eq("phone",phone).eq("ppwd",ppwd);
            //查询
            MarriedPerson marriedPerson = marriedPersonService.getOne(queryWrapper);
        //响应结果
            return marriedPerson;
    }
    //声明单元方法:手机验证码
    @ResponseBody
    @RequestMapping("/personCode")
    public String phoneCode(String phonenumber) throws ClientException {
        //得到验证码
        AliPhoneUtil.setNewCode();
        Integer newCode = AliPhoneUtil.getNewCode();
        SendSmsResponse sendSmsResponse = AliPhoneUtil.sendSms(phonenumber,newCode);
        System.out.println(sendSmsResponse);
        return sendSmsResponse.getCode();
    }

}

