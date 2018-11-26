package com.zanyun.tms.request.front;

import javax.validation.constraints.NotNull;

public class OwnerCompleteTypeForm {
    @NotNull
    private Integer type;

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }
}
