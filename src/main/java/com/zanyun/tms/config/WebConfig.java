package com.zanyun.tms.config;

import com.sug.core.platform.web.filter.PlatformFilter;
import com.zanyun.tms.interceptor.background.AuthenticationInterceptor;
import com.zanyun.tms.interceptor.front.PageInterceptor;
import com.zanyun.tms.interceptor.front.SessionInterceptor;
import com.zanyun.tms.interceptor.front.UserAgentInterceptor;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpStatus;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

import java.nio.charset.Charset;


@Configuration
@MapperScan(value = "com.zanyun.tms.mapper")
@EnableTransactionManagement
public class WebConfig implements WebMvcConfigurer {

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry){
        registry.addResourceHandler("/**").addResourceLocations("classpath:/static/");
    }


    @Override
    public void addInterceptors(InterceptorRegistry registry){

        registry.addInterceptor(userAgentInterceptor())
                .addPathPatterns("/**")
                .excludePathPatterns("/resources/**","/background/**","/payment/wechat/notify","/test/**","/led");

        registry.addInterceptor(pageInterceptor())
                .addPathPatterns("/**")
                .excludePathPatterns("/resources/**","/background/**","/payment/wechat/notify","/test/**","/led");

        registry.addInterceptor(sessionInterceptor())
                .addPathPatterns("/**")
                .excludePathPatterns("/resources/**","/background/**","/payment/wechat/notify","/test/**","/led");

        registry.addInterceptor(authenticationInterceptor())
                .addPathPatterns("/background/**")
                .excludePathPatterns("/resources/**","/test/**","/led");
    }

    @Bean
    public AuthenticationInterceptor authenticationInterceptor(){
        return new AuthenticationInterceptor();
    }

    @Bean
    public PageInterceptor pageInterceptor(){
        return new PageInterceptor();
    }

    @Bean
    public SessionInterceptor sessionInterceptor(){
        return new SessionInterceptor();
    }

    @Bean
    public UserAgentInterceptor userAgentInterceptor(){
        return new UserAgentInterceptor();
    }
}
