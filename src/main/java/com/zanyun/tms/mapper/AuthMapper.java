package com.zanyun.tms.mapper;

import com.zanyun.tms.domain.background.Auth;
import com.zanyun.tms.view.background.AuthView;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface AuthMapper {
    Auth selectById(Integer id);

    Auth select(Map<String, Object> map);

    List<Auth> selectList(Map<String, Object> map);

    List<AuthView> selectViewList();

    default List<Auth> selectListByDepartmentId(Integer departmentId){
        Map<String,Object> map = new HashMap<>();
        map.put("departmentId",departmentId);
        return selectList(map);
    }

    default Auth selectByName(String name){
        Map<String,Object> map = new HashMap<>();
        map.put("name",name);
        return select(map);
    }
}
