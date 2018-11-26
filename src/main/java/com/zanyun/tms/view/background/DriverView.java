package com.zanyun.tms.view.background;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.sug.core.util.jsonFormat.SimpleDateSerializer;

import java.util.Date;

public class DriverView {
    private Integer id;
    private String name;
    private String phone;
    private String wechatName;
    private String province;
    private String city;
    private String county;
    private String address;
    private String portraitUrl;
    private String gender;
    private String licenseType;
    private String licenseNum;
    private String drivingExp;
    private String licenseUrl;
    @JsonSerialize(using = SimpleDateSerializer.class)
    private Date licenseEffTime;
    @JsonSerialize(using = SimpleDateSerializer.class)
    private Date licenseStartTime;
    private String expiredTime;
    private String dLicenseNum;
    private String engineNum;
    private String dLicenseUrl;
    private Date createTime;
    private Date updateTime;
    private Integer updateBy;
    private Integer status;

    private String wechatHeadImg;

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

    public String getWechatName() {
        return wechatName;
    }

    public void setWechatName(String wechatName) {
        this.wechatName = wechatName;
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

    public String getPortraitUrl() {
        return portraitUrl;
    }

    public void setPortraitUrl(String portraitUrl) {
        this.portraitUrl = portraitUrl;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getLicenseType() {
        return licenseType;
    }

    public void setLicenseType(String licenseType) {
        this.licenseType = licenseType;
    }

    public String getLicenseNum() {
        return licenseNum;
    }

    public void setLicenseNum(String licenseNum) {
        this.licenseNum = licenseNum;
    }

    public String getDrivingExp() {
        return drivingExp;
    }

    public void setDrivingExp(String drivingExp) {
        this.drivingExp = drivingExp;
    }

    public String getLicenseUrl() {
        return licenseUrl;
    }

    public void setLicenseUrl(String licenseUrl) {
        this.licenseUrl = licenseUrl;
    }

    public Date getLicenseEffTime() {
        return licenseEffTime;
    }

    public void setLicenseEffTime(Date licenseEffTime) {
        this.licenseEffTime = licenseEffTime;
    }

    public Date getLicenseStartTime() {
        return licenseStartTime;
    }

    public void setLicenseStartTime(Date licenseStartTime) {
        this.licenseStartTime = licenseStartTime;
    }

    public String getExpiredTime() {
        return expiredTime;
    }

    public void setExpiredTime(String expiredTime) {
        this.expiredTime = expiredTime;
    }

    public String getdLicenseNum() {
        return dLicenseNum;
    }

    public void setdLicenseNum(String dLicenseNum) {
        this.dLicenseNum = dLicenseNum;
    }

    public String getEngineNum() {
        return engineNum;
    }

    public void setEngineNum(String engineNum) {
        this.engineNum = engineNum;
    }

    public String getdLicenseUrl() {
        return dLicenseUrl;
    }

    public void setdLicenseUrl(String dLicenseUrl) {
        this.dLicenseUrl = dLicenseUrl;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

    public Integer getUpdateBy() {
        return updateBy;
    }

    public void setUpdateBy(Integer updateBy) {
        this.updateBy = updateBy;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getWechatHeadImg() {
        return wechatHeadImg;
    }

    public void setWechatHeadImg(String wechatHeadImg) {
        this.wechatHeadImg = wechatHeadImg;
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
