package com.zanyun.tms.request.background;

import javax.validation.constraints.Size;

public class ChangePwdForm {

    @Size(min = 6,max = 20,message = "密码长度在6到20之间")
    private String originPwd;

    @Size(min = 6,max = 20,message = "密码长度在6到20之间")
    private String newPwd;

    public String getOriginPwd() {
        return originPwd;
    }

    public void setOriginPwd(String originPwd) {
        this.originPwd = originPwd;
    }

    public String getNewPwd() {
        return newPwd;
    }

    public void setNewPwd(String newPwd) {
        this.newPwd = newPwd;
    }
}
