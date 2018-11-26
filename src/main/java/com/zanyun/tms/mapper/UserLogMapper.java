package com.zanyun.tms.mapper;

import com.zanyun.tms.domain.background.UserLog;

import java.util.List;
import java.util.Map;

public interface UserLogMapper {
    UserLog selectById(Integer id);

    List<UserLog> selectList(Map<String, Object> map);

    int selectCount(Map<String, Object> map);

    int insert(UserLog userLog);
}
