package com.zanyun.tms.request.front;

import com.sug.core.util.RegexUtils;
import org.hibernate.validator.constraints.NotEmpty;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;
import java.util.Date;

public class OrderCreateForm {

    @NotNull
    private Integer ownerType;
    @Pattern(regexp = RegexUtils.REGEX_CHINESE,message = "请输入中文")
    private String ownerName;

    private String ownerIdCardNum;
    private String companyName;
    private String companyLicenseCode;
    private String companyProvince;
    private String companyCity;
    private String companyCounty;
    private String companyAddr;

    private Date loadTime;
    @Pattern(regexp = RegexUtils.REGEX_CHINESE,message = "请输入中文")
    @Size(min = 2,max = 6,message = "长度在2到6之间")
    private String loadContact;
    @Pattern(regexp = "^1[3-8]{1}\\d{9}$", message = "请输入正确的手机号码！")
    private String loadPhone;
    @Pattern(regexp = RegexUtils.REGEX_CHINESE,message = "请输入中文")
    @Size(min = 2,max = 6,message = "长度在2到6之间")
    private String dischargeContact;
    @Pattern(regexp = "^1[3-8]{1}\\d{9}$", message = "请输入正确的手机号码！")
    private String dischargePhone;
    @Pattern(regexp = RegexUtils.REGEX_CHINESE,message = "请输入中文")
    private String oriProvince;
    @Pattern(regexp = RegexUtils.REGEX_CHINESE,message = "请输入中文")
    private String oriCity;
    @Pattern(regexp = RegexUtils.REGEX_CHINESE,message = "请输入中文")
    private String oriCounty;
    @Pattern(regexp = "^[\\u4E00-\\u9FA5a-zA-Z0-9]+$",message = "请输入中文,英文大小写,数字")
    private String oriAddress;
    @Pattern(regexp = "^\\d{1,3}.\\d{3,6}$",message = "错误的格式")
    private String oriLong;
    @Pattern(regexp = "^\\d{1,2}.\\d{3,6}$",message = "错误的格式")
    private String oriLat;
    @Pattern(regexp = RegexUtils.REGEX_CHINESE,message = "请输入中文")
    private String arrProvince;
    @Pattern(regexp = RegexUtils.REGEX_CHINESE,message = "请输入中文")
    private String arrCity;
    @Pattern(regexp = RegexUtils.REGEX_CHINESE,message = "请输入中文")
    private String arrCounty;
    @Pattern(regexp = "^[\\u4E00-\\u9FA5a-zA-Z0-9]+$",message = "请输入中文,英文大小写,数字")
    private String arrAddress;
    @Pattern(regexp = "^\\d{1,3}.\\d{3,6}$",message = "错误的格式")
    private String arrLong;
    @Pattern(regexp = "^\\d{1,2}.\\d{3,6}$",message = "错误的格式")
    private String arrLat;
    @NotEmpty
    private String cargoType;
    @NotEmpty
    private String cargoDesc;
    @NotNull
    private Double ton;

    private Integer cube;

    private Integer pieces;

    private Double cargoValue;
    @NotNull
    private Integer type;

    @Pattern(regexp = "^\\d{1,6}(.\\d{1,2})?$",message = "错误的格式")
    private String ownerFreight;

    private String remarks;

//    @NotNull
    private Integer oriStationId;
//    @NotNull
    private Integer arrStationId;

//    @NotEmpty
    private String oriStationName;
//    @NotEmpty
    private String arrStationName;

    private Date landTime;

    private String dischargeCompany;

    private String transportationModel;

    public Date getLoadTime() {
        return loadTime;
    }

    public void setLoadTime(Date loadTime) {
        this.loadTime = loadTime;
    }

    public String getLoadContact() {
        return loadContact;
    }

    public void setLoadContact(String loadContact) {
        this.loadContact = loadContact;
    }

    public String getLoadPhone() {
        return loadPhone;
    }

    public void setLoadPhone(String loadPhone) {
        this.loadPhone = loadPhone;
    }

