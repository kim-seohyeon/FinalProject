package shoppingmall.service.item;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import jakarta.servlet.http.HttpSession;
import shoppingmall.domain.AuthInfoDTO;
import shoppingmall.domain.MemberDTO;
import shoppingmall.domain.PurchaseListDTO;
import shoppingmall.repository.MemberRepository;
import shoppingmall.repository.PurchaseRepository;

@Service
public class PurchaseListService {

	@Autowired
	PurchaseRepository purchaseRepository;
	
	@Autowired
	MemberRepository memberRepository;
	
	public void execute(Model model, HttpSession session) {
		
        AuthInfoDTO auth = (AuthInfoDTO) session.getAttribute("auth");
        MemberDTO dto = memberRepository.memberSelectOne(auth.getUserId()); // 사용자 ID

		List<PurchaseListDTO> list = purchaseRepository.SelectAll(dto.getMemberNum());
		model.addAttribute("list", list);
		
	}
	
	public void hasPurchased( HttpSession session, String goodsNum, Model model) {
		AuthInfoDTO auth = (AuthInfoDTO)session.getAttribute("auth");
		MemberDTO dto = memberRepository.memberSelectOne(auth.getUserId());
		List<PurchaseListDTO> list =  purchaseRepository.countByMemberAndGoods(dto.getMemberNum(), goodsNum);
		model.addAttribute("list", list);
    }

}
