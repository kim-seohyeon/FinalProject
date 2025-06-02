package shoppingmall.repository;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import shoppingmall.domain.CommentDTO;
import shoppingmall.domain.GoodsDTO;
import shoppingmall.domain.IcommentDTO;
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
				+ ", INQUIRE_CONTENTS, MEMBER_NUM, inquire_date )"
				+ " values(?, ?, ?, ?, ?, sysdate)";
		
		return jdbcTemplate.update(sql, inquireNumAutoSelect(),dto.getInquireWriter(), dto.getInquireSubject()
				, dto.getInquireContents(), dto.getMemberNum());
		
	}

	public List<InquireDTO> inquireSelectAll() {
		sql = " select INQUIRE_NUM, MEMBER_NUM, INQUIRE_WRITER"
				+ ", INQUIRE_SUBJECT, INQUIRE_CONTENTS, INQUIRE_KIND, INQUIRE_DATE"
				+ " from inquire";
		
		return jdbcTemplate.query(sql, new BeanPropertyRowMapper<InquireDTO>(InquireDTO.class));

	}

	public InquireDTO inquireSelectOne(String inquireNum) {

		sql = " select INQUIRE_NUM, MEMBER_NUM, INQUIRE_WRITER"
				+ ", INQUIRE_SUBJECT, INQUIRE_CONTENTS, INQUIRE_KIND, INQUIRE_DATE"
				+ " from inquire where inquire_num = ?";
		
		return jdbcTemplate.queryForObject(sql, new BeanPropertyRowMapper<InquireDTO>(InquireDTO.class), inquireNum);

		
	}

	public int inquireUpdate(InquireDTO dto) {

		sql = " update inquire"
				+ " set inquire_subject = ?, inquire_contents = ?"
				+ " where inquire_num = ?";
		
		return jdbcTemplate.update(sql, dto.getInquireSubject(), dto.getInquireContents(), dto.getInquireNum());
		
	}

	public int inquireDelete(String inquireNum) {

		sql = " delete from inquire where inquire_num = ?";
		return jdbcTemplate.update(sql, inquireNum);
	}

	public List<IcommentDTO> icommentSelectAllByCommunityNum(String inquireNum) {
		sql = " SELECT icomment_id , inquire_num, icomment_writer,  icomment_content, icomment_date "
				+ "       ,member_id, m.member_num"
				+ " FROM inquire_comment i join members m "
				+ " on i.member_num = m.member_num "
				+ " WHERE inquire_num = ? ORDER BY icomment_date DESC";
			return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(IcommentDTO.class), inquireNum);
	}
	

}
