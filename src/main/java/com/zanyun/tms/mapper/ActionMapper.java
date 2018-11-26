package com.zanyun.tms.mapper;

import com.zanyun.tms.domain.background.Action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface ActionMapper {
    Action selectById(Integer id);

    Action select(Map<String, Object> map);

    List<Action> selectList(Map<String, Object> map);

    default List<Action> selectListByDepartmentId(Integer departmentId){
        Map<String,Object> map = new HashMap<>();
        map.put("departmentId",departmentId);
        return selectList(map);
    }
}
