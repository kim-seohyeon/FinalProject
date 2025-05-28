package shoppingmall; // 네 프로젝트 패키지명 맞게 수정

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class UploadConfig implements WebMvcConfigurer {

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/community/communityUpload/**")
                .addResourceLocations("file:///C:/upload/communityUpload/");
    }
}
