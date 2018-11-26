package com.zanyun.tms.request.front;

import com.sug.core.util.RegexUtils;
import org.hibernate.validator.constraints.NotEmpty;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;
import java.util.Date;

public class DriverCompleteInfoForm {
    @Pattern(regexp = RegexUtils.REGEX_CHINESE,message = "请输入中文")
    @Size(min = 2,max = 6,message = "长度在2到6之间")
    private String name;

    @Pattern(regexp = RegexUtils.REGEX_CHINESE,message = "请输入中文")
    private String province;
    @Pattern(regexp = RegexUtils.REGEX_CHINESE,message = "请输入中文")
    private String city;
    @Pattern(regexp = RegexUtils.REGEX_CHINESE,message = "请输入中文")
    private String county;

    private String address;

    private String portraitUrl;
    @NotEmpty
    private String gender;
    @NotEmpty
    private String licenseType;
    @NotEmpty
    private String licenseNum;
    @NotEmpty
    private String drivingExp;
    @NotEmpty
    private String licenseUrl;
    @NotNull
    private Date licenseEffTime;
    @NotNull
    private Date licenseStartTime;
    @NotEmpty
    private String expiredTime;
    @NotEmpty
    private String dLicenseNum;
    @NotEmpty
    private String engineNum;
    @NotEmpty
    private String dLicenseUrl;
    @NotEmpty
    private String model;


    private String taskProvince1;

    private String taskCity1;

    private String taskCounty1;

    private String taskProvince2;

    private String taskCity2;

    private String taskCounty2;


    private String taskProvince3;

    private String taskCity3;

    private String taskCounty3;

    private String taskProvince4;

    private String taskCity4;

    private String taskCounty4;

    @NotEmpty
    private String licensePlate;

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

    public String getDrivingExp() {
        return drivingExp;
    }

    public void setDrivingExp(String drivingExp) {
        this.drivingExp = drivingExp;
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

    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
    }

    public String getTaskProvince1() {
        return taskProvince1;
    }

    public void setTaskProvince1(String taskProvince1) {
        this.taskProvince1 = taskProvince1;
    }

    public String getTaskCity1() {
        return taskCity1;
    }

    public void setTaskCity1(String taskCity1) {
        this.taskCity1 = taskCity1;
    }

    public String getTaskCounty1() {
        return taskCounty1;
    }

    public void setTaskCounty1(String taskCounty1) {
        this.taskCounty1 = taskCounty1;
    }

    public String getTaskProvince2() {
        return taskProvince2;
    }

    public void setTaskProvince2(String taskProvince2) {
        this.taskProvince2 = taskProvince2;
    }

    public String getTaskCity2() {
        return taskCity2;
    }

    public void setTaskCity2(String taskCity2) {
        this.taskCity2 = taskCity2;
    }

    public String getTaskCounty2() {
        return taskCounty2;
    }

    public void setTaskCounty2(String taskCounty2) {
        this.taskCounty2 = taskCounty2;
    }

    public String getLicensePlate() {
        return licensePlate;
    }

    public void setLicensePlate(String licensePlate) {
        this.licensePlate = licensePlate;
    }

    public String getTaskProvince3() {
        return taskProvince3;
    }

    public void setTaskProvince3(String taskProvince3) {
        this.taskProvince3 = taskProvince3;
    }

    public String getTaskCity3() {
        return taskCity3;
    }

    public void setTaskCity3(String taskCity3) {
        this.taskCity3 = taskCity3;
    }

    public String getTaskCounty3() {
        return taskCounty3;
    }

    public void setTaskCounty3(String taskCounty3) {
        this.taskCounty3 = taskCounty3;
    }

    public String getTaskProvince4() {
        return taskProvince4;
    }

    public void setTaskProvince4(String taskProvince4) {
        this.taskProvince4 = taskProvince4;
    }

    public String getTaskCity4() {
        return taskCity4;
    }

    public void setTaskCity4(String taskCity4) {
        this.taskCity4 = taskCity4;
    }

    public String getTaskCounty4() {
        return taskCounty4;
    }

    public void setTaskCounty4(String taskCounty4) {
        this.taskCounty4 = taskCounty4;
    }
}
