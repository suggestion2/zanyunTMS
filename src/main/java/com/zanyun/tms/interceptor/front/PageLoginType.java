package com.zanyun.tms.interceptor.front;

import com.zanyun.tms.constants.WeChatSitLoginType;

import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;

@Retention(RetentionPolicy. RUNTIME)
public @interface PageLoginType {
    String value() default WeChatSitLoginType.COMMON;
}
