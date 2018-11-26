package com.zanyun.tms.service;

import com.sug.core.platform.exception.LoginRequiredException;
import com.sug.core.platform.exception.ResourceNotFoundException;
import com.sug.core.platform.wechat.request.WeChatPushMsgForm;
import com.sug.core.platform.wechat.response.WeChatUserInfoResponse;
import com.sug.core.platform.wechat.service.WeChatAuthService;
import com.sug.core.platform.wechat.service.WeChatMsgService;
import com.zanyun.tms.constants.DriverConstant;
import com.zanyun.tms.constants.UrlConstants;
import com.zanyun.tms.constants.WeChatPushMsgConstants;
import com.zanyun.tms.context.front.SessionContext;
import com.zanyun.tms.domain.front.Driver;
import com.zanyun.tms.domain.front.Order;
import com.zanyun.tms.domain.front.Owner;
import com.zanyun.tms.mapper.DriverMapper;
import com.zanyun.tms.mapper.OwnerMapper;
import com.zanyun.tms.request.wechat.WeChatMsgDataForm;
import com.zanyun.tms.request.wechat.WeChatOrderMsgData;
import com.zanyun.tms.request.wechat.WeChatRegisterValidateMsgData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Objects;

import static com.zanyun.tms.constants.UrlConstants.*;
import static com.zanyun.tms.constants.WeChatSitLoginType.*;

@Service
public class WeChatService {
    @Value("${website.domain:@null}")
    private String domain;

    @Autowired
    private SessionContext sessionContext;

    @Autowired
    private WeChatAuthService weChatAuthService;

    @Autowired
    private WeChatMsgService weChatMsgService;

    @Autowired
    private DriverMapper driverMapper;

    @Autowired
    private OwnerMapper ownerMapper;

    public boolean isWeChatBrowser() {
        if (Objects.isNull(sessionContext.getWeChatBrowser())) {
            throw new RuntimeException("userAgentRequired");
        }

        return sessionContext.getWeChatBrowser();
    }

    public String weChatBrowserDo(String type, String redirect_path) {
        if (Objects.isNull(sessionContext.getWeChatOAuthEntity())) {
            return weChatAuthService.getInfoAuthUrl(authCallbackUrl(), redirect_path);
        }

        if (DRIVER.equalsIgnoreCase(type)) {
            Driver driver = null;
            if (Objects.isNull(sessionContext.getDriverId())) {
                driver = driverMapper.selectByOpenId(sessionContext.getWeChatOAuthEntity().getOpenid());
                if (Objects.isNull(driver)) {
                    return PAGE_DRIVER + LOGIN;
                }
                sessionContext.setDriverId(driver.getId());
            }

            Driver currentDriver = Objects.isNull(driver) ? driverMapper.selectById(sessionContext.getDriverId()) : driver;
            if (DriverConstant.DRIVER_VALIDATE == (currentDriver.getStatus())){
                return PAGE_DRIVER + CENTER;
            }

            if (DriverConstant.DRIVER_COMPLETE != (currentDriver.getStatus())) {
                return PAGE_DRIVER + COMPLETE_INFO;
            }

        } else if (OWNER.equalsIgnoreCase(type) && Objects.isNull(sessionContext.getOwnerId())) {
            Owner owner = ownerMapper.selectByOpenId(sessionContext.getWeChatOAuthEntity().getOpenid());
            if (Objects.isNull(owner)) {
                return PAGE_OWNER + LOGIN;
            }
            sessionContext.setOwnerId(owner.getId());
        }

        return redirect_path;
    }

    private String authCallbackUrl() {
        return domain + UrlConstants.WECHAT_AUTH_REDIRECT;
    }

    public WeChatUserInfoResponse getWeChatUserInfo() {
        if (Objects.isNull(sessionContext.getWeChatOAuthEntity())) {
            throw new LoginRequiredException("weChatLoginRequired", "loginRequired");
        }

        try {
            return weChatAuthService.getUserInfo(sessionContext.getWeChatOAuthEntity());
        } catch (Exception e) {
            throw new RuntimeException("get weChat nick name fail:" + e.getMessage());
        }
    }

