package com.zanyun.tms.view.background;

import com.zanyun.tms.domain.background.CustomerCount;
import com.zanyun.tms.domain.background.OrderCount;

import java.util.List;

public class ReportView {
    private List<OrderCount> orderCountList;
    private List<CustomerCount> customerCountList;

    public List<OrderCount> getOrderCountList() {
        return orderCountList;
    }

    public void setOrderCountList(List<OrderCount> orderCountList) {
        this.orderCountList = orderCountList;
    }

    public List<CustomerCount> getCustomerCountList() {
        return customerCountList;
    }

    public void setCustomerCountList(List<CustomerCount> customerCountList) {
        this.customerCountList = customerCountList;
    }
}
