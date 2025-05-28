package shoppingmall.service.comment;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import jakarta.servlet.http.HttpSession;
import shoppingmall.domain.AuthInfoDTO;
import shoppingmall.domain.CommentDTO;
import shoppingmall.domain.MemberDTO;
import shoppingmall.repository.CommentRepository;
import shoppingmall.repository.MemberRepository;

@Service
public class CommentWriteService {

    @Autowired
    CommentRepository commentRepository;
    @Autowired
    MemberRepository memberRepository;
    // 댓글 등록 처리
    public void execute(CommentDTO commentDTO, HttpSession session) {
        // 댓글 저장
    	AuthInfoDTO auth = (AuthInfoDTO) session.getAttribute("auth");
    	MemberDTO dto = memberRepository.memberSelectOne(auth.getUserId());
    	commentDTO.setMemberNum(dto.getMemberNum());
        commentRepository.commentInsert(commentDTO);
    }
}
