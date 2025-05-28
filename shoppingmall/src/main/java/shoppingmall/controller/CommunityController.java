package shoppingmall.controller;

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
import shoppingmall.repository.CommentRepository;
import shoppingmall.repository.CommunityRepository;
import shoppingmall.service.community.CommunityAutoNumService;
import shoppingmall.service.community.CommunityDetailService;
import shoppingmall.service.community.CommunityListService;
import shoppingmall.service.community.CommunityUpdateService;
import shoppingmall.service.community.CommunityWriteService;
import shoppingmall.service.comment.CommentUpdateService;
import shoppingmall.service.comment.CommentWriteService;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.nio.file.Files;
import java.util.UUID;

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

    @PostMapping("/write")
    public String submitPost(CommunityCommand communityCommand, HttpSession session) {
        MultipartFile uploadImage = communityCommand.getUploadImage();

        if (uploadImage != null && !uploadImage.isEmpty()) {
            try {
                String originalFileName = uploadImage.getOriginalFilename();
                String extension = originalFileName.substring(originalFileName.lastIndexOf("."));
                String storedFileName = UUID.randomUUID().toString().replace("-", "") + extension;

                // 실제 파일 저장 경로 (static 아래)
                String uploadDirPath = Paths.get("src/main/resources/static/upload/community").toString();
                File uploadDir = new File(uploadDirPath);
                if (!uploadDir.exists()) uploadDir.mkdirs();

                File dest = new File(uploadDir, storedFileName);
				uploadImage.transferTo(dest);

                // DB에 저장할 상대 경로 (주의: /resources 빼고!)
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

    // 게시글 상세보기 + 댓글 목록 포함
    @GetMapping("/communityDetail")
    public String detail(String communityNum, Model model, HttpSession session) {
        communityDetailService.execute(communityNum, model);
        AuthInfoDTO auth = (AuthInfoDTO) session.getAttribute("auth");
        model.addAttribute("auth", auth);
        return "community/communityDetail";
    }

    @GetMapping("")
    public String redirectToList() {
        return "redirect:/community/communityList";
    }

    @PostMapping("/commentWrite")
    public String commentWrite(CommentDTO commentDTO, HttpSession session) {
        commentWriteService.execute(commentDTO, session);
        return "redirect:/community/communityDetail?communityNum=" + commentDTO.getCommunityNum();
    }

    @GetMapping("/update")
    public String showUpdateForm(String communityNum, HttpSession session, Model model) {
        communityDetailService.execute(communityNum, model);
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

    @GetMapping("/commentDelete")
    public String commentDelete(String commentNum, String communityNum, HttpSession session) {
        AuthInfoDTO auth = (AuthInfoDTO) session.getAttribute("auth");
        commentRepository.deleteComment(commentNum);
        return "redirect:/community/communityDetail?communityNum=" + communityNum;
    }
}
