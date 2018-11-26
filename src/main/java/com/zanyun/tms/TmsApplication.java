package com.zanyun.tms;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
@EnableScheduling
@ComponentScan(basePackages = {
		"com.zanyun",
		"com.sug.core.platform.web",
		"com.sug.core.platform.dingtalk",
		"com.sug.core.platform.sms",
		"com.sug.core.platform.wechat"
})
public class TmsApplication {

	public static void main(String[] args) {
		SpringApplication.run(TmsApplication.class, args);
	}
}
