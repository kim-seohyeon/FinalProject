package shoppingmall.service.my;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import shoppingmall.domain.EmployeeDTO;
import shoppingmall.mapper.EmployeeMapper;

@Service
public class EmployeeDetailService {

    @Autowired
    EmployeeMapper employeeMapper;

    public void execute(String empId, Model model) {
        EmployeeDTO dto = employeeMapper.selectByEmpId(empId); // ID로 조회
        model.addAttribute("dto", dto);
    }
    
}
