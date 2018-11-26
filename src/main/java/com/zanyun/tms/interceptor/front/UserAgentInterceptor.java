package com.zanyun.tms.interceptor.front;

import com.zanyun.tms.context.front.SessionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.util.StringUtils;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Objects;

import static com.sug.core.platform.wechat.constants.WeChatParams.WECHAT_BROWSER;


public class UserAgentInterceptor extends HandlerInterceptorAdapter {

    private final org.slf4j.Logger logger = org.slf4j.LoggerFactory.getLogger(UserAgentInterceptor.class);

    @Autowired
    private SessionContext sessionContext;

    @Value("${spring.profiles.active:@null}")
    private String env;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        logger.debug("UserAgentInterceptor ----------preHandle------------, URI=" + request.getRequestURI());

        //如果Annotation标识有LoginRequired, 判断method是否含有customer session

        String userAgent = request.getHeader("user-agent");
        boolean isWeChatBrowser = userAgent.contains(WECHAT_BROWSER);
        if (Objects.isNull(sessionContext.getWeChatBrowser())) {
            sessionContext.setWeChatBrowser(isWeChatBrowser);
        }

        if (!StringUtils.hasText(sessionContext.getRemoteAddr())) {
            if ("dev".equalsIgnoreCase(env)) {
                sessionContext.setRemoteAddr(request.getRemoteAddr());
            } else {
                sessionContext.setRemoteAddr(request.getHeader("X-Real-IP"));
            }
        }

        return true;
    }


}

