package com.zanyun.tms.controller.api.background;

import com.sug.core.platform.exception.ResourceNotFoundException;
import com.sug.core.platform.web.pagination.PaginationView;
import com.sug.core.rest.view.SuccessView;
import com.zanyun.tms.constants.background.ArticleConstants;
import com.zanyun.tms.domain.background.Article;
import com.zanyun.tms.interceptor.background.AuthRequired;
import com.zanyun.tms.interceptor.background.LoginRequired;
import com.zanyun.tms.mapper.ArticleMapper;
import com.zanyun.tms.request.background.ArticleCreateForm;
import com.zanyun.tms.request.background.ArticleListForm;
import com.zanyun.tms.request.background.ArticleUpdateForm;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.Objects;

import static com.zanyun.tms.constants.UrlConstants.*;

@RestController("ArticleBackgroundController")
@RequestMapping("/background/article")
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
        view.setList(articleMapper.selectList(form.getQueryMap()));
        view.setCount(articleMapper.selectCount(form.getQueryMap()));
        return view;
    }

    @RequestMapping(value = DETAIL + ID,method = RequestMethod.GET)
    @LoginRequired
    @AuthRequired
    public Article getById(@PathVariable Integer id){
        Article article = articleMapper.selectById(id);
        article.setCoverImageUrl(StringUtils.hasText(article.getCoverImageUrl()) ? adsHost + "/" + article.getCoverImageUrl() : null);
        return article;
    }

    @RequestMapping(value = CREATE,method = RequestMethod.POST)
    @LoginRequired
    @AuthRequired
    public SuccessView create(@Valid @RequestBody ArticleCreateForm form){
        Article article = new Article();
        BeanUtils.copyProperties(form,article);
        if(!StringUtils.hasText(article.getSummary())){
            article.setSummary(article.getTitle());
        }
        if(Objects.isNull(article.getType())){
            article.setType(ArticleConstants.NEWS_COMPANY_TYPE);
        }
        articleMapper.insert(article);

        return new SuccessView();
    }

    @RequestMapping(value = UPDATE,method = RequestMethod.PUT)
    @LoginRequired
    @AuthRequired
    public SuccessView update(@Valid @RequestBody ArticleUpdateForm form){
        Article article = articleMapper.selectById(form.getId());

        if(Objects.isNull(article)){
            throw new ResourceNotFoundException("article is not exists");
        }
        if(form.getCoverImageUrl().contains("http:")){
            form.setCoverImageUrl(article.getCoverImageUrl());
        }
        BeanUtils.copyProperties(form,article);

        articleMapper.update(article);

        return new SuccessView();
    }
}
