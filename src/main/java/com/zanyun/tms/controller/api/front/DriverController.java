package com.zanyun.tms.controller.api.front;

import com.sug.core.platform.crypto.MD5;
import com.sug.core.platform.exception.ForbiddenException;
import com.sug.core.platform.exception.ResourceNotFoundException;
import com.sug.core.platform.exception.UserAuthorizationException;
import com.sug.core.platform.web.pagination.PaginationForm;
import com.sug.core.platform.web.pagination.PaginationView;
import com.sug.core.platform.web.rest.exception.InvalidRequestException;
import com.sug.core.platform.wechat.response.WeChatUserInfoResponse;
import com.zanyun.tms.constants.DriverConstant;
import com.zanyun.tms.context.front.SessionContext;
import com.zanyun.tms.domain.front.Driver;
import com.zanyun.tms.interceptor.front.DriverLoginRequired;
import com.zanyun.tms.interceptor.front.OwnerLoginRequired;
import com.zanyun.tms.interceptor.front.WeChatLoginRequired;
import com.zanyun.tms.mapper.DriverMapper;
import com.zanyun.tms.request.front.*;
import com.zanyun.tms.service.OSSService;
import com.zanyun.tms.service.WeChatService;
import com.zanyun.tms.view.front.TruckView;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import static com.zanyun.tms.constants.DriverConstant.DRIVER_COMPLETE;
import static com.zanyun.tms.constants.UrlConstants.*;


@RestController
@RequestMapping(API_DRIVER)
public class DriverController {
    private static final Logger logger = LoggerFactory.getLogger(DriverController.class);

    @Autowired
    private DriverMapper driverMapper;

    @Autowired
    private SessionContext sessionContext;

    @Autowired
    private OSSService ossService;

    @Autowired
    private WeChatService weChatService;

    @RequestMapping(value = REGISTER,method = RequestMethod.POST)
    @WeChatLoginRequired
    public String register(@Valid @RequestBody RegisterForm form){
        if(!sessionContext.validCaptcha(form.getPhone(),form.getCaptcha())){
            throw new InvalidRequestException("错误的验证码");
        }

        if(Objects.nonNull(driverMapper.selectByPhone(form.getPhone()))){
            throw new InvalidRequestException("手机号已注册");
        }

        if(sessionContext.getWeChatBrowser()
                && !Objects.isNull(driverMapper.selectByOpenId(sessionContext.getWeChatOAuthEntity().getOpenid()))){
            throw new ForbiddenException("该微信账号已绑定其他账号");
        }

        Driver driver = new Driver();
        driver.setPhone(form.getPhone());
        driver.setPassword(MD5.encrypt(form.getPassword()));

        if(sessionContext.getWeChatBrowser()){
            driver.setWechatPubOpenId(sessionContext.getWeChatOAuthEntity().getOpenid());
            WeChatUserInfoResponse info = weChatService.getWeChatUserInfo();
            driver.setWechatName(info.getNickname());
            driver.setWechatHeadImg(info.getHeadimgurl());
        }

        driverMapper.insert(driver);
        sessionContext.removeCaptcha();
        sessionContext.setDriverId(driver.getId());

        return "success";
    }

    @RequestMapping(value = CHECK_PHONE,method = RequestMethod.POST)
    @WeChatLoginRequired
    public String checkPhone(@Valid @RequestBody CheckPhoneForm form){
        Driver driver = driverMapper.selectByPhone(form.getPhone());
        if(Objects.isNull(driver)){
            throw new ResourceNotFoundException("手机号未注册");
        }

        return "success";
    }

    @RequestMapping(value = CHANGE_PASSWORD,method = RequestMethod.PUT)
    @WeChatLoginRequired
    public String changePwd(@Valid @RequestBody ChangePwdForm form){
        Driver driver = driverMapper.selectByPhone(form.getPhone());

        if(Objects.isNull(driver)){
            throw new ResourceNotFoundException("账号不存在");
        }

        if(sessionContext.getWeChatBrowser()
            && !sessionContext.getWeChatOAuthEntity().getOpenid().equalsIgnoreCase(driver.getWechatPubOpenId())){
            throw new ForbiddenException("当前微信账号无权限");
        }

        if(!sessionContext.validCaptcha(form.getPhone(),form.getCaptcha())){
            throw new InvalidRequestException("错误的验证码");
        }

        driver.setPassword(MD5.encrypt(form.getPassword()));

        driverMapper.update(driver);
        sessionContext.removeCaptcha();

        return "success";
    }

