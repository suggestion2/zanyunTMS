package com.zanyun.tms.mapper;

import com.zanyun.tms.domain.background.OfflineOrder;

import java.util.List;
import java.util.Map;

public interface OfflineOrderMapper {
    OfflineOrder selectById(Integer id);

    OfflineOrder select(Map<String, Object> map);

    List<OfflineOrder> selectList(Map<String, Object> map);

    int selectCount(Map<String, Object> map);

    int insert(OfflineOrder order);

    int update(OfflineOrder order);

    int deleteById(Integer id);
}
