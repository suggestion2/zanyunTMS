package com.zanyun.tms.mapper;

import com.zanyun.tms.domain.background.Banner;

import java.util.List;
import java.util.Map;

public interface BannerMapper {
    Banner selectById(Integer id);

    List<Banner> selectList(Map<String, Object> map);

    int update(Banner banner);
}
