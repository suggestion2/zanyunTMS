package com.zanyun.tms.request.background;

import com.sug.core.platform.web.pagination.PaginationForm;

public class TransportationListForm extends PaginationForm{
    private String content;

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }
}
