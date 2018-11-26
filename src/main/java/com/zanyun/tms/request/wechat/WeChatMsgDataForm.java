package com.zanyun.tms.request.wechat;

import org.springframework.beans.factory.annotation.Autowired;

public class WeChatMsgDataForm {
    private String value;
    private String color;

    @Autowired
    public WeChatMsgDataForm() {
    }

    public WeChatMsgDataForm(String value, String color) {
        this.value = value;
        this.color = color;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }
}
