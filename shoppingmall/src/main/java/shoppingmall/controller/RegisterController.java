package shoppingmall.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import shoppingmall.command.MemberCommand;
import shoppingmall.service.user.UserWriteService;

@Controller
@RequestMapping("/register")
public class RegisterController {
	@Autowired
	UserWriteService userWriteService;

	@GetMapping("/userAgree")
	public String agree() {
		return "memberJoin/agree";
	}
	@GetMapping("/userWrite")
	public String write(MemberCommand memberCommand) {
		return "memberJoin/userForm";
	}
	
	@PostMapping("/userWrite")
	public String writer(@Validated MemberCommand memberCommand, BindingResult result, Error error) {
		if(result.hasErrors()) {
			return "memberJoin/userForm";
		}
		if(!memberCommand.isMemberPwEqualsMemberPwCon()) {
			result.rejectValue("memberPwCon", "memberCommand.memberPwCon", "비밀번호와 일치하지 않습니다.");
			return "memberJoin/userForm";
		}
		userWriteService.execute(memberCommand);
		return "redirect:/";
	}
}
