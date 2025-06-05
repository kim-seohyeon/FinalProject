package shoppingmall.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpSession;
import shoppingmall.domain.AuthInfoDTO;
import shoppingmall.domain.ReviewDTO;
import shoppingmall.service.item.ReviewWriteService;

@Controller
@RequestMapping("/review")
public class ReviewController {

    @Autowired
    private ReviewWriteService reviewService;

    @PostMapping("/write")
    public String writeReview(String goodsNum, String purchaseNum ,String reviewContent, HttpSession session, Model model) {
        AuthInfoDTO auth = (AuthInfoDTO) session.getAttribute("auth");
        if (auth == null) return "redirect:/login/loginCk";

        ReviewDTO dto = new ReviewDTO();
        dto.setPurchaseNum(purchaseNum);
        dto.setGoodsNum(goodsNum);
        dto.setMemberNum(auth.getUserId());
        dto.setReviewContent(reviewContent);

        reviewService.execute(dto, goodsNum,model, session );

        return "redirect:/item/detailView?goodsNum=" + goodsNum;
    }
/*
    @GetMapping("/detail")
    public String detailView(@RequestParam String goodsNum, Model model) {
        List<ReviewDTO> reviewList = reviewService.execute(new ReviewDTO(),  goodsNum, model,session );
        model.addAttribute("reviewList", reviewList);
        return "items/detail";
    }
    */
}
