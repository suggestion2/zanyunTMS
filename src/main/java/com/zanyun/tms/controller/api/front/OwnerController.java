package com.zanyun.tms.controller.api.front;

import com.sug.core.platform.crypto.MD5;
import com.sug.core.platform.exception.ForbiddenException;
import com.sug.core.platform.exception.ResourceNotFoundException;
import com.sug.core.platform.exception.UserAuthorizationException;
import com.sug.core.platform.web.rest.exception.InvalidRequestException;
import com.sug.core.platform.wechat.response.WeChatUserInfoResponse;
import com.zanyun.tms.context.front.SessionContext;
import com.zanyun.tms.domain.front.Owner;
import com.zanyun.tms.interceptor.front.OwnerLoginRequired;
import com.zanyun.tms.interceptor.front.WeChatLoginRequired;
import com.zanyun.tms.mapper.OwnerMapper;
import com.zanyun.tms.request.front.*;
import com.zanyun.tms.service.WeChatService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import javax.validation.Valid;
import java.util.Objects;

import static com.zanyun.tms.constants.UrlConstants.*;

@RestController
@RequestMapping(API_OWNER)
public class OwnerController {
    @Autowired
    private OwnerMapper ownerMapper;

    @Autowired
    private SessionContext sessionContext;

    @Autowired
    private WeChatService weChatService;

    @RequestMapping(value = REGISTER, method = RequestMethod.POST)
    @WeChatLoginRequired
    public String register(@Valid @RequestBody RegisterForm form) {
        if (!sessionContext.validCaptcha(form.getPhone(), form.getCaptcha())) {
            throw new InvalidRequestException("错误的验证码");
        }

        if (Objects.nonNull(ownerMapper.selectByPhone(form.getPhone()))) {
            throw new InvalidRequestException("手机号已注册");
        }

        if (sessionContext.getWeChatBrowser()
                && !Objects.isNull(ownerMapper.selectByOpenId(sessionContext.getWeChatOAuthEntity().getOpenid()))) {
            throw new ForbiddenException("该微信账号已绑定其他账号");
        }

        Owner owner = new Owner();
        owner.setPhone(form.getPhone());
        owner.setPassword(MD5.encrypt(form.getPassword()));
        owner.setName(form.getName());

        if (sessionContext.getWeChatBrowser()) {
            owner.setWechatPubOpenId(sessionContext.getWeChatOAuthEntity().getOpenid());
            WeChatUserInfoResponse info = weChatService.getWeChatUserInfo();
            owner.setWechatName(info.getNickname());
            owner.setWechatHeadImg(info.getHeadimgurl());
        }

        ownerMapper.insert(owner);
        sessionContext.removeCaptcha();
        sessionContext.setOwnerId(owner.getId());

        return "success";
    }

    @RequestMapping(value = CHANGE_PASSWORD, method = RequestMethod.PUT)
    @WeChatLoginRequired
    public String changePwd(@Valid @RequestBody ChangePwdForm form) {
        Owner owner = ownerMapper.selectByPhone(form.getPhone());

        if (Objects.isNull(owner)) {
            throw new ResourceNotFoundException("账号不存在");
        }

        if (sessionContext.getWeChatBrowser()
                && !sessionContext.getWeChatOAuthEntity().getOpenid().equalsIgnoreCase(owner.getWechatPubOpenId())) {
            throw new ForbiddenException("当前微信账号无权限");
        }

        if (!sessionContext.validCaptcha(form.getPhone(), form.getCaptcha())) {
            throw new InvalidRequestException("错误的验证码");
        }

        owner.setPassword(MD5.encrypt(form.getPassword()));

        ownerMapper.update(owner);
        sessionContext.removeCaptcha();

        return "success";
    }

    @RequestMapping(value = LOGIN, method = RequestMethod.POST)
    @WeChatLoginRequired
    public String login(@Valid @RequestBody LoginForm form) {
        Owner owner = ownerMapper.selectByPhone(form.getPhone());

        if (Objects.isNull(owner)) {
            throw new ResourceNotFoundException("账号不存在");
        }

        if (sessionContext.getWeChatBrowser()) {
            String sessionOpenId = sessionContext.getWeChatOAuthEntity().getOpenid();
            Owner selectByOpenId = ownerMapper.selectByOpenId(sessionOpenId);

            if(Objects.nonNull(selectByOpenId) && !selectByOpenId.getId().equals(owner.getId())){
                    throw new ForbiddenException("该微信账号已绑定其他账户");
            }

            if(Objects.isNull(selectByOpenId) && StringUtils.hasText(owner.getWechatPubOpenId())){
                throw new ForbiddenException("该账户已绑定其他微信账号");
            }
        }

        if (!owner.getPassword().equalsIgnoreCase(MD5.encrypt(form.getPassword()))) {
            throw new InvalidRequestException("密码错误");
        }

        if (sessionContext.getWeChatBrowser()) {
            boolean isChange = false;

            if (!StringUtils.hasText(owner.getWechatPubOpenId())) {
                owner.setWechatPubOpenId(sessionContext.getWeChatOAuthEntity().getOpenid());
                isChange = true;
            }

            WeChatUserInfoResponse info = weChatService.getWeChatUserInfo();

            if(!StringUtils.hasText(owner.getWechatName())){
                owner.setWechatName(info.getNickname());
                isChange = true;
            }

            if(!StringUtils.hasText(owner.getWechatHeadImg())){
                owner.setWechatHeadImg(info.getHeadimgurl());
                isChange = true;
            }

            if (isChange) {
                ownerMapper.update(owner);
            }
        }
        sessionContext.setOwnerId(owner.getId());

        return "success";
    }

    @RequestMapping(value = CURRENT, method = RequestMethod.GET)
    @OwnerLoginRequired
    public Owner getCurrentOwner() {
        return getCurrentOwnerBySession();
    }

    private Owner getCurrentOwnerBySession() {
        if (Objects.isNull(sessionContext.getOwnerId())) {
            throw new UserAuthorizationException("请登录");
        }

        return ownerMapper.selectById(sessionContext.getOwnerId());
    }

    @RequestMapping(value = UPDATE, method = RequestMethod.PUT)
    @OwnerLoginRequired
    public String changeName(@Valid @RequestBody ChangeNameForm form) {
        Owner owner = getCurrentOwner();
        owner.setName(form.getName());
        ownerMapper.update(owner);

        return "success";
    }
}
