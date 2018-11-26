package com.zanyun.tms.mapper;

import com.zanyun.tms.domain.background.CustomerCount;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface CustomerCountMapper {
    CustomerCount select(Map<String, Object> map);

    List<CustomerCount> selectList(Map<String, Object> map);

    default List<CustomerCount> selectListByDays(Integer days){
        Map<String,Object> map = new HashMap<>();
        map.put("days",days);

        return this.selectList(map);
    }

    int insert(CustomerCount customerCount);
}
