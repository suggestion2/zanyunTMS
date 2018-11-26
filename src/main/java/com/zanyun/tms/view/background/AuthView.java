package com.zanyun.tms.view.background;

import java.util.List;

public class AuthView {
    private Integer id;
    private String name;
    private String desc;
    private Integer parentId;
    private List<AuthView> subList;

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

    public List<AuthView> getSubList() {
        return subList;
    }

    public void setSubList(List<AuthView> subList) {
        this.subList = subList;
    }

    public Integer getParentId() {
        return parentId;
    }

    public void setParentId(Integer parentId) {
        this.parentId = parentId;
    }
}
