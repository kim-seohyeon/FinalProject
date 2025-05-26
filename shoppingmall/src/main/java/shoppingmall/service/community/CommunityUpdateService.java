package shoppingmall.service.community;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import jakarta.servlet.http.HttpSession;
import shoppingmall.command.CommunityCommand;
import shoppingmall.domain.AuthInfoDTO;
import shoppingmall.domain.CommunityDTO;
import shoppingmall.repository.CommunityRepository;

@Service
public class CommunityUpdateService {


	
	 @Autowired
	    CommunityRepository communityRepository;

	    public void execute(CommunityCommand communityCommand, HttpSession session) {
	        AuthInfoDTO auth = (AuthInfoDTO) session.getAttribute("auth");
	        
	        // 원래 글 데이터 불러오기
	        CommunityDTO original = communityRepository.communitySelectOne(communityCommand.getCommunityNum());
	        
	        if (original == null) {
	            throw new RuntimeException("게시글 없음");
	        }
	        
	        // 작성자 확인
	        if (!original.getCommunityWriter().equals(auth.getUserId())) {
	            throw new RuntimeException("작성자만 수정 가능");
	        }
	        
	        // 업데이트할 내용 설정
	        original.setCommunitySubject(communityCommand.getCommunitySubject());
	        original.setCommunityContent(communityCommand.getCommunityContent());
	        // 필요하면 수정일 등 추가
	        
	        communityRepository.communityUpdate(original);
	    }
	}

