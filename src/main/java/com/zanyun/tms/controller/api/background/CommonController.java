package com.zanyun.tms.controller.api.background;

import com.sug.core.rest.view.SuccessView;
import com.sug.core.util.RandomStringGenerator;
import com.zanyun.tms.context.background.SessionContext;
import com.zanyun.tms.interceptor.background.LoginRequired;
import com.zanyun.tms.mapper.CustomerCountMapper;
import com.zanyun.tms.mapper.OrderCountMapper;
import com.zanyun.tms.request.front.SendCaptchaForm;
import com.zanyun.tms.service.OSSService;
import com.zanyun.tms.service.SmsService;
import com.zanyun.tms.view.background.ReportView;
import com.zanyun.tms.view.front.CaptchaView;
import com.zanyun.tms.view.front.UploadParamsView;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import javax.validation.Valid;

@RestController("CommonBackgroundController")
@RequestMapping("/background/common")
public class CommonController {

    @Autowired
    private SessionContext sessionContext;

    @Autowired
    private SmsService smsService;

    @Autowired
    private OrderCountMapper orderCountMapper;

    @Autowired
    private CustomerCountMapper customerCountMapper;

    @Autowired
    private OSSService ossService;

    @Value("${aliyun.sms.whiteList:@null}")
    private String whiteList;

    @RequestMapping(value = "/captcha",method = RequestMethod.POST)
    public CaptchaView sendCaptcha(@Valid @RequestBody SendCaptchaForm form){
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
    public SuccessView logout(){
        sessionContext.invalidate();
        return new SuccessView();
    }

    @RequestMapping(value = "/uploadParams",method = RequestMethod.GET)
    @LoginRequired
    public UploadParamsView uploadParams() throws Exception {
        return ossService.getBackUploadParams();
    }

    @RequestMapping(value = "/report",method = RequestMethod.GET)
    @LoginRequired
    public ReportView report() throws Exception {
        ReportView view = new ReportView();
        view.setOrderCountList(orderCountMapper.selectListByDays(7));
        view.setCustomerCountList(customerCountMapper.selectListByDays(7));
        return view;
    }
}
