package shoppingmall.repository;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import shoppingmall.domain.EmployeeDTO;

@Repository
public class EmployeeRepository {
	
	@Autowired
	JdbcTemplate jdbcTemplate;
	String sql;
	public String empNumAutoSelect() {
		
		sql = " select concat('emp_', nvl(substr(max(emp_num),5),10000)+1) from employees";
		return jdbcTemplate.queryForObject(sql, String.class);
	}
	
	public int empInsert(EmployeeDTO dto) {
		sql = " insert into employees(EMP_NUM, EMP_ID, EMP_PW, EMP_NAME"
				+ "					, EMP_ADDR, EMP_ADDR_DETAIL, EMP_POST, EMP_PHONE"
				+ "				    , EMP_JUMIN, EMP_EMAIL, EMP_HIRE_DATE)"
				+ " values(?, ?, ?, ?"
				+ "		 , ?, ?, ?, ?"
				+ "      , ?, ?, ?)";
		return jdbcTemplate.update(sql, dto.getEmpNum(), dto.getEmpId(), dto.getEmpPw(), dto.getEmpName()
									  , dto.getEmpAddr(), dto.getEmpAddrDetail(), dto.getEmpPost(), dto.getEmpPhone()
									  , dto.getEmpJumin(), dto.getEmpEmail(), dto.getEmpHireDate());
	}

	public List<EmployeeDTO> empSelectAll() {

		sql = " select EMP_NUM, EMP_ID, EMP_PW, EMP_NAME"
				+ "  , EMP_ADDR, EMP_ADDR_DETAIL, EMP_POST, EMP_PHONE"
				+ "  , EMP_JUMIN, EMP_EMAIL, EMP_HIRE_DATE"
				+ " from employees";
		
		return jdbcTemplate.query(sql, new BeanPropertyRowMapper<EmployeeDTO>(EmployeeDTO.class));
	
	}

	public EmployeeDTO empSelectOne(String empNum) {

		sql = " select EMP_NUM, EMP_ID, EMP_PW, EMP_NAME"
				+ "  , EMP_ADDR, EMP_ADDR_DETAIL, EMP_POST, EMP_PHONE"
				+ "  , EMP_JUMIN, EMP_EMAIL, EMP_HIRE_DATE"
				+ " from employees where EMP_NUM = ?";
		
		return jdbcTemplate.queryForObject(sql, new BeanPropertyRowMapper<EmployeeDTO>(EmployeeDTO.class), empNum);
	}

	public int empUpdate(EmployeeDTO dto) {

		sql = " update employees"
				+ " set emp_name = ?, emp_addr = ?, emp_addr_detail = ?"
				+ "		, emp_post = ?, emp_phone = ?, emp_email = ?"
				+ " where emp_num = ?";
		return jdbcTemplate.update(sql, dto.getEmpName(), dto.getEmpAddr(), dto.getEmpAddrDetail()
									  , dto.getEmpPost(), dto.getEmpPhone(), dto.getEmpEmail()
									  , dto.getEmpNum());
	}

	public int empDelete(String empNum) {

		sql = " delete from employees where emp_num = ?";
		return jdbcTemplate.update(sql, empNum);
	}
}
