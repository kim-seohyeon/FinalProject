package shoppingmall.service.inquire;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import shoppingmall.command.InquireCommand;
import shoppingmall.domain.InquireDTO;
import shoppingmall.repository.InquireRepository;

@Service
public class InquireUpdateService {

	@Autowired
	InquireRepository inquireRepository;
	
	public void execute(InquireCommand inquireCommand) {

		InquireDTO dto = inquireRepository.inquireSelectOne(inquireCommand.getInquireNum());
		dto.setInquireNum(inquireCommand.getInquireNum());
		dto.setInquireWriter(inquireCommand.getInquireWriter());
		dto.setInquireSubject(inquireCommand.getInquireSubject());
		dto.setInquireContents(inquireCommand.getInquireContents());
	
		inquireRepository.inquireUpdate(dto);
	
	}

}
