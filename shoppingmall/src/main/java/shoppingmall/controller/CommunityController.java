package shoppingmall.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.servlet.http.HttpSession;
import shoppingmall.command.CommunityCommand;
import shoppingmall.domain.AuthInfoDTO;
import shoppingmall.domain.CommentDTO;
import shoppingmall.domain.CommunityDTO;
import shoppingmall.repository.CommentRepository;
import shoppingmall.repository.CommunityRepository;
import shoppingmall.service.community.CommentWriteService;
import shoppingmall.service.community.CommunityAutoNumService;
import shoppingmall.service.community.CommunityDetailService;
import shoppingmall.service.community.CommunityListService;
import shoppingmall.service.community.CommunityUpdateService;
import shoppingmall.service.community.CommunityWriteService;
import shoppingmall.service.comment.CommentUpdateService;  // 새로 추가한 서비스

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
    
    @Autowired
    CommunityUpdateService communityUpdateService;

    @Autowired
    CommunityRepository communityRepository;

    @Autowired
    CommentUpdateService commentUpdateService;
    
    @Autowired
    CommentRepository commentRepository;


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
    public String detail(String communityNum, Model model, HttpSession session) {
        communityDetailService.execute(communityNum, model);  // 게시글 + 댓글 서비스 실행
     // 세션에서 로그인 정보 가져와 model에 넣기 (auth는 JSP에서 사용됨)
        AuthInfoDTO auth = (AuthInfoDTO) session.getAttribute("auth");
        model.addAttribute("auth", auth);
        
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
    
    @GetMapping("/update")
    public String showUpdateForm(String communityNum, HttpSession session, Model model) {
        // 글 상세 정보 가져오기
        communityDetailService.execute(communityNum, model);
        
        // 글 정보 꺼내기
        CommunityDTO dto = (CommunityDTO) model.getAttribute("community");
        AuthInfoDTO auth = (AuthInfoDTO) session.getAttribute("auth");

        if (dto == null || auth == null || !dto.getCommunityWriter().equals(auth.getUserId())) {
            // 작성자가 아니면 접근 불가 처리 (목록으로 돌리거나 에러페이지)
            return "redirect:/community/communityList";
        }
        
        return "community/communityUpdateForm";  // 수정 폼 JSP
    }

    // 수정 처리
    @PostMapping("/update")
    public String submitUpdate(CommunityCommand communityCommand, HttpSession session) {
    	communityUpdateService.execute(communityCommand, session);
        return "redirect:/community/communityDetail?communityNum=" + communityCommand.getCommunityNum();
    }
    
    @GetMapping("/delete")
    public String deletePost(String communityNum, HttpSession session) {
        AuthInfoDTO auth = (AuthInfoDTO) session.getAttribute("auth");
        CommunityDTO dto = communityRepository.communitySelectOne(communityNum);

        if (dto == null || auth == null || !dto.getCommunityWriter().equals(auth.getUserId())) {
            // 권한 없으면 목록으로 리다이렉트
            return "redirect:/community/communityList";
        }

        communityRepository.deleteCommunity(communityNum);
        return "redirect:/community/communityList";
    }
    
    // 댓글 수정 처리
    @PostMapping("/commentUpdate")
    public String commentUpdate(CommentDTO commentDTO, HttpSession session) {
        commentUpdateService.execute(commentDTO, session);
        return "redirect:/community/communityDetail?communityNum=" + commentDTO.getCommunityNum();
    }

    @GetMapping("/commentDelete")
    public String commentDelete(String commentNum, String communityNum, HttpSession session) {
        // 권한 확인 (선택)
        AuthInfoDTO auth = (AuthInfoDTO) session.getAttribute("auth");
        // 여기서 댓글 작성자와 로그인한 유저를 비교해도 좋아요
        
        // 실제 삭제 처리
        commentRepository.deleteComment(commentNum);
        
        // 삭제 후 다시 해당 게시글 상세보기로 리다이렉트
        return "redirect:/community/communityDetail?communityNum=" + communityNum;
    }

    
}
