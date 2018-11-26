package com.zanyun.tms.mapper;

import com.zanyun.tms.domain.background.Nav;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface NavMapper {
    Nav selectById(Integer id);

    Nav select(Map<String, Object> map);

    List<Nav> selectList(Map<String, Object> map);

    default List<Nav> selectListByDepartmentId(Integer departmentId){
        Map<String,Object> map = new HashMap<>();
        map.put("departmentId",departmentId);
        return selectList(map);
    }
}
