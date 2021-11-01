package com.bjsxt.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.bjsxt.pojo.HostPower;
import com.bjsxt.mapper.HostPowerMapper;
import com.bjsxt.pojo.Result;
import com.bjsxt.service.IHostPowerService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
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
public class HostPowerServiceImpl extends ServiceImpl<HostPowerMapper, HostPower> implements IHostPowerService {
    //声明mapper层属性
    @Autowired
    private HostPowerMapper hostPowerMapper;
    //批量操作主持人的权限信息
    @Override
    public Result delInsHostPowerBatchService(String hostids, HostPower hostPower) {
        //1.获取主持人的ID数组
        String[] hids=hostids.split(",");
        //2.删除主持人的权限信息
            //创建条件构造器
            QueryWrapper<HostPower> queryWrapper=new QueryWrapper<>();
            queryWrapper.in("hostid",hids);
            //删除
            int delete = hostPowerMapper.delete(queryWrapper);
        //3.新增主持人权限信息
            for(String hostid:hids){
                hostPower.setHostid(Integer.valueOf(hostid));
                boolean insert = hostPower.insert();
            }
        //4.返回
        return new Result(delete>0,"");
    }
}
