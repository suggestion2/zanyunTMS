package com.zanyun.tms.request.front;

import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

public class RegisterForm {
    @Pattern(regexp = "^1[3-8]{1}\\d{9}$", message = "请输入正确的手机号码！")
    private String phone;

    @Pattern(regexp = "\\d{6}",message = "验证码格式错误")
    private String captcha;

    @Size(min = 6,max = 20,message = "密码长度在6到20之间")
    private String password;

    private String name;

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getCaptcha() {
        return captcha;
    }

    public void setCaptcha(String captcha) {
        this.captcha = captcha;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
