package com.zanyun.tms.controller.api.background;

import com.sug.core.platform.exception.ResourceNotFoundException;
import com.sug.core.platform.web.rest.exception.InvalidRequestException;
import com.sug.core.rest.view.SuccessView;
import com.zanyun.tms.constants.DriverConstant;
import com.zanyun.tms.context.background.SessionContext;
import com.zanyun.tms.domain.front.Driver;
import com.zanyun.tms.interceptor.background.AuthRequired;
import com.zanyun.tms.interceptor.background.LoginRequired;
import com.zanyun.tms.mapper.DriverMapper;
import com.zanyun.tms.request.background.*;
import com.zanyun.tms.service.OSSService;
import com.zanyun.tms.service.WeChatService;
import com.zanyun.tms.view.background.DriverListView;
import com.zanyun.tms.view.background.DriverView;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.Objects;

import static com.zanyun.tms.constants.UrlConstants.*;

@RestController("DriverBackgroundController")
@RequestMapping("/background/driver")
public class DriverController {
    private static final Logger logger = LoggerFactory.getLogger(DriverController.class);

    @Autowired
    private DriverMapper driverMapper;

    @Autowired
    private WeChatService weChatService;

    @Autowired
    private SessionContext sessionContext;

    @Autowired
    private OSSService ossService;

    @RequestMapping(value = LIST,method = RequestMethod.POST)
    @LoginRequired
    @AuthRequired
    public DriverListView list(@Valid @RequestBody DriverListForm form){
        DriverListView view = new DriverListView();
        view.setList(driverMapper.selectViewList(form.getQueryMap()));
        view.setCount(driverMapper.selectCount(form.getQueryMap()));

        return view;
    }

    @RequestMapping(value = DETAIL + ID,method = RequestMethod.GET)
    @LoginRequired
    @AuthRequired
    public DriverView getById(@PathVariable Integer id){
        Driver driver = driverMapper.selectById(id);
        if(Objects.isNull(driver)){
            throw new ResourceNotFoundException("司机不存在");
        }

        DriverView view = new DriverView();

        BeanUtils.copyProperties(driver,view);
        view.setLicenseUrl(StringUtils.hasText(view.getLicenseUrl()) ? ossService.getImage(view.getLicenseUrl()) : null);
        view.setdLicenseUrl(StringUtils.hasText(view.getdLicenseUrl()) ? ossService.getImage(view.getdLicenseUrl()) : null);

        return view;
    }

    @RequestMapping(value = "/validate",method = RequestMethod.PUT)
    @LoginRequired
    @AuthRequired
    public SuccessView validate(@Valid @RequestBody ValidateForm form){

        Driver driver = driverMapper.selectById(form.getId());
        if(Objects.isNull(driver)){
            throw new ResourceNotFoundException("账号不存在");
        }

        if(!driver.getStatus().equals(DriverConstant.DRIVER_VALIDATE)){
            throw new InvalidRequestException("不是待审核的状态");
        }

        driver.setStatus(DriverConstant.DRIVER_COMPLETE);
        driver.setUpdateBy(sessionContext.getUserId());

        driverMapper.update(driver);

        try {
            weChatService.sendRegisterValidateMsg(driver);
        } catch (Exception e) {
            logger.error("send driver register validate msg fail:" + e.getMessage());
        }

        return new SuccessView();
    }

    @RequestMapping(value = "/reject",method = RequestMethod.PUT)
    @LoginRequired
    @AuthRequired
    public SuccessView reject(@Valid @RequestBody DriverRejectForm form){

        Driver driver = driverMapper.selectById(form.getId());
        if(Objects.isNull(driver)){
            throw new ResourceNotFoundException("账号不存在");
        }

        if(!driver.getStatus().equals(DriverConstant.DRIVER_VALIDATE)){
            throw new InvalidRequestException("不是待审核的状态");
        }

        String licenseUrl = driver.getLicenseUrl();
        String dLicenseUrl = driver.getdLicenseUrl();

        BeanUtils.copyProperties(form,driver);
        if(StringUtils.hasText(driver.getLicenseUrl())){
            driver.setLicenseUrl(licenseUrl);
        }
        if(StringUtils.hasText(driver.getdLicenseUrl())){
            driver.setdLicenseUrl(dLicenseUrl);
        }
        driver.setStatus(DriverConstant.DRIVER_REJECT);
        driver.setUpdateBy(sessionContext.getUserId());

        driverMapper.update(driver);

        try {
            weChatService.sendRegisterRejectMsg(driver);
        } catch (Exception e) {
            logger.error("send driver register validate msg fail:" + e.getMessage());
        }

        return new SuccessView();
    }

    @RequestMapping(value = "/enable",method = RequestMethod.PUT)
    @LoginRequired
    @AuthRequired
    public SuccessView enable(@Valid @RequestBody DriverAvailableForm form){

        Driver driver = driverMapper.selectById(form.getId());
        if(Objects.isNull(driver)){
            throw new ResourceNotFoundException("账号不存在");
        }

        if(!driver.getStatus().equals(DriverConstant.DRIVER_INVALID)){
            throw new InvalidRequestException("不是禁用的状态");
        }

        driver.setStatus(DriverConstant.DRIVER_COMPLETE);
        driver.setUpdateBy(sessionContext.getUserId());

        driverMapper.update(driver);

        return new SuccessView();
    }

    @RequestMapping(value = "/disable",method = RequestMethod.PUT)
    @LoginRequired
    @AuthRequired
    public SuccessView disable(@Valid @RequestBody DriverAvailableForm form){

        Driver driver = driverMapper.selectById(form.getId());
        if(Objects.isNull(driver)){
            throw new ResourceNotFoundException("账号不存在");
        }

        if(!driver.getStatus().equals(DriverConstant.DRIVER_COMPLETE)){
            throw new InvalidRequestException("错误的状态");
        }

        driver.setStatus(DriverConstant.DRIVER_INVALID);
        driver.setUpdateBy(sessionContext.getUserId());

        driverMapper.update(driver);

        return new SuccessView();
    }

    @RequestMapping(value = "/unbundled",method = RequestMethod.PUT)
    @LoginRequired
    @AuthRequired
    public String unbundled(@Valid @RequestBody UnbundledForm form){

        Driver driver = driverMapper.selectByPhone(form.getPhone());
        if(Objects.isNull(driver)){
            throw new ResourceNotFoundException("账号不存在");
        }

        driver.setWechatPubOpenId(null);

        driverMapper.update(driver);

        return "success";
    }


}
