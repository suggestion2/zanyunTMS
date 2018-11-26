package com.zanyun.tms.interceptor.background;

import java.lang.annotation.*;

/**
 * Created by Administrator on 2017/5/24.
 */
@Target({ElementType.TYPE,ElementType.METHOD})
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface AuthRequired {
}
