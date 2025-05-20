package shoppingmall.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import shoppingmall.domain.StartEndPageDTO;

@Service
public class StartEndPageService {
	public StartEndPageDTO execute(int page, int limit, String searchWord) {
		int startRow = (page - 1) * limit + 1; // 1, 11, 21, 31
		int endRow = startRow + limit -1;
		StartEndPageDTO sepDTO = new StartEndPageDTO(startRow, endRow, searchWord);
		return sepDTO;
	}
	
	public void execute(int page, int limit, int count, List list, Model model, String searchWord) {
		int limitPage = 10;	// 13 / 10 = 1.3+0.95 = 2.25-1 = 1.25*10+1
		int startPageNum = (int)((double)page / limitPage + 0.95 - 1) * limitPage + 1;
		int endPageNum = startPageNum + limitPage -1;
		
		//최대 페이지수 11/10 = 1.1+0.95
		int maxPage = (int)((double)count / limit + 0.95);
		//1~10
		if(endPageNum > maxPage) endPageNum = maxPage;
		
		
		model.addAttribute("list", list);
		model.addAttribute("page", page);
		model.addAttribute("startPageNum", startPageNum);
		model.addAttribute("endPageNum", endPageNum);
		model.addAttribute("maxPage", maxPage);
		model.addAttribute("count", count);
		model.addAttribute("searchWord", searchWord);


	}
}
