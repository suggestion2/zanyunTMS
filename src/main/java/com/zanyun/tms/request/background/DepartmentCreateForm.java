package com.zanyun.tms.request.background;

import org.hibernate.validator.constraints.NotEmpty;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.util.List;

/**
 * Created by Administrator on 2017/10/7.
 */
public class DepartmentCreateForm {
    @NotEmpty
    private String name;

    private String desc;

    @NotNull
    @Size(min = 1)
    private List<Integer> authIdList;

    private String chatName;

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

    public String getChatName() {
        return chatName;
    }

    public void setChatName(String chatName) {
        this.chatName = chatName;
    }
}
