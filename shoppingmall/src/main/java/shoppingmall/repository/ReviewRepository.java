package shoppingmall.repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import shoppingmall.domain.ReviewDTO;

@Repository
public class ReviewRepository {

    @Autowired
    JdbcTemplate jdbcTemplate;
    String sql;

    // 후기 작성
    public void insertReview(ReviewDTO dto) {
        sql = "INSERT INTO REVIEW (REVIEW_NUM, GOODS_NUM, MEMBER_NUM, REVIEW_CONTENT , purchase_num, REVIEW_DATE) VALUES (REVIEW_SEQ.NEXTVAL, ?, ?, ?,?, sysdate)";
        jdbcTemplate.update(sql, dto.getGoodsNum(), dto.getMemberNum(), dto.getReviewContent(), dto.getPurchaseNum());
    }

    // 후기 목록 조회ㅇ
    public List<ReviewDTO> getReviewsByGoodsNum(String goodsNum) {
        sql = "SELECT REVIEW_NUM, GOODS_NUM, M.MEMBER_ID, REVIEW_CONTENT, REVIEW_DATE "
            + "FROM REVIEW R JOIN MEMBERS M ON R.MEMBER_NUM = M.MEMBER_NUM "
            + "WHERE GOODS_NUM = ? ORDER BY REVIEW_DATE DESC";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(ReviewDTO.class), goodsNum);
    }
    
    // 리뷰 삭제
    public void deleteById(Long reviewNum) {
        sql = "DELETE FROM REVIEW WHERE REVIEW_NUM = ?";
        jdbcTemplate.update(sql, reviewNum);
    }

	public int reviewDelete(String reviewNum) {

		sql = " delete from review where review_Num = ?";
		return jdbcTemplate.update(sql, reviewNum);		
	}
}
