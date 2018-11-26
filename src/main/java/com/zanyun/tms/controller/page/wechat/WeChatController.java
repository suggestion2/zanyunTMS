package com.zanyun.tms.controller.page.wechat;

import com.sug.core.platform.wechat.entity.WeChatOAuthEntity;
import com.sug.core.platform.wechat.service.WeChatAuthService;
import com.zanyun.tms.constants.UrlConstants;
import com.zanyun.tms.context.front.SessionContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.net.URLDecoder;

import static com.sug.core.platform.wechat.constants.WeChatParams.MP_TYPE;

@Controller
public class WeChatController {
    private final Logger logger = LoggerFactory.getLogger(WeChatController.class);

    @Autowired
    private WeChatAuthService weChatAuthService;

    @Autowired
    private SessionContext sessionContext;

    @RequestMapping(value = UrlConstants.WECHAT_AUTH_REDIRECT)
    public String weChatAuthCode(@RequestParam String code, @RequestParam String state) throws Exception {
        WeChatOAuthEntity entity = weChatAuthService.getOAuth(code,MP_TYPE);
        sessionContext.setWeChatOAuthEntity(entity);

        return "redirect:" + URLDecoder.decode(state,"UTF-8");
    }
}
