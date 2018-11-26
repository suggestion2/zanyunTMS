package com.zanyun.tms.request.background;

import javax.validation.constraints.NotNull;

public class OrderStatusForm {
    @NotNull
    private Integer id;

    private Integer comDepartmentId;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getComDepartmentId() {
        return comDepartmentId;
    }

    public void setComDepartmentId(Integer comDepartmentId) {
        this.comDepartmentId = comDepartmentId;
    }
}
