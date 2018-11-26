package com.zanyun.tms.request.background;

import javax.validation.constraints.NotNull;

public class OrderCancelForm {
    @NotNull
    private Integer id;

    private String validateRemarks;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getValidateRemarks() {
        return validateRemarks;
    }

    public void setValidateRemarks(String validateRemarks) {
        this.validateRemarks = validateRemarks;
    }
}
