package com.zanyun.tms.controller.api.background;

import com.sug.core.platform.crypto.MD5;
import com.sug.core.platform.dingtalk.service.DingtalkCommonService;
import com.sug.core.platform.exception.ForbiddenException;
import com.sug.core.platform.exception.ResourceNotFoundException;
import com.sug.core.platform.web.rest.exception.InvalidRequestException;
import com.sug.core.rest.view.SuccessView;
import com.zanyun.tms.constants.background.UserConstants;
import com.zanyun.tms.context.background.SessionContext;
import com.zanyun.tms.domain.background.Department;
import com.zanyun.tms.domain.background.User;
import com.zanyun.tms.domain.background.UserLog;
import com.zanyun.tms.interceptor.background.AuthRequired;
import com.zanyun.tms.interceptor.background.LoginRequired;
import com.zanyun.tms.mapper.AuthMapper;
import com.zanyun.tms.mapper.DepartmentMapper;
import com.zanyun.tms.mapper.UserLogMapper;
import com.zanyun.tms.mapper.UserMapper;
import com.zanyun.tms.request.background.*;
import com.zanyun.tms.view.background.DepartmentListView;
import com.zanyun.tms.view.background.UserListView;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.util.Objects;

import static com.zanyun.tms.constants.UrlConstants.*;

@RestController
@RequestMapping("/background/user")
public class UserController {
    private static final Logger logger = LoggerFactory.getLogger(UserController.class);

    @Autowired
    private SessionContext sessionContext;

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private UserLogMapper userLogMapper;

    @Autowired
    private DepartmentMapper departmentMapper;

    @Autowired
    private AuthMapper authMapper;

    @Autowired
    private DingtalkCommonService dingtalkCommonService;

    @Value("${spring.profiles.active:@null}")
    private String env;

    @RequestMapping(value = LOGIN,method = RequestMethod.POST)
    public User login(@Valid @RequestBody LoginForm form, HttpServletRequest request){
        User user = userMapper.selectByPhone(form.getPhone());
        if(Objects.isNull(user)){
            throw new ResourceNotFoundException("用户不存在");
        }

        if(user.getStatus().equals(UserConstants.DISABLED)){
            throw new ForbiddenException("用户已被禁用");
        }

        if(!user.getPassword().equals(MD5.encrypt(form.getPassword()))){
            throw new InvalidRequestException("密码错误");
        }

        sessionContext.invalidate();

        sessionContext.setUserId(user.getId());
        sessionContext.setDepartmentId(user.getDepartmentId());
        sessionContext.setAvailable(user.getStatus().equals(UserConstants.AVAILABLE));
        sessionContext.setAdmin(user.getAdmin() > 0);
        sessionContext.setAuthList(!sessionContext.isAdmin() ?
                authMapper.selectListByDepartmentId(user.getDepartmentId()) : authMapper.selectList(null));

        UserLog userLog = new UserLog();
        userLog.setIpAddress("dev".equalsIgnoreCase(env)?request.getRemoteAddr():request.getHeader("X-Real-IP"));
        userLog.setUserName(user.getName());
        userLog.setUserId(user.getId());
        userLog.setUserPhone(user.getPhone());

        userLogMapper.insert(userLog);

        return user;
    }

    @RequestMapping(value = CURRENT,method = RequestMethod.GET)
    @LoginRequired
    public User current(){
        return userMapper.selectById(sessionContext.getUserId());
    }

    @RequestMapping(value = "/forgetPwd",method = RequestMethod.PUT)
    public SuccessView forgetPwd(@Valid @RequestBody ForgetPwdForm form){
        User user = userMapper.selectByPhone(form.getPhone());

        if(Objects.isNull(user)){
            throw new ResourceNotFoundException("手机号未注册");
        }

        if(user.getStatus().equals(UserConstants.DISABLED)){
            throw new ForbiddenException("用户已被禁用");
        }

        if(!sessionContext.validCaptcha(form.getPhone(),form.getCaptcha())){
            throw new InvalidRequestException("验证码错误");
        }

        user.setPassword(MD5.encrypt(form.getPassword()));
        user.setStatus(UserConstants.AVAILABLE);
        userMapper.update(user);

        sessionContext.setAvailable(user.getStatus().equals(UserConstants.AVAILABLE));

        return new SuccessView();
    }

    @RequestMapping(value = CHANGE_PASSWORD,method = RequestMethod.PUT)
    @LoginRequired
    public SuccessView changePwd(@Valid @RequestBody ChangePwdForm form){
        User user = userMapper.selectById(sessionContext.getUserId());
        if(!user.getPassword().equals(MD5.encrypt(form.getOriginPwd()))){
            throw new InvalidRequestException("错误的原密码");
        }

        user.setPassword(MD5.encrypt(form.getNewPwd()));
        user.setStatus(UserConstants.AVAILABLE);
        userMapper.update(user);

        sessionContext.setAvailable(user.getStatus().equals(UserConstants.AVAILABLE));

        return new SuccessView();
    }

    @RequestMapping(value = INIT_PASSWORD,method = RequestMethod.PUT)
    @LoginRequired
    @AuthRequired
    public String initPwd(@Valid @RequestBody InitPwdForm form){
        User user = userMapper.selectById(form.getUserId());
        if(Objects.isNull(user)){
            throw new ResourceNotFoundException("用户未找到");
        }

        user.setPassword(MD5.encrypt("123456"));
        user.setStatus(UserConstants.CREATED);
        userMapper.update(user);

        return "success";
    }

