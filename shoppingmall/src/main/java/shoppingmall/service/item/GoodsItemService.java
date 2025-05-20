package shoppingmall.service.item;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import shoppingmall.domain.AuthInfoDTO;
import shoppingmall.domain.CartListDTO;
import shoppingmall.domain.MemberDTO;
import shoppingmall.repository.ItemRepository;
import shoppingmall.repository.MemberRepository;

@Service
public class GoodsItemService {

    @Autowired
    MemberRepository memberRepository;

    @Autowired
    ItemRepository itemRepository;

    public void execute(String [] prodCk, Model model, HttpSession session) {
        AuthInfoDTO auth = (AuthInfoDTO) session.getAttribute("auth");

        MemberDTO mdto = memberRepository.memberSelectOne(auth.getUserId());

        List<CartListDTO> list = new ArrayList<>();
        Integer goodsTotalPrice = 0;
        String nums = "";

        for (String goodsNum : prodCk) {
            System.out.println("mdto.getMemberNum() : " + mdto.getMemberNum());
            System.out.println("goodsNum : " + goodsNum);
            CartListDTO dto = itemRepository.itemSelectOne(goodsNum, mdto.getMemberNum());
            list.add(dto);
            goodsTotalPrice += dto.getCartQty() * dto.getGoodsPrice();
            nums += goodsNum + "`";
        }
        System.out.println("goodsTotalPrice : " + goodsTotalPrice);
        model.addAttribute("goodsTotalPrice", goodsTotalPrice);
        model.addAttribute("list", list);
        model.addAttribute("nums", nums);
    }
}
