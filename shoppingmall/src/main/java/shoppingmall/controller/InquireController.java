package shoppingmall.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.servlet.http.HttpSession;
import shoppingmall.command.IcommentCommand;
import shoppingmall.command.InquireCommand;
import shoppingmall.service.icomment.IcommentDeleteService;
import shoppingmall.service.icomment.IcommentUpdateService;
import shoppingmall.service.icomment.IcommentWriteService;
import shoppingmall.service.inquire.InquireAutoNumService;
import shoppingmall.service.inquire.InquireDeleteService;
import shoppingmall.service.inquire.InquireDetailService;
import shoppingmall.service.inquire.InquireListService;
import shoppingmall.service.inquire.InquireUpdateService;
import shoppingmall.service.inquire.InquireWriteService;

@Controller
@RequestMapping("/inquire")
public class InquireController {
	
	@Autowired
	InquireAutoNumService inquireAutoNumService;
	@Autowired
	InquireListService inquireListService;
	@Autowired
	InquireWriteService inquireWriteService;
	@Autowired
	InquireDetailService inquireDetailService;
	@Autowired
	InquireUpdateService inquireUpdateService;
	@Autowired
	InquireDeleteService inquireDeleteService;
	
	@Autowired
	IcommentWriteService icommentWriteService;
	@Autowired
	IcommentUpdateService icommentUpdateService;
	@Autowired
	IcommentDeleteService icommentDeleteService;
	
	
	@GetMapping("/inquireList")
	public String list(Model model){
		inquireListService.execute(model);
		return "inquire/inquireList";
	}
	
	@GetMapping("/write")
	public String write(Model model){
		inquireAutoNumService.execute(model);
		return "inquire/inquireForm";
	}
	
	@PostMapping("/write")
	public String write(InquireCommand inquireCommand, HttpSession session) {
		inquireWriteService.execute(inquireCommand, session);
		return "redirect:/inquire/inquireList";
	}
	
    // 게시글 상세보기 + 댓글 목록 포함
    @GetMapping("/inquireDetail")
    public String detail(Model model, String inquireNum, HttpSession session) {
        inquireDetailService.execute(model, inquireNum, session);
        return "inquire/inquireInfo";
    }
    
	@GetMapping("/inquireUpdate")
	public String update(Model model, String inquireNum, HttpSession session) {
        inquireDetailService.execute(model, inquireNum, session);
		return "inquire/inquireModify";
	}
	
	@PostMapping("/inquireModify")
	public String Update(InquireCommand inquireCommand, HttpSession session) {
	    inquireUpdateService.execute(inquireCommand, session);
		return "redirect:/inquire/inquireDetail?inquireNum=" + inquireCommand.getInquireNum();

	}
	
	@GetMapping("/inquireDelete")
	public String delete(String inquireNum, HttpSession session) {
		inquireDeleteService.execute(inquireNum, session);
		return "redirect:/inquire/inquireList";
	}
	
	//댓글
	@PostMapping("/icommentWrite")
	public String icommentWrite(IcommentCommand icommentCommand, HttpSession session) {
		icommentWriteService.execute(icommentCommand, session);
		return "redirect:/inquire/inquireDetail?inquireNum="+icommentCommand.getInquireNum();
	}
	
//    @GetMapping("/icommentUpdate")
//    public String icommentUpdate(IcommentCommand icommentCommand, HttpSession session) {
//        icommentUpdateService.execute(icommentCommand, session);
//        return "redirect:/inquire/inquireDetail?inquireNum=" + icommentCommand.getInquireNum();
//    }
  
    @GetMapping("/icommentDelete")
    public String icommentDelete(String icommentId, String inquireNum, HttpSession session) {
        icommentDeleteService.execute(icommentId, inquireNum, session);
        return "redirect:/inquire/inquireDetail?inquireNum=" + inquireNum;
    }
    
}
