package shoppingmall.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.servlet.http.HttpSession;
import shoppingmall.command.MemberCommand;
import shoppingmall.domain.MemberDTO;
import shoppingmall.service.member.MemberDeleteService;
import shoppingmall.service.member.MemberDetailService;
import shoppingmall.service.member.MemberUpdateService;
import shoppingmall.service.my.MemberPwUpdateService;

@Controller
@RequestMapping("/myPage")
public class MemMyPageController {

    @Autowired
    MemberDetailService memberDetailService;
    @Autowired
    MemberUpdateService memberUpdateService;
    @Autowired
    MemberDeleteService memberDeleteService;
    @Autowired
    MemberPwUpdateService memberPwUpdateService;

    // 내 정보 보기 페이지 요청 처리
    @GetMapping("/memberMyPage")
    public String memberMyPage(HttpSession session, Model model) {
        memberDetailService.execute(session, model);  // memberNum을 통해 회원 정보 조회
        return "myPage/memberMyPage";  // memberMyPage.jsp로 이동
    }
    
    @GetMapping("/memberUpdate")
    public String memberUpdate(HttpSession session, Model model) {
        memberDetailService.execute(session, model);  // 회원 정보 조회
        return "myPage/myModify";  
    }


    @PostMapping("/memberUpdate")
    public String memberUpdate(HttpSession session, MemberCommand memberCommand) {
        int  i = memberUpdateService.execute(session, memberCommand);
        if (i == 1) {
            return "redirect:/myPage/memberMyPage";
        } else {
            return "redirect:/myPage/memberUpdate";
        }
    }
    
    
    @GetMapping("/myNewPw")
    public String pwPro() {
    	return "myPage/myNewPw";
    }
    
    @PostMapping("/myNewPw")
    public String pwPro(HttpSession session, Model model, String oldPw, String newPw) {
    	int i = memberPwUpdateService.execute(session, model, oldPw, newPw);
    	if(i == 1) {
    		return "redirect:/myPage/memberMyPage";
    	}
    	else {
    		System.out.println("비밀번호 안 바뀜");
    		return "redirect:/myPage/myNewPw";
    	}
    }
    
    @GetMapping("/memberDrop")
    public String memberDrop(HttpSession session) {
        memberDeleteService.execute(session);  // 회원 삭제 서비스 호출
        return "redirect:/login/logout";  // 회원 탈퇴 후 홈으로 리디렉션
    }

}
