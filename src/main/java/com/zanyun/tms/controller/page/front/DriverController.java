package com.zanyun.tms.controller.page.front;

import com.sug.core.platform.exception.ForbiddenException;
import com.sug.core.platform.exception.ResourceNotFoundException;
import com.zanyun.tms.constants.OrderConstants;
import com.zanyun.tms.context.front.SessionContext;
import com.zanyun.tms.domain.background.TransportationParams;
import com.zanyun.tms.domain.front.Driver;
import com.zanyun.tms.domain.front.Order;
import com.zanyun.tms.interceptor.front.PageCheckRequired;
import com.zanyun.tms.interceptor.front.PageLoginType;
import com.zanyun.tms.mapper.DriverMapper;
import com.zanyun.tms.mapper.OrderMapper;
import com.zanyun.tms.mapper.TransportationMapper;
import com.zanyun.tms.service.OSSService;
import com.zanyun.tms.view.front.OrderListView;
import com.zanyun.tms.view.front.OrderStatusCount;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.util.*;

import static com.zanyun.tms.constants.DriverConstant.*;
import static com.zanyun.tms.constants.DriverConstant.DRIVER_INCOMPLETE;
import static com.zanyun.tms.constants.UrlConstants.*;
import static com.zanyun.tms.constants.UrlConstants.CENTER;
import static com.zanyun.tms.constants.UrlConstants.COMPLETE_INFO;
import static com.zanyun.tms.constants.UrlConstants.DETAIL;
import static com.zanyun.tms.constants.UrlConstants.HISTORY;
import static com.zanyun.tms.constants.UrlConstants.LOGIN;
import static com.zanyun.tms.constants.UrlConstants.ORDER_DETAIL;
import static com.zanyun.tms.constants.UrlConstants.ORDER_LIST;
import static com.zanyun.tms.constants.UrlConstants.PAGE_DRIVER;
import static com.zanyun.tms.constants.UrlConstants.PAGE_WEB;
import static com.zanyun.tms.constants.UrlConstants.PAGE_WECHAT;
import static com.zanyun.tms.constants.UrlConstants.PASSWORD_CHANGE;
import static com.zanyun.tms.constants.UrlConstants.REGISTER;
import static com.zanyun.tms.constants.UrlConstants.SETTING;
import static com.zanyun.tms.constants.WeChatSitLoginType.DRIVER;

@Controller("DriverPageController")
@RequestMapping(value = PAGE_DRIVER)
@PageCheckRequired
public class DriverController {
    private final Logger logger = LoggerFactory.getLogger(DriverController.class);

    @Autowired
    private SessionContext sessionContext;

    @Autowired
    private DriverMapper driverMapper;

    @Autowired
    private OrderMapper orderMapper;

    @Autowired
    private TransportationMapper transportationMapper;

    @Autowired
    private OSSService ossService;

    @RequestMapping(value = REGISTER,method = RequestMethod.GET)
    public String register(){
        String redirectUrl = checkLogin();
        return StringUtils.hasText(redirectUrl) ? redirectUrl : getPath() + PAGE_DRIVER + REGISTER;
    }

    @RequestMapping(value = LOGIN, method = RequestMethod.GET)
    public String login(){
        String redirectUrl = checkLogin();
        return StringUtils.hasText(redirectUrl) ? redirectUrl : getPath() + PAGE_DRIVER + LOGIN;
    }

    private String checkLogin(){
        if(Objects.nonNull(sessionContext.getDriverId())){
            Driver driver = driverMapper.selectById(sessionContext.getDriverId());
            if(driver.getStatus().equals(DRIVER_INCOMPLETE)){
                return "redirect:/driver/completeInfo";
            }
            return "redirect:/driver/center";
        }
        return null;
    }

    @RequestMapping(value = PASSWORD_CHANGE, method = RequestMethod.GET)
    public String changePassword(){
        return getPath() + PAGE_DRIVER + PASSWORD_CHANGE;
    }

