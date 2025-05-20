package shoppingmall.command;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
public class MemberCommand {
	String memberNum;
	@NotBlank(message = "이름을 입력하세요")
	String memberName;
	
	@NotBlank(message = "아이디를 입력하세요")
	String memberId;
	
	@NotBlank(message = "비밀번호를 입력하세요")
	String memberPw;
	
	@NotBlank(message = "비밀번호 확인을 입력하세요")
	String memberPwCon;
	
	@NotBlank(message = "주소를 입력하세요")
	String memberAddr;
	
	String memberAddrDetail;
	
	String memberPost;

	@DateTimeFormat(pattern = "yyyy-MM-dd")
	Date memberRegist;
	
	@NotBlank(message = "성별을 입력하세요")
	String memberGender;
	@NotBlank(message = "연락처1을 입력하세요")
	String memberPhone1;
	@NotBlank(message = "연락처2를 입력하세요")
	String memberPhone2;
	@NotBlank(message = "이메일을 입력하세요")
	String memberEmail;
	
	@NotNull(message = "생년월일을 입력하세요")
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	Date memberBirth;
	
	public boolean isMemberPwEqualsMemberPwCon() {
		System.out.println(memberPw);
		System.out.println(memberPwCon);
		return memberPw.equals(memberPwCon);
	}

}
