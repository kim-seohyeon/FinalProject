package shoppingmall.domain;

import lombok.Data;

@Data
public class CartDTO {

	String memberNum;
	String goodsNum;
	Integer cartQty;
	String cartDate;

	
}
