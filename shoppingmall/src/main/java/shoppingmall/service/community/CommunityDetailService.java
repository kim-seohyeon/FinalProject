package shoppingmall.service.community;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import shoppingmall.domain.CommentDTO;
import shoppingmall.domain.CommunityDTO;
import shoppingmall.repository.CommentRepository;
import shoppingmall.repository.CommunityRepository;

@Service
public class CommunityDetailService {

    @Autowired
    CommunityRepository communityRepository;

    public void execute(String communityNum, Model model) {
        CommunityDTO dto = communityRepository.communitySelectOne(communityNum);
        model.addAttribute("community", dto);
        
        List<CommentDTO> commentList = communityRepository.commentSelectAllByCommunityNum(communityNum);
        model.addAttribute("commentList", commentList);
    }
    @Autowired
    CommentRepository commentRepository;
    
    
}