    @RequestMapping(value = CREATE,method = RequestMethod.POST)
    @LoginRequired
    @AuthRequired
    public SuccessView create(@Valid @RequestBody UserCreateForm form){
        User user = userMapper.selectByPhone(form.getPhone());
        if(Objects.nonNull(user)){
            throw new InvalidRequestException("用户手机已存在");
        }

        user = new User();

        BeanUtils.copyProperties(form,user);
        user.setPassword(MD5.encrypt("123456"));
        user.setStatus(1);

        userMapper.insert(user);

        try {
            String dingUserId = dingtalkCommonService.createUser(user.getName(),user.getPhone());
            user.setDingUserId(dingUserId);
            userMapper.update(user);
        }catch (Exception e){
            throw new InvalidRequestException("钉钉用户创建失败");
        }

        try {
            Department department = departmentMapper.selectById(form.getDepartmentId());
            if(StringUtils.hasText(department.getDingChatId())){
                dingtalkCommonService.updateChat(department.getDingChatId(),department.getChatName(),user.getDingUserId(),null);
            }
        }catch (Exception e){
            throw new InvalidRequestException("用户加入钉钉群失败");
        }

        return new SuccessView();
    }

    @RequestMapping(value = ENABLED,method = RequestMethod.PUT)
    @LoginRequired
    @AuthRequired
    public SuccessView enabled(@Valid @RequestBody UserUsableForm form){
        User user = userMapper.selectById(form.getId());
        if(Objects.isNull(user)){
            throw new ResourceNotFoundException("用户未找到");
        }

        if(!user.getStatus().equals(UserConstants.DISABLED)){
            throw new InvalidRequestException("错误的用户状态");
        }

        user.setPassword(MD5.encrypt("123456"));
        user.setStatus(UserConstants.CREATED);

        userMapper.update(user);

        try {
            Department department = departmentMapper.selectById(user.getDepartmentId());
            if(StringUtils.hasText(department.getDingChatId())){
                dingtalkCommonService.updateChat(department.getDingChatId(),department.getChatName(),user.getDingUserId(),null);
            }
        }catch (Exception e){
            throw new InvalidRequestException("用户加入钉钉群失败");
        }

        return new SuccessView();
    }

    @RequestMapping(value = DISABLED,method = RequestMethod.PUT)
    @LoginRequired
    @AuthRequired
    public SuccessView disabled(@Valid @RequestBody UserUsableForm form){
        User user = userMapper.selectById(form.getId());
        if(Objects.isNull(user)){
            throw new ResourceNotFoundException("用户未找到");
        }

        if(user.getAdmin() > 0){
            throw new InvalidRequestException("不能禁用超级管理员");
        }

        if(user.getStatus().equals(UserConstants.DISABLED)){
            throw new InvalidRequestException("错误的用户状态");
        }

        user.setStatus(UserConstants.DISABLED);

        userMapper.update(user);

        try {
            Department department = departmentMapper.selectById(user.getDepartmentId());
            if(StringUtils.hasText(department.getDingChatId())){
                dingtalkCommonService.updateChat(department.getDingChatId(),department.getChatName(),null,user.getDingUserId());
            }
        }catch (Exception e){
            throw new InvalidRequestException("用户退出钉钉群失败");
        }

        return new SuccessView();
    }

    @RequestMapping(value = LIST,method = RequestMethod.POST)
    @LoginRequired
    @AuthRequired
    public UserListView list(@Valid @RequestBody UserListForm form){
        UserListView view = new UserListView();
        view.setList(userMapper.selectViewList(form.getQueryMap()));
        view.setCount(userMapper.selectCount(form.getQueryMap()));

        return view;
    }

    @RequestMapping(value = DETAIL + ID,method = RequestMethod.GET)
    @LoginRequired
    @AuthRequired
    public User getById(@PathVariable Integer id){
        return userMapper.selectById(id);
    }

    @RequestMapping(value = UPDATE,method = RequestMethod.PUT)
    @LoginRequired
    @AuthRequired
    public SuccessView update(@Valid @RequestBody UserUpdateForm form){
        User user = userMapper.selectById(form.getId());
        if(Objects.isNull(user)){
            throw new ResourceNotFoundException("用户未找到");
        }

        Integer originDepartmentId = user.getDepartmentId();
        Integer newDepartmentId = form.getDepartmentId();

        user.setDepartmentId(form.getDepartmentId());
        userMapper.update(user);

        Department originDepartment = departmentMapper.selectById(originDepartmentId);
        if(StringUtils.hasText(originDepartment.getDingChatId())){
            try{
                dingtalkCommonService.updateChat(originDepartment.getDingChatId(),originDepartment.getChatName(),null,user.getDingUserId());
            }catch (Exception e){
                throw new InvalidRequestException("用户退出原部门群失败",e);
            }
        }

        Department newDepartment = departmentMapper.selectById(newDepartmentId);
        if(StringUtils.hasText(newDepartment.getDingChatId())){
            try{
                dingtalkCommonService.updateChat(newDepartment.getDingChatId(),newDepartment.getChatName(),user.getDingUserId(),null);
            }catch (Exception e){
                throw new InvalidRequestException("用户加入新部门群失败",e);
            }
        }

        return new SuccessView();
    }

    @RequestMapping(value = "/department" + LIST,method = RequestMethod.GET)
    @LoginRequired
    public DepartmentListView departmentList(){
        DepartmentListView view = new DepartmentListView();
        view.setList(departmentMapper.selectList(null));
        return view;
    }
}
