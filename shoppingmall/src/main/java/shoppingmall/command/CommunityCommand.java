package shoppingmall.command;

import java.sql.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class CommunityCommand {

	String communityNum;
	String communityWriter;
	String communitySubject;
	String communityContent; 
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	Date communityDate;
	int commentCount; 
	int likeCount;            
	String communityComment;
	String replyComment; 
	
	
}
