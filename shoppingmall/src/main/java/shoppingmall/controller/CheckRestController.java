package shoppingmall.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import jakarta.servlet.http.HttpSession;
import shoppingmall.domain.AuthInfoDTO;
import shoppingmall.repository.ItemRepository;
import shoppingmall.repository.MemberRepository;
import shoppingmall.service.FileDelService;
import shoppingmall.service.LoginService;
import shoppingmall.service.item.CartInsertService;
import shoppingmall.service.item.CartListService;
import shoppingmall.service.item.CartdeletService;
import shoppingmall.service.item.GoodsOrderService;
import shoppingmall.service.item.GoodsWishItemService;
import shoppingmall.service.item.GoodsWishService;
import shoppingmall.service.user.EmailCheckService;

@RestController
public class CheckRestController {

    @Autowired
    EmailCheckService emailCheckService;
    @Autowired
    FileDelService fileDelService;
    @Autowired
    LoginService loginService;
    @Autowired
    CartListService cartListService;
    @Autowired
    MemberRepository memberRepository;
    @Autowired
    ItemRepository itemRepository;
    @Autowired
    CartInsertService cartInsertService ;
    @Autowired
    GoodsOrderService goodsOrderService;
    @Autowired
    GoodsWishItemService goodsWishItemService;
    @Autowired
    CartdeletService cartdeletService;
    
   
    // 이메일 인증 처리
    @GetMapping("/help/userConfirm")
    public String confirm(String chk) {
        Integer i = emailCheckService.execute(chk);
        if (i != 0) return "인증되었습니다.";
        else return "이미 인증되었습니다.";
    }

    // 파일 삭제 처리
    @PostMapping("/file/fileDel")
    public int fileDel(String orgFile, String storeFile, HttpSession session) {
        return fileDelService.execute(orgFile, storeFile, session);
    }
   
    @PostMapping("/item/cart")
    public void cart(String goodsNum , int cartQty, HttpSession session) {
    	cartInsertService.execute(goodsNum, cartQty, session);
    }
    /*
    @PostMapping("/item/buy")
    public void buy(String goodsNum, int cartQty, HttpSession session) {
    	goodsOrderService.execute(goodsNum, cartQty, session);
    }
	*/
    @PostMapping("/item/wishItem")
    public boolean wishItem(HttpSession session, String goodsNum) {
    	return goodsWishItemService.execute(session, goodsNum);
    }

    @PostMapping("/item/deleteCart")
    public boolean deleteCart(String goodsNums[], HttpSession session) {
        AuthInfoDTO auth = (AuthInfoDTO) session.getAttribute("auth");
        if (auth == null) {
            return false;
        }

        String memberId = auth.getUserId();
        cartdeletService.deleteCart(memberId, goodsNums);
        return true;
    }

}
