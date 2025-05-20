package shoppingmall.service.employee;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import shoppingmall.command.EmployeeCommand;
import shoppingmall.domain.EmployeeDTO;
import shoppingmall.repository.EmployeeRepository;

@Service
public class EmployeeWriteService {
	@Autowired
	PasswordEncoder passwordEncoder;
    @Autowired
    EmployeeRepository employeeRepository;
    
	public void execute(EmployeeCommand employeeCommand) {
		EmployeeDTO dto = new EmployeeDTO();
		dto.setEmpNum(employeeCommand.getEmpNum());
		dto.setEmpId(employeeCommand.getEmpId());
		dto.setEmpName(employeeCommand.getEmpName());
		dto.setEmpAddr(employeeCommand.getEmpAddr());
		dto.setEmpAddrDetail(employeeCommand.getEmpAddrDetail());
		dto.setEmpPost(employeeCommand.getEmpPost());
		dto.setEmpPhone(employeeCommand.getEmpPhone());
		dto.setEmpJumin(employeeCommand.getEmpJumin());
		dto.setEmpEmail(employeeCommand.getEmpEmail());
		dto.setEmpHireDate(employeeCommand.getEmpHireDate());
		
		dto.setEmpPw(passwordEncoder.encode(employeeCommand.getEmpPw()));

		employeeRepository.empInsert(dto);

	}
}