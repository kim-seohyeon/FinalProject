package shoppingmall.domain;

import lombok.Data;

@Data
public class PurchaseListDTO {

	String goodsNum;
	String goodsName;
	String goodsPrice;
	String goodsContents;
	String goodsMainImage;
	String goodsMainStoreImage;
	String updateEmpNum;
	
	String purchaseNum;
	String purchasePrice;
	String purchaseStatus;
	String confirmNumber;
	String cardNum;
	String applDate;

}
