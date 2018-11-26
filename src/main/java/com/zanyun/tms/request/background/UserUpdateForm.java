package com.zanyun.tms.request.background;

import javax.validation.constraints.NotNull;

/**
 * Created by Administrator on 2017/10/7.
 */
public class UserUpdateForm {
    @NotNull
    private Integer id;

    @NotNull
    private Integer departmentId;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getDepartmentId() {
        return departmentId;
    }

    public void setDepartmentId(Integer departmentId) {
        this.departmentId = departmentId;
    }
}
