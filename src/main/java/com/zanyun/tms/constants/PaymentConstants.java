package com.zanyun.tms.constants;

public class PaymentConstants {
    public final static Double INFO_COST = 0.01d;

    public final static int PAY_TYPE = 1;
    public final static int REFUND_TYPE = 2;

    public final static String PAY_TYPE_NAME = "付款";

    public final static int CANCEL_STATUS = -1;
    public final static int UNPAID_STATUS = 0;
    public final static int PAID_STATUS = 1;
    public final static int REFUND_STATUS = -2;

    public final static String CANCEL_STATUS_NAME = "已取消";
    public final static String UNPAID_STATUS_NAME = "未支付";
    public final static String PAID_STATUS_NAME = "已支付";
    public final static String REFUND_STATUS_NAME = "已退款";

    //url
    public final static String REFUND = "/refund";
}
