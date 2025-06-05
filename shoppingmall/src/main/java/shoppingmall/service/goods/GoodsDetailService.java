package shoppingmall.service.goods;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import shoppingmall.domain.AuthInfoDTO;
import shoppingmall.domain.GoodsDTO;
import shoppingmall.repository.GoodsRepository;
import shoppingmall.repository.PurchaseRepository;

@Service
public class GoodsDetailService {

    @Autowired
    GoodsRepository goodsRepository;

    @Autowired
    PurchaseRepository purchaseRepository;

    public void execute(HttpServletRequest request, Model model, String goodsNum) {
        GoodsDTO dto = goodsRepository.goodsSelectOne(goodsNum);
        model.addAttribute("dto", dto);

   }
//ㅇ
}
