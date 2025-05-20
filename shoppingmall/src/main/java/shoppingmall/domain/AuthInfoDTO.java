package shoppingmall.domain;

import org.apache.ibatis.type.Alias;
import shoppingmall.domain.AuthInfoDTO;

import lombok.Data;

@Data
@Alias("auth")
public class AuthInfoDTO {

	String userId;
	String userPw;
	String userName;
	String grade;
	String userEmail;
	
}
