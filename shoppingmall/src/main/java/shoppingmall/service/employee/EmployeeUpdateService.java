package shoppingmall.service.employee;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import shoppingmall.command.EmployeeCommand;
import shoppingmall.domain.EmployeeDTO;
import shoppingmall.repository.EmployeeRepository;

@Service
public class EmployeeUpdateService {

	@Autowired
	EmployeeRepository employeeRepository;
	@Autowired
	PasswordEncoder passwordEncoder;
	public int execute(EmployeeCommand employeeCommand) {
		
		EmployeeDTO dto = employeeRepository.empSelectOne(employeeCommand.getEmpNum());
		
		int i = 0;
		
		if(passwordEncoder.matches(employeeCommand.getEmpPw(), dto.getEmpPw())) {
			
			dto.setEmpNum(employeeCommand.getEmpNum());
			dto.setEmpName(employeeCommand.getEmpName());
			dto.setEmpId(employeeCommand.getEmpId());
			dto.setEmpAddr(employeeCommand.getEmpAddr());
			dto.setEmpAddrDetail(employeeCommand.getEmpAddrDetail());
			dto.setEmpPost(employeeCommand.getEmpPost());
			dto.setEmpHireDate(employeeCommand.getEmpHireDate());
			dto.setEmpPhone(employeeCommand.getEmpPhone());
			dto.setEmpJumin(employeeCommand.getEmpJumin());
			dto.setEmpEmail(employeeCommand.getEmpEmail());
			
			employeeRepository.empUpdate(dto);
			i = 1;
		}
		return i;
		
	}
}
