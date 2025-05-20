package shoppingmall.service.my;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import jakarta.servlet.http.HttpSession;
import shoppingmall.domain.AuthInfoDTO;
import shoppingmall.repository.MemberRepository;

@Service
public class MemberPwUpdateService {
	@Autowired
	MemberRepository memberRepository;
	@Autowired
	PasswordEncoder passwordEncoder;
	public int execute(HttpSession session, Model model, String oldPw, String newPw) {
		
		AuthInfoDTO auth = (AuthInfoDTO) session.getAttribute("auth");
		
		String memberId = auth.getUserId();
		
		int i;
		if(passwordEncoder.matches(oldPw, auth.getUserPw())) {
			String encPw=passwordEncoder.encode(newPw);
			memberRepository.memberPwUpdate(memberId, encPw);
			auth.setUserPw(encPw);
			i = 1;
		}else {
			model.addAttribute("pwErr", "비밀번호가 틀렸습니다.");
			i = 0;
		}
		return i;
	}
}
