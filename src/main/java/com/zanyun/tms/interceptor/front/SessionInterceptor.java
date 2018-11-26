package com.zanyun.tms.interceptor.front;

import com.sug.core.platform.exception.LoginRequiredException;
import com.zanyun.tms.context.front.SessionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.servlet.resource.ResourceHttpRequestHandler;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Objects;


public class SessionInterceptor extends HandlerInterceptorAdapter {

    private final org.slf4j.Logger logger = org.slf4j.LoggerFactory.getLogger(SessionInterceptor.class);

    @Autowired
    private SessionContext sessionContext;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        logger.debug("SessionInterceptor ----------preHandle------------, URI=" + request.getRequestURI());

        if (handler instanceof ResourceHttpRequestHandler) {
            return true;
        }

        //如果Annotation标识有LoginRequired, 判断method是否含有customer session

        checkLoginRequired(handler);

        return true;
    }

    private void checkLoginRequired(Object handler) throws Exception {

        if (((HandlerMethod) handler).getMethod().isAnnotationPresent(WeChatLoginRequired.class)
                && sessionContext.getWeChatBrowser() && Objects.isNull(sessionContext.getWeChatOAuthEntity())) {
            throw new LoginRequiredException("weChatLoginRequired", "请登录");
        }

        if (((HandlerMethod) handler).getMethod().isAnnotationPresent(DriverLoginRequired.class)
                && Objects.isNull(sessionContext.getDriverId())) {
            throw new LoginRequiredException(sessionContext.getWeChatBrowser() ? "weChatLoginRequired" : "driverLoginRequired", "请登录");
        }

        if (((HandlerMethod) handler).getMethod().isAnnotationPresent(OwnerLoginRequired.class)
                && Objects.isNull(sessionContext.getOwnerId())) {
            throw new LoginRequiredException(sessionContext.getWeChatBrowser() ? "weChatLoginRequired" : "ownerLoginRequired", "请登录");
        }
    }
}

