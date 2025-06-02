package shoppingmall.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import shoppingmall.domain.CommentDTO;
import shoppingmall.domain.CommunityDTO;

@Repository
public class CommentRepository {

    @Autowired
    JdbcTemplate jdbcTemplate;
    String sql;

    // 댓글 번호 자동 생성 (예: c_10001, c_10002 처럼)
 // 숫자형 댓글 ID 자동 생성
    public int commentNumAutoSelect() {
        String sql = "SELECT NVL(MAX(comment_id), 0) + 1 FROM community_comment";
        Integer nextNum = jdbcTemplate.queryForObject(sql, Integer.class);
        return nextNum;
    }




    // 댓글 저장
    public int commentInsert(CommentDTO dto) {
        sql = "INSERT INTO community_comment (comment_id, community_num, writer, content, comment_date, member_num) "
            + "VALUES (?, ?, ?, ?, SYSDATE, ?)";
        return jdbcTemplate.update(sql, commentNumAutoSelect(), dto.getCommunityNum(), dto.getWriter(), dto.getContent(), dto.getMemberNum());
    }


    @Autowired
    SqlSession sqlSession;
	public List<CommentDTO> selectByCommunityNum(String communityNum) {
		// TODO Auto-generated method stub
		 return sqlSession.selectList("shoppingmall.mapper.CommentMapper.selectByCommunityNum", communityNum);
	}
	
	// 댓글 하나 가져오기
	public CommentDTO selectCommentByNum(String commentNum) {
	    return sqlSession.selectOne("shoppingmall.mapper.CommentMapper.selectCommentByNum", commentNum);
	}

	// 댓글 수정
	public int updateComment(CommentDTO dto) {
	    String sql = "UPDATE community_comment SET content = ? WHERE comment_id = ?";
	    return jdbcTemplate.update(sql, dto.getContent(), dto.getCommentNum());
	}

	// 댓글 삭제
	public int deleteComment(String commentNum) {
	    String sql = "DELETE FROM community_comment WHERE comment_id = ?";
	    return jdbcTemplate.update(sql, commentNum);
	}
	public List<CommunityDTO> selectCommunityByMemberNum(String memberNum) {
	    String sql = "SELECT c.* FROM community c JOIN community_comment cc ON c.community_num = cc.community_num WHERE cc.member_num = ?";
	    return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(CommunityDTO.class), memberNum);
	}
	public List<CommunityDTO> findCommunityByMemberNum(String memberNum) {
	    String sql = "SELECT DISTINCT c.* " +
	                 "FROM community c JOIN community_comment cc ON c.community_num = cc.community_num " +
	                 "WHERE cc.member_num = ? " +
	                 "ORDER BY c.community_date DESC";
	    return jdbcTemplate.query(sql,
	            (rs, rowNum) -> {
	                CommunityDTO dto = new CommunityDTO();
	                dto.setCommunityNum(rs.getString("community_num"));
	                dto.setCommunityWriter(rs.getString("community_writer"));
	                dto.setCommunitySubject(rs.getString("community_subject"));
	                dto.setCommunityContent(rs.getString("community_content"));
	                dto.setCommunityDate(rs.getDate("community_date"));
	                dto.setLikeCount(rs.getInt("like_count"));
	                dto.setImagePath(rs.getString("image_path"));
	                return dto;
	            },
	            memberNum
	        );
	}
}
