package shoppingmall.domain;

import lombok.Data;

@Data
public class PaymentDTO {

	String purchaseNum;
	String confirmNumber; // applNum: 승인번호
	String cardNum; //카드 번호
	String tid; //거래 번호
	String totalPrice; //결제 금액
	String resultMessage; //결과 메세지
	String payMathod; //결제 방법
	String applDate; //승인 날짜
	String applTime; //승인 시간
	String purchaseName; //제품명

	
}
