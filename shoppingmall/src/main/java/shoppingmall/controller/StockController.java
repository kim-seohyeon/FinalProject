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
import shoppingmall.domain.StockA3;
import shoppingmall.domain.StockDTO;
import shoppingmall.domain.WishStockDTO;
import shoppingmall.repository.MemberRepository;
import shoppingmall.repository.StockRepository;
import shoppingmall.service.StockService;

@Controller
@RequestMapping("/stock")
public class StockController {

    @Autowired
    private StockService stockService;
    @Autowired
    StockRepository stockRepository ;
    @Autowired 
    MemberRepository memberRepository;
    
    @GetMapping("/realtime")
    @ResponseBody
    public List<StockA3> getRealtimeStock(HttpSession session) {
    	System.out.println("realtime");
    	AuthInfoDTO auth = (AuthInfoDTO) session.getAttribute("auth");
    	MemberDTO dto = memberRepository.memberSelectOne(auth.getUserId());
    	List<StockA3> list = stockRepository.recommandStock(dto.getMemberNum());
    	System.out.println(list.toString());
        return list;
    }
    
    @GetMapping("/main")
    public String stockMain(HttpSession session, Model model) {
        AuthInfoDTO auth = (AuthInfoDTO) session.getAttribute("auth");
        if (auth != null) {
            List<WishStockDTO> wishStocks = stockService.getWishStocks(auth.getUserId());
            System.out.println("auth.getUserId() : " + auth.getUserId());
            model.addAttribute("wishStocks", wishStocks);
        }
        MemberDTO dto = memberRepository.memberSelectOne(auth.getUserId());
        List<StockDTO> list = stockRepository.stockInfo();
        //List<StockA3> list1 =  stockRepository.recommandStock(dto.getMemberNum());
        //System.out.println("list1.size() : " + list1.size());
        model.addAttribute("list", list);
        //model.addAttribute("stockList", list1);
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
        
        List<StockDTO> list = stockRepository.stockInfo();
        model.addAttribute("list", list);
        
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
    
    @GetMapping("/realStock")
    public String realStock(Model model,  String StockName) {
       List<StockA3> list =  stockRepository.stockSelect(StockName);
       if(list.size() == 0) {
    	   return "redirect:stockX";
       }
       model.addAttribute("list", list);
       model.addAttribute("StockName", StockName);
       return "stock/realStock";
    }
    
    @GetMapping("/stockCurrent")
    public @ResponseBody List<StockA3> currentDate(String StockName){
       //System.out.println("q21341414");
       List<StockA3> list = stockRepository.stockCurrentSelect(StockName);
       System.out.println(list.size());
       return list;
    }
    
    @GetMapping("/stockX")
    public String stockXPage() {
        return "stock/stockX"; // → /WEB-INF/views/stock/stockX.jsp
    }

}
