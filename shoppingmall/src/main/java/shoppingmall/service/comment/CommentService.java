package shoppingmall.service.comment;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import shoppingmall.domain.CommunityDTO;
import shoppingmall.domain.MemberDTO;
import shoppingmall.repository.CommentRepository;
import shoppingmall.repository.MemberRepository;

@Service
public class CommentService {

    @Autowired
    private CommentRepository commentRepository;

    @Autowired
    private MemberRepository memberRepository;

    // memberNum으로 댓글 단 게시글 리스트 가져오기
    public List<CommunityDTO> getCommunityByMemberNum(String memberNum) {
        return commentRepository.findCommunityByMemberNum(memberNum);
    }
}
