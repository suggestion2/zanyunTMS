package com.zanyun.tms.request.background;

import com.sug.core.util.RegexUtils;
import org.hibernate.validator.constraints.NotEmpty;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;

/**
 * Created by Administrator on 2017/10/7.
 */
public class UserCreateForm {
    @NotNull
    private Integer departmentId;
    @NotEmpty
    private String name;
    @Pattern(regexp = RegexUtils.REGEX_MOBILE,message = "错误的手机格式")
    private String phone;

    public Integer getDepartmentId() {
        return departmentId;
    }

    public void setDepartmentId(Integer departmentId) {
        this.departmentId = departmentId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }
}
