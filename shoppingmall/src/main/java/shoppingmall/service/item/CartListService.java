package shoppingmall.service.item;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import shoppingmall.domain.CartDTO;
import shoppingmall.domain.CartListDTO;
import shoppingmall.domain.MemberDTO;
import shoppingmall.repository.ItemRepository;
import shoppingmall.repository.MemberRepository;

@Service
public class CartListService {

    @Autowired
    MemberRepository memberRepository;

    @Autowired
    ItemRepository itemRepository;

    public void execute(String memberId, String goodsNum, Integer cartQty, Model model) {
        // 1. 사용자 정보 가져오기
        MemberDTO member = memberRepository.memberSelectOne(memberId);
        if (member == null) {
            throw new IllegalArgumentException("존재하지 않는 사용자입니다: " + memberId);
        }

        // 2. 상품 번호가 null이면 조회, 아니면 추가
        if (goodsNum == null) {
            // 장바구니 목록 조회
            List<CartListDTO> list = itemRepository.cartSelectAll(member.getMemberNum());
            model.addAttribute("list", list);
        } else {
            // 장바구니에 상품 추가
            CartDTO cart = new CartDTO();
            cart.setMemberNum(member.getMemberNum());
            cart.setGoodsNum(goodsNum);
            cart.setCartQty(cartQty != null ? cartQty : 1);
            itemRepository.cartMerge(cart);
        }
    }
}
