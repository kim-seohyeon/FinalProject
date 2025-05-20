package shoppingmall.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.servlet.http.HttpSession;
import shoppingmall.command.MemberCommand;
import shoppingmall.domain.AuthInfoDTO;
import shoppingmall.service.member.MemberDeleteService;
import shoppingmall.service.member.MemberDetailService;
import shoppingmall.service.member.MemberListService;
import shoppingmall.service.member.MemberNumAutoNumService;
import shoppingmall.service.member.MemberUpdateService;
import shoppingmall.service.member.MemberWriteService;


@Controller
@RequestMapping("/member")
public class MemberController {

	@Autowired
	MemberNumAutoNumService memberNumAutoNumService;
	@Autowired
	MemberWriteService memberWriteService;
	@Autowired
	MemberListService memberListService;
	@Autowired
	MemberDetailService memberDetailService;
	@Autowired
	MemberUpdateService memberUpdateService;
	@Autowired
	MemberDeleteService memberDeleteService;
	
	@GetMapping("/memberList")
	public String list(Model model) {
		memberListService.execute(model);
		return "member/memberList";
	}
	
	@GetMapping("/memberWrite")
	public String write(Model model) {
		memberNumAutoNumService.execute(model);
		return "member/memberForm";
		
	}
	
	@PostMapping("/memberWrite")
	public String write(MemberCommand memberCommand) {
		memberWriteService.execute(memberCommand);
		return "redirect:memberList";
	}
	
	@GetMapping("/memberDetail")
	public String detail(HttpSession session, Model model) {
		memberDetailService.execute(session, model);
		return "member/memberDetail";
	}
	
	@GetMapping("/memberUpdate")
	public String update(HttpSession session, Model model) {
		memberDetailService.execute(session, model);
		return "member/memberModify";
	}
	
	@PostMapping("/memberUpdate")
	public String memberUpdate(HttpSession session, MemberCommand memberCommand) {
	    int i  = memberUpdateService.execute(session, memberCommand);
	    if (i == 1) {
	        return "redirect:/myPage/memberMyPage";
	    } else {
	        return "redirect:/myPage/memberUpdate";
	    }
	}
	
	@GetMapping("/memberDelete")
	public String delete(String memberNum) {
		memberDeleteService.execute(memberNum);
		return "redirect:memberList";
	}
	

}
