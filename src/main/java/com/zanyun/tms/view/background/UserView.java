package com.zanyun.tms.view.background;

import static com.zanyun.tms.constants.background.UserConstants.*;

public class UserView {
    private Integer id;
    private String name;
    private String phone;
    private Integer departmentId;
    private String department;
    private Integer status;
    private String statusName;

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

    public Integer getDepartmentId() {
        return departmentId;
    }

    public void setDepartmentId(Integer departmentId) {
        this.departmentId = departmentId;
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
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
            case DISABLED:
                return DISABLED_NAME;
            case CREATED:
                return CREATED_NAME;
            case AVAILABLE:
                return AVAILABLE_NAME;
            default:
                return "未知";
        }
    }
}
