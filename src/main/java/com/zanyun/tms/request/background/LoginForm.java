package com.zanyun.tms.request.background;

import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

public class LoginForm {
    @Pattern(regexp = "^1[3-8]{1}\\d{9}$", message = "请输入正确的手机号码！")
    private String phone;

    @Size(min = 6,max = 20,message = "密码长度在6到20之间")
    private String password;

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
