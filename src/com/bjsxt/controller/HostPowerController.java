package com.bjsxt.controller;


import com.bjsxt.pojo.HostPower;
import com.bjsxt.pojo.Result;
import com.bjsxt.service.IHostPowerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author ${author}
 * @since 2020-03-20
 */
@Controller
@RequestMapping("/hostPower")
public class HostPowerController {
    //声明业务层属性
    @Autowired
    private IHostPowerService hostPowerService;
    //声明单元方法:处理权限的更新 或者新增
    @ResponseBody
    @RequestMapping("hostPowerOper")
    private Result hostPowerOper(HostPower hostPower){
        //处理请求
                if(hostPower.getHpid()!=null){
                    //更新
                    boolean up = hostPower.updateById();
                    return new Result(up,"更新成功");
                }else{
                    //新增
                    boolean insert = hostPower.insert();
                    return new Result(insert,"增加成功");
                }

    }
    //声明单元方法:处理权限的更新 或者新增
    @ResponseBody
    @RequestMapping("hostPowerBatchOper")
    private Result hostPowerBatchOper(String hostids,HostPower hostPower){
        //处理请求
         Result result=  hostPowerService.delInsHostPowerBatchService(hostids,hostPower);
       //响应结果
            return  result;
    }
}

