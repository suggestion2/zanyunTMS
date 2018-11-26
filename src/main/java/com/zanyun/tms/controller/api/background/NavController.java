package com.zanyun.tms.controller.api.background;

import com.zanyun.tms.context.background.SessionContext;
import com.zanyun.tms.interceptor.background.LoginRequired;
import com.zanyun.tms.mapper.NavMapper;
import com.zanyun.tms.view.background.NavListView;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import java.util.Objects;

import static com.zanyun.tms.constants.UrlConstants.LIST;

@RestController
@RequestMapping("/background/nav")
public class NavController {
    private static final Logger logger = LoggerFactory.getLogger(NavController.class);

    @Autowired
    private SessionContext sessionContext;

    @Autowired
    private NavMapper navMapper;

    @RequestMapping(value = LIST,method = RequestMethod.GET)
    @LoginRequired
    public NavListView list(){
        NavListView view = new NavListView();

        view.setList(Objects.nonNull(sessionContext.getNavList()) ?
                sessionContext.getNavList() : (Objects.nonNull(sessionContext.isAdmin()) && sessionContext.isAdmin() ?
                navMapper.selectList(null) : navMapper.selectListByDepartmentId(sessionContext.getDepartmentId())));

        return view;
    }
}
