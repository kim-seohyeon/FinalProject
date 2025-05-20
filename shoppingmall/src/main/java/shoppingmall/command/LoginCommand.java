package shoppingmall.command;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotEmpty;
import lombok.Data;

@Data
public class LoginCommand {
	
	//String @NotBlank, @NotEmpty를 쓴다. 나머지 @NotNull
	@NotBlank(message = "아이디를 입력해주세요")
	String userId;
	@NotEmpty(message = "비밀번호를 입력해주세요")
	String userPw;
	boolean idStore;
	boolean autoLogin;

}
