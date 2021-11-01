package com.bjsxt.controller;


import com.bjsxt.pojo.Host;
import com.bjsxt.pojo.HostCondition;
import com.bjsxt.pojo.PageResult;
import com.bjsxt.pojo.Result;
import com.bjsxt.service.IHostService;
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
@RequestMapping("/host")
public class HostController {
    //声明业务层属性
    @Autowired
    private IHostService hostService;
    //声明单元方法:分页加载主持人信息
    /**
     * dataGrid的数据格式：
     *   要求响应一个json数据，并且有total和rows两个属性
     *   total表示符合要求的总的数据量
     *   rows为当前请求页的数据的list集合
     *   注意:
     *      创建实体类，实体类中有两个属性，属性名必须为total，rows
     *
     * 单元方法的形参:
     *      请求的页码： page
     *      每页显示的数量: rows
     *      筛选条件:HostCondition
     */
    @ResponseBody
    @RequestMapping("hostInfo")
    public PageResult<Host> hostInfo(Integer page, Integer rows, HostCondition hostCondition){
        //处理请求
            PageResult<Host> pageResult=hostService.selHostInfoService(page,rows,hostCondition);
        //响应结果
            return pageResult;
    }
    //声明单元方法:新增主持人信息
    @ResponseBody
    @RequestMapping("hostAdd")
    public Result hostAdd(Host host){
        //处理请求
            //设置主持人默认数据
            host.setStarttime(LocalDateTime.now());
            host.setStatus("1");
            host.setStrong("20");
            host.setOrdernumber(0);
            //新增
            boolean insert = host.insert();
        //响应结果
            return  new Result(insert,insert?"增加成功":"增加失败");
    }

    //声明单元方法:修改主持人账号状态
    @ResponseBody
    @RequestMapping("hostAccountUp")
    public Result hostAccountUp(String hids,String statuss){
        //处理请求
            //获取要修改的主持人ID的数组
            String[] hidsStr=hids.split(",");
            //获取主持人当前账号状态
            String[] statussStr=statuss.split(",");
            //修改
            for(int i=0;i<hidsStr.length;i++){
                //修改主持人账号状态
                Host host=new Host();
                host.setHid(Integer.valueOf(hidsStr[i]));
                host.setStatus("1".equals(statussStr[i])?"0":"1");
                //更新
                host.updateById();
            }
        //响应结果
        return  new Result(true,"");
    }
    //声明单元方法:修改主持人权重
    @ResponseBody
    @RequestMapping("hostStrongUp")
    public Result hostStrongUp(Host host){

        //处理请求
         boolean b = host.updateById();
        //响应结果
        return  new Result(b,"");
    }

}

