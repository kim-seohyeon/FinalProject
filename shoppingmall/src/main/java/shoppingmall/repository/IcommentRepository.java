package shoppingmall.repository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import shoppingmall.command.IcommentCommand;

@Repository
public class IcommentRepository {

    @Autowired
    JdbcTemplate jdbcTemplate;
    String sql;
    
    public String icommentNumAutoSelect() {
        sql = "SELECT NVL(MAX(icomment_id),0) + 1 FROM inquire_comment";
        return jdbcTemplate.queryForObject(sql, String.class);
    }
	
	public int icommentInsert(IcommentCommand icommentCommand) {
		
		sql = "INSERT INTO inquire_comment (icomment_id, inquire_num, icomment_content, icomment_date, MEMBER_NUM) "
	            + "VALUES (?, ?, ?, SYSDATE,?)";
	    
		return jdbcTemplate.update(sql, icommentNumAutoSelect(), icommentCommand.getInquireNum(), icommentCommand.getIcommentContent(), icommentCommand.getMemberNum());
	}

	
}
