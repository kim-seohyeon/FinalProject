package shoppingmall.command;

import java.util.Date;

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
	Date inquireDate;
	String inquireAnswer;
	String inquireAnswerDate;
	String empNum;
	String inquireWriter;
	
}
