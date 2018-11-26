package com.zanyun.tms.request.front;

import javax.validation.constraints.NotNull;

public class OrderTakeForm {
    @NotNull
    private Integer id;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }
}
