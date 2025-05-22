package shoppingmall.repository;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import shoppingmall.domain.CommunityDTO;
import shoppingmall.domain.GoodsDTO;

@Repository
public class CommunityRepository {
	
	@Autowired
	JdbcTemplate jdbcTemplate;
	String sql;

	public List<CommunityDTO> commnunitySelectAll() {
		sql = " select COMMUNITY_NUM, COMMUNITY_SUBJECT, COMMUNITY_CONTENT"
				+ ", COMMUNITY_DATE, COMMENT_COUNT, LIKE_COUNT, COMMUNITY_COMMENT, REPLY_COMMENT"
				+ " from COMMUNITY";
		
		return jdbcTemplate.query(sql, new BeanPropertyRowMapper<CommunityDTO>(CommunityDTO.class));
	}


}