    @RequestMapping(value = COMPLETE_INFO, method = RequestMethod.GET)
    @PageLoginType(DRIVER)
    public String completeInfo(ModelMap model){
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
        return getPath() + PAGE_DRIVER + COMPLETE_INFO;
    }

    @RequestMapping(value = CENTER, method = RequestMethod.GET)
    @PageLoginType(DRIVER)
    public String driverCenter(ModelMap model){

        Driver driver = driverMapper.selectById(sessionContext.getDriverId());
        Map<String, Object> map = new HashMap<>();

        map.put("driverId", sessionContext.getDriverId());
        map.put("cancel", OrderConstants.CANCEL_STATUS);
        map.put("unpaid", OrderConstants.LOCK_STATUS);
        map.put("accept", OrderConstants.ACCEPT_STATUS);
        map.put("transport", OrderConstants.TRANSPORT_STATUS);
        map.put("complete", OrderConstants.COMPLETE_STATUS);

        OrderStatusCount count = orderMapper.selectStatusCount(map);

        model.put("driver",driver);
        model.put("count",count);
        model.put("active", "member");
        return getPath() + PAGE_DRIVER + CENTER;
    }

    @RequestMapping(value = "/resetAddress", method = RequestMethod.GET)
    @PageLoginType(DRIVER)
    public String resetAddress(ModelMap model){

        Driver driver = driverMapper.selectById(sessionContext.getDriverId());
        model.put("driver",driver);

        return getPath() + PAGE_DRIVER + "/resetAddress";
    }

    @RequestMapping(value = ORDER_LIST + "/{status}", method = RequestMethod.GET)
    @PageLoginType(DRIVER)
    public String driverList(@PathVariable Integer status, ModelMap model){
        Map<String, Object> map = new HashMap<>();
        map.put("startIndex",0);
        map.put("pageSize",20);
        map.put("driverId", sessionContext.getDriverId());
        map.put(OrderConstants.CREATE_STATUS == status ? "created" : "status", status);

        List<OrderListView> list = orderMapper.selectListView(map);
        int count = orderMapper.selectCount(map);

        model.put("list",list);
        model.put("count",count);

        Driver driver = driverMapper.selectById(sessionContext.getDriverId());
        model.put("driver", driver);
        model.put("active", "order");

        return getPath() + PAGE_DRIVER + HISTORY;
    }

    @RequestMapping(value = ORDER_DETAIL + "/{id}", method = RequestMethod.GET)
    @PageLoginType(DRIVER)
    public String driverOrderDetail(@PathVariable Integer id, ModelMap model) {
        Order order = orderMapper.selectById(id);
        if(Objects.isNull(order)){
            throw new ResourceNotFoundException("order not found");
        }
        if(!sessionContext.getDriverId().equals(order.getDriverId())){
            throw new ForbiddenException("no auth");
        }
        order.setOwnerFreight(0d);
        order.setFinalFreight(0d);
        model.put("order",order);
        return getPath() + PAGE_DRIVER + DETAIL;
    }

    @RequestMapping(value = CENTER + SETTING, method = RequestMethod.GET)
    @PageLoginType(DRIVER)
    public String webDriverCenterSetting(ModelMap model) {
        Driver driver = driverMapper.selectById(sessionContext.getDriverId());
        Map<String, Object> query = new HashMap<>();
        query.put("driverId", sessionContext.getDriverId());
        query.put("cancel", OrderConstants.CANCEL_STATUS);
        query.put("unpaid", OrderConstants.LOCK_STATUS);
        query.put("accept", OrderConstants.ACCEPT_STATUS);
        query.put("transport", OrderConstants.TRANSPORT_STATUS);
        query.put("complete", OrderConstants.COMPLETE_STATUS);
        OrderStatusCount count = orderMapper.selectStatusCount(query);
        model.put("driver", driver);
        model.put("orderCount", count);
        model.put("active", "setting");
        return PAGE_WEB + PAGE_DRIVER + SETTING;
    }

    private String getPath(){
        return sessionContext.getWeChatBrowser() ? PAGE_WECHAT : PAGE_WEB;
    }

}
