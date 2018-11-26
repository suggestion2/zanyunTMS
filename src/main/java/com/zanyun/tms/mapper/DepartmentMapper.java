package com.zanyun.tms.mapper;

import com.zanyun.tms.domain.background.Department;
import com.zanyun.tms.view.background.DepartmentView;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface DepartmentMapper {
    Department selectById(Integer id);

    DepartmentView selectViewById(Integer id);

    Department select(Map<String, Object> map);

    default Department selectByName(String name){
        Map<String,Object> map = new HashMap<>();
        map.put("name",name);
        return select(map);
    }

    List<Department> selectList(Map<String, Object> map);

    List<Department> selectListByAuth(Map<String, Object> map);

    int selectCount(Map<String, Object> map);

    int insert(Department department);

    int update(Department department);
}
