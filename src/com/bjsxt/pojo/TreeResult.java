package com.bjsxt.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Map;

/**
 * @author zhanxiao    2021-10-23  17:30
 */
@NoArgsConstructor
@Data
@AllArgsConstructor
public class TreeResult {
    private Integer id;
    private String text;
    private String state;
    private Map<String,Object> attributes;//存储自定义的数据
}