    @RequestMapping(value = LOGIN,method = RequestMethod.POST)
    @WeChatLoginRequired
    public String login(@Valid @RequestBody LoginForm form){
        Driver driver = driverMapper.selectByPhone(form.getPhone());

        if(Objects.isNull(driver)){
            throw new ResourceNotFoundException("账号不存在");
        }

        if (sessionContext.getWeChatBrowser()) {
            String sessionOpenId = sessionContext.getWeChatOAuthEntity().getOpenid();
            Driver selectByOpenId = driverMapper.selectByOpenId(sessionOpenId);

            if(Objects.nonNull(selectByOpenId) && !selectByOpenId.getId().equals(driver.getId())){
                throw new ForbiddenException("该微信账号已绑定其他账户");
            }

            if(Objects.isNull(selectByOpenId) && StringUtils.hasText(driver.getWechatPubOpenId())){
                throw new ForbiddenException("该账户已绑定其他微信账号");
            }
        }

        if(!driver.getPassword().equalsIgnoreCase(MD5.encrypt(form.getPassword()))){
            throw new InvalidRequestException("密码错误");
        }

        if(sessionContext.getWeChatBrowser()){
            boolean isChange = false;

            if(!StringUtils.hasText(driver.getWechatPubOpenId())){
                driver.setWechatPubOpenId(sessionContext.getWeChatOAuthEntity().getOpenid());
                isChange = true;
            }

            WeChatUserInfoResponse info = weChatService.getWeChatUserInfo();

            if(!StringUtils.hasText(driver.getWechatName())){
                driver.setWechatName(info.getNickname());
                isChange = true;
            }

            if(!StringUtils.hasText(driver.getWechatHeadImg())){
                driver.setWechatHeadImg(info.getHeadimgurl());
                isChange = true;
            }

            if(isChange){
                driverMapper.update(driver);
            }
        }

        sessionContext.setDriverId(driver.getId());

        return "success";
    }

    @RequestMapping(value = CURRENT,method = RequestMethod.GET)
    @DriverLoginRequired
    public Driver getCurrentDriver(){
        return getCurrentDriverBySession();
    }

    private Driver getCurrentDriverBySession(){
        if(Objects.isNull(sessionContext.getDriverId())){
            throw new UserAuthorizationException("请登录");
        }

        return driverMapper.selectById(sessionContext.getDriverId());
    }

    @RequestMapping(value = COMPLETE_INFO,method = RequestMethod.PUT)
    @DriverLoginRequired
    public String completeInfo(@RequestBody @Valid DriverCompleteInfoForm form){
        Driver driver = getCurrentDriverBySession();
        if(!(driver.getStatus().equals(DriverConstant.DRIVER_INCOMPLETE)
                || driver.getStatus().equals(DriverConstant.DRIVER_REJECT))){
            throw new InvalidRequestException("司机已验证或不可用");
        }

        String licenseUrl = driver.getLicenseUrl();
        String dLicenseUrl = driver.getdLicenseUrl();

        if(StringUtils.hasText(licenseUrl)){
            form.setLicenseUrl(licenseUrl);
        }
        if(StringUtils.hasText(dLicenseUrl)){
            form.setdLicenseUrl(dLicenseUrl);
        }

        BeanUtils.copyProperties(form,driver);
        driver.setUpdateBy(0);
        driver.setStatus(DriverConstant.DRIVER_VALIDATE);

        driver.setTaskAddress1((StringUtils.hasText(driver.getTaskProvince1())?driver.getTaskProvince1() : "") + (StringUtils.hasText(driver.getTaskCity1())?driver.getTaskProvince1() : "") + (StringUtils.hasText(driver.getTaskCounty1())?driver.getTaskCounty1() : ""));
        driver.setTaskAddress2((StringUtils.hasText(driver.getTaskProvince2())?driver.getTaskProvince2() : "") + (StringUtils.hasText(driver.getTaskCity2())?driver.getTaskProvince2() : "") + (StringUtils.hasText(driver.getTaskCounty2())?driver.getTaskCounty2() : ""));
        driver.setTaskAddress3((StringUtils.hasText(driver.getTaskProvince3())?driver.getTaskProvince3() : "") + (StringUtils.hasText(driver.getTaskCity3())?driver.getTaskProvince3() : "") + (StringUtils.hasText(driver.getTaskCounty3())?driver.getTaskCounty3() : ""));
        driver.setTaskAddress4((StringUtils.hasText(driver.getTaskProvince4())?driver.getTaskProvince4() : "") + (StringUtils.hasText(driver.getTaskCity4())?driver.getTaskProvince4() : "") + (StringUtils.hasText(driver.getTaskCounty4())?driver.getTaskCounty4() : ""));

        driverMapper.update(driver);

        return "success";
    }

