package com.zanyun.tms.view.background;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.sug.core.util.jsonFormat.SimpleDateSerializer;

import java.util.Date;

import static com.zanyun.tms.constants.OrderConstants.*;

public class OrderViewForList {
    private Integer id;
    private String number;
    private String ownerName;
    private String ownerPhone;
    private String driverName;
    private String driverPhone;
    private String oriProvince;
    private String oriCity;
    private String oriCounty;
    private String arrProvince;
    private String arrCity;
    private String arrCounty;
    private Double ownerFreight;
    private Double driverFreight;
    @JsonSerialize(using = SimpleDateSerializer.class)
    private Date createTime;
    @JsonSerialize(using = SimpleDateSerializer.class)
    private Date loadTime;
    private Double cargoValue;
    private Double infoFee;
    private Integer status;
    private String statusName;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getNumber() {
        return number;
    }

    public void setNumber(String number) {
        this.number = number;
    }

    public String getOwnerName() {
        return ownerName;
    }

    public void setOwnerName(String ownerName) {
        this.ownerName = ownerName;
    }

    public String getOwnerPhone() {
        return ownerPhone;
    }

    public void setOwnerPhone(String ownerPhone) {
        this.ownerPhone = ownerPhone;
    }

    public String getDriverName() {
        return driverName;
    }

    public void setDriverName(String driverName) {
        this.driverName = driverName;
    }

    public String getDriverPhone() {
        return driverPhone;
    }

    public void setDriverPhone(String driverPhone) {
        this.driverPhone = driverPhone;
    }

    public String getOriProvince() {
        return oriProvince;
    }

    public void setOriProvince(String oriProvince) {
        this.oriProvince = oriProvince;
    }

    public String getOriCity() {
        return oriCity;
    }

    public void setOriCity(String oriCity) {
        this.oriCity = oriCity;
    }

    public String getOriCounty() {
        return oriCounty;
    }

    public void setOriCounty(String oriCounty) {
        this.oriCounty = oriCounty;
    }

    public String getArrProvince() {
        return arrProvince;
    }

    public void setArrProvince(String arrProvince) {
        this.arrProvince = arrProvince;
    }

    public String getArrCity() {
        return arrCity;
    }

    public void setArrCity(String arrCity) {
        this.arrCity = arrCity;
    }

    public String getArrCounty() {
        return arrCounty;
    }

    public void setArrCounty(String arrCounty) {
        this.arrCounty = arrCounty;
    }

    public Double getOwnerFreight() {
        return ownerFreight;
    }

    public void setOwnerFreight(Double ownerFreight) {
        this.ownerFreight = ownerFreight;
    }

    public Double getDriverFreight() {
        return driverFreight;
    }

    public void setDriverFreight(Double driverFreight) {
        this.driverFreight = driverFreight;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getLoadTime() {
        return loadTime;
    }

    public void setLoadTime(Date loadTime) {
        this.loadTime = loadTime;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public void setStatusName(String statusName) {
        this.statusName = statusName;
    }

    public Double getCargoValue() {
        return cargoValue;
    }

    public void setCargoValue(Double cargoValue) {
        this.cargoValue = cargoValue;
    }

    public String getStatusName() {
        if(this.status == null){
            return "未知";
        }
        switch (this.status){
            case CANCEL_STATUS:
                return CANCEL_STATUS_NAME;
            case CREATE_STATUS:
                return CREATE_STATUS_NAME;
            case VALIDATE_STATUS:
                return VALIDATE_STATUS_NAME;
            case LOCK_STATUS:
                return LOCK_STATUS_NAME;
            case PAID_STATUS:
                return PAID_STATUS_NAME;
            case TRANSPORT_STATUS:
                return TRANSPORT_STATUS_NAME;
            case COMPLETE_STATUS:
                return COMPLETE_STATUS_NAME;
            default:
                return "未知";
        }
    }

    public Double getInfoFee() {
        return infoFee;
    }

    public void setInfoFee(Double infoFee) {
        this.infoFee = infoFee;
    }
}
