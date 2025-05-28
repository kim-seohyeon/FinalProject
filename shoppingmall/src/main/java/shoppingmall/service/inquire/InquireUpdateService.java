package shoppingmall.service.inquire;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import jakarta.servlet.http.HttpSession;
import shoppingmall.command.InquireCommand;
import shoppingmall.domain.AuthInfoDTO;
import shoppingmall.domain.InquireDTO;
import shoppingmall.repository.InquireRepository;

@Service
public class InquireUpdateService {

	@Autowired
	InquireRepository inquireRepository;
	
	public void execute(InquireCommand inquireCommand, HttpSession session) {

        AuthInfoDTO auth = (AuthInfoDTO) session.getAttribute("auth");
		
		InquireDTO dto = inquireRepository.inquireSelectOne(inquireCommand.getInquireNum());
		dto.setInquireNum(inquireCommand.getInquireNum());
		dto.setInquireWriter(inquireCommand.getInquireWriter());
		dto.setInquireSubject(inquireCommand.getInquireSubject());
		dto.setInquireContents(inquireCommand.getInquireContents());
	
		inquireRepository.inquireUpdate(dto);
	
	}

}
