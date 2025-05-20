package shoppingmall.domain;

import java.util.Date;

import lombok.Data;

@Data
public class EmployeeDTO {
	
	String empNum;
	String empName;
	String empId;
	String empPw;
	String empAddr;
	String empAddrDetail;
	String empPost;
	String empPhone;
	String empJumin;
	String empEmail;
	Date empHireDate;

}
