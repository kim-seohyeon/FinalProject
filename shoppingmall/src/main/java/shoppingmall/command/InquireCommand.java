package shoppingmall.command;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class InquireCommand {

	String inquireNum;
	String memberNum;
	String goodsNum;
	String inquireSubject;
	String inquireContents;
	String inquireKind;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	String inquireDate;
	String inquireAnswer;
	String inquireAnswerDate;
	String empNum;
	String inquireWriter;
	
}
