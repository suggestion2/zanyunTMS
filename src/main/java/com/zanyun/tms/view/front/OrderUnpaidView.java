package com.zanyun.tms.view.front;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.sug.core.util.jsonFormat.SimpleDateTimeSerializer;

import java.util.Date;

public class OrderUnpaidView {
    private Integer id;
    @JsonSerialize(using = SimpleDateTimeSerializer.class)
    private Date loadTime;
    private String oriProvince;
    private String oriCity;
    private String oriCounty;
    private String oriLong;
    private String oriLat;
    private String arrProvince;
    private String arrCity;
    private String arrCounty;
    private String arrLong;
    private String arrLat;
    private String cargoType;
    private Double driverFreight;
    private String driverPayType;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Date getLoadTime() {
        return loadTime;
    }

    public void setLoadTime(Date loadTime) {
        this.loadTime = loadTime;
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

    public String getCargoType() {
        return cargoType;
    }

    public void setCargoType(String cargoType) {
        this.cargoType = cargoType;
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

    public String getOriLong() {
        return oriLong;
    }

    public void setOriLong(String oriLong) {
        this.oriLong = oriLong;
    }

    public String getOriLat() {
        return oriLat;
    }

    public void setOriLat(String oriLat) {
        this.oriLat = oriLat;
    }

    public String getArrLong() {
        return arrLong;
    }

    public void setArrLong(String arrLong) {
        this.arrLong = arrLong;
    }

    public String getArrLat() {
        return arrLat;
    }

    public void setArrLat(String arrLat) {
        this.arrLat = arrLat;
    }
}
