package com.bjsxt.controller;


import com.bjsxt.pojo.Host;
import com.bjsxt.pojo.HostCondition;
import com.bjsxt.pojo.PageResult;
import com.bjsxt.service.IHostService;
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
 * @since 2021-10-16
 */
@Controller
@RequestMapping("/host")
public class HostController {

    //声明业务层属性
    @Autowired
    private IHostService hostService;

    //声明单元方法:分页加载主持人信息
    /**
     * 因为前端使用的时dataGrid数据网格,所以要根据网格要求响应回数据
     *  要求响应一个json数据,并且有total和rows两个属性
     *  total:表示返回的数据总数
     *  rows:表示返回的数据的List集合
     *      注意:创建对应的实体类
     *
     * 单元方法的形参:
     *   请求的页码
     *   每页显示的数量
     *   查询条件
     */
    @ResponseBody
    @RequestMapping("/hostInfo")
    public PageResult<Host> hostInfo(Integer page, Integer rows, HostCondition hostCondition){

        PageResult<Host> pageResult = hostService.selHostInfoService(page,rows,hostCondition);

        return pageResult;

    }

}

