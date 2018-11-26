package com.zanyun.tms.controller.api.background;

import com.sug.core.platform.exception.ResourceNotFoundException;
import com.sug.core.platform.web.pagination.PaginationView;
import com.sug.core.rest.view.SuccessView;
import com.zanyun.tms.domain.background.Banner;
import com.zanyun.tms.interceptor.background.AuthRequired;
import com.zanyun.tms.interceptor.background.LoginRequired;
import com.zanyun.tms.mapper.BannerMapper;
import com.zanyun.tms.request.background.BannerUpdateForm;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;
import java.util.Objects;

import static com.zanyun.tms.constants.UrlConstants.*;

@RestController
@RequestMapping("/background/banner")
public class BannerController {
    private static final Logger logger = LoggerFactory.getLogger(BannerController.class);

    @Value("${aliyun.upload.ads.host:@null}")
    private String adsHost;

    @Autowired
    private BannerMapper bannerMapper;

    @RequestMapping(value = LIST,method = RequestMethod.GET)
    @LoginRequired
    @AuthRequired
    public PaginationView<Banner> list(){
        PaginationView<Banner> view = new PaginationView<>();
        List<Banner> list = bannerMapper.selectList(null);
        list.forEach(b->b.setBannerUrl(StringUtils.hasText(b.getBannerUrl()) ? adsHost + "/" + b.getBannerUrl() : null));
        view.setList(list);
        return view;
    }

    @RequestMapping(value = DETAIL + ID,method = RequestMethod.GET)
    @LoginRequired
    @AuthRequired
    public Banner getById(@PathVariable Integer id){
        Banner banner = bannerMapper.selectById(id);
        banner.setBannerUrl(StringUtils.hasText(banner.getBannerUrl()) ? adsHost + "/" + banner.getBannerUrl() : null);
        return banner;
    }

    @RequestMapping(value = UPDATE,method = RequestMethod.PUT)
    @LoginRequired
    @AuthRequired
    public SuccessView update(@Valid @RequestBody BannerUpdateForm form){
        Banner banner = bannerMapper.selectById(form.getId());

        if(Objects.isNull(banner)){
            throw new ResourceNotFoundException("banner is not exists");
        }

        if(form.getBannerUrl().contains("http://")){
            form.setBannerUrl(null);
        }
        BeanUtils.copyProperties(form,banner);

        bannerMapper.update(banner);

        return new SuccessView();
    }
}
