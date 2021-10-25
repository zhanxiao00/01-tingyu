package com.bjsxt.service.impl;

import com.bjsxt.pojo.Host;
import com.bjsxt.mapper.HostMapper;
import com.bjsxt.pojo.HostCondition;
import com.bjsxt.pojo.PageResult;
import com.bjsxt.service.IHostService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
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

    //分页加载主持人信息
    @Override
    public PageResult<Host> selHostInfoService(Integer page, Integer rows, HostCondition hostCondition) {


        return null;
    }
}
