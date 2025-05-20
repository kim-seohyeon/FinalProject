package shoppingmall.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import shoppingmall.service.UserEmailCheckService;
import shoppingmall.service.UserIdCheckService;

@RestController
@RequestMapping("/duplication")
public class DuplicationRestController {
	@Autowired
	UserIdCheckService userIdcheckService;
	@Autowired
	UserEmailCheckService userEmailCheckService;
	
	@PostMapping("/userIdCheck")
	public String idcheck(String userId) {
		return userIdcheckService.execute(userId);
	}
	
	@PostMapping("/emailCheck")
	public String emailCheck(String userEmail) {
		return  userEmailCheckService.execute(userEmail);
	}
}
