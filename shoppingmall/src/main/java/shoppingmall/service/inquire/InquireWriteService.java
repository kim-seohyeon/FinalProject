package shoppingmall.service.inquire;

import java.sql.Date;
import java.time.LocalDate;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import jakarta.servlet.http.HttpSession;
import shoppingmall.command.InquireCommand;
import shoppingmall.domain.AuthInfoDTO;
import shoppingmall.domain.InquireDTO;
import shoppingmall.domain.MemberDTO;
import shoppingmall.repository.InquireRepository;
import shoppingmall.repository.MemberRepository;

@Service
public class InquireWriteService {

	@Autowired
	InquireRepository inquireRepository;
	@Autowired
	MemberRepository memberRepository;
	
	public void execute(InquireCommand inquireCommand, HttpSession session) {

		AuthInfoDTO auth = (AuthInfoDTO)session.getAttribute("auth");
    	MemberDTO mdto = memberRepository.memberSelectOne(auth.getUserId());
    	
    	InquireDTO dto = new InquireDTO();
    	dto.setInquireNum(inquireCommand.getInquireNum());
        dto.setInquireWriter(inquireCommand.getInquireWriter());
        dto.setInquireSubject(inquireCommand.getInquireSubject());
        dto.setInquireContents(inquireCommand.getInquireContents());
        dto.setInquireDate(inquireCommand.getInquireDate());
        dto.setMemberNum(mdto.getMemberNum());
        inquireRepository.inquireInsert(dto);

		
		
	}

}
