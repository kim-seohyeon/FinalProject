package shoppingmall.domain;

import lombok.Data;

@Data
public class InquireDTO {
	
	String inquireNum;
	String memberNum;
	String goodsNum;
	String inquireSubject;
	String inquireContents;
	String inquireKind;
	String inquireDate;
	String inquireAnswer;
	String inquireAnswerDate;
	String empNum;
	String inquireWriter;
	
}
