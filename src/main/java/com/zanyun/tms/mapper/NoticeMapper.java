package com.zanyun.tms.mapper;

import com.zanyun.tms.domain.background.Notice;

import java.util.List;
import java.util.Map;

public interface NoticeMapper {
    Notice selectById(Integer id);

    List<Notice> selectList(Map<String, Object> map);

    int selectCount(Map<String, Object> map);

    int insert(Notice notice);

    int update(Notice notice);
}
