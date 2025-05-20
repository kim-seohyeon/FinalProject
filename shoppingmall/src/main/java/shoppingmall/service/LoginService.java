package shoppingmall.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.validation.BindingResult;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import shoppingmall.command.LoginCommand;
import shoppingmall.domain.AuthInfoDTO;
import shoppingmall.repository.LoginRepository;
import shoppingmall.repository.MemberRepository;

@Service
public class LoginService {

    @Autowired
    LoginRepository loginRepository;
    @Autowired
    MemberRepository memberRepository;
    @Autowired
    PasswordEncoder passwordEncoder;

    public void execute(LoginCommand loginCommand, BindingResult result,
                        HttpSession session, HttpServletResponse response) {

        // 1. 아이디 조회
        AuthInfoDTO auth = memberRepository.loginSelectOne(loginCommand.getUserId());

        if (auth == null) {
            result.rejectValue("userId", "loginCommand.userId", "아이디가 존재하지 않습니다.");
            return;
        }

        // 2. 비밀번호 확인
        if (passwordEncoder.matches(loginCommand.getUserPw(), auth.getUserPw())) {
            // 로그인 성공
            session.setAttribute("auth", auth);  // 세션에 auth 정보 저장
            System.out.println("세션에 auth 정보 저장됨: " + session.getAttribute("auth"));

            // 3. 자동 로그인 쿠키 설정
            if (loginCommand.isAutoLogin()) {
                setLoginCookie(response, "autoLogin", loginCommand.getUserId(), 60 * 60 * 24 * 30);
            }

            // 4. 아이디 저장 쿠키 설정
            if (loginCommand.isIdStore()) {
                setLoginCookie(response, "idStore", loginCommand.getUserId(), 60 * 60 * 24 * 30);
            } else {
                // 아이디 저장을 선택하지 않으면 쿠키 삭제
                setLoginCookie(response, "idStore", "", 0);
            }

        } else {
            // 비밀번호 불일치
            result.rejectValue("userPw", "loginCommand.userPw", "비밀번호가 일치하지 않습니다.");
        }
    }

    private void setLoginCookie(HttpServletResponse response, String cookieName, String value, int maxAge) {
        Cookie cookie = new Cookie(cookieName, value);
        cookie.setPath("/");
        cookie.setMaxAge(maxAge);  // 쿠키의 유효 기간 설정
        response.addCookie(cookie);
    }
}
