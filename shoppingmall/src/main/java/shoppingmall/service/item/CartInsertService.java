package shoppingmall.service.item;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import shoppingmall.domain.AuthInfoDTO;
import shoppingmall.domain.CartDTO;
import shoppingmall.domain.MemberDTO;
import shoppingmall.repository.ItemRepository;
import shoppingmall.repository.MemberRepository;

@Service
public class CartInsertService {

    @Autowired
    MemberRepository memberRepository;

    @Autowired
    ItemRepository itemRepository;

    public void execute(String goodsNum , int cartQty, HttpSession session) {
        AuthInfoDTO auth = (AuthInfoDTO) session.getAttribute("auth");

        MemberDTO mdto = memberRepository.memberSelectOne(auth.getUserId());
        CartDTO dto = new CartDTO();
        dto.setCartQty(cartQty);
        dto.setGoodsNum(goodsNum);
        dto.setMemberNum(mdto.getMemberNum());

        itemRepository.cartMerge(dto);
    }
}
