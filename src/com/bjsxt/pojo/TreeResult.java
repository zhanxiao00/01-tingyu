package com.bjsxt.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;
import java.util.Map;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class TreeResult {
    private Integer id;
    private String text;
    private String state;
    private Map<String,Object> attributes;//存储自定义的数据
    private List<TreeResult> children;
}
