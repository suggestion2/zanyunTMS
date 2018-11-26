package com.zanyun.tms.request.background;

import javax.validation.constraints.NotNull;

public class ValidateForm {
    @NotNull
    private Integer id;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

}
