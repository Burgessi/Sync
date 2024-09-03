package com.pro.sync.common.aop;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.EnableAspectJAutoProxy;

@Configuration
@EnableAspectJAutoProxy
public class AopConfig {

	@Bean
    public SessionUpdateAspect sessionUpdateAspect() {
        return new SessionUpdateAspect();
    }
}
