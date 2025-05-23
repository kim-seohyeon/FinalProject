package shoppingmall.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.servlet.http.HttpSession;
import shoppingmall.command.CommunityCommand;
import shoppingmall.domain.CommentDTO;
import shoppingmall.service.community.CommentWriteService;
import shoppingmall.service.community.CommunityAutoNumService;
import shoppingmall.service.community.CommunityDetailService;
import shoppingmall.service.community.CommunityListService;
import shoppingmall.service.community.CommunityWriteService;

@Controller
@RequestMapping("/community")
public class CommunityController {

    @Autowired
    CommunityAutoNumService communityAutoNumService;

    @Autowired
    CommunityListService communityListService;

    @Autowired
    CommunityWriteService communityWriteService;

    @Autowired
    CommunityDetailService communityDetailService;

    @Autowired
    CommentWriteService commentWriteService;

    // 커뮤니티 게시글 목록
    @GetMapping("/communityList")
    public String list(Model model) {
        communityListService.execute(model);
        return "community/communityList";
    }

    // 글쓰기 폼
    @GetMapping("/write")
    public String showWriteForm(Model model) {
        communityAutoNumService.execute(model);
        return "community/communityForm";
    }

    // 글 작성 저장 처리
    @PostMapping("/write")
    public String submitPost(CommunityCommand communityCommand, HttpSession session) {
        communityWriteService.execute(communityCommand, session);
        return "redirect:/community/communityList";
    }

    // 게시글 상세보기 + 댓글 목록 포함
    @GetMapping("/communityDetail")
    public String detail(String communityNum, Model model) {
        communityDetailService.execute(communityNum, model);  // 게시글 + 댓글 서비스 실행
        return "community/communityDetail";
    }

    // 루트로 접속하면 목록으로 리다이렉트
    @GetMapping("")
    public String redirectToList() {
        return "redirect:/community/communityList";
    }

    // 댓글 작성 처리 (communityDetail.jsp 내의 form에서 이 경로로 POST 요청)
    @PostMapping("/commentWrite")
    public String commentWrite(CommentDTO commentDTO, HttpSession session) {
        commentWriteService.execute(commentDTO, session);
        return "redirect:/community/communityDetail?communityNum=" + commentDTO.getCommunityNum();
    }
    
}
