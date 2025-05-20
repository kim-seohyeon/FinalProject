package shoppingmall.controller;

import java.io.IOException;
import java.io.PrintWriter;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import shoppingmall.command.LoginCommand;
import shoppingmall.domain.AuthInfoDTO;
import shoppingmall.service.LoginService;

@Controller
@RequestMapping("/login")
public class LoginController {

    @Autowired
    LoginService loginService;

    // 로그인 처리
    @PostMapping("/login")
    public String login(@Validated LoginCommand loginCommand,
                        BindingResult result,
                        HttpSession session,
                        HttpServletResponse response) {
        if (result.hasErrors()) {
            return "index";
        }

        loginService.execute(loginCommand, result, session, response);
        if (result.hasErrors()) {
            return "index";
        }

        // 원래 가려던 주소로 리다이렉트
        String redirectURI = (String) session.getAttribute("redirectURI");
        session.removeAttribute("redirectURI"); // 사용 후 삭제

        if (redirectURI != null) {
            return "redirect:" + redirectURI;
        } else {
            return "redirect:/";
        }
    }

    // 로그아웃 처리
    @GetMapping("/logout")
    public String logout(HttpSession session, HttpServletResponse response) {
        Cookie cookie = new Cookie("autoLogin", "");
        cookie.setPath("/");
        cookie.setMaxAge(0);
        response.addCookie(cookie);
        session.invalidate();
        return "redirect:/";
    }

    // 로그인 폼 요청
    @GetMapping("/loginCk")
    public String loginCk(HttpServletRequest request, HttpSession session) {
        // 현재 사용자가 가려던 URI 저장
        String referer = request.getHeader("Referer");
        if (referer != null && !referer.contains("/login")) {
            session.setAttribute("redirectURI", referer);
        }
        return "login"; // 로그인 폼 JSP
    }
    
    // 로그인 처리 (POST)
    @PostMapping("/loginOk")
    public String loginOk(@Validated LoginCommand loginCommand,
                          BindingResult result, HttpServletResponse response, HttpSession session) {
        if (result.hasErrors()) {
            return "login";
        }

        // 로그인 처리
        loginService.execute(loginCommand, result, session, response);

        if (result.hasErrors()) {
            return "login";
        }

        // 세션에 auth 정보 저장 (로그인 성공 후 세션에 저장된 auth 정보를 직접 가져옵니다.)
        AuthInfoDTO authInfo = (AuthInfoDTO) session.getAttribute("auth"); // 세션에서 auth 정보 가져오기
        if (authInfo != null) {
            // 로그인 성공 후 세션에 auth 정보가 정상적으로 저장되었으면, 세션에 설정된 auth 정보를 다시 설정합니다.
            session.setAttribute("auth", authInfo);  
        } else {
            return "login";
        }

        // 부모 창 새로고침 후 현재 창 닫기 (팝업 로그인 창의 경우)
        response.setContentType("text/html; charset=utf-8");
        PrintWriter out = null;
        try {
            out = response.getWriter();
        } catch (IOException e) {
            e.printStackTrace();
        }
        String str = "<script language='javascript'>";
        str += " opener.location.reload();";  // 부모 창 새로고침
        str += " window.self.close();";      // 현재 창 닫기
        str += " </script>";
        out.print(str);
        out.close();
        return null;
    }
}
