package shoppingmall.service.library;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import jakarta.servlet.http.HttpSession;
import shoppingmall.domain.AuthInfoDTO;
import shoppingmall.domain.LibraryDTO;
import shoppingmall.mapper.LibraryMapper;

@Service
public class LibraryDetailService {

	@Autowired
	LibraryMapper libraryMapper;
	public void execute(Model model, int libNum, HttpSession session) {
    	AuthInfoDTO auth = (AuthInfoDTO) session.getAttribute("auth");

    	 // 조회수 증가
        libraryMapper.incrementReadCount(libNum);
    	
		LibraryDTO dto = libraryMapper.libSelectOne(libNum);
		model.addAttribute("libraryCommand", dto);
		
	}
	
}
