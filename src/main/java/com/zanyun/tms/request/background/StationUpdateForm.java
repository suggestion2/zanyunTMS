package com.zanyun.tms.request.background;

import org.hibernate.validator.constraints.NotEmpty;

import javax.validation.constraints.NotNull;

public class StationUpdateForm {
    @NotNull
    private Integer id;
    @NotEmpty
    private String name;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
