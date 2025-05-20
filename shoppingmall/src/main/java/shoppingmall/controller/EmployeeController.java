package shoppingmall.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import shoppingmall.command.EmployeeCommand;
import shoppingmall.service.employee.EmployeeAutoNumService;
import shoppingmall.service.employee.EmployeeDeleteService;
import shoppingmall.service.employee.EmployeeInfoService;
import shoppingmall.service.employee.EmployeeListService;
import shoppingmall.service.employee.EmployeeUpdateService;
import shoppingmall.service.employee.EmployeeWriteService;
import shoppingmall.service.my.EmployeeDetailService;

@Controller
@RequestMapping("/employee")
public class EmployeeController {

	@Autowired
	EmployeeAutoNumService employeeAutoNumService;
	@Autowired
	EmployeeWriteService employeeWriteService;
	@Autowired
	EmployeeListService employeeListService;
	@Autowired
	EmployeeInfoService employeeInfoService;
	@Autowired
	EmployeeUpdateService employeeUpdateService;
	@Autowired
	EmployeeDeleteService employeeDeleteService;
	@Autowired
	EmployeeDetailService employeeDetailService;
	
	@GetMapping("/empList")
	public String list(Model model) {
		employeeListService.execute(model);
		return "employee/empList";
	}
	
	@GetMapping("/empWrite")
	public String write(Model model) {
		employeeAutoNumService.execute(model);
		return "employee/empForm";
	}
	@PostMapping("/empWrite")
	public String write(@Validated EmployeeCommand employeeCommand
						, BindingResult result) { //BindingResult는 항상 Command 뒤에 와야 함

		if(result.hasErrors()) {
			return "employee/empForm";
		}
		if(!employeeCommand.isEmpPwEquealsEmpPwCon()) {
			result.rejectValue("empPwCon", "errPw", "비밀번호 확인이 일치하지 않습니다");
			return "employee/empForm";

		}
		employeeWriteService.execute(employeeCommand);
		return "redirect:empList";			
	}
	
	@GetMapping("/empDetail")
	public String detail(Model model, String empNum) {
		employeeInfoService.execute(model, empNum);
		return "employee/empDetail";
	}
	
	@GetMapping("/empUpdate")
	public String update(String empId, Model model) {
		employeeDetailService.execute(empId, model );
		return "employee/empModify";
	}
	
	@PostMapping("/empUpdate")
	public String update(@Validated EmployeeCommand employeeCommand
						, BindingResult result) {
		if(result.hasErrors()) {
			return "employee/empForm";
		}
		int i = employeeUpdateService.execute(employeeCommand);
		if(i == 0) {
			result.rejectValue("empPw", "macthErr", "비밀번호가 일치하지 않습니다.");
			return "employee/empModify";

		}
		return "redirect:empDetail?empNum="+employeeCommand.getEmpNum();

	}
	
	@GetMapping("/empDelete")
	public String delete(String empNum) {
		employeeDeleteService.execute(empNum);
		return "redirect:empList";
	}
}
