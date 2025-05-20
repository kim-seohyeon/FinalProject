package shoppingmall.service.item;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import jakarta.servlet.http.HttpSession;
import shoppingmall.command.PurchaseCommand;
import shoppingmall.domain.AuthInfoDTO;
import shoppingmall.domain.MemberDTO;
import shoppingmall.domain.PurchaseDTO;
import shoppingmall.repository.ItemRepository;
import shoppingmall.repository.MemberRepository;
import shoppingmall.repository.PurchaseRepository;

@Service
public class GoodsOrderService {

    @Autowired
    ItemRepository itemRepository;

    @Autowired
    MemberRepository memberRepository;

    @Autowired
    PurchaseRepository purchaseRepository;

    public String execute(PurchaseCommand purchaseCommand, HttpSession session) {

        // 장바구니에 있는 상품을 구매 정보로 저장
        PurchaseDTO dto = new PurchaseDTO();
        dto.setPurchaseNum(purchaseCommand.getPurchaseNum());
        dto.setPurchaseName(purchaseCommand.getPurchaseName());
        dto.setDeliveryName(purchaseCommand.getDeliveryName());
        dto.setDeliveryAddr(purchaseCommand.getDeliveryAddr());
        dto.setDeliveryAddrDetail(purchaseCommand.getDeliveryAddrDetail());
        dto.setDeliveryPost(purchaseCommand.getDeliveryPost());
        dto.setDeliveryPhone(purchaseCommand.getDeliveryPhone());
        dto.setMessage(purchaseCommand.getMessage());
        dto.setPurchasePrice(purchaseCommand.getTotalPaymentPrice());


        // 회원 정보 조회
        AuthInfoDTO auth = (AuthInfoDTO) session.getAttribute("auth");
        MemberDTO mdto = memberRepository.memberSelectOne(auth.getUserId());

        dto.setMemberNum(mdto.getMemberNum());

        // 구매 번호 생성
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
        String purchaseNum = sdf.format(new Date());
        dto.setPurchaseNum(purchaseNum);

        // 구매 정보 저장
        purchaseRepository.save(dto);

        // 장바구니 상품을 구매 리스트에 추가하고, 장바구니에서 제거
        String[] nums = purchaseCommand.getGoodsNums().split("`");
        for (String goodsNum : nums) {
            itemRepository.purchaseListInsert(goodsNum, purchaseNum, mdto.getMemberNum());
            itemRepository.cartDelete(goodsNum, mdto.getMemberNum());
        }

        return purchaseNum;
    }
}
