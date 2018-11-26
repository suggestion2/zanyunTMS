package com.zanyun.tms.mapper;

import com.zanyun.tms.domain.Dingtalkchat;

import java.util.HashMap;
import java.util.Map;

public interface DingtalkchatMapper {
    Dingtalkchat selectById(Integer id);

    int insert(Dingtalkchat dingtalkchat);

    int update(Dingtalkchat dingtalkchat);

    Dingtalkchat select(Map<String, Object> map);

    default Dingtalkchat selectMain(){
        Map<String,Object> map = new HashMap<>();
        map.put("main",true);

        return this.select(map);
    }
}
