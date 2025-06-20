package shoppingmall.controller;

import java.io.File;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import jakarta.servlet.http.HttpSession;
import shoppingmall.command.CommunityCommand;
import shoppingmall.domain.AuthInfoDTO;
import shoppingmall.domain.CommentDTO;
import shoppingmall.domain.CommunityDTO;
import shoppingmall.domain.MemberDTO;
import shoppingmall.repository.CommentRepository;
import shoppingmall.repository.CommunityRepository;
import shoppingmall.repository.MemberRepository;
import shoppingmall.service.comment.CommentService;
import shoppingmall.service.comment.CommentUpdateService;
import shoppingmall.service.comment.CommentWriteService;
import shoppingmall.service.community.CommunityAutoNumService;
import shoppingmall.service.community.CommunityDetailService;
import shoppingmall.service.community.CommunityLikeService;
import shoppingmall.service.community.CommunityListService;
import shoppingmall.service.community.CommunityService;
import shoppingmall.service.community.CommunityUpdateService;
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

    @Autowired
    CommunityUpdateService communityUpdateService;

    @Autowired
    CommunityRepository communityRepository;

    @Autowired
    CommentUpdateService commentUpdateService;

    @Autowired
    CommentRepository commentRepository;

    @Autowired
    CommunityLikeService communityLikeService;
    
    @Autowired
    MemberRepository memberRepository;
    
    @Autowired
    CommentService commentService;
    
    @Autowired
    CommunityService communityService;
    
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

    @PostMapping("/write")
    public String submitPost(CommunityCommand communityCommand, HttpSession session) {
        MultipartFile uploadImage = communityCommand.getUploadImage();

        if (uploadImage != null && !uploadImage.isEmpty()) {
            try {
                String originalFileName = uploadImage.getOriginalFilename();
                String extension = originalFileName.substring(originalFileName.lastIndexOf("."));
                String storedFileName = UUID.randomUUID().toString().replace("-", "") + extension;

                String uploadDirPath = Paths.get("src/main/resources/static/upload/community").toString();
                File uploadDir = new File(uploadDirPath);
                if (!uploadDir.exists()) uploadDir.mkdirs();

                File dest = new File(uploadDir, storedFileName);
                uploadImage.transferTo(dest);

                String dbPath = "upload/community/" + storedFileName;
                communityCommand.setImagePath(dbPath);

                System.out.println("DB에 저장될 이미지 경로: " + dbPath);
            } catch (Exception e) {
                e.printStackTrace();
            }
        } else {
            System.out.println("이미지 파일이 비어있음. null 저장 예정.");
        }

        communityWriteService.execute(communityCommand, session);
        return "redirect:/community/communityList";
    }

    // 게시글 상세보기 + 댓글 목록 포함 (기존 기능 모두 포함)
    @GetMapping("/communityDetail")
    public String detail(String communityNum, Model model, HttpSession session) {
    	
    	 @SuppressWarnings("unchecked")
    	    List<String> viewedPosts = (List<String>) session.getAttribute("viewedPosts");
    	    if (viewedPosts == null) {
    	        viewedPosts = new ArrayList<>();
    	    }

    	    if (!viewedPosts.contains(communityNum)) {
    	        // 조회한 적 없으면 조회수 증가
    	        communityService.incrementViewCount(communityNum);

    	        // 세션에 추가해서 중복 조회 막기
    	        viewedPosts.add(communityNum);
    	        session.setAttribute("viewedPosts", viewedPosts);
    	    }
    	
    
        // 상세 게시글 데이터 받아오기 (댓글 목록도 모델에 담겨야 함)
        communityDetailService.execute(communityNum, model, session);

        // 좋아요 관련 처리
        AuthInfoDTO auth = (AuthInfoDTO) session.getAttribute("auth");
        if (auth != null) {
            boolean userLiked = communityLikeService.hasUserLiked(communityNum, session);
            model.addAttribute("userLiked", userLiked);
        }

        int likeCount = communityLikeService.getLikeCount(communityNum);
        model.addAttribute("likeCount", likeCount);

        return "community/communityDetail";
    }


    @PostMapping("/commentWrite")
    public String commentWrite(CommentDTO commentDTO, HttpSession session) {
        commentWriteService.execute(commentDTO, session);
        return "redirect:/community/communityDetail?communityNum=" + commentDTO.getCommunityNum();
    }

    @GetMapping("/update")
    public String showUpdateForm(String communityNum, HttpSession session, Model model) {
        communityDetailService.execute(communityNum, model, session);
        CommunityDTO dto = (CommunityDTO) model.getAttribute("community");
        AuthInfoDTO auth = (AuthInfoDTO) session.getAttribute("auth");

        if (dto == null || auth == null || !dto.getCommunityWriter().equals(auth.getUserId())) {
            return "redirect:/community/communityList";
        }
        return "community/communityUpdateForm";
    }

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
            return "redirect:/community/communityList";
        }

        communityRepository.deleteCommunity(communityNum);
        return "redirect:/community/communityList";
    }

    @PostMapping("/commentUpdate")
    public String commentUpdate(CommentDTO commentDTO, HttpSession session) {
        commentUpdateService.execute(commentDTO, session);
        return "redirect:/community/communityDetail?communityNum=" + commentDTO.getCommunityNum();
    }

    // POST 방식으로 변경한 댓글 삭제
    @PostMapping("/commentDelete")
    public String commentDelete(String commentNum, String communityNum, HttpSession session) {
        AuthInfoDTO auth = (AuthInfoDTO) session.getAttribute("auth");
        // 필요시 인증 체크 추가 가능
        commentRepository.deleteComment(commentNum);
        return "redirect:/community/communityDetail?communityNum=" + communityNum;
    }

    @PostMapping("/like")
    public String like(String communityNum, HttpSession session) {
        communityLikeService.toggleLike(communityNum, session);
        return "redirect:/community/communityDetail?communityNum=" + communityNum;
    }

    @GetMapping("/myActivity")
    public String myActivity() {
        // 내 활동 페이지 (버튼만 있는 페이지)
        return "community/myActivity"; 
    }

    @GetMapping("/myLikesPosts")
    public String myLikedPosts(Model model, HttpSession session) {
        AuthInfoDTO auth = (AuthInfoDTO)session.getAttribute("auth");
        MemberDTO member = memberRepository.memberSelectOne(auth.getUserId());
        List<CommunityDTO> likedPosts = communityLikeService.getLikedPosts(member.getMemberNum());
        model.addAttribute("likedPosts", likedPosts);
        return "community/myLikedPosts";
    }

    @GetMapping("/myCommentedPosts")
    public String myCommentedPosts(Model model, HttpSession session) {
        AuthInfoDTO auth = (AuthInfoDTO) session.getAttribute("auth");
        if (auth == null) {
            return "redirect:/login";  // 로그인 안 됐으면 로그인 페이지로
        }
        MemberDTO member = memberRepository.memberSelectOne(auth.getUserId());

        List<CommunityDTO> commentedPosts = commentService.getCommunityByMemberNum(member.getMemberNum());
        model.addAttribute("list", commentedPosts);
        return "community/myCommentedPosts";
    }  
    
    @GetMapping("/myPosts")
    public String myPosts(Model model, HttpSession session) {
        AuthInfoDTO auth = (AuthInfoDTO) session.getAttribute("auth");
        if (auth == null) {
            return "redirect:/login";
        }

        String writerId = auth.getUserId(); // ← 로그인된 사용자 ID
        List<CommunityDTO> myPosts = communityService.getPostsByWriter(writerId);

        model.addAttribute("list", myPosts);

        return "community/myPosts";
    }

}
