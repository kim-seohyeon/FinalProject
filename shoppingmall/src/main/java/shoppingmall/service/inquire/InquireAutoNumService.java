package shoppingmall.service.inquire;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import shoppingmall.command.InquireCommand;
import shoppingmall.repository.InquireRepository;

@Service
public class InquireAutoNumService {

	@Autowired
	InquireRepository inquireRepository;
	
	public void execute(Model model) {

		String inquireNum = inquireRepository.inquireNumAutoSelect();
		
		InquireCommand inquireCommand = new InquireCommand();
		inquireCommand.setInquireNum(inquireNum);
		
		model.addAttribute("inquireCommand", inquireCommand);

	}

}
