package com.zanyun.tms.service;

import com.aliyuncs.exceptions.ClientException;
import com.sug.core.platform.sms.aliyun.AliyunSmsService;
import com.zanyun.tms.request.aliyun.SmsCaptchaForm;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.io.UnsupportedEncodingException;

@Service
public class SmsService {
    private static final Logger logger = LoggerFactory.getLogger(SmsService.class);

    @Autowired
    private AliyunSmsService smsService;

    @Value("${aliyun.sms.sign:@null}")
    private String sign;

    @Value("${aliyun.sms.captcha.template:@null}")
    private String captchaTemp;

    public void sendCaptcha(String phone,String captcha) throws ClientException, UnsupportedEncodingException {
        SmsCaptchaForm form = new SmsCaptchaForm();
        form.setCode(captcha);
        smsService.send(phone,new String(sign.getBytes("ISO-8859-1"),"UTF-8"),captchaTemp,form);
    }
}
