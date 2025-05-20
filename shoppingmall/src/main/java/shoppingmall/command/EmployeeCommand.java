package shoppingmall.command;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotEmpty;
import lombok.Data;

@Data
public class EmployeeCommand {

	String empNum;
	@NotBlank(message = "이름을 입력하세요")
	String empName;
	
	@NotEmpty(message = "아이디를 입력하세요")
	String empId;
	
	@NotEmpty(message = "비밀번호를 입력하세요")
	String empPw;
	
	@NotEmpty(message = "비밀번호 확인을 입력하세요")
	String empPwCon;
	
	@NotEmpty(message = "주소를 입력하세요")
	String empAddr;
	
	@NotEmpty(message = "상세주소를 입력하세요")
	String empAddrDetail;
	
	@NotEmpty(message = "우편번호를 입력하세요")
	String empPost;
	
	@NotEmpty(message = "연락처를 입력하세요")
	String empPhone;
	
	@NotEmpty(message = "주민번호를 - 없이 입력하세요")
	String empJumin;
	
	@NotEmpty(message = "이메일을 입력하세요")
	String empEmail;
	
	@DateTimeFormat(pattern="yyyy-MM-dd")
	Date empHireDate;

	public boolean isEmpPwEquealsEmpPwCon() {
	
		if(empPw.equals(empPwCon))return true;
		else return false;
	
	}
}

