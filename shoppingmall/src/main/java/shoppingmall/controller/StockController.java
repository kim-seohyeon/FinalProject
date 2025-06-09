package shoppingmall.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import jakarta.servlet.http.HttpSession;
import shoppingmall.domain.AuthInfoDTO;
import shoppingmall.domain.MemberDTO;
import shoppingmall.domain.WishStockDTO;
import shoppingmall.repository.MemberRepository;
import shoppingmall.service.StockService;

@Controller
@RequestMapping("/stock")
public class StockController {

    @Autowired
    private StockService stockService;

    @GetMapping("/main")
    public String stockMain(HttpSession session, Model model) {
        AuthInfoDTO auth = (AuthInfoDTO) session.getAttribute("auth");
        if (auth != null) {
            List<WishStockDTO> wishStocks = stockService.getWishStocks(auth.getUserId());
            model.addAttribute("wishStocks", wishStocks);
        }
        return "stock/stockMain";
    }

    @GetMapping("/wishlist")
    public String stockWishlist(HttpSession session, Model model) {
        AuthInfoDTO authInfo = (AuthInfoDTO) session.getAttribute("auth");
        if (authInfo == null) {
            return "redirect:/login";
        }

        String memberNum = authInfo.getUserId();
        List<WishStockDTO> wishStocks = stockService.getWishStocks(memberNum);
        model.addAttribute("wishStocks", wishStocks);
        return "stock/stockWishList";
    }

    @PostMapping("/addFavorite")
    public String addFavoriteStock(@RequestParam("stockCode") String stockCode, HttpSession session) {
        AuthInfoDTO authInfo = (AuthInfoDTO) session.getAttribute("auth");
        if (authInfo == null) {
            return "redirect:/login";
        }

        String memberNum = authInfo.getUserId();
        stockService.addWishStock(memberNum, stockCode);
        return "redirect:/stock/main";
    }

    @PostMapping("/removeFavorite")
    public String removeFavoriteStock(@RequestParam("stockCode") String stockCode, HttpSession session) {
        AuthInfoDTO authInfo = (AuthInfoDTO) session.getAttribute("auth");
        if (authInfo == null) {
            return "redirect:/login";
        }

        String memberNum = authInfo.getUserId();
        stockService.removeWishStock(memberNum, stockCode);
        return "redirect:/stock/main";
    }
    
    @PostMapping("/toggleFavorite")
    @ResponseBody
    public Map<String, Object> toggleFavorite(@RequestParam("stockCode") String stockCode, HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        AuthInfoDTO auth = (AuthInfoDTO) session.getAttribute("auth");

        if (auth == null) {
            response.put("message", "로그인이 필요합니다.");
            return response;
        }

        String memberNum = auth.getUserId();
        boolean isFavorite = stockService.toggleWishStock(memberNum, stockCode);

        response.put("message", isFavorite ? "찜에 추가되었습니다." : "찜에서 제거되었습니다.");
        response.put("wishStocks", stockService.getWishStocks(memberNum));
        return response;
    }
    
    @GetMapping("/timeseries")
    public String showTimeseriesPage() {
        return "stock/timeseries"; // → /WEB-INF/views/stock/timeseries.jsp 로 이동
    }

}
