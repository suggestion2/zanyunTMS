package com.zanyun.tms.controller.api.front;

import com.sug.core.platform.web.pagination.PaginationView;
import com.sug.core.platform.web.rest.exception.InvalidRequestException;
import com.sug.core.rest.view.SuccessView;
import com.sug.core.util.RandomStringGenerator;
import com.zanyun.tms.context.front.SessionContext;
import com.zanyun.tms.domain.background.Advertisement;
import com.zanyun.tms.domain.background.Banner;
import com.zanyun.tms.domain.background.TransportationParams;
import com.zanyun.tms.interceptor.front.DriverLoginRequired;
import com.zanyun.tms.mapper.*;
import com.zanyun.tms.request.front.SendCaptchaForm;
import com.zanyun.tms.service.OSSService;
import com.zanyun.tms.service.SmsService;
import com.zanyun.tms.view.front.CaptchaView;
import com.zanyun.tms.view.front.TruckModelView;
import com.zanyun.tms.view.front.UploadParamsView;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import javax.validation.Valid;
import java.util.List;
import java.util.Objects;

@RestController
@RequestMapping(value = "/api")
public class CommonController {

    private static final Logger logger = LoggerFactory.getLogger(CommonController.class);

    @Autowired
    private SessionContext sessionContext;

    @Autowired
    private TransportationMapper transportationMapper;

    @Autowired
    private OSSService oSSService;

    @Autowired
    private SmsService smsService;

    @Autowired
    private AdvertisementMapper advertisementMapper;

    @Autowired
    private BannerMapper bannerMapper;

    @Autowired
    private DriverMapper driverMapper;

    @Autowired
    private OwnerMapper ownerMapper;

    @Value("${aliyun.sms.whiteList:@null}")
    private String whiteList;

    @Value("${aliyun.upload.ads.host:@null}")
    private String adsHost;

    @RequestMapping(value = "/captcha/register",method = RequestMethod.POST)
    public CaptchaView sendCaptchaRegister(@Valid @RequestBody SendCaptchaForm form){
        if(!StringUtils.hasText(whiteList) || !whiteList.contains(form.getPhone())) {
            if (form.getType() == 1) {
                if (Objects.nonNull(driverMapper.selectByPhone(form.getPhone()))) {
                    throw new InvalidRequestException("手机号已注册");
                }
            } else {
                if (Objects.nonNull(ownerMapper.selectByPhone(form.getPhone()))) {
                    throw new InvalidRequestException("手机号已注册");
                }
            }
        }
        String captcha = RandomStringGenerator.getRandomNumberStringByLength(6);

        try {
            if(!StringUtils.hasText(whiteList) || whiteList.contains(form.getPhone())){
                smsService.sendCaptcha(form.getPhone(),captcha);
            }
            sessionContext.setCaptcha(form.getPhone(),captcha);
        } catch (Exception e) {
            throw new RuntimeException("send captcha fail : " + e.getMessage());
        }

        CaptchaView view = new CaptchaView();
        view.setCaptcha(captcha);
        return view;
    }

    @RequestMapping(value = "/captcha/forgetPassword",method = RequestMethod.POST)
    public CaptchaView sendCaptchaForgetPassword(@Valid @RequestBody SendCaptchaForm form){
        if(form.getType() == 1){
            if(Objects.isNull(driverMapper.selectByPhone(form.getPhone()))){
                throw new InvalidRequestException("手机号未注册");
            }
        }else{
            if(Objects.isNull(ownerMapper.selectByPhone(form.getPhone()))){
                throw new InvalidRequestException("手机号未注册");
            }
        }
        String captcha = RandomStringGenerator.getRandomNumberStringByLength(6);

        try {
            if(!StringUtils.hasText(whiteList) || whiteList.contains(form.getPhone())){
                smsService.sendCaptcha(form.getPhone(),captcha);
            }
            sessionContext.setCaptcha(form.getPhone(),captcha);
        } catch (Exception e) {
            throw new RuntimeException("send captcha fail : " + e.getMessage());
        }

        CaptchaView view = new CaptchaView();
        view.setCaptcha(captcha);
        return view;
    }

    @RequestMapping(value = "/logout",method = RequestMethod.GET)
    public String logout(){
        sessionContext.invalidate();
        return "success";
    }

    @RequestMapping(value = "/uploadParams",method = RequestMethod.GET)
    @DriverLoginRequired
    public UploadParamsView uploadParams() throws Exception {
        return oSSService.getUploadParams();
    }

    @RequestMapping(value = "/transportationParams",method = RequestMethod.GET)
    public TruckModelView transportationParams() throws Exception {
        List<TransportationParams> list = transportationMapper.selectParams();

        TruckModelView view = new TruckModelView();

        list.forEach(t->{
            if(t.getName().equals("type")){
                view.setList(t.getValue());
            }
        });

        return view;
    }

    @RequestMapping(value = "/current/loginStatus",method = RequestMethod.GET)
    public SuccessView loginStatus(){
        if(Objects.nonNull(sessionContext.getDriverId())){
            return new SuccessView("driver");
        }
        if(Objects.nonNull(sessionContext.getOwnerId())){
            return new SuccessView("owner");
        }
        return new SuccessView("fail");
    }

    @RequestMapping(value = "/advertisement/list",method = RequestMethod.GET)
    public PaginationView<Advertisement> advertisementList(){
        PaginationView<Advertisement> view = new PaginationView<>();
        List<Advertisement> list = advertisementMapper.selectList(null);
        list.forEach(a->a.setImageUrl(StringUtils.hasText(a.getImageUrl()) ? adsHost + "/" + a.getImageUrl() : null));
        view.setList(list);
        return view;
    }

    @RequestMapping(value = "/banner/list",method = RequestMethod.GET)
    public PaginationView<Banner> bannerList(){
        PaginationView<Banner> view = new PaginationView<>();
        List<Banner> list = bannerMapper.selectList(null);
        list.forEach(b->b.setBannerUrl(StringUtils.hasText(b.getBannerUrl()) ? adsHost + "/" + b.getBannerUrl() : null));
        view.setList(list);
        return view;
    }
}
