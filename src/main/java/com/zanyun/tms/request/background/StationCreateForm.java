package com.zanyun.tms.request.background;

import org.hibernate.validator.constraints.NotEmpty;

import javax.validation.constraints.Pattern;

public class StationCreateForm {
    @NotEmpty
    private String name;
    @NotEmpty
    private String province;
    @NotEmpty
    private String city;
    @NotEmpty
    private String county;
    @NotEmpty
    private String address;

    @Pattern(regexp = "^\\d{1,3}.\\d{3,6}$",message = "错误的格式")
    private String longitude;
    @Pattern(regexp = "^\\d{1,3}.\\d{3,6}$",message = "错误的格式")
    private String latitude;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getProvince() {
        return province;
    }

    public void setProvince(String province) {
        this.province = province;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getCounty() {
        return county;
    }

    public void setCounty(String county) {
        this.county = county;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getLongitude() {
        return longitude;
    }

    public void setLongitude(String longitude) {
        this.longitude = longitude;
    }

    public String getLatitude() {
        return latitude;
    }

    public void setLatitude(String latitude) {
        this.latitude = latitude;
    }
}
