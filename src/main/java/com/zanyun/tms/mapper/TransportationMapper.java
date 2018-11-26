package com.zanyun.tms.mapper;

import com.zanyun.tms.domain.background.Transportation;
import com.zanyun.tms.domain.background.TransportationParams;

import java.util.List;
import java.util.Map;

public interface TransportationMapper {
    Transportation selectById(Integer id);

    Transportation select(Map<String, Object> map);

    List<Transportation> selectList(Map<String, Object> map);

    int selectCount(Map<String, Object> map);

    int insert(Transportation transportation);

    int update(Transportation transportation);

    int delete(Integer id);

    List<TransportationParams> selectParams();
}
