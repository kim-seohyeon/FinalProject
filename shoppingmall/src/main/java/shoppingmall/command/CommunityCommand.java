package shoppingmall.command;

import java.sql.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class CommunityCommand {

	String memberNum;
	String communityNum;
	String communitySubject;
	String communityContent; 
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	Date communityDate;
	int commentCount; 
	int likeCount;            
	String communityComment;
	String replyComment; 
	
	
}
