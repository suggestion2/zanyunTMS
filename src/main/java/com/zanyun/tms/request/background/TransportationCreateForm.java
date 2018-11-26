package com.zanyun.tms.request.background;

import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.sug.core.util.jsonFormat.SimpleDateDeserializer;
import org.hibernate.validator.constraints.NotEmpty;

import javax.validation.constraints.NotNull;
import java.util.Date;

/**
 * Created by Administrator on 2017/10/21.
 */
public class TransportationCreateForm {
    @NotEmpty
    private String brand;
    @NotEmpty
    private String type;
    private String typeRemarks;
    @NotNull
    private Integer loadTons;
    @NotNull
    private Integer loadCubic;
    @NotNull
    private Double length;
    @NotNull
    private Double width;
    @NotNull
    private Double height;
    @NotEmpty
    private String licenseNum;
    @NotEmpty
    private String engineNum;
    @JsonDeserialize(using = SimpleDateDeserializer.class)
    private Date purchaseDate;
    @JsonDeserialize(using = SimpleDateDeserializer.class)
    private Date inspectionDate;
    private String cargoTypes;

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
}
