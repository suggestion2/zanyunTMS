package com.zanyun.tms.mapper;

import com.zanyun.tms.domain.background.Article;

import java.util.List;
import java.util.Map;

public interface ArticleMapper {
    Article selectById(Integer id);

    List<Article> selectList(Map<String, Object> map);

    int selectCount(Map<String, Object> map);

    int insert(Article article);

    int update(Article article);

    int updateCount(Article article);
}
