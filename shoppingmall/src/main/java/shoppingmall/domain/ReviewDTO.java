package shoppingmall.domain;

import java.util.Date;

import lombok.Data;

@Data
public class ReviewDTO {
	private String purchaseNum;
    private String reviewNum;
    private String goodsNum;
    private String memberNum;
    private String memberId; // 작성자 표시용
    private String reviewContent;
    private Date reviewDate;
}
