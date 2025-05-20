package shoppingmall.service.employee;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import shoppingmall.repository.EmployeeRepository;

@Service
public class EmployeeDeleteService {
	@Autowired
	EmployeeRepository employeeRepository;
	public void execute(String empNum) {
		employeeRepository.empDelete(empNum);
	}
}
