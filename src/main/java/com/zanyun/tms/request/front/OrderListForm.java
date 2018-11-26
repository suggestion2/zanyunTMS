package com.zanyun.tms.request.front;

import com.sug.core.platform.web.pagination.PaginationForm;

public class OrderListForm extends PaginationForm{
    private Integer status;

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }
}
