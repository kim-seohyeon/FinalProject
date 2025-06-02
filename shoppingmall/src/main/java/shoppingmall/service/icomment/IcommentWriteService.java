package shoppingmall.service.icomment;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import jakarta.servlet.http.HttpSession;
import shoppingmall.command.IcommentCommand;
import shoppingmall.domain.AuthInfoDTO;
import shoppingmall.domain.EmployeeDTO;
import shoppingmall.domain.MemberDTO;
import shoppingmall.repository.EmployeeRepository;
import shoppingmall.repository.IcommentRepository;
import shoppingmall.repository.MemberRepository;

@Service
public class IcommentWriteService {

	@Autowired
	IcommentRepository icommentRepository;
	@Autowired
	MemberRepository memberRepository;
	@Autowired
	EmployeeRepository employeeRepository;
	public void execute(IcommentCommand icommentCommand, HttpSession session) {
		
    	AuthInfoDTO auth = (AuthInfoDTO) session.getAttribute("auth");
    	if (auth.getGrade().equals("mem")) {
    		MemberDTO dto = memberRepository.memberSelectOne(auth.getUserId());
    		icommentCommand.setMemberNum(dto.getMemberNum());
    	}else {
    		EmployeeDTO dto = employeeRepository.empSelectOne(auth.getUserId());
    		icommentCommand.setEmpNum(dto.getEmpNum());
    	}
    	icommentRepository.icommentInsert(icommentCommand,auth.getGrade());
	}

}
