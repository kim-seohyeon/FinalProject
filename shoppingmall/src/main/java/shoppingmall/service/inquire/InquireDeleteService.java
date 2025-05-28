package shoppingmall.service.inquire;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import jakarta.servlet.http.HttpSession;
import shoppingmall.domain.AuthInfoDTO;
import shoppingmall.repository.InquireRepository;

@Service
public class InquireDeleteService {

	@Autowired
	InquireRepository inquireRepository;
	public void execute(String inquireNum, HttpSession session) {
		
        AuthInfoDTO auth = (AuthInfoDTO) session.getAttribute("auth");

		
		inquireRepository.inquireDelete(inquireNum);
	}
}
