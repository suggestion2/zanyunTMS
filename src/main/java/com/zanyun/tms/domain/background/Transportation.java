package com.zanyun.tms.domain.background;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.sug.core.util.jsonFormat.SimpleDateSerializer;

import java.util.Date;

/**
 * Created by Administrator on 2017/10/21.
 */
public class Transportation {
    private Integer id;
    private String brand;
    private String type;
    private String typeRemarks;
    private Integer loadTons;
    private Integer loadCubic;
    private Double length;
    private Double width;
    private Double height;
    private String licenseNum;
    private String engineNum;
    @JsonSerialize(using = SimpleDateSerializer.class)
    private Date purchaseDate;
    @JsonSerialize(using = SimpleDateSerializer.class)
    private Date inspectionDate;
    private String cargoTypes;
    private Integer status;

    private Integer updateBy;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getTypeRemarks() {
        return typeRemarks;
    }

    public void setTypeRemarks(String typeRemarks) {
        this.typeRemarks = typeRemarks;
    }

    public Integer getLoadTons() {
        return loadTons;
    }

    public void setLoadTons(Integer loadTons) {
        this.loadTons = loadTons;
    }

    public Integer getLoadCubic() {
        return loadCubic;
    }

    public void setLoadCubic(Integer loadCubic) {
        this.loadCubic = loadCubic;
    }

    public Double getLength() {
        return length;
    }

    public void setLength(Double length) {
        this.length = length;
    }

    public Double getWidth() {
        return width;
    }

    public void setWidth(Double width) {
        this.width = width;
    }

    public Double getHeight() {
        return height;
    }

    public void setHeight(Double height) {
        this.height = height;
    }

    public String getLicenseNum() {
        return licenseNum;
    }

    public void setLicenseNum(String licenseNum) {
        this.licenseNum = licenseNum;
    }

    public String getEngineNum() {
        return engineNum;
    }

    public void setEngineNum(String engineNum) {
        this.engineNum = engineNum;
    }

    public Date getPurchaseDate() {
        return purchaseDate;
    }

    public void setPurchaseDate(Date purchaseDate) {
        this.purchaseDate = purchaseDate;
    }

    public Date getInspectionDate() {
        return inspectionDate;
    }

    public void setInspectionDate(Date inspectionDate) {
        this.inspectionDate = inspectionDate;
    }

    public String getCargoTypes() {
        return cargoTypes;
    }

    public void setCargoTypes(String cargoTypes) {
        this.cargoTypes = cargoTypes;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Integer getUpdateBy() {
        return updateBy;
    }

    public void setUpdateBy(Integer updateBy) {
        this.updateBy = updateBy;
    }
}
