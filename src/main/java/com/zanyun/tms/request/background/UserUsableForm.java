package com.zanyun.tms.request.background;

import javax.validation.constraints.NotNull;

/**
 * Created by Administrator on 2017/10/7.
 */
public class UserUsableForm {
    @NotNull
    private Integer id;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }
}
