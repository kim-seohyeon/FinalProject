package shoppingmall.domain;

import java.util.Date;

import lombok.Data;

@Data
public class GoodsDTO {
	
	String goodsNum;
	String goodsName;
	int goodsPrice;
	String goodsContents;
	String goodsMainImage;
	String goodsMainStoreImage;
	String goodsDetailImage;
	String goodsDetailStoreImage;
	String empNum;
	Date goodsRegist;
	String updateEmpNum;
	Date goodsUpdateDate;
	int visitCount;
}
