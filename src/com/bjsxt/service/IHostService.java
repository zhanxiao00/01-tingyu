package com.bjsxt.service;

import com.bjsxt.pojo.Host;
import com.baomidou.mybatisplus.extension.service.IService;
import com.bjsxt.pojo.HostCondition;
import com.bjsxt.pojo.PageResult;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author ${author}
 * @since 2020-03-20
 */
public interface IHostService extends IService<Host> {
    //分页加载主持人信息
    PageResult<Host> selHostInfoService(Integer page, Integer rows, HostCondition hostCondition);
}