    public String getDischargeContact() {
        return dischargeContact;
    }

    public void setDischargeContact(String dischargeContact) {
        this.dischargeContact = dischargeContact;
    }

    public String getDischargePhone() {
        return dischargePhone;
    }

    public void setDischargePhone(String dischargePhone) {
        this.dischargePhone = dischargePhone;
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

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public String getOwnerFreight() {
        return ownerFreight;
    }

    public void setOwnerFreight(String ownerFreight) {
        this.ownerFreight = ownerFreight;
    }

    public Integer getOwnerType() {
        return ownerType;
    }

    public void setOwnerType(Integer ownerType) {
        this.ownerType = ownerType;
    }

    public String getOwnerName() {
        return ownerName;
    }

    public void setOwnerName(String ownerName) {
        this.ownerName = ownerName;
    }

    public String getOwnerIdCardNum() {
        return ownerIdCardNum;
    }

    public void setOwnerIdCardNum(String ownerIdCardNum) {
        this.ownerIdCardNum = ownerIdCardNum;
    }

    public String getCompanyName() {
        return companyName;
    }

    public void setCompanyName(String companyName) {
        this.companyName = companyName;
    }

    public String getCompanyLicenseCode() {
        return companyLicenseCode;
    }

    public void setCompanyLicenseCode(String companyLicenseCode) {
        this.companyLicenseCode = companyLicenseCode;
    }

    public String getCompanyProvince() {
        return companyProvince;
    }

    public void setCompanyProvince(String companyProvince) {
        this.companyProvince = companyProvince;
    }

    public String getCompanyCity() {
        return companyCity;
    }

    public void setCompanyCity(String companyCity) {
        this.companyCity = companyCity;
    }

    public String getCompanyCounty() {
        return companyCounty;
    }

    public void setCompanyCounty(String companyCounty) {
        this.companyCounty = companyCounty;
    }

    public String getCompanyAddr() {
        return companyAddr;
    }

    public void setCompanyAddr(String companyAddr) {
        this.companyAddr = companyAddr;
    }

    public String getCargoType() {
        return cargoType;
    }

    public void setCargoType(String cargoType) {
        this.cargoType = cargoType;
    }

    public String getCargoDesc() {
        return cargoDesc;
    }

    public void setCargoDesc(String cargoDesc) {
        this.cargoDesc = cargoDesc;
    }

    public Double getTon() {
        return ton;
    }

    public void setTon(Double ton) {
        this.ton = ton;
    }

    public Integer getCube() {
        return cube;
    }

    public void setCube(Integer cube) {
        this.cube = cube;
    }

    public Integer getPieces() {
        return pieces;
    }

    public void setPieces(Integer pieces) {
        this.pieces = pieces;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    public Double getCargoValue() {
        return cargoValue;
    }

    public void setCargoValue(Double cargoValue) {
        this.cargoValue = cargoValue;
    }

    public Integer getOriStationId() {
        return oriStationId;
    }

    public void setOriStationId(Integer oriStationId) {
        this.oriStationId = oriStationId;
    }

    public Integer getArrStationId() {
        return arrStationId;
    }

    public void setArrStationId(Integer arrStationId) {
        this.arrStationId = arrStationId;
    }

    public String getOriStationName() {
        return oriStationName;
    }

    public void setOriStationName(String oriStationName) {
        this.oriStationName = oriStationName;
    }

    public String getArrStationName() {
        return arrStationName;
    }

    public void setArrStationName(String arrStationName) {
        this.arrStationName = arrStationName;
    }

    public Date getLandTime() {
        return landTime;
    }

    public void setLandTime(Date landTime) {
        this.landTime = landTime;
    }

    public String getDischargeCompany() {
        return dischargeCompany;
    }

    public void setDischargeCompany(String dischargeCompany) {
        this.dischargeCompany = dischargeCompany;
    }

    public String getTransportationModel() {
        return transportationModel;
    }

    public void setTransportationModel(String transportationModel) {
        this.transportationModel = transportationModel;
    }
}
