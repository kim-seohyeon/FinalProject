package shoppingmall.command;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class IcommentCommand {
	String icommentId;
	String inquireNum;
	String icommentWriter;
	String icommentContent;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	Date icommentDate;
	String memberNum;
}
