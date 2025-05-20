package shoppingmall.domain;

import java.util.Date;

import org.apache.ibatis.type.Alias;
import org.springframework.format.annotation.DateTimeFormat;

import jakarta.validation.constraints.NotBlank;
import lombok.Data;

@Data
@Alias("mem")
public class MemberDTO {

	String memberNum;
	String memberName;
	String memberId;	
	String memberPw;	
	String memberPwCon;
	String memberAddr;
	String memberAddrDetail;	
	String memberPost;
	Date memberRegist;
	String memberGender;
	String memberPhone1;
	String memberPhone2;
	String memberEmail;
	Date memberBirth;
	
}