    public void sendRegisterValidateMsg(Driver driver) throws Exception {
        if (!StringUtils.hasText(driver.getWechatPubOpenId())) {
            return;
        }

        WeChatPushMsgForm form = new WeChatPushMsgForm();
        form.setTouser(driver.getWechatPubOpenId());
        form.setTemplate_id(WeChatPushMsgConstants.REGISTER_VALIDATE_ID);

        WeChatRegisterValidateMsgData data = new WeChatRegisterValidateMsgData();

        data.setFirst(new WeChatMsgDataForm(WeChatPushMsgConstants.REGISTER_VALIDATE_TITLE, "#173177"));
        data.setKeyword1(new WeChatMsgDataForm(driver.getName(), "#173177"));
        data.setKeyword2(new WeChatMsgDataForm(driver.getPhone(), "#173177"));
        data.setKeyword3(new WeChatMsgDataForm(SimpleDateFormat.getDateInstance().format(new Date()), "#173177"));
        data.setRemark(new WeChatMsgDataForm(WeChatPushMsgConstants.REGISTER_VALIDATE_REMARK, "#173177"));

        form.setData(data);

        weChatMsgService.sendMsg(form);
    }

    public void sendRegisterRejectMsg(Driver driver) throws Exception {
        if (!StringUtils.hasText(driver.getWechatPubOpenId())) {
            return;
        }

        WeChatPushMsgForm form = new WeChatPushMsgForm();
        form.setTouser(driver.getWechatPubOpenId());
        form.setTemplate_id(WeChatPushMsgConstants.REGISTER_VALIDATE_ID);

        WeChatRegisterValidateMsgData data = new WeChatRegisterValidateMsgData();

        data.setFirst(new WeChatMsgDataForm(WeChatPushMsgConstants.REGISTER_VALIDATE_REJECT_TITLE, "#173177"));
        data.setKeyword1(new WeChatMsgDataForm(driver.getName(), "#173177"));
        data.setKeyword2(new WeChatMsgDataForm(driver.getPhone(), "#173177"));
        data.setKeyword3(new WeChatMsgDataForm(SimpleDateFormat.getDateInstance().format(new Date()), "#173177"));
        data.setRemark(new WeChatMsgDataForm(WeChatPushMsgConstants.REGISTER_VALIDATE_REJECT_REMARK, "#173177"));

        form.setData(data);

        weChatMsgService.sendMsg(form);
    }

    public void sendOrderAcceptMsg(Order order) throws Exception {
        if(Objects.isNull(order.getOwnerId()) || Objects.isNull(order.getDriverId())){
            throw new ResourceNotFoundException("can not found ownerId or driverId");
        }

        Driver driver = driverMapper.selectById(order.getDriverId());
        Owner owner = ownerMapper.selectById(order.getOwnerId());

        if(Objects.nonNull(driver.getWechatPubOpenId())){
            WeChatPushMsgForm form = new WeChatPushMsgForm();
            form.setTouser(driver.getWechatPubOpenId());
            form.setTemplate_id(WeChatPushMsgConstants.ORDER_ID);

            WeChatOrderMsgData data = new WeChatOrderMsgData();

            data.setFirst(new WeChatMsgDataForm(WeChatPushMsgConstants.ORDER_TITLE, "#173177"));
            data.setKeyword1(new WeChatMsgDataForm(order.getNumber(), "#173177"));
            data.setKeyword2(new WeChatMsgDataForm("已成交", "#173177"));
            data.setRemark(new WeChatMsgDataForm(String.format(WeChatPushMsgConstants.ORDER_ACCEPT_DRIVER_REMARK,SimpleDateFormat.getDateInstance().format(order.getLoadTime()),(order.getOriProvince() + order.getOriCity() + order.getOriCounty() + order.getOriAddress())), "#173177"));

            form.setData(data);

            weChatMsgService.sendMsg(form);
        }

        if(Objects.nonNull(owner.getWechatPubOpenId())){
            WeChatPushMsgForm form = new WeChatPushMsgForm();
            form.setTouser(owner.getWechatPubOpenId());
            form.setTemplate_id(WeChatPushMsgConstants.ORDER_ID);

            WeChatOrderMsgData data = new WeChatOrderMsgData();

            data.setFirst(new WeChatMsgDataForm(WeChatPushMsgConstants.ORDER_TITLE, "#173177"));
            data.setKeyword1(new WeChatMsgDataForm(order.getNumber(), "#173177"));
            data.setKeyword2(new WeChatMsgDataForm("已成交", "#173177"));
            data.setRemark(new WeChatMsgDataForm(WeChatPushMsgConstants.ORDER_ACCEPT_OWNER_REMARK, "#173177"));

            form.setData(data);

            weChatMsgService.sendMsg(form);
        }
    }

