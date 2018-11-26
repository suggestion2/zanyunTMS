package com.zanyun.tms.constants;

public class DriverConstant {
    public final static int DRIVER_INVALID = -1;
    public final static int DRIVER_REJECT = 0;
    public final static int DRIVER_INCOMPLETE = 1;
    public final static int DRIVER_VALIDATE = 2;
    public final static int DRIVER_COMPLETE = 3;

    public final static String REJECT_NAME = "审核未通过";
    public final static String INCOMPLETE_NAME = "未完善资料";
    public final static String VALIDATE_NAME = "待审核";
    public final static String COMPLETE_NAME = "审核通过";
}
