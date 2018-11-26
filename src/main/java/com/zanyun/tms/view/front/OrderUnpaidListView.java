package com.zanyun.tms.view.front;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.sug.core.util.jsonFormat.SimpleDateSerializer;

import java.util.Date;

public class OrderUnpaidListView {
    private Integer id;
    private String oriProvince;
    private String oriCity;
    private String oriCounty;
    private String arrProvince;
    private String arrCity;
    private String arrCounty;
    @JsonSerialize(using = SimpleDateSerializer.class)
    private Date loadTime;
    private Double driverFreight;

    private Double ton;
    private String cargoDesc;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
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

    public Double getTon() {
        return ton;
    }

    public void setTon(Double ton) {
        this.ton = ton;
    }

    public String getCargoDesc() {
        return cargoDesc;
    }

    public void setCargoDesc(String cargoDesc) {
        this.cargoDesc = cargoDesc;
    }
}
