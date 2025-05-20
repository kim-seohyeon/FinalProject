package shoppingmall.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import shoppingmall.command.PurchaseCommand;
import shoppingmall.domain.AuthInfoDTO;
import shoppingmall.service.goods.GoodsDetailService;
import shoppingmall.service.item.CartListService;
import shoppingmall.service.item.GoodsItemService;
import shoppingmall.service.item.GoodsOrderService;
import shoppingmall.service.item.INIstdpayPcReturnService;
import shoppingmall.service.item.IniPayReqService;
import shoppingmall.service.item.PurchaseListService;

@Controller
@RequestMapping("/item")
public class ItemController {

    @Autowired
    CartListService cartListService;
    
    @Autowired
    GoodsDetailService goodsDetailService;
    
    @Autowired
    GoodsItemService goodsItemService;
    
    @Autowired
    GoodsOrderService goodsOrderService;
    
    @Autowired
    IniPayReqService iniPayReqService;
    
    @Autowired
    INIstdpayPcReturnService iNIstdpayPcReturnService;
    
    @Autowired
    PurchaseListService purchaseListService;
    
    // 장바구니 목록
    @GetMapping("/cartList")
    public String cartList(HttpSession session, Model model, HttpServletRequest request) {
        AuthInfoDTO auth = (AuthInfoDTO) session.getAttribute("auth");
        if (auth == null) {
            // 로그인하지 않은 경우: 원래 가려던 경로 저장 후 로그인 페이지로 이동
            session.setAttribute("redirectURI", request.getRequestURI());
            return "redirect:/login/login";
        }

        String userId = auth.getUserId();
        System.out.println("userId : " + userId);
        cartListService.execute(userId, null, null, model);
        System.out.println("userId : " + userId);        
        return "item/cartList";
    }

    
    // 상품 상세 페이지
    @GetMapping("/detailView")
    public String detail(HttpServletRequest request, Model model, String goodsNum) {
        goodsDetailService.execute(request, model, goodsNum);
        return "item/detailView";
    }

    // 상품 구매 페이지
    @PostMapping("/itemBuy")
    public String buy(String [] prodCk,  Model model, HttpSession session) {
        goodsItemService.execute(prodCk, model, session);
        return "item/goodsOrder";
    }

    // 주문 처리 완료 페이지
    @PostMapping("/goodsOrder")
    public String order(PurchaseCommand purchaseCommand, HttpSession session) {
        String purchaseNum = goodsOrderService.execute(purchaseCommand, session);
    
        return "redirect:paymentOk?purchaseNum="+purchaseNum;
    }
   
    @GetMapping("/paymentOk")
    public String paymentOk(String purchaseNum, Model model) throws Exception {
    	iniPayReqService.execute(purchaseNum,model);
    	return "item/payment";
    }
    
    @PostMapping("/INIstdpay_pc_return")
    public String pcRetrun(HttpServletRequest request) {
    	iNIstdpayPcReturnService.execute(request);
    	return "item/buyfinished";
    }
    
    @GetMapping("/purchaseList")
    public String purchaseList(Model model, HttpSession session) {
    	purchaseListService.execute(model, session);
    	return "item/purchaseList";
    }
    
    
   
    
}
