package com.zanyun.tms.view.background;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.sug.core.util.jsonFormat.SimpleDateSerializer;

import java.util.Date;

import static com.zanyun.tms.constants.DriverConstant.*;

public class DriverViewForList {
    private Integer id;
    private String name;
    private String phone;
    @JsonSerialize(using = SimpleDateSerializer.class)
    private Date createTime;
    private Integer status;
    private String statusName;

    private String taskAddress1;
    private String taskAddress2;
    private String taskAddress3;
    private String taskAddress4;

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

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getStatusName() {
        if(this.status == null){
            return "未知";
        }
        switch (this.status){
            case DRIVER_REJECT:
                return REJECT_NAME;
            case DRIVER_INCOMPLETE:
                return INCOMPLETE_NAME;
            case DRIVER_VALIDATE:
                return VALIDATE_NAME;
            case DRIVER_COMPLETE:
                return COMPLETE_NAME;
            default:
                return "未知";
        }
    }

    public String getTaskAddress1() {
        return taskAddress1;
    }

    public void setTaskAddress1(String taskAddress1) {
        this.taskAddress1 = taskAddress1;
    }

    public String getTaskAddress2() {
        return taskAddress2;
    }

    public void setTaskAddress2(String taskAddress2) {
        this.taskAddress2 = taskAddress2;
    }

    public String getTaskAddress3() {
        return taskAddress3;
    }

    public void setTaskAddress3(String taskAddress3) {
        this.taskAddress3 = taskAddress3;
    }

    public String getTaskAddress4() {
        return taskAddress4;
    }

    public void setTaskAddress4(String taskAddress4) {
        this.taskAddress4 = taskAddress4;
    }
}
