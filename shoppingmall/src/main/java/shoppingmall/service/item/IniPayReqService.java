package shoppingmall.service.item;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.inicis.std.util.SignatureUtil;

import shoppingmall.domain.PurchaseDTO;
import shoppingmall.repository.ItemRepository;

@Service
public class IniPayReqService {

    @Autowired
    ItemRepository itemRepository;

    public void execute(String purchaseNum,  Model model) throws Exception {

        // purchase_price 가져옴
        PurchaseDTO dto = itemRepository.purchaseSelectOne(purchaseNum);

        // 스크립트릿 옮김model
        String mid = "INIpayTest"; // 상점아이디					
        String signKey = "SU5JTElURV9UUklQTEVERVNfS0VZU1RS"; // 웹 결제 signkey

        String mKey = SignatureUtil.hash(signKey, "SHA-256");
        String timestamp = SignatureUtil.getTimestamp();
        String orderNumber = purchaseNum;
        String price = dto.getPurchasePrice().toString();

        Map<String, String> signParam = new HashMap<>();
        signParam.put("oid", orderNumber);
        signParam.put("price", price);
        signParam.put("timestamp", timestamp);

        String signature = SignatureUtil.makeSignature(signParam);

        // 결제 관련 정보 request에 저장
        model.addAttribute("mid", mid);
        model.addAttribute("orderNumber", orderNumber);
        model.addAttribute("price", price);
        model.addAttribute("timestamp", timestamp);
        model.addAttribute("signature", signature);
        model.addAttribute("mKey", mKey);

        // 배송 및 구매자 정보 저장
        model.addAttribute("deliveryName", dto.getDeliveryName());
        model.addAttribute("purchaseName", dto.getPurchaseName());
        model.addAttribute("deliveryPhone", dto.getDeliveryPhone());
    }
}
