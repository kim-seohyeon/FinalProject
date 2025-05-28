package shoppingmall.service.inquire;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import jakarta.servlet.http.HttpSession;
import shoppingmall.domain.AuthInfoDTO;
import shoppingmall.domain.IcommentDTO;
import shoppingmall.domain.InquireDTO;
import shoppingmall.repository.InquireRepository;

@Service
public class InquireDetailService {

	@Autowired
	InquireRepository inquireRepository;
	
	public void execute(Model model, String inquireNum, HttpSession session) {
        AuthInfoDTO auth = (AuthInfoDTO) session.getAttribute("auth");
		
        InquireDTO dto = inquireRepository.inquireSelectOne(inquireNum);
		model.addAttribute("dto", dto);
		
		List<IcommentDTO> icommentList = inquireRepository.icommentSelectAllByCommunityNum(inquireNum);
        System.out.println(icommentList.size());
		model.addAttribute("icommentList", icommentList);
	}

	
	
}
