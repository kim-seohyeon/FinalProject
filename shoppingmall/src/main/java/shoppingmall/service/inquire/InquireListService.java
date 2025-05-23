package shoppingmall.service.inquire;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import shoppingmall.domain.InquireDTO;
import shoppingmall.repository.InquireRepository;

@Service
public class InquireListService {

	@Autowired
	InquireRepository inquireRepository;
	
	public void execute(Model model) {
		List<InquireDTO> list = inquireRepository.inquireSelectAll();
	    System.out.println("inquire List Size: " + list.size()); // 리스트 크기 확인
		model.addAttribute("list", list);		
	}

}
