package com.zanyun.tms.controller.api.background;

import com.sug.core.platform.exception.ResourceNotFoundException;
import com.sug.core.platform.web.pagination.PaginationView;
import com.sug.core.rest.view.SuccessView;
import com.zanyun.tms.domain.background.Advertisement;
import com.zanyun.tms.interceptor.background.AuthRequired;
import com.zanyun.tms.interceptor.background.LoginRequired;
import com.zanyun.tms.mapper.AdvertisementMapper;
import com.zanyun.tms.request.background.AdvertisementUpdateForm;
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
@RequestMapping("/background/advertisement")
public class AdvertisementController {
    private static final Logger logger = LoggerFactory.getLogger(AdvertisementController.class);

    @Value("${aliyun.upload.ads.host:@null}")
    private String adsHost;

    @Autowired
    private AdvertisementMapper advertisementMapper;

    @RequestMapping(value = LIST,method = RequestMethod.GET)
    @LoginRequired
    @AuthRequired
    public PaginationView<Advertisement> list(){
        PaginationView<Advertisement> view = new PaginationView<>();
        List<Advertisement> list = advertisementMapper.selectList(null);
        list.forEach(a->a.setImageUrl(StringUtils.hasText(a.getImageUrl()) ? adsHost + "/" + a.getImageUrl() : null));
        view.setList(list);
        return view;
    }

    @RequestMapping(value = DETAIL + ID,method = RequestMethod.GET)
    @LoginRequired
    @AuthRequired
    public Advertisement getById(@PathVariable Integer id){
        Advertisement advertisement = advertisementMapper.selectById(id);
        advertisement.setImageUrl(StringUtils.hasText(advertisement.getImageUrl()) ? adsHost + "/" + advertisement.getImageUrl() : null);
        return advertisement;
    }

    @RequestMapping(value = UPDATE,method = RequestMethod.PUT)
    @LoginRequired
    @AuthRequired
    public SuccessView update(@Valid @RequestBody AdvertisementUpdateForm form){
        Advertisement advertisement = advertisementMapper.selectById(form.getId());

        if(Objects.isNull(advertisement)){
            throw new ResourceNotFoundException("ad is not exists");
        }

        if(form.getImageUrl().contains("http://")){
            form.setImageUrl(null);
        }
        BeanUtils.copyProperties(form,advertisement);

        advertisementMapper.update(advertisement);

        return new SuccessView();
    }
}
