package shoppingmall.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpSession;
import shoppingmall.command.LibraryCommand;
import shoppingmall.service.FileDownloadService;
import shoppingmall.service.library.LibraryCheckDeleteService;
import shoppingmall.service.library.LibraryDeleteService;
import shoppingmall.service.library.LibraryDetailService;
import shoppingmall.service.library.LibraryInsertService;
import shoppingmall.service.library.LibraryListService;
import shoppingmall.service.library.LibraryUpdateService;

@Controller
public class LibraryController {
	@Autowired
	LibraryInsertService librarInsertService;
	@Autowired
	LibraryListService libraryListService;
	@Autowired
	LibraryDetailService libraryDetailService;
	@Autowired
	LibraryDeleteService libraryDeleteService;
	@Autowired
	LibraryUpdateService libraryUpdateService;
	@Autowired
	FileDownloadService fileDownloadService;
	@Autowired
	LibraryCheckDeleteService libraryCheckDeleteService;
	
	
	@GetMapping("/library")
	public String form(@RequestParam(value = "page", defaultValue = "1", required = false) 
							int page, Model model, @RequestParam(value="searchWord", required = false, defaultValue = "") String searchWord) {
		libraryListService.execute(model, page, searchWord);
		//return "library/libList";
		return "library/libList";
	}
	
	@GetMapping("/libWrite")
	public String write(LibraryCommand libraryCommand) {
		return "library/libForm";
	}
	
	@PostMapping("/libWrite")
	public String write(@Validated LibraryCommand libraryCommand
						, BindingResult result) {
		if(result.hasErrors()) {
			return "library/libForm";
		}
		librarInsertService.execute(libraryCommand);
		return "redirect:library";
	}
	
	@GetMapping("/libInfo")
	public String info(Model model, int libNum) {
		libraryDetailService.execute(model, libNum);
		return "library/libDetail";
	}

	@GetMapping("/libUpdate")
	public String update(Model model, int libNum) {
		libraryDetailService.execute(model, libNum);
		return "library/libModify";
	}
	
	@PostMapping("/libUpdate")
	public String update(LibraryCommand libraryCommand, HttpSession session) {
		libraryUpdateService.execute(libraryCommand, session);
		return "redirect:libInfo?libNum="+libraryCommand.getLibNum();
	}
	
	@GetMapping("/libDelete")
	public String delete(int libNum) {
		
		libraryDeleteService.execute(libNum);
		return "redirect:/library";
	}
	
	@GetMapping("/libDownLoad")
	public ResponseEntity<Resource> download(String oname, String sname) throws Exception{
		return fileDownloadService.execute(oname, sname);
	}
	
	@PostMapping("/libDelete")
	public String delete(int nums[]) {
		libraryCheckDeleteService.execute(nums);
		return "redirect:library";
	}
}
