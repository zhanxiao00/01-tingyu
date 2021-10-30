package com.bjsxt.service.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.bjsxt.pojo.Host;
import com.bjsxt.mapper.HostMapper;
import com.bjsxt.pojo.HostCondition;
import com.bjsxt.pojo.HostPower;
import com.bjsxt.pojo.PageResult;
import com.bjsxt.service.IHostService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author ${author}
 * @since 2021-10-16
 */
@Service
public class HostServiceImpl extends ServiceImpl<HostMapper, Host> implements IHostService {

    @Autowired
    private HostMapper hostMapper;

    //分页加载主持人信息
    @Override
    public PageResult<Host> selHostInfoService(Integer page, Integer rows, HostCondition hostCondition) {
        //1.创建分页对象存储分页条件
            IPage<Host> p = new Page<>(page, rows);
        //2.调用mapper层完成查询
            IPage<Host> phost = hostMapper.selHostInfoMapper(p, hostCondition);
        //3.将结果分装到PageResult中返回
            PageResult<Host> pageResult = new PageResult<>();
            pageResult.setTotal(phost.getTotal());
            pageResult.setRows(phost.getRecords());
        //4.返回对象
        return pageResult;
    }
}
