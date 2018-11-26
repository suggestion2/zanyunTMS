package com.zanyun.tms.view.background;

import java.util.List;

public class DepartmentView{
    private Integer id;
    private String name;
    private String desc;
    private String dingChatId;
    private String chatName;
    private String chatPhone;

    private List<Integer> authIdList;

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

    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }

    public List<Integer> getAuthIdList() {
        return authIdList;
    }

    public void setAuthIdList(List<Integer> authIdList) {
        this.authIdList = authIdList;
    }

    public String getDingChatId() {
        return dingChatId;
    }

    public void setDingChatId(String dingChatId) {
        this.dingChatId = dingChatId;
    }

    public String getChatName() {
        return chatName;
    }

    public void setChatName(String chatName) {
        this.chatName = chatName;
    }

    public String getChatPhone() {
        return chatPhone;
    }

    public void setChatPhone(String chatPhone) {
        this.chatPhone = chatPhone;
    }
}
