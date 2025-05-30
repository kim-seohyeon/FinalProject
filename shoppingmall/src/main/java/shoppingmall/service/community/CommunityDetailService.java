package shoppingmall.service.community;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import jakarta.servlet.http.HttpSession;
import shoppingmall.domain.AuthInfoDTO;
import shoppingmall.domain.CommentDTO;
import shoppingmall.domain.CommunityDTO;
import shoppingmall.domain.MemberDTO;
import shoppingmall.repository.CommentRepository;
import shoppingmall.repository.CommunityRepository;
import shoppingmall.repository.MemberRepository;

@Service
public class CommunityDetailService {

    @Autowired
    CommunityRepository communityRepository;
    @Autowired
    MemberRepository memberRepository;
    @Autowired
    CommentRepository commentRepository;
    public void execute(String communityNum, Model model, HttpSession session) {
        CommunityDTO dto = communityRepository.communitySelectOne(communityNum);
        model.addAttribute("community", dto);
        
        // 댓글
        List<CommentDTO> commentList = communityRepository.commentSelectAllByCommunityNum(communityNum);
        model.addAttribute("commentList", commentList);
        
        // 좋아요
        AuthInfoDTO auth = (AuthInfoDTO) session.getAttribute("auth");
        if (auth != null) {
        MemberDTO mdto = memberRepository.memberSelectOne(auth.getUserId());
        String num = communityRepository.selectLike(communityNum, mdto.getMemberNum());
        
        model.addAttribute("num", num);
        }else {
            model.addAttribute("num", null);
    }
  }
}