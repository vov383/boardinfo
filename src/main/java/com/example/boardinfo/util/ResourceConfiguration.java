//package com.example.boardinfo.util;
//
//import org.springframework.context.annotation.Configuration;
//import org.springframework.http.CacheControl;
//import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
//import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
//
//import java.util.concurrent.TimeUnit;
//
///*별도의 외부 고정된 경로에 파일을 참조하는 util*/
//@Configuration
//public class ResourceConfiguration implements WebMvcConfigurer {
//
//    @Override
//    public void addResourceHandlers(final ResourceHandlerRegistry registry) {
//        registry.addResourceHandler("/download/**").addResourceLocations("file:///C:/webserver_storage/").setCacheControl(CacheControl.maxAge(1, TimeUnit.MINUTES));
//        //접근 파일 캐싱 시간
//}
//
//}
