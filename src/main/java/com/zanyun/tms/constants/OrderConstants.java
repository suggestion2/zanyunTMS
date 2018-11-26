package com.zanyun.tms.constants;

public class OrderConstants {
    public static final int PERSON_TYPE = 1;
    public static final int COMPANY_TYPE = 2;

    public static final String PERSON_NAME = "个人";
    public static final String COMPANY_NAME = "公司";

    public static final int CANCEL_STATUS = -1;
    public static final int CREATE_STATUS = 0;
    public static final int VALIDATE_STATUS = 1;
    public static final int LOCK_STATUS = 2;
    public static final int PAID_STATUS = 3;
    public static final int ACCEPT_STATUS = 3;
    public static final int TRANSPORT_STATUS = 4;
    public static final int COMPLETE_STATUS = 5;

    public static final int ALL_STATUS = 10;

    public static final String CANCEL_STATUS_NAME = "已取消";
    public static final String CREATE_STATUS_NAME = "待审核";
    public static final String VALIDATE_STATUS_NAME = "待接单";
    public static final String LOCK_STATUS_NAME = "锁定";
    public static final String PAID_STATUS_NAME = "待发货";
    public static final String ACCEPT_STATUS_NAME = "已接单";
    public static final String TRANSPORT_STATUS_NAME = "运输中";
    public static final String COMPLETE_STATUS_NAME = "已完成";

    public static final String VALIDATE_LIST_TYPE = "validate";
    public static final String UNPAID_LIST_TYPE = "unpaid";
    public static final String TRANSPORT_LIST_TYPE = "transport";
    public static final String COMPLETE_LIST_TYPE = "complete";
    public static final String DONE_LIST_TYPE = "done";
    public static final String CANCEL_LIST_TYPE = "cancel";

    //url
    public static final String LIST_TYPE = "/{type}";
}
