package com.bjsxt.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

/**
 * @author zhanxiao    2021-10-25  21:29
 */
@NoArgsConstructor
@AllArgsConstructor
@Data
public class PageResult<T> {
    private Long total;
    private List<T> rows;
}
