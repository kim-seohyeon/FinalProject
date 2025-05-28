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
                + "                    , COMMUNITY_DATE, COMMENT_COUNT, LIKE_COUNT, COMMUNITY_COMMENT, REPLY_COMMENT"
                + "                    , MEMBER_NUM, IMAGE_PATH)"
                + " values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        return jdbcTemplate.update(sql, dto.getCommunityNum(), dto.getCommunityWriter(), dto.getCommunitySubject(), dto.getCommunityContent(),
                dto.getCommunityDate(), dto.getCommentCount(), dto.getLikeCount(),
                dto.getCommunityComment(), dto.getReplyComment(), dto.getMemberNum(), dto.getImagePath());
    }

    // 전체 게시글 조회 (메서드명 오타 수정)
    public List<CommunityDTO> communitySelectAll() {
        sql = "select COMMUNITY_NUM, COMMUNITY_SUBJECT, COMMUNITY_CONTENT, COMMUNITY_WRITER"
                + ", COMMUNITY_DATE, COMMENT_COUNT, LIKE_COUNT, COMMUNITY_COMMENT, REPLY_COMMENT, IMAGE_PATH"
                + " from COMMUNITY"
        		+ " ORDER BY COMMUNITY_DATE DESC";  // 이 줄 추가
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<CommunityDTO>(CommunityDTO.class));
    }

    // 단일 게시글 조회
    public CommunityDTO communitySelectOne(String communityNum) {
        sql = "SELECT COMMUNITY_NUM, COMMUNITY_WRITER, COMMUNITY_SUBJECT, COMMUNITY_CONTENT, COMMUNITY_DATE, COMMENT_COUNT, LIKE_COUNT, COMMUNITY_COMMENT, REPLY_COMMENT, MEMBER_NUM, IMAGE_PATH "
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
        sql = "SELECT c.comment_id AS commentNum, c.community_num AS communityNum, c.writer AS writer, "
            + "c.content AS content, c.comment_date AS commentDate, m.member_id AS memberId, m.member_num AS memberNum "
            + "FROM community_comment c "
            + "JOIN members m ON c.member_num = m.member_num "
            + "WHERE c.community_num = ? "
            + "ORDER BY c.comment_date DESC";

        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(CommentDTO.class), communityNum);
    }

    
    // 게시글 수정
    public int communityUpdate(CommunityDTO dto) {
        sql = "UPDATE community SET COMMUNITY_SUBJECT = ?, COMMUNITY_CONTENT = ? WHERE COMMUNITY_NUM = ?";
        return jdbcTemplate.update(sql, dto.getCommunitySubject(), dto.getCommunityContent(), dto.getCommunityNum());
    }

    // 게시글 삭제
    public int deleteCommunity(String communityNum) {
        String sql = "DELETE FROM community WHERE community_num = ?";
        return jdbcTemplate.update(sql, communityNum);
    }

    // 댓글 수정
    public int updateComment(CommentDTO dto) {
        String sql = "UPDATE community_comment SET comment_content = ? WHERE comment_id = ?";
        return jdbcTemplate.update(sql, dto.getContent(), dto.getCommentNum());
    }

    // 댓글 삭제
    public int deleteComment(String commentNum) {
        String sql = "DELETE FROM community_comment WHERE comment_id = ?";
        return jdbcTemplate.update(sql, commentNum);
    }
}
