package shoppingmall.repository;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import shoppingmall.domain.CommunityDTO;

@Repository
public class CommunityRepository {
	
	@Autowired
	JdbcTemplate jdbcTemplate;
	String sql;

	public String communityNumAutoSelect() {
		sql = " select concat('c_', nvl(to_number(substr(max(community_num), 3)), 10000) + 1) from community";
		return jdbcTemplate.queryForObject(sql, String.class);
		
	}
	
	
	public int communityInsert(CommunityDTO dto) {
		sql = " insert into community(COMMUNITY_NUM, COMMUNITY_SUBJECT, COMMUNITY_CONTENT"
				+ "					, COMMUNITY_DATE, COMMENT_COUNT, LIKE_COUNT, COMMUNITY_COMMENT,REPLY_COMMENT"
				+ "                 ,MEMBER_NUM )"
				+ " values(?, ?, ?"
				+ "		 , sysdate, ?, ?, ?,?, ?)";
		
		return jdbcTemplate.update(sql, dto.getCommunityNum(), dto.getCommunitySubject(), dto.getCommunityContent()
				, dto.getCommentCount(), dto.getLikeCount()
				, dto.getCommunityComment(), dto.getReplyComment(), dto.getMemberNum());
		
	}

	public List<CommunityDTO> commnunitySelectAll() {
		sql = " select COMMUNITY_NUM, COMMUNITY_SUBJECT, COMMUNITY_CONTENT"
				+ ", COMMUNITY_DATE, COMMENT_COUNT, LIKE_COUNT, COMMUNITY_COMMENT, REPLY_COMMENT"
				+ " from COMMUNITY";
		
		return jdbcTemplate.query(sql, new BeanPropertyRowMapper<CommunityDTO>(CommunityDTO.class));
	}








}
