package com.zanyun.tms.request.front;

import org.hibernate.validator.constraints.NotEmpty;

public class ChangeNameForm {
    @NotEmpty
    private String name;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
