package com.zanyun.tms.view.front;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.sug.core.util.jsonFormat.SimpleDateSerializer;

import java.util.Date;

public class OrderListView {
    private Integer id;
    private String number;
    private String oriProvince;
    private String oriCity;
    private String oriCounty;
    private String oriAddress;
    private String arrProvince;
    private String arrCity;
    private String arrCounty;
    private String arrAddress;
    @JsonSerialize(using = SimpleDateSerializer.class)
    private Date loadTime;
    private Double driverFreight;
    private Double ownerFreight;

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

    public String getOriAddress() {
        return oriAddress;
    }

    public void setOriAddress(String oriAddress) {
        this.oriAddress = oriAddress;
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

    public String getArrAddress() {
        return arrAddress;
    }

    public void setArrAddress(String arrAddress) {
        this.arrAddress = arrAddress;
    }

    public Date getLoadTime() {
        return loadTime;
    }

    public void setLoadTime(Date loadTime) {
        this.loadTime = loadTime;
    }

    public Double getDriverFreight() {
        return driverFreight;
    }

    public void setDriverFreight(Double driverFreight) {
        this.driverFreight = driverFreight;
    }

    public Double getOwnerFreight() {
        return ownerFreight;
    }

    public void setOwnerFreight(Double ownerFreight) {
        this.ownerFreight = ownerFreight;
    }
}
