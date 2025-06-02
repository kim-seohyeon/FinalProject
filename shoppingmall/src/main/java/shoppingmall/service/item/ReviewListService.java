package shoppingmall.service.item;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import shoppingmall.domain.ReviewDTO;
import shoppingmall.repository.ReviewRepository;

@Service
public class ReviewListService {
	
	@Autowired
	ReviewRepository reviewRepository;
	
    // 리뷰 목록 가져오기 (기존 방식)
    public void getReviews(String goodsNum, Model model) {
    	List<ReviewDTO> list =  reviewRepository.getReviewsByGoodsNum(goodsNum);
    	model.addAttribute("reviewList", list);
    }
}
