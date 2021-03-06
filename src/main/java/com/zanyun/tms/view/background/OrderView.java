package com.zanyun.tms.view.background;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.sug.core.util.jsonFormat.SimpleDateSerializer;
import com.sug.core.util.jsonFormat.SimpleDateTimeSerializer;

import java.util.Date;

import static com.zanyun.tms.constants.OrderConstants.*;

public class OrderView {
    private Integer id;
    private String number;
    private Integer ownerId;
    private Integer driverId;
    private Integer ownerType;
    private String ownerTypeName;
    private String ownerPhone;
    private String ownerName;
    private String driverName;
    private String driverPhone;
    @JsonSerialize(using = SimpleDateSerializer.class)
    private Date loadTime;
    private String loadContact;
    private String loadPhone;
    private String dischargeContact;
    private String dischargePhone;
    private String oriProvince;
    private String oriCity;
    private String oriCounty;
    private String oriAddress;
    private String oriLong;
    private String oriLat;
    private String arrProvince;
    private String arrCity;
    private String arrCounty;
    private String arrAddress;
    private String arrLong;
    private String arrLat;
    private String cargoType;
    private String cargoDesc;
    private Double ton;
    private Integer cube;
    private Integer pieces;
    private Double cargoValue;
    private Double ownerFreight;
    private Double driverFreight;
    private String driverPayType;
    @JsonSerialize(using = SimpleDateTimeSerializer.class)
    private Date createTime;
    private Integer updateBy;
    private Integer type;
    private Integer status;
    private String remarks;
    private String validateRemarks;

    private String statusName;

    private String ownerIdCardNum;
    private String companyName;
    private String companyLicenseCode;
    private String companyProvince;
    private String companyCity;
    private String companyCounty;
    private String companyAddr;

    private Double infoFee;

    private String transportationModel;

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

    public Integer getOwnerId() {
        return ownerId;
    }

    public void setOwnerId(Integer ownerId) {
        this.ownerId = ownerId;
    }

    public Integer getDriverId() {
        return driverId;
    }

    public void setDriverId(Integer driverId) {
        this.driverId = driverId;
    }

    public Integer getOwnerType() {
        return ownerType;
    }

    public void setOwnerType(Integer ownerType) {
        this.ownerType = ownerType;
    }

    public String getOwnerPhone() {
        return ownerPhone;
    }

    public void setOwnerPhone(String ownerPhone) {
        this.ownerPhone = ownerPhone;
    }

    public String getOwnerName() {
        return ownerName;
    }

    public void setOwnerName(String ownerName) {
        this.ownerName = ownerName;
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

    public Double getCargoValue() {
        return cargoValue;
    }

    public void setCargoValue(Double cargoValue) {
        this.cargoValue = cargoValue;
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

    public String getDriverPayType() {
        return driverPayType;
    }

    public void setDriverPayType(String driverPayType) {
        this.driverPayType = driverPayType;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Integer getUpdateBy() {
        return updateBy;
    }

    public void setUpdateBy(Integer updateBy) {
        this.updateBy = updateBy;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    public String getValidateRemarks() {
        return validateRemarks;
    }

    public void setValidateRemarks(String validateRemarks) {
        this.validateRemarks = validateRemarks;
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

    public Double getInfoFee() {
        return infoFee;
    }

    public void setInfoFee(Double infoFee) {
        this.infoFee = infoFee;
    }

    public String getOwnerTypeName() {
        if(this.ownerType == null){
            return "未知";
        }
        switch (this.ownerType){
            case PERSON_TYPE:
                return PERSON_NAME;
            case COMPANY_TYPE:
                return COMPANY_NAME;
            default:
                return "未知";
        }
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

    public String getTransportationModel() {
        return transportationModel;
    }

    public void setTransportationModel(String transportationModel) {
        this.transportationModel = transportationModel;
    }
}
