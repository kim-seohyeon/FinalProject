package shoppingmall.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.servlet.http.HttpSession;
import shoppingmall.command.CommunityCommand;
import shoppingmall.service.community.CommunityAutoNumService;
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
	
	
    @GetMapping("/communityList")
    public String list(Model model) {
    	communityListService.execute(model);
    	return "community/communityList";  // 뷰 이름: communityList.jsp (아래 위치에 만들 예정)
    }
    
 // 글쓰기 폼 화면 보여주기
    @GetMapping("/write")
    public String showWriteForm(Model model) {
    	communityAutoNumService.execute(model);
        return "community/communityForm";  // communityForm.jsp를 보여줌
    }

    // 글 작성 후 저장 처리
    @PostMapping("/write")
    public String submitPost(CommunityCommand communityCommand, HttpSession session) {               // ② 주입받은 서비스 객체로 메서드 호출
    	communityWriteService.execute(communityCommand, session);
    	return "redirect:/community/communityList";             // 작성 후 목록으로 이동
    }
    

}