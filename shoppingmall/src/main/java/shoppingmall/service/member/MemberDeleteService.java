package shoppingmall.service.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import jakarta.servlet.http.HttpSession;
import shoppingmall.domain.AuthInfoDTO;
import shoppingmall.domain.MemberDTO;
import shoppingmall.repository.MemberRepository;


@Service
public class MemberDeleteService {

	@Autowired
	MemberRepository memberRepository;
	public void execute(HttpSession session) {
		
		AuthInfoDTO auth = (AuthInfoDTO) session.getAttribute("auth");

		int dto = memberRepository.memberDelete(auth.getUserId());
	}

}
