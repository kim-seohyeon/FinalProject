package shoppingmall.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import shoppingmall.command.LoginCommand;
import shoppingmall.command.MailCommand;
import shoppingmall.domain.AuthInfoDTO;
import shoppingmall.repository.MemberRepository;
import shoppingmall.service.EmailService;
import shoppingmall.service.goods.GoodsListService;
import shoppingmall.service.library.LibraryListService;

@Controller
public class IndexController {
	@Autowired
	MemberRepository memberRepository;
	@Autowired
	EmailService emailService;
	@Autowired
	LibraryListService libraryListService;
	@Autowired
	GoodsListService goodsListService;
	
	@GetMapping("/")
	public String index(@ModelAttribute("loginCommand") LoginCommand loginCommand
							, HttpServletRequest request, Model model) {
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
		goodsListService.execute(model);
		return "index";
	}
	
	@GetMapping("/mailling")
	public String mailSend() {
		
		return "email";
	}
	
	@PostMapping("/mailling")
	public String mailSend(MailCommand mailCommand) {
		emailService.execute(mailCommand);
		return "redirect:/";
	}
	
	@PostMapping("/loadMore")
	public ModelAndView loadMore(int page, Model model) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");
		libraryListService.execute(model, page, "");
		return mav;
	}
	
	@GetMapping("/realStock")
	public String realStock() {
		return "/socket/chattingClient";
	}
	
}
