package com.zanyun.tms.controller.api.wechat;

import com.sug.core.platform.exception.ResourceNotFoundException;
import com.sug.core.platform.wechat.constants.WeChatJsInter;
import com.sug.core.platform.wechat.form.WeChatJsPayParamsForm;
import com.sug.core.platform.wechat.form.WeChatNativeParamsForm;
import com.sug.core.platform.wechat.request.WeChatJsConfigForm;
import com.sug.core.platform.wechat.request.WeChatPayNotifyForm;
import com.sug.core.platform.wechat.response.WeChatJsConfigResponse;
import com.sug.core.platform.wechat.response.WeChatJsPayResponse;
import com.sug.core.platform.wechat.response.WeChatNativePayResponse;
import com.sug.core.platform.wechat.service.WeChatJsParamsService;
import com.sug.core.platform.wechat.service.WeChatPayService;
import com.zanyun.tms.constants.OrderConstants;
import com.zanyun.tms.constants.PaymentConstants;
import com.zanyun.tms.context.front.SessionContext;
import com.zanyun.tms.domain.front.Driver;
import com.zanyun.tms.domain.front.Order;
import com.zanyun.tms.domain.front.Payment;
import com.zanyun.tms.interceptor.front.DriverLoginRequired;
import com.zanyun.tms.mapper.DriverMapper;
import com.zanyun.tms.mapper.OrderMapper;
import com.zanyun.tms.mapper.PaymentMapper;
import com.zanyun.tms.service.WeChatService;
import com.zanyun.tms.view.front.PaymentStatusView;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Objects;


@RestController("CommonWeChatController")
@RequestMapping(value = "/wechat")
public class CommonController {

    private static final Logger logger = LoggerFactory.getLogger(CommonController.class);

    @Autowired
    private SessionContext sessionContext;

    @Autowired
    private WeChatJsParamsService weChatJsParamsService;

    @Autowired
    private WeChatPayService weChatPayService;

    @Autowired
    private OrderMapper orderMapper;

    @Autowired
    private PaymentMapper paymentMapper;

    @Autowired
    private DriverMapper driverMapper;

    @Autowired
    private WeChatService weChatService;

    private static final String UNIFIED_BODY = "赵霞智慧物流-信息费";

    @RequestMapping(value = "/payment/notify")
    @Transactional
    public String weChatPayNotify(@RequestBody WeChatPayNotifyForm form, HttpServletRequest request) throws IOException {

        if("FAIL".equals(form.getReturn_code())){
            logger.error("weChatPayNotify request content type:" + request.getHeader(HttpHeaders.CONTENT_TYPE)
                    + ",return_code:" + form.getReturn_code() + ",return_msg:"+ form.getReturn_msg());
        }

        Date now = new Date();

        Payment payment = paymentMapper.selectByNum(form.getOut_trade_no());
        payment.setStatus(PaymentConstants.PAID_STATUS);
        payment.setUpdateTime(now);
        payment.setUpdateBy(0);

        Order order = orderMapper.selectById(payment.getOrderId());
        order.setStatus(OrderConstants.PAID_STATUS);
        order.setPaidTime(now);
        order.setUpdateBy(0);

        paymentMapper.update(payment);
        orderMapper.update(order);

        try {
            weChatService.sendOrderAcceptMsg(order);
        } catch (Exception e) {
            logger.error("weChat order paid msg fail:" + e.getMessage());
        }

        return "success";
    }

    @RequestMapping(value = "/js/configParams",method = RequestMethod.POST)
    public WeChatJsConfigResponse weChatJsParams(@RequestBody WeChatJsConfigForm form) throws Exception {
        List<String> interfaceList = new ArrayList<>();
        interfaceList.add(WeChatJsInter.JS_PAY);
        interfaceList.add(WeChatJsInter.TIMELINE_SHARE);
        interfaceList.add(WeChatJsInter.APPMESSAGE_SHARE);
        return weChatJsParamsService.getJsConfigParams(form.getUrl(),interfaceList);
    }

    @RequestMapping(value = "/js/payParams/{id}",method = RequestMethod.GET)
    @DriverLoginRequired
    public WeChatJsPayResponse weChatJsPay(@PathVariable Integer id){
        Driver driver = driverMapper.selectById(sessionContext.getDriverId());
        if(Objects.isNull(driver)){
            throw new ResourceNotFoundException("driver not exists");
        }
        String openId = driver.getWechatPubOpenId();
        Payment payment = paymentMapper.selectById(id);

        if(Objects.isNull(payment)){
            throw new ResourceNotFoundException("payment not found");
        }

        WeChatJsPayParamsForm form = new WeChatJsPayParamsForm();
        form.setTotal_fee((int)(payment.getAmount() * 100));
        form.setBody(UNIFIED_BODY);
        form.setOut_trade_no(payment.getNumber());
        form.setSpbill_create_ip(sessionContext.getRemoteAddr());
        form.setOpenid(openId);

        try {
            WeChatJsPayResponse response = weChatPayService.getJsPayParams(form);
            sessionContext.setPaymentId(id);
            return response;
        } catch (Exception ex) {
            StringWriter stringWriter = new StringWriter();
            ex.printStackTrace(new PrintWriter(stringWriter));
            throw new RuntimeException("get weChatJsPayParams fail,Exception:" + stringWriter.toString());
        }
    }

    @RequestMapping(value = "/native/code/{id}",method = RequestMethod.GET)
    @DriverLoginRequired
    public WeChatNativePayResponse weChatNativePay(@PathVariable Integer id){
        Driver driver = driverMapper.selectById(sessionContext.getDriverId());
        if(Objects.isNull(driver)){
            throw new ResourceNotFoundException("driver not exists");
        }

        Payment payment = paymentMapper.selectById(id);
        if(Objects.isNull(payment)){
            throw new ResourceNotFoundException("payment not found");
        }

        Order order = orderMapper.selectById(payment.getOrderId());
        if(Objects.isNull(order)){
            throw new ResourceNotFoundException("order not found");
        }

        WeChatNativeParamsForm form = new WeChatNativeParamsForm();
        form.setTotal_fee((int)(payment.getAmount() * 100));
        form.setBody(UNIFIED_BODY);
        form.setOut_trade_no(payment.getNumber());
        form.setSpbill_create_ip(sessionContext.getRemoteAddr());
        form.setProduct_id(order.getNumber());

        WeChatNativePayResponse response = new WeChatNativePayResponse();

        try {
            response.setCode_url(weChatPayService.getQrCodeUrl(form));
            sessionContext.setPaymentId(payment.getId());
            return response;
        } catch (Exception ex) {
            StringWriter stringWriter = new StringWriter();
            ex.printStackTrace(new PrintWriter(stringWriter));
            throw new RuntimeException("get weChatJsPayParams fail,Exception:" + stringWriter.toString());
        }
    }

    @RequestMapping(value = "/payment/status",method = RequestMethod.GET)
    @DriverLoginRequired
    public PaymentStatusView payStatus(){
        if(Objects.isNull(sessionContext.getPaymentId())){
            throw new ResourceNotFoundException("payment not found");
        }
        Payment payment = paymentMapper.selectById(sessionContext.getPaymentId());
        if(Objects.isNull(payment)){
            throw new ResourceNotFoundException("payment not found");
        }
        PaymentStatusView view = new PaymentStatusView();
        view.setStatus(payment.getStatus());
        return view;
    }
}
