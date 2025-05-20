package shoppingmall.command;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class GoodsCommand {

	String goodsNum;
	String goodsName;
	int goodsPrice;
	String goodsContents;

	// 이미지 파일을 MultipartFile로 수정
	MultipartFile mainImage;

    MultipartFile image1;
    MultipartFile image2;
    MultipartFile image3;
	
	// DB에 저장될 원본 이름, 저장 이름
	String goodsMainImage;
	String goodsMainStoreImage;
	String goodsDetailImage;
	String goodsDetailStoreImage;

	String empNum;
	Date goodsRegist;
	String updateEmpNum;
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	Date goodsUpdateDate;


	
}
