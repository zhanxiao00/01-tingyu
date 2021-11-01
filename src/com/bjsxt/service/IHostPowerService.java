package com.bjsxt.service;

import com.bjsxt.pojo.HostPower;
import com.baomidou.mybatisplus.extension.service.IService;
import com.bjsxt.pojo.Result;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author ${author}
 * @since 2020-03-20
 */
public interface IHostPowerService extends IService<HostPower> {
    //批量操作主持人的权限信息
    Result delInsHostPowerBatchService(String hostids, HostPower hostPower);
}
