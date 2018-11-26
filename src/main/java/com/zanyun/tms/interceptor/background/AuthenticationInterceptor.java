package com.zanyun.tms.interceptor.background;

import com.sug.core.platform.exception.ForbiddenException;
import com.sug.core.platform.exception.LoginRequiredException;
import com.zanyun.tms.context.background.SessionContext;
import com.zanyun.tms.domain.background.Action;
import com.zanyun.tms.mapper.ActionMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Objects;

/**
 * Created by Greg.Chen on 2015/7/30.
 */
public class AuthenticationInterceptor extends HandlerInterceptorAdapter {

    private static final Logger log = LoggerFactory.getLogger(AuthenticationInterceptor.class);

    @Autowired
    private SessionContext sessionContext;

    @Autowired
    private ActionMapper actionMapper;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        log.debug("AuthenticationInterceptor-->preHandle, URI" + request.getRequestURI());

        if (((HandlerMethod) handler).getMethod().isAnnotationPresent(LoginRequired.class)) {
            if(Objects.isNull(sessionContext.getUserId())){
                throw new LoginRequiredException("UserLoginRequired", "请登录");
            }
            if(!sessionContext.isAvailable() && !request.getRequestURI().equalsIgnoreCase("/background/user/changePwd")){
                throw new LoginRequiredException("initPwdRequired", "请修改密码");
            }
        }

        if(((HandlerMethod) handler).getMethod().isAnnotationPresent(AuthRequired.class)){
            if(sessionContext.isAdmin()){
                return true;
            }

            List<Action> actionList = sessionContext.getActionList();
            if(Objects.isNull(actionList)){
                actionList = actionMapper.selectListByDepartmentId(sessionContext.getDepartmentId());
                sessionContext.setActionList(actionList);
            }

            String requestUri = request.getRequestURI();

            if(actionList.stream().anyMatch(a->requestUri.contains(a.getUri()))){
                return true;
            }

            throw new ForbiddenException("没有权限");
        }

        return true;
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
        log.debug("AuthenticationInterceptor ----- afterCompletion -------------------------------------");
    }
}
