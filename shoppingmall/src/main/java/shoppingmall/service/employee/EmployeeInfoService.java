package shoppingmall.service.employee;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import shoppingmall.domain.EmployeeDTO;
import shoppingmall.mapper.EmployeeMapper;
import shoppingmall.repository.EmployeeRepository;

@Service
public class EmployeeInfoService {
	
	@Autowired
	EmployeeRepository employeeRepository;
	public void execute(Model model, String empNum) {
		
		EmployeeDTO dto = employeeRepository.empSelectOne(empNum);
		model.addAttribute("employeeCommand", dto);
		
	}


}
