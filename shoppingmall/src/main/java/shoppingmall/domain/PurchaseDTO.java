package shoppingmall.domain;

import lombok.Data;

@Data
public class PurchaseDTO {

	String purchaseNum;
	String purchaseDate;
	Long purchasePrice;
	String deliveryName;
	String deliveryAddr;
	String deliveryAddrDetail;
	String deliveryPost;
	String deliveryPhone;
	String message;
	String purchaseStatus;
	String memberNum;	
	String purchaseName; // 구매상품이름
	String stockName;
	
}