    @RequestMapping(value = UPDATE_INFO,method = RequestMethod.PUT)
    @DriverLoginRequired
    public String updateInfo(@RequestBody @Valid DriverUpdateInfoForm form){
        Driver driver = getCurrentDriverBySession();
        if(!driver.getStatus().equals(DriverConstant.DRIVER_COMPLETE)){
            throw new InvalidRequestException("司机状态错误");
        }

        BeanUtils.copyProperties(form,driver);
        driver.setUpdateBy(0);

        driver.setTaskAddress1((StringUtils.hasText(driver.getTaskProvince1())?driver.getTaskProvince1() : "") + (StringUtils.hasText(driver.getTaskCity1())?driver.getTaskProvince1() : "") + (StringUtils.hasText(driver.getTaskCounty1())?driver.getTaskCounty1() : ""));
        driver.setTaskAddress2((StringUtils.hasText(driver.getTaskProvince2())?driver.getTaskProvince2() : "") + (StringUtils.hasText(driver.getTaskCity2())?driver.getTaskProvince2() : "") + (StringUtils.hasText(driver.getTaskCounty2())?driver.getTaskCounty2() : ""));
        driver.setTaskAddress3((StringUtils.hasText(driver.getTaskProvince3())?driver.getTaskProvince3() : "") + (StringUtils.hasText(driver.getTaskCity3())?driver.getTaskProvince3() : "") + (StringUtils.hasText(driver.getTaskCounty3())?driver.getTaskCounty3() : ""));
        driver.setTaskAddress4((StringUtils.hasText(driver.getTaskProvince4())?driver.getTaskProvince4() : "") + (StringUtils.hasText(driver.getTaskCity4())?driver.getTaskProvince4() : "") + (StringUtils.hasText(driver.getTaskCounty4())?driver.getTaskCounty4() : ""));

        driverMapper.update(driver);

        return "success";
    }

    @RequestMapping(value = "/truckView/list",method = RequestMethod.POST)
    @OwnerLoginRequired
    public PaginationView<TruckView> getTruckViewList(@RequestBody @Valid PaginationForm form){
        PaginationView<TruckView> view = new PaginationView<>();
        Map<String,Object> query = form.getQueryMap();
        query.put("status",DRIVER_COMPLETE);
        List<TruckView> list  = driverMapper.selectTruckViewList(query);
        list.forEach(v-> v.setdLicenseUrl(StringUtils.hasText(v.getdLicenseUrl()) ? ossService.getImage(v.getdLicenseUrl()) : null));
        view.setList(list);
        view.setCount(driverMapper.selectCount(query));

        return view;
    }

    @RequestMapping(value = "/truckView/{id}",method = RequestMethod.GET)
    @OwnerLoginRequired
    public TruckView getTruckView(@PathVariable Integer id){

        TruckView view = driverMapper.selectTruckViewById(id);
        view.setdLicenseUrl(StringUtils.hasText(view.getdLicenseUrl()) ? ossService.getImage(view.getdLicenseUrl()) : null);
        return view;
    }

    @RequestMapping(value = "/truckView/list/public",method = RequestMethod.POST)
    public PaginationView<TruckView> publicTruckViewList(@RequestBody @Valid PaginationForm form){
        if(sessionContext.getWeChatBrowser()){
            throw new ResourceNotFoundException("not found");
        }
        Map<String,Object> query = form.getQueryMap();
        query.put("status",DRIVER_COMPLETE);
        PaginationView<TruckView> view = new PaginationView<>();
        List<TruckView> list  = driverMapper.selectTruckViewList(query);
        list.forEach(v-> v.setdLicenseUrl(StringUtils.hasText(v.getdLicenseUrl()) ? ossService.getImage(v.getdLicenseUrl()) : null));
        view.setList(list);
        view.setCount(driverMapper.selectCount(query));

        return view;
    }
}
