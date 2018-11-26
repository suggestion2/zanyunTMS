package com.zanyun.tms.request.front;

import com.sug.core.util.RegexUtils;
import org.hibernate.validator.constraints.NotEmpty;

import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

public class AddressCreateForm {
    @NotEmpty
    @Pattern(regexp = RegexUtils.REGEX_CHINESE,message = "请输入中文")
    @Size(min = 2,max = 6,message = "联系人长度在2到6之间")
    private String contact;
    @NotEmpty
    @Pattern(regexp = "^1[3-8]{1}\\d{9}$", message = "请输入正确的手机号码！")
    private String phone;
    @NotEmpty
    private String province;
    @NotEmpty
    private String city;
    @NotEmpty
    private String county;
    @NotEmpty
    private String address;
    @NotEmpty
    private String longitude;
    @NotEmpty
    private String latitude;

    public String getContact() {
        return contact;
    }

    public void setContact(String contact) {
        this.contact = contact;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
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
