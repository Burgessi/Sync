package com.pro.sync.mypage.controller;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/resources/upload/profile/**")
                .addResourceLocations("file:/C:/Eclipse_IDES/Program_Eclipse_SpringMVC/workspace_spring/.metadata/.plugins/org.eclipse.wst.server.core/tmp1/wtpwebapps/Sync/resources/upload/profile/");
    }
}

