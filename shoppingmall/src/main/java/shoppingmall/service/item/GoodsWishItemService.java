package shoppingmall.service.item;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import shoppingmall.domain.AuthInfoDTO;
import shoppingmall.domain.MemberDTO;
import shoppingmall.domain.WishDTO;
import shoppingmall.repository.MemberRepository;
import shoppingmall.repository.ItemRepository;

@Service
public class GoodsWishItemService {

    @Autowired
    private MemberRepository memberRepository;

    @Autowired
    private ItemRepository itemRepository;

    public void execute(HttpSession session, String goodsNum ) {
        AuthInfoDTO auth = (AuthInfoDTO) session.getAttribute("auth");

        MemberDTO mdto = memberRepository.memberSelectOne(auth.getUserId());


        // WishDTO 객체 생성 후 데이터 설정
        WishDTO dto = new WishDTO();
        dto.setMemberNum(mdto.getMemberNum());
        dto.setGoodsNum(goodsNum);

        // wish 테이블에 데이터 삽입
        itemRepository.wishInsert(dto);
    }
}
