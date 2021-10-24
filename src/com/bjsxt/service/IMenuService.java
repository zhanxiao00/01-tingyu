package com.bjsxt.service;

import com.bjsxt.pojo.Menu;
import com.baomidou.mybatisplus.extension.service.IService;
import com.bjsxt.pojo.TreeResult;

import java.util.List;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author ${author}
 * @since 2021-10-16
 */
public interface IMenuService extends IService<Menu> {

    List<TreeResult> selMenuInfoService(String id, Integer aid);


}
