package shoppingmall.service.community;

import java.sql.Date;
import java.time.LocalDate;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import jakarta.servlet.http.HttpSession;
import shoppingmall.command.CommunityCommand;
import shoppingmall.domain.AuthInfoDTO;
import shoppingmall.domain.CommunityDTO;
import shoppingmall.domain.MemberDTO;
import shoppingmall.repository.CommunityRepository;
import shoppingmall.repository.MemberRepository;

@Service
public class CommunityWriteService {

	@Autowired
	CommunityRepository communityRepository;
	@Autowired
	MemberRepository memberRepository;
	public void execute(CommunityCommand communityCommand, HttpSession session) {
    	AuthInfoDTO auth = (AuthInfoDTO)session.getAttribute("auth");
    	MemberDTO mdto = memberRepository.memberSelectOne(auth.getUserId());
    	
    	CommunityDTO dto = new CommunityDTO();
    	dto.setCommunityNum(communityCommand.getCommunityNum());
        dto.setCommunityWriter(communityCommand.getCommunityWriter());
        dto.setCommunitySubject(communityCommand.getCommunitySubject());
        dto.setCommunityContent(communityCommand.getCommunityContent());
        dto.setMemberNum(mdto.getMemberNum());
        dto.setCommunityDate(Date.valueOf(LocalDate.now()));
        communityRepository.communityInsert(dto);
        dto.setCommunityDate(new java.sql.Date(System.currentTimeMillis())); // 📌 등록일 추가

	}
	
}
