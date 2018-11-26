package com.zanyun.tms.interceptor.front;

import com.zanyun.tms.constants.DriverConstant;
import com.zanyun.tms.context.front.SessionContext;
import com.zanyun.tms.domain.front.Driver;
import com.zanyun.tms.mapper.DriverMapper;
import com.zanyun.tms.service.WeChatService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.servlet.resource.ResourceHttpRequestHandler;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Objects;

import static com.zanyun.tms.constants.UrlConstants.*;
import static com.zanyun.tms.constants.WeChatSitLoginType.DRIVER;
import static com.zanyun.tms.constants.WeChatSitLoginType.OWNER;


public class PageInterceptor extends HandlerInterceptorAdapter {

    private final org.slf4j.Logger logger = org.slf4j.LoggerFactory.getLogger(PageInterceptor.class);

    @Autowired
    private WeChatService weChatService;

    @Autowired
    private DriverMapper driverMapper;

    @Autowired
    private SessionContext sessionContext;

    @Value("${spring.profiles.active:@null}")
    private String env;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        logger.debug("PageInterceptor ----------preHandle------------, URI=" + request.getRequestURI());

        if (handler instanceof ResourceHttpRequestHandler) {
            return true;
        }

        logger.debug("PageInterceptor ----------preHandle------------, has PageCheckRequired annotation=" + ((HandlerMethod) handler).getBeanType().isAnnotationPresent(PageCheckRequired.class));

        if (((HandlerMethod) handler).getBeanType().isAnnotationPresent(PageCheckRequired.class)) {
            logger.debug("PageInterceptor ----------preHandle------------, isWeChatBrowser=" + weChatService.isWeChatBrowser());

            String redirect_uri = request.getRequestURI();

            String type = null;

            if (((HandlerMethod) handler).getMethod().isAnnotationPresent(PageLoginType.class)) {
                type = ((HandlerMethod) handler).getMethod().getAnnotation(PageLoginType.class).value();
            }
            String returnUrl = redirect_uri;
            if (weChatService.isWeChatBrowser()) {
                returnUrl = weChatService.weChatBrowserDo(type, redirect_uri);

                logger.debug("PageInterceptor ----------preHandle------------, returnUrl=" + returnUrl);
            }else {
                if(DRIVER.equalsIgnoreCase(type)){
                    if (Objects.isNull(sessionContext.getDriverId())) {
                        returnUrl = LOGIN;
                    }else{
                        Driver driver = driverMapper.selectById(sessionContext.getDriverId());
                        if (DriverConstant.DRIVER_VALIDATE == (driver.getStatus())){
                            returnUrl = PAGE_DRIVER + CENTER;
                        } else if (DriverConstant.DRIVER_COMPLETE != (driver.getStatus())) {
                            returnUrl = PAGE_DRIVER + COMPLETE_INFO;
                        }
                    }
                }else if (OWNER.equalsIgnoreCase(type) && Objects.isNull(sessionContext.getOwnerId())) {
                    returnUrl = LOGIN;
                }
            }
            if (!redirect_uri.equals(returnUrl)) {
                response.sendRedirect(returnUrl);
                return false;
            }
        }

        return true;
    }
}

