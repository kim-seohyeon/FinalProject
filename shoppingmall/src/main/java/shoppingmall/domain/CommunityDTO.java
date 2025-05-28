package shoppingmall.domain;

import java.sql.Date;
import java.time.LocalDateTime;

import lombok.Data;


@Data
public class CommunityDTO {

	String memberNum;
	String communityNum;
	String communityWriter;
	String communitySubject;
	String communityContent; 
	Date communityDate;
	int commentCount; 
	int likeCount;            
	String communityComment;
	String replyComment; 
	String imagePath;
	
	

}
	
	
