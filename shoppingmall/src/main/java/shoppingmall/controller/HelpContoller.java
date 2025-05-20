package shoppingmall.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import shoppingmall.service.help.FindIdService;
import shoppingmall.service.help.FindPwService;

@Controller
@RequestMapping("/help")
public class HelpContoller {
	
	@Autowired
	FindPwService findPwService;
	@Autowired
	FindIdService findIdService;

	@GetMapping("findPassword")
	public String findPassword() {

		return "help/findPw";
	}
	
	@PostMapping("/findPassword")
	public String findPassword(String userId, String userPhone, Model model) {
		findPwService.execute(userId, userPhone, model);
		return "help/findPwOk";
	}
	
	@GetMapping("/findId")
	public String findId() {
		return "help/findId";
	}
	
	@PostMapping("/findId")
	public String findId(String userPhone, String userEmail, Model model) {
		findIdService.execute(userPhone, userEmail, model);
		return "help/findIdOk";
	}
}
