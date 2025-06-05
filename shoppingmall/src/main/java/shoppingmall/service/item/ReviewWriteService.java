package shoppingmall.service.item;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import jakarta.servlet.http.HttpSession;
import shoppingmall.domain.AuthInfoDTO;
import shoppingmall.domain.MemberDTO;
import shoppingmall.domain.ReviewDTO;
import shoppingmall.repository.MemberRepository;
import shoppingmall.repository.ReviewRepository;

@Service
public class ReviewWriteService {

    @Autowired
    ReviewRepository reviewRepository;
    @Autowired
    MemberRepository memberRepository;

	public void execute(ReviewDTO reviewDTO, String goodsNum, Model model, HttpSession session) {

		AuthInfoDTO auth = (AuthInfoDTO) session.getAttribute("auth");
    	MemberDTO dto = memberRepository.memberSelectOne(auth.getUserId());
    	reviewDTO.setMemberNum(dto.getMemberNum());
    	reviewRepository.insertReview(reviewDTO);
		//ㄴ
	}
}
