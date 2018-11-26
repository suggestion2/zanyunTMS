package com.zanyun.tms.request.front;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;

public class SendCaptchaForm {
    @Pattern(regexp = "^1[3-8]{1}\\d{9}$", message = "请输入正确的手机号码！")
    private String phone;

    @NotNull
    private Integer type;

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }
}
