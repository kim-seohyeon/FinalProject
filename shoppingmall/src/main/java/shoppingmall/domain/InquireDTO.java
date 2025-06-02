package shoppingmall.domain;

import java.util.Date;

import lombok.Data;

@Data
public class InquireDTO {
	
	String inquireNum;
	String memberNum;
	String goodsNum;
	String inquireSubject;
	String inquireContents;
	String inquireKind;
	Date inquireDate;
	String inquireAnswer;
	String inquireAnswerDate;
	String empNum;
	String inquireWriter;
	
}
