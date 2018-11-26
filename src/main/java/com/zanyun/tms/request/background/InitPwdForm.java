package com.zanyun.tms.request.background;

import javax.validation.constraints.NotNull;

public class InitPwdForm {

    @NotNull
    private Integer userId;

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }
}
