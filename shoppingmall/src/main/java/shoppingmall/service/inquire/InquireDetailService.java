package shoppingmall.service.inquire;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import jakarta.servlet.http.HttpServletRequest;
import shoppingmall.domain.InquireDTO;
import shoppingmall.repository.InquireRepository;

@Service
public class InquireDetailService {

	@Autowired
	InquireRepository inquireRepository;
	
	public void execute(Model model, String inquireNum) {

		InquireDTO dto = inquireRepository.inquireSelectOne(inquireNum);
		model.addAttribute("dto", dto);
		
	}

	
	
}
