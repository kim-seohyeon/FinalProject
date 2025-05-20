package shoppingmall.mapper;

import org.apache.ibatis.annotations.Mapper;

import shoppingmall.domain.EmployeeDTO;

@Mapper
public interface EmployeeMapper {

	EmployeeDTO selectByEmpId(String empId);

}

