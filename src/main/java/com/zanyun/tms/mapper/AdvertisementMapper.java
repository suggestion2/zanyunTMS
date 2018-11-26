package com.zanyun.tms.mapper;

import com.zanyun.tms.domain.background.Advertisement;

import java.util.List;
import java.util.Map;

public interface AdvertisementMapper {
    Advertisement selectById(Integer id);

    List<Advertisement> selectList(Map<String, Object> map);

    int update(Advertisement advertisement);
}
