package shoppingmall.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.servlet.http.HttpSession;
import shoppingmall.command.InquireCommand;
import shoppingmall.service.inquire.InquireAutoNumService;
import shoppingmall.service.inquire.InquireListService;
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
	
}
