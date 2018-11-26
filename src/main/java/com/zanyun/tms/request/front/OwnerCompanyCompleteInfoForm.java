package com.zanyun.tms.request.front;

import com.sug.core.util.RegexUtils;
import org.hibernate.validator.constraints.NotEmpty;

import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

public class OwnerCompanyCompleteInfoForm {
    @Pattern(regexp = RegexUtils.REGEX_CHINESE,message = "请输入中文")
    @Size(min = 2,max = 6,message = "长度在2到6之间")
    private String name;

    @Pattern(regexp = RegexUtils.REGEX_CHINESE,message = "请输入中文")
    private String province;
    @Pattern(regexp = RegexUtils.REGEX_CHINESE,message = "请输入中文")
    private String city;
    @Pattern(regexp = RegexUtils.REGEX_CHINESE,message = "请输入中文")
    private String county;
    @Pattern(regexp = RegexUtils.REGEX_CHINESE,message = "请输入中文")
    private String address;
    @NotEmpty
    private String companyName;
    @NotEmpty
    private String unifiedSocialCreditCode;


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

    public String getCompanyName() {
        return companyName;
    }

    public void setCompanyName(String companyName) {
        this.companyName = companyName;
    }

    public String getUnifiedSocialCreditCode() {
        return unifiedSocialCreditCode;
    }

    public void setUnifiedSocialCreditCode(String unifiedSocialCreditCode) {
        this.unifiedSocialCreditCode = unifiedSocialCreditCode;
    }
}
