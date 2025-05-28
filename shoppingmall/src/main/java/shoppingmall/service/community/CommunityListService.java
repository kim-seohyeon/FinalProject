package shoppingmall.service.community;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import shoppingmall.domain.CommunityDTO;
import shoppingmall.repository.CommunityRepository;

@Service
public class CommunityListService {

	@Autowired
	CommunityRepository communityRepository;
	
	 public void execute(Model model) {
	        // 메서드 이름 수정
	        List<CommunityDTO> list = communityRepository.communitySelectAll();
	        System.out.println("community List Size: " + list.size()); // 리스트 크기 확인
	        model.addAttribute("list", list);
	    }
	
}
