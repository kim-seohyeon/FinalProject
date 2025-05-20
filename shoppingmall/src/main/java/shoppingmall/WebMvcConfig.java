package shoppingmall;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import shoppingmall.InterceptorConfig;

public class WebMvcConfig implements WebMvcConfigurer{

	@Autowired
	InterceptorConfig inteceptorConfig;
	
	@Override
	public void addInterceptors(InterceptorRegistry registry) {

		List<String> excludeList = new ArrayList<String>();
		//로그인하지 않아도 사용할 수 있는 주소 추가
		excludeList.add("/help/**/*");
		excludeList.add("/login/**/*");
		excludeList.add("/static/**/*");
		excludeList.add("/register/**/*");
		excludeList.add("/checkRest/**/*");
		excludeList.add("/review/**/*");
		excludeList.add("/payment/**/*");
		excludeList.add("/corner/**/*");
		excludeList.add("/hospitals");
		registry.addInterceptor(inteceptorConfig)
				.addPathPatterns("/**/*")// 모두차단
				.excludePathPatterns(excludeList);// 허용할 주소	
		}
	
}
