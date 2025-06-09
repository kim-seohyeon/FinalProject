package shoppingmall.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import shoppingmall.command.LoginCommand;
import shoppingmall.command.MailCommand;
import shoppingmall.domain.AuthInfoDTO;
import shoppingmall.domain.GoodsDTO;
import shoppingmall.repository.GoodsRepository;
import shoppingmall.repository.MemberRepository;
import shoppingmall.service.EmailService;
import shoppingmall.service.goods.GoodsListService;
import shoppingmall.service.library.LibraryListService;

@Controller
public class IndexController {
    @Autowired
    MemberRepository memberRepository;

    @Autowired
    EmailService emailService;

    @Autowired
    LibraryListService libraryListService;

    @Autowired
    GoodsListService goodsListService;
    
    @Autowired
    GoodsRepository goodsRepository;

    // 기본 페이지 렌더링 - 기존
    @GetMapping("/")
    public String index(@ModelAttribute("loginCommand") LoginCommand loginCommand,
                        HttpServletRequest request, Model model,
                        @RequestParam(value = "page", defaultValue = "1") int page) {

        // 로그인 관련 쿠키 처리
        Cookie[] cookies = request.getCookies();
        if (cookies != null && cookies.length > 0) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("idStore")) {
                    loginCommand.setIdStore(true);
                    loginCommand.setUserId(cookie.getValue());
                }
                if (cookie.getName().equals("autoLogin")) {
                    String userId = cookie.getValue();
                    AuthInfoDTO auth = memberRepository.loginSelectOne(userId);
                    HttpSession session = request.getSession();
                    session.setAttribute("auth", auth);
                }
            }
        }

        int pageSize = 5; // 한 번에 보여줄 상품 수

        // 상품 목록 모델에 넣기 (첫 페이지)
        goodsListService.execute(model, page);

        // 더보기 버튼 표시 여부 판단
        int totalCount = goodsListService.totalGoodsCount();
        boolean hasNext = (page * pageSize) < totalCount;
        int nextPage = page + 1;

        model.addAttribute("hasNext", hasNext);
        model.addAttribute("nextPage", nextPage);
        model.addAttribute("currentPage", page);

        return "index";
    }

    // AJAX용 상품 페이징 API — JSON 반환
    @GetMapping("/goods/page")
    @ResponseBody
    public Map<String, Object> getGoodsByPage(@RequestParam(value = "page", defaultValue = "1") int page) {
    	System.out.println("asfafd");
        int limit = 5; // 한 번에 보여줄 상품 수
        int offset = (page - 1) * limit;

        List<GoodsDTO> list = goodsListService.goodsRepository.selectGoodsByPage(offset, limit);
        int totalCount = goodsListService.totalGoodsCount();
        int maxPage = (int) Math.ceil((double) totalCount / limit);

        Map<String, Object> result = new HashMap<>();
        result.put("list", list);
        result.put("maxPage", maxPage);
        result.put("currentPage", page);

        return result;
    }

    @GetMapping("/mailling")
    public String mailSend() {
        return "email";
    }

    @PostMapping("/mailling")
    public String mailSend(MailCommand mailCommand) {
        emailService.execute(mailCommand);
        return "redirect:/";
    }
}
