package com.zanyun.tms.mapper;

import com.zanyun.tms.domain.background.OrderCount;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface OrderCountMapper {
    OrderCount select(Map<String, Object> map);

    List<OrderCount> selectList(Map<String, Object> map);

    default List<OrderCount> selectListByDays(Integer days){
        Map<String,Object> map = new HashMap<>();
        map.put("days",days);

        return this.selectList(map);
    }

    int insert(OrderCount orderCount);
}
