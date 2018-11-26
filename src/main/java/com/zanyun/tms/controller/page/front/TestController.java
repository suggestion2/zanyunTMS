package com.zanyun.tms.controller.page.front;

import com.zanyun.tms.context.front.SessionContext;
import com.zanyun.tms.domain.background.*;
import com.zanyun.tms.domain.front.Driver;
import com.zanyun.tms.mapper.*;
import com.zanyun.tms.service.OSSService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.util.ArrayList;
import java.util.List;

import static com.zanyun.tms.constants.UrlConstants.*;

@Controller
public class TestController {
    @Autowired
    private SessionContext sessionContext;

    @Autowired
    private DriverMapper driverMapper;

    @Autowired
    private TransportationMapper transportationMapper;

    @Autowired
    private OSSService ossService;


    @RequestMapping(value = "/test/wechat/driver/completeInfo", method = RequestMethod.GET)
    public String completeInfo2(ModelMap model) {

        List<TransportationParams> list = transportationMapper.selectParams();

        List<String> params = new ArrayList<>();

        for(TransportationParams t : list){
            if(t.getName().equals("type")){
                params = t.getValue();
            }
        }

        Driver driver = driverMapper.selectById(sessionContext.getDriverId());
        driver.setLicenseUrl(StringUtils.hasText(driver.getLicenseUrl()) ? ossService.getImage(driver.getLicenseUrl()) : null);
        driver.setdLicenseUrl(StringUtils.hasText(driver.getdLicenseUrl()) ? ossService.getImage(driver.getdLicenseUrl()) : null);
        model.put("driver",driver);
        model.put("transportation",params);
        return "/wechat/driver/completeInfo";
    }



    @RequestMapping(value = "/test/wechat/order/createOrder", method = RequestMethod.GET)
    public String driverLogin(ModelMap model) {
        sessionContext.setOwnerId(1);
        return "/wechat/owner/createOrder";
    }

    @RequestMapping(value = "/test/wechat/driver/resetPassword", method = RequestMethod.GET)
    public String driverResetPassword(ModelMap model) {
        return "/wechat/driver/resetPassword";
    }

    @RequestMapping(value = "/test/wechat/owner/resetPassword", method = RequestMethod.GET)
    public String ownerResetPassword(ModelMap model) {
        return "/wechat/owner/resetPassword";
    }
}
