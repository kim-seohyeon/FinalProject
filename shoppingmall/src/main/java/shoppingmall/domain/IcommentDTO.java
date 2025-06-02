package shoppingmall.domain;

import java.util.Date;

import lombok.Data;

@Data
public class IcommentDTO {

	String icommentId;
	String inquireNum;
	String icommentWriter;
	String icommentContent;
	Date icommentDate;
	String memberId;
	String empId;
	
}
