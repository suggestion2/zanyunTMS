package com.zanyun.tms.mapper;

import com.zanyun.tms.domain.background.User;
import com.zanyun.tms.view.background.UserView;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface UserMapper {
    User selectById(Integer id);

    User select(Map<String, Object> map);

    List<User> selectList(Map<String, Object> map);

    default List<User> selectListByDepartmentId(Integer departmentId){
        Map<String,Object> map = new HashMap<>();
        map.put("departmentId",departmentId);
        map.put("status",1);
        return this.selectList(map);
    }

    List<UserView> selectViewList(Map<String, Object> map);

    int selectCount(Map<String, Object> map);

    default User selectByPhone(String phone){
        Map<String,Object> map = new HashMap<>();
        map.put("phone",phone);
        return this.select(map);
    }

    default User selectByName(String name){
        Map<String,Object> map = new HashMap<>();
        map.put("name",name);
        return select(map);
    }

    int insert(User user);

    int update(User user);
}
