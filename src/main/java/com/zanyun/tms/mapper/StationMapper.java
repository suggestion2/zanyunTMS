package com.zanyun.tms.mapper;

import com.zanyun.tms.domain.front.Station;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface StationMapper {
    Station selectById(Integer id);

    Station select(Map<String, Object> map);

    default Station selectByName(String name){
        Map<String,Object> query = new HashMap<>();
        query.put("name",name);

        return this.select(query);
    }

    List<Station> selectList(Map<String, Object> map);

    int selectCount(Map<String, Object> map);

    int insert(Station station);

    int update(Station station);
}
