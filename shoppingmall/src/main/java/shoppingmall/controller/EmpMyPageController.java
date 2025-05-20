package shoppingmall.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.servlet.http.HttpSession;
import shoppingmall.domain.AuthInfoDTO;
import shoppingmall.service.member.MemberDetailService;
import shoppingmall.service.my.EmployeeDetailService;

@Controller
@RequestMapping("/empPage")
public class EmpMyPageController {
	
	@Autowired
	EmployeeDetailService employeeDetailService;
	@Autowired
	MemberDetailService memberDetailService;
	
    @GetMapping("/empMyPage")
    public String empMyPage(HttpSession session, Model model) {
        // 로그인된 직원 정보 가져오기 (예: 세션에서 AuthInfoDTO 사용)
        AuthInfoDTO authInfo = (AuthInfoDTO) session.getAttribute("auth");
        if (authInfo != null) {
            System.out.println("로그인된 직원 ID: " + authInfo.getUserId());

            // DB에서 직원 정보 조회
            employeeDetailService.execute(authInfo.getUserId(), model);
            model.addAttribute("authInfo", authInfo);
        }
        return "empPage/empMyPage"; // empMyPage.jsp가 있어야 함
    }
    
    @GetMapping("/empModify")
    public String empModify(HttpSession session, Model model) {
    	
        AuthInfoDTO authInfo = (AuthInfoDTO) session.getAttribute("auth");
        if (authInfo != null) {
            System.out.println("수정 페이지 요청한 직원 ID: " + authInfo.getUserId());
            employeeDetailService.execute(authInfo.getUserId(), model);
        }
    	
    	return "empPage/empModify";
    }
}
