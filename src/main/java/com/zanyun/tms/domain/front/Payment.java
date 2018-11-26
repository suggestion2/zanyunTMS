package com.zanyun.tms.domain.front;

import java.util.Date;

import static com.zanyun.tms.constants.PaymentConstants.*;

public class Payment {
    private Integer id;
    private String number;
    private Integer orderId;
    private String orderNum;
    private Double amount;
    private Date createTime;
    private Date updateTime;
    private Integer type;
    private Integer status;

    private Integer updateBy;

    private String refundNum;
    private String remark;

    private String typeName;
    private String statusName;

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

    public Integer getOrderId() {
        return orderId;
    }

    public void setOrderId(Integer orderId) {
        this.orderId = orderId;
    }

    public String getOrderNum() {
        return orderNum;
    }

    public void setOrderNum(String orderNum) {
        this.orderNum = orderNum;
    }

    public Double getAmount() {
        return amount;
    }

    public void setAmount(Double amount) {
        this.amount = amount;
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

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public String getTypeName() {
        if(this.type == null){
            return "未知";
        }
        switch (this.type){
            case PAY_TYPE:
                return PAY_TYPE_NAME;
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
            case UNPAID_STATUS:
                return UNPAID_STATUS_NAME;
            case PAID_STATUS:
                return PAID_STATUS_NAME;
            case REFUND_STATUS:
                return REFUND_STATUS_NAME;
            default:
                return "未知";
        }
    }

    public Integer getUpdateBy() {
        return updateBy;
    }

    public void setUpdateBy(Integer updateBy) {
        this.updateBy = updateBy;
    }

    public String getRefundNum() {
        return refundNum;
    }

    public void setRefundNum(String refundNum) {
        this.refundNum = refundNum;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }
}
