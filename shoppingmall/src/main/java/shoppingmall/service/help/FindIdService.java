package shoppingmall.service.help;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import shoppingmall.repository.MemberRepository;


@Service
public class FindIdService {
	@Autowired
	MemberRepository memberRepository;

	public void execute(String userPhone, Model model) {

        String userId = memberRepository.findUserIdByPhone(userPhone);
        model.addAttribute("userId", userId != null ? userId : "");

	}
}
