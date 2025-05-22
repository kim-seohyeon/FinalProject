package shoppingmall.domain;

import lombok.Data;

@Data
public class CartListDTO {

	String memberNum;
	
	String goodsNum;
	Integer cartQty;
	String cartDate;
	
	String goodsName;
	int goodsPrice;
	String goodsImage;
	String goodsMainStoreImage;
	int totalPrice;

	
}
