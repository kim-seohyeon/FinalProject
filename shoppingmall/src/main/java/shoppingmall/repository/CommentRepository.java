package shoppingmall.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import shoppingmall.domain.CommentDTO;

@Repository
public class CommentRepository {

    @Autowired
    JdbcTemplate jdbcTemplate;
    String sql;

    // 댓글 번호 자동 생성 (예: c_10001, c_10002 처럼)
    public String commentNumAutoSelect() {
        sql = "SELECT NVL(MAX(comment_id),0) + 1 FROM community_comment";
        return jdbcTemplate.queryForObject(sql, String.class);
    }

    // 댓글 저장
    public int commentInsert(CommentDTO dto) {
        sql = "INSERT INTO community_comment (comment_id, community_num, content, comment_date, MEMBER_NUM) "
            + "VALUES (?, ?, ?, SYSDATE,?)";
        return jdbcTemplate.update(sql, commentNumAutoSelect(), dto.getCommunityNum(), dto.getContent(), dto.getMemberNum());
    }
    @Autowired
    SqlSession sqlSession;
	public List<CommentDTO> selectByCommunityNum(String communityNum) {
		// TODO Auto-generated method stub
		 return sqlSession.selectList("shoppingmall.mapper.CommentMapper.selectByCommunityNum", communityNum);
	}
}
