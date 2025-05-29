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
	
    // 2) 아이디+전화번호 확인 -> 회원이 있으면 새 비밀번호 입력 폼으로 이동

	@PostMapping("/findPassword")
	public String checkUserForPasswordReset(String userId, String userPhone, Model model) {
	    if (!findPwService.verifyUser(userId, userPhone, model)) {
	        return "help/findPw"; // 실패하면 다시 입력 폼
	    }
	    return "help/resetPwForm"; // 성공 시 비밀번호 재설정 폼으로 이동
	}

	//비밀번호 변경
	@PostMapping("/resetPassword")
	public String resetPassword(String userId, String newPassword, Model model) {
	    findPwService.updatePassword(userId, newPassword, model);
	    return "help/resetPwResult";
	}

	
//	@PostMapping("/findPassword")
//	public String findPassword(String userId, String userPhone, Model model) {
//		findPwService.execute(userId, userPhone, model);
//		return "help/findPwOk";
//	}

	
	@GetMapping("/findId")
	public String findId() {
		return "help/findId";
	}
	
	@PostMapping("/findId")
	public String findId(String userPhone, Model model) {
		try {
		findIdService.execute(userPhone, model);
		
		}
		catch (Exception e) {
			model.addAttribute("msg", "오류가 발생되었습니다.");
			e.printStackTrace();
		}
		return "help/findIdOk";
	}
}
