package com.zanyun.tms.request.front;

import com.sug.core.util.RegexUtils;

import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

public class OwnerPersonCompleteInfoForm {
    @Pattern(regexp = RegexUtils.REGEX_CHINESE,message = "请输入中文")
    @Size(min = 2,max = 6,message = "长度在2到6之间")
    private String name;

    @Pattern(regexp = RegexUtils.REGEX_IDCARD,message = "请输入正确身份证号")
    private String idCardNum;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getIdCardNum() {
        return idCardNum;
    }

    public void setIdCardNum(String idCardNum) {
        this.idCardNum = idCardNum;
    }
}
