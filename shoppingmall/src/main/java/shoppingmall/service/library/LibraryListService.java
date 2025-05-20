package shoppingmall.service.library;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import shoppingmall.domain.LibraryDTO;
import shoppingmall.domain.StartEndPageDTO;
import shoppingmall.mapper.LibraryMapper;
import shoppingmall.service.StartEndPageService;

@Service
public class LibraryListService {

	@Autowired
	LibraryMapper libraryMapper;
	@Autowired
	StartEndPageService startEndPageService;
	public void execute(Model model, int page, String searchWord) {
		
		int limit = 6;
		//1페이지 : 1~10 2페이지 : 11~20
		StartEndPageDTO sepDTO = startEndPageService.execute(page, limit, searchWord);
		List<LibraryDTO> list = libraryMapper.libSelectList(sepDTO);

		//게시물 갯수
		int libCount = libraryMapper.libraryCount(searchWord);
		startEndPageService.execute(page, limit, libCount, list, model, searchWord);

	}	
}
