package com.zanyun.tms.domain.background;

import java.util.List;

/**
 * Created by Administrator on 2017/10/21.
 */
public class TransportationParams {
    private Integer id;
    private String name;
    private List<String> value;

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

    public List<String> getValue() {
        return value;
    }

    public void setValue(List<String> value) {
        this.value = value;
    }
}
