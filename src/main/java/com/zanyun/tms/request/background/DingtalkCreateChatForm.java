package com.zanyun.tms.request.background;

import org.hibernate.validator.constraints.NotEmpty;

public class DingtalkCreateChatForm {
    @NotEmpty
    private String chatName;

    @NotEmpty
    private String phone;

    public String getChatName() {
        return chatName;
    }

    public void setChatName(String chatName) {
        this.chatName = chatName;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }
}
