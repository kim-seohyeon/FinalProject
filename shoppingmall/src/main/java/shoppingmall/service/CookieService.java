package shoppingmall.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import shoppingmall.command.LoginCommand;
import shoppingmall.domain.AuthInfoDTO;
import shoppingmall.repository.MemberRepository;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Service
public class CookieService {
	@Autowired
	MemberRepository memberRepository;
	public void execute(LoginCommand loginCommand, HttpServletRequest request) {
		Cookie [] cookies = request.getCookies();
		if(cookies != null && cookies.length > 0) {
			for(Cookie cookie : cookies) {
				if(cookie.getName().equals("idStore")) {
					System.out.println("idStore 쿠키 있음");
					loginCommand.setIdStore(true);
					loginCommand.setUserId(cookie.getValue());
				}
				if(cookie.getName().equals("autoLogin")) {
					System.out.println("autoLogin 쿠키 있음");
					String userId = cookie.getValue();
					AuthInfoDTO auth = memberRepository.loginSelectOne(userId);
					//자동로그인 : 쿠키를 이용해서로그인 session을 만들어줌
					HttpSession session = request.getSession();
					session.setAttribute("auth", auth);
				}
			}
		}
	}
}
