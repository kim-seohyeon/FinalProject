package shoppingmall.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import shoppingmall.command.InquireCommand;
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
	
    @GetMapping("/inquireDetail")
    public String detail(HttpServletRequest request, Model model, String inquireNum, HttpSession session) {
        inquireDetailService.execute(request, model, inquireNum);
        return "inquire/inquireInfo";
    }
    
	@GetMapping("/inquireUpdate")
	public String update(HttpServletRequest request, Model model, String inquireNum) {
        inquireDetailService.execute(request, model, inquireNum);
		return "inquire/inquireModify";
	}
	
	@PostMapping("/inquireModify")
	public String Update(InquireCommand inquireCommand) {
	    inquireUpdateService.execute(inquireCommand);
		return "redirect:/inquire/inquireDetail?inquireNum=" + inquireCommand.getInquireNum();

	}
	
	@GetMapping("/inquireDelete")
	public String delete(String inquireNum) {
		inquireDeleteService.execute(inquireNum);
		return "redirect:/inquire/inquireList";
	}
}
