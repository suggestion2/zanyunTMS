package com.zanyun.tms.request.background;

import org.hibernate.validator.constraints.NotEmpty;

import javax.validation.constraints.NotNull;

public class OrderValidateForm {

    @NotNull
    private Integer id;
    @NotNull
    private Double driverFreight;
    @NotNull
    private Double infoFee;
    @NotEmpty
    private String driverPayType;
    @NotNull
    private Integer transDepartmentId;
    @NotNull
    private Double finalFreight;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Double getDriverFreight() {
        return driverFreight;
    }

    public void setDriverFreight(Double driverFreight) {
        this.driverFreight = driverFreight;
    }

    public String getDriverPayType() {
        return driverPayType;
    }

    public void setDriverPayType(String driverPayType) {
        this.driverPayType = driverPayType;
    }

    public Double getInfoFee() {
        return infoFee;
    }

    public void setInfoFee(Double infoFee) {
        this.infoFee = infoFee;
    }

    public Integer getTransDepartmentId() {
        return transDepartmentId;
    }

    public void setTransDepartmentId(Integer transDepartmentId) {
        this.transDepartmentId = transDepartmentId;
    }

    public Double getFinalFreight() {
        return finalFreight;
    }

    public void setFinalFreight(Double finalFreight) {
        this.finalFreight = finalFreight;
    }
}
