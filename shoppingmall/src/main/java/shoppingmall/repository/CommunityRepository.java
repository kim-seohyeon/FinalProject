package shoppingmall.repository;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import shoppingmall.domain.CommentDTO;
import shoppingmall.domain.CommunityDTO;

@Repository
public class CommunityRepository {
	
	@Autowired
	JdbcTemplate jdbcTemplate;
	String sql;

	// 게시글 번호 자동 생성
	public String communityNumAutoSelect() {
	    sql = "select 'c_' || to_char(nvl(max(to_number(substr(community_num, 3))), 10000) + 1) from community";
	    return jdbcTemplate.queryForObject(sql, String.class);
	}
	
	// 댓글 번호 자동 생성
	public String commentNumAutoSelect() {
	    sql = "select nvl(max(comment_num),0) + 1 from community_comment";
	    return jdbcTemplate.queryForObject(sql, String.class);
	}
	
	// 게시글 등록
	public int communityInsert(CommunityDTO dto) {
		sql = " insert into community(COMMUNITY_NUM, COMMUNITY_WRITER, COMMUNITY_SUBJECT, COMMUNITY_CONTENT"
				+ "					, COMMUNITY_DATE, COMMENT_COUNT, LIKE_COUNT, COMMUNITY_COMMENT,REPLY_COMMENT"
				+ "                 ,MEMBER_NUM )"
				+ " values(?, ?, ?, ?"
				+ "		 , ?, ?, ?, ?,?, ?)";
		
		return jdbcTemplate.update(sql, dto.getCommunityNum(),dto.getCommunityWriter(), dto.getCommunitySubject(), dto.getCommunityContent()
				,dto.getCommunityDate(), dto.getCommentCount(), dto.getLikeCount()
				, dto.getCommunityComment(), dto.getReplyComment(), dto.getMemberNum());
	}

	// 전체 게시글 조회
	public List<CommunityDTO> commnunitySelectAll() {
		sql = " select COMMUNITY_NUM, COMMUNITY_SUBJECT, COMMUNITY_CONTENT, COMMUNITY_WRITER"
				+ ", COMMUNITY_DATE, COMMENT_COUNT, LIKE_COUNT, COMMUNITY_COMMENT, REPLY_COMMENT"
				+ " from COMMUNITY";
		
		return jdbcTemplate.query(sql, new BeanPropertyRowMapper<CommunityDTO>(CommunityDTO.class));
	}

	// 단일 게시글 조회
	public CommunityDTO communitySelectOne(String communityNum) {
	    sql = "SELECT COMMUNITY_NUM, COMMUNITY_WRITER, COMMUNITY_SUBJECT, COMMUNITY_CONTENT, COMMUNITY_DATE, COMMENT_COUNT, LIKE_COUNT, COMMUNITY_COMMENT, REPLY_COMMENT, MEMBER_NUM "
	        + "FROM COMMUNITY WHERE COMMUNITY_NUM = ?";
	    return jdbcTemplate.queryForObject(sql, new BeanPropertyRowMapper<>(CommunityDTO.class), communityNum);
	}
	
	// 댓글 등록
	public int insertComment(CommentDTO dto) {
		sql = "INSERT INTO community_comment (comment_id, community_num, comment_writer, comment_content, comment_date) "
				+ "VALUES (?, ?, ?, ?, sysdate)";
		return jdbcTemplate.update(sql, commentNumAutoSelect(), dto.getCommunityNum(), dto.getWriter(), dto.getContent());
	}
	
	// 게시글에 달린 댓글 전체 조회
	public List<CommentDTO> commentSelectAllByCommunityNum(String communityNum) {
		sql = " SELECT COMMENT_ID AS comment_Num, COMMUNITY_NUM, writer,  content, COMMENT_DATE "
			+ "       ,member_id, m.member_num"
			+ " FROM community_comment c join members m "
			+ " on c.member_num = m.member_num "
			+ " WHERE COMMUNITY_NUM = ? ORDER BY COMMENT_DATE DESC";
		return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(CommentDTO.class), communityNum);
	}
	
	// 게시글 수정
	public int communityUpdate(CommunityDTO dto) {
	    sql = "UPDATE community SET COMMUNITY_SUBJECT = ?, COMMUNITY_CONTENT = ? WHERE COMMUNITY_NUM = ?";
	    return jdbcTemplate.update(sql, dto.getCommunitySubject(), dto.getCommunityContent(), dto.getCommunityNum());
	}

	public int deleteCommunity(String communityNum) {
	    String sql = "DELETE FROM community WHERE community_num = ?";
	    return jdbcTemplate.update(sql, communityNum);
	}

		
}


