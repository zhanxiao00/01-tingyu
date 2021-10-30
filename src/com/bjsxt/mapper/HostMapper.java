package com.bjsxt.mapper;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.bjsxt.pojo.Host;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.bjsxt.pojo.HostCondition;
import org.apache.ibatis.annotations.Param;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author ${author}
 * @since 2021-10-16
 */
public interface HostMapper extends BaseMapper<Host> {

    //分页加载主持人信息
    IPage<Host> selHostInfoMapper(IPage<Host> p, @Param("hostCondition") HostCondition hostCondition);
}
