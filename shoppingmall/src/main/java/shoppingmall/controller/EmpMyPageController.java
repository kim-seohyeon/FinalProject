package shoppingmall.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.servlet.http.HttpSession;
import shoppingmall.command.EmployeeCommand;
import shoppingmall.domain.AuthInfoDTO;
import shoppingmall.service.employee.EmployeeUpdateService;
import shoppingmall.service.my.EmployeeDetailService;
import shoppingmall.service.my.EmployeePwUpdateService;

@Controller
@RequestMapping("/empPage")
public class EmpMyPageController {
	
	@Autowired
	EmployeeDetailService employeeDetailService;
	@Autowired
	EmployeeUpdateService employeeUpdateService;
	@Autowired
	EmployeePwUpdateService employeePwUpdateService;
	
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
    
    @GetMapping("/empUpdate")
    public String empModify(HttpSession session, Model model) {
    	
        AuthInfoDTO authInfo = (AuthInfoDTO) session.getAttribute("auth");
        if (authInfo != null) {
            employeeDetailService.execute(authInfo.getUserId(), model);
        }
    	
    	return "empPage/empModify";
    }
    
    @PostMapping("/empModify")
    public String empUpdate(HttpSession session, EmployeeCommand employeeCommand) {
	    int i  = employeeUpdateService.execute(session, employeeCommand);
	    if (i == 1) {
	        return "redirect:/empPage/empMyPage";
	    } else {
	        return "redirect:/empPage/empModify";
	    }
    }
    
    @GetMapping("/empNewPw")
    public String pwPro() {
    	return "empPage/empNewPw";
    }
    
    @PostMapping("/empNewPw")
    public String pwPro(HttpSession session, Model model, String oldPw, String newPw) {
    	int i = employeePwUpdateService.execute(session, model, oldPw, newPw);
    	if(i == 1) {
    		return "redirect:/empPage/empMyPage";
    	}
    	else {
    		System.out.println("비밀번호 안 바뀜");
    		return "redirect:/empPage/empNewPw";
    	}
    }
}
