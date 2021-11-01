package com.bjsxt.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.bjsxt.pojo.PageResult;
import com.bjsxt.pojo.Planner;
import com.bjsxt.service.IPlannerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author ${author}
 * @since 2020-03-20
 */
@Controller
@RequestMapping("/planner")
public class PlannerController {
    //声明业务层属性
    @Autowired
    private IPlannerService plannerService;

    //声明单元方法:加载策划师信息
    @ResponseBody
    @RequestMapping("plannerInfo")
    public PageResult<Planner> plannerInfo(Integer cid){
        //处理请求
            //创建条件构造器
            QueryWrapper<Planner> queryWrapper=new QueryWrapper<>();
            queryWrapper.eq("cid",cid);
            //查询
            List<Planner> list = plannerService.list(queryWrapper);
        //响应结果
            return new PageResult<Planner>(0L,list);
    }

}

