package com.zanyun.tms.controller.api.background;

import com.sug.core.platform.web.pagination.PaginationView;
import com.zanyun.tms.domain.background.UserLog;
import com.zanyun.tms.interceptor.background.AuthRequired;
import com.zanyun.tms.interceptor.background.LoginRequired;
import com.zanyun.tms.mapper.UserLogMapper;
import com.zanyun.tms.request.background.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import javax.validation.Valid;

import static com.zanyun.tms.constants.UrlConstants.*;
import static com.zanyun.tms.constants.UrlConstants.LIST;

@RestController
@RequestMapping("/background/userLog")
public class UserLogController {
    private static final Logger logger = LoggerFactory.getLogger(UserLogController.class);

    @Autowired
    private UserLogMapper userLogMapper;

    @RequestMapping(value = LIST,method = RequestMethod.POST)
    @LoginRequired
    @AuthRequired
    public PaginationView<UserLog> list(@Valid @RequestBody ListSearchForm form){
        PaginationView<UserLog> view = new PaginationView<>();
        view.setList(userLogMapper.selectList(form.getQueryMap()));
        view.setCount(userLogMapper.selectCount(form.getQueryMap()));
        return view;
    }
}