    public void sendOrderSendMsg(Order order) throws Exception {
        if(Objects.isNull(order.getOwnerId())){
            throw new ResourceNotFoundException("can not found ownerId or driverId");
        }

        Owner owner = ownerMapper.selectById(order.getOwnerId());

        if(Objects.nonNull(owner.getWechatPubOpenId())){
            WeChatPushMsgForm form = new WeChatPushMsgForm();
            form.setTouser(owner.getWechatPubOpenId());
            form.setTemplate_id(WeChatPushMsgConstants.ORDER_ID);

            WeChatOrderMsgData data = new WeChatOrderMsgData();

            data.setFirst(new WeChatMsgDataForm(WeChatPushMsgConstants.ORDER_TITLE, "#173177"));
            data.setKeyword1(new WeChatMsgDataForm(order.getNumber(), "#173177"));
            data.setKeyword2(new WeChatMsgDataForm("已发货", "#173177"));
            data.setRemark(new WeChatMsgDataForm(String.format(WeChatPushMsgConstants.ORDER_SEND_REMARK,order.getArrProvince() + order.getArrCity() + order.getArrCounty() + order.getArrAddress()), "#173177"));

            form.setData(data);

            weChatMsgService.sendMsg(form);
        }
    }

    public void sendOrderCompleteMsg(Order order) throws Exception {
        if(Objects.isNull(order.getOwnerId())){
            throw new ResourceNotFoundException("can not found ownerId or driverId");
        }

        Owner owner = ownerMapper.selectById(order.getOwnerId());

        if(Objects.nonNull(owner.getWechatPubOpenId())){
            WeChatPushMsgForm form = new WeChatPushMsgForm();
            form.setTouser(owner.getWechatPubOpenId());
            form.setTemplate_id(WeChatPushMsgConstants.ORDER_ID);

            WeChatOrderMsgData data = new WeChatOrderMsgData();

            data.setFirst(new WeChatMsgDataForm(WeChatPushMsgConstants.ORDER_TITLE, "#173177"));
            data.setKeyword1(new WeChatMsgDataForm(order.getNumber(), "#173177"));
            data.setKeyword2(new WeChatMsgDataForm("已卸货", "#173177"));
            data.setRemark(new WeChatMsgDataForm(WeChatPushMsgConstants.ORDER_COMPLETE_REMARK, "#173177"));

            form.setData(data);

            weChatMsgService.sendMsg(form);
        }
    }

    public void sendOrderCancelMsg(Order order) throws Exception {
        if(Objects.isNull(order.getOwnerId()) || Objects.isNull(order.getDriverId())){
            throw new ResourceNotFoundException("can not found ownerId or driverId");
        }

        Driver driver = driverMapper.selectById(order.getDriverId());
        Owner owner = ownerMapper.selectById(order.getOwnerId());

        WeChatPushMsgForm form = new WeChatPushMsgForm();
        form.setTemplate_id(WeChatPushMsgConstants.ORDER_ID);

        WeChatOrderMsgData data = new WeChatOrderMsgData();

        data.setFirst(new WeChatMsgDataForm(WeChatPushMsgConstants.ORDER_TITLE, "#173177"));
        data.setKeyword1(new WeChatMsgDataForm(order.getNumber(), "#173177"));
        data.setKeyword2(new WeChatMsgDataForm("已取消", "#173177"));
        data.setRemark(new WeChatMsgDataForm(WeChatPushMsgConstants.ORDER_CANCEL_REMARK, "#173177"));

        form.setData(data);

        if(Objects.nonNull(driver.getWechatPubOpenId())){
            form.setTouser(driver.getWechatPubOpenId());
            weChatMsgService.sendMsg(form);
        }

        if(Objects.nonNull(owner.getWechatPubOpenId())){
            form.setTouser(owner.getWechatPubOpenId());
            weChatMsgService.sendMsg(form);
        }
    }
}
