package shoppingmall.service.item;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import jakarta.servlet.http.HttpSession;
import shoppingmall.domain.AuthInfoDTO;
import shoppingmall.domain.MemberDTO;
import shoppingmall.domain.WishDTO;
import shoppingmall.repository.ItemRepository;
import shoppingmall.repository.MemberRepository;

@Service
public class GoodsWishService {

    @Autowired
    ItemRepository itemRepository;  // ItemRepository 주입

    @Autowired
    MemberRepository memberRepository;  // MemberRepository 주입

    public void execute(HttpSession session, String goodsNum, Model model) {
        

        AuthInfoDTO auth = (AuthInfoDTO) session.getAttribute("auth");
        
        String memberNum = null;
        
        if (auth != null) {
        	if(auth.getGrade().equals("mem")) {
	            MemberDTO mdto = memberRepository.memberSelectOne(auth.getUserId());
	            memberNum = mdto.getMemberNum();
        	}
        }
        
        // 찜 정보 저장
        WishDTO dto = new WishDTO();
        dto.setGoodsNum(goodsNum);
        dto.setMemberNum(memberNum);
        
        // 찜 정보 가져오기 (repository 사용)
        dto = itemRepository.wishSelectOne(dto);
        
        // request에 찜 정보를 담아서 전달
        model.addAttribute("wish", dto);
    }
}
