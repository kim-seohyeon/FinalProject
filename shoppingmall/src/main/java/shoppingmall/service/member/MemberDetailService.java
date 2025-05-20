package shoppingmall.service.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import jakarta.servlet.http.HttpSession;
import shoppingmall.domain.AuthInfoDTO;
import shoppingmall.domain.MemberDTO;
import shoppingmall.repository.MemberRepository;

@Service
public class MemberDetailService {
	@Autowired
	MemberRepository memberRepository;
	
	public void execute(HttpSession session, Model model) {
		
        AuthInfoDTO auth = (AuthInfoDTO) session.getAttribute("auth");
        
		MemberDTO dto = memberRepository.memberSelectOne(auth.getUserId());
		model.addAttribute("dto", dto);
		
	}
}
