package com.zanyun.tms.controller.api.background;

import com.zanyun.tms.context.background.SessionContext;
import com.zanyun.tms.interceptor.background.LoginRequired;
import com.zanyun.tms.mapper.AuthMapper;
import com.zanyun.tms.view.background.AuthListView;
import com.zanyun.tms.view.background.AuthView;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

import static com.zanyun.tms.constants.UrlConstants.*;
import static com.zanyun.tms.constants.UrlConstants.LIST;

@RestController
@RequestMapping("/background/auth")
public class AuthController {
    private static final Logger logger = LoggerFactory.getLogger(AuthController.class);

    @Autowired
    private SessionContext sessionContext;

    @Autowired
    private AuthMapper authMapper;

    @RequestMapping(value = LIST,method = RequestMethod.GET)
    @LoginRequired
    public AuthListView list(){
        AuthListView view = new AuthListView();
        List<AuthView> list = authMapper.selectViewList();
        view.setList(list);
        return view;
    }
}
