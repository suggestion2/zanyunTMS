package com.zanyun.tms.controller.api.front;

import com.sug.core.platform.web.pagination.PaginationView;
import com.zanyun.tms.domain.background.Article;
import com.zanyun.tms.interceptor.background.AuthRequired;
import com.zanyun.tms.interceptor.background.LoginRequired;
import com.zanyun.tms.mapper.ArticleMapper;
import com.zanyun.tms.request.background.ArticleListForm;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;

import static com.zanyun.tms.constants.UrlConstants.*;

@RestController
@RequestMapping("/api/article")
public class ArticleController {
    private static final Logger logger = LoggerFactory.getLogger(ArticleController.class);

    @Autowired
    private ArticleMapper articleMapper;

    @Value("${aliyun.upload.ads.host:@null}")
    private String adsHost;

    @RequestMapping(value = LIST,method = RequestMethod.POST)
    @LoginRequired
    @AuthRequired
    public PaginationView<Article> list(@Valid @RequestBody ArticleListForm form){
        PaginationView<Article> view = new PaginationView<>();
        List<Article> list = articleMapper.selectList(form.getQueryMap());
        list.forEach(a->a.setCoverImageUrl(StringUtils.hasText(a.getCoverImageUrl()) ? adsHost + "/" + a.getCoverImageUrl() : null));
        view.setList(list);
        view.setCount(articleMapper.selectCount(form.getQueryMap()));
        return view;
    }

    @RequestMapping(value = ID,method = RequestMethod.GET)
    @LoginRequired
    @AuthRequired
    public Article getById(@PathVariable Integer id){
        Article article = articleMapper.selectById(id);
        article.setCoverImageUrl(StringUtils.hasText(article.getCoverImageUrl()) ? adsHost + "/" + article.getCoverImageUrl() : null);
        return article;
    }
}
