package shoppingmall.service.help;

import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import shoppingmall.domain.AuthInfoDTO;
import shoppingmall.domain.UserChangePasswordDTO;
import shoppingmall.repository.MemberRepository;
import shoppingmall.service.EmailSendService;

@Service
public class FindPwService {
	
	@Autowired
	PasswordEncoder passwordEncoder;
	@Autowired
	MemberRepository memberRepository;
	@Autowired
	EmailSendService emailSendService;

	public void execute(String userId, String userPhone, Model model) {
		//임시 비밀번호(8자리)
		String newPw = UUID.randomUUID().toString().substring(0,8);
		
		AuthInfoDTO auth = memberRepository.loginSelectOne(userId);
		UserChangePasswordDTO dto = new UserChangePasswordDTO();
		
		if(auth.getGrade().equals("emp")) {
			dto.setTableName("employees");
			dto.setPhoneColumnName("emp_phone");
			dto.setUserIdColumnName("emp_id");
			dto.setPwColumnName("emp_pw");
			
		}else {
			dto.setTableName("members");
			dto.setPhoneColumnName("member_phone1");
			dto.setUserIdColumnName("member_id");
			dto.setPwColumnName("member_pw");
		
		}
		
		dto.setUserPhone(userPhone);
		dto.setUserId(userId);
		dto.setUserPw(passwordEncoder.encode(newPw));
		
		int i = memberRepository.userPwUpdate(dto);
		if(i != 0) {
			
			String html = auth.getUserName()+ "님의 임시 비밀번호는 <b>"+ newPw + "</b> 입니다.";
			String subject = auth.getUserName() + "님의 임시 비밀번호입니다.";
			String fromEmail = "soongmoostudent@gmail.com";
			String toEmail = auth.getUserEmail();
			
			
			emailSendService.send(fromEmail, toEmail, subject, html);
		}else {
			model.addAttribute("email", null);
		}
		
	}	
	
}
