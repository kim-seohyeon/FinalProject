package shoppingmall.repository;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import shoppingmall.domain.InquireDTO;

@Repository
public class InquireRepository {

	@Autowired
	JdbcTemplate jdbcTemplate;
	String sql;
	
	public String inquireNumAutoSelect() {
		sql = " select  nvl(max(inquire_num),0) + 1 from inquire";
		return jdbcTemplate.queryForObject(sql, String.class);
		
	}
	
	public int inquireInsert(InquireDTO dto) {
		sql = " insert into inquire(INQUIRE_NUM, INQUIRE_WRITER, INQUIRE_SUBJECT"
				+ ", INQUIRE_CONTENTS, MEMBER_NUM )"
				+ " values(?, ?, ?, ?, ?)";
		
		return jdbcTemplate.update(sql, inquireNumAutoSelect(),dto.getInquireWriter(), dto.getInquireSubject()
				, dto.getInquireContents(), dto.getMemberNum());
		
	}

	public List<InquireDTO> inquireSelectAll() {
		sql = " select INQUIRE_NUM, MEMBER_NUM, INQUIRE_WRITER"
				+ ", INQUIRE_SUBJECT, INQUIRE_CONTENTS, INQUIRE_KIND, INQUIRE_DATE"
				+ " from inquire";
		
		return jdbcTemplate.query(sql, new BeanPropertyRowMapper<InquireDTO>(InquireDTO.class));

	}


}
