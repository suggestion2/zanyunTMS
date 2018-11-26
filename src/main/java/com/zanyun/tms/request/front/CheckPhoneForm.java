package com.zanyun.tms.request.front;

import javax.validation.constraints.Pattern;

public class CheckPhoneForm {
    @Pattern(regexp = "^1[3-8]{1}\\d{9}$", message = "请输入正确的手机号码！")
    private String phone;

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }
}
