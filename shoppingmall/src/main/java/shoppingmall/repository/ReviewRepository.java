package shoppingmall.repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import shoppingmall.domain.ReviewDTO;

@Repository
public class ReviewRepository {

    @Autowired
    JdbcTemplate jdbcTemplate;
    String sql;

    // 후기 작성
    public void insertReview(ReviewDTO dto) {
        sql = "INSERT INTO REVIEW (REVIEW_NUM, GOODS_NUM, MEMBER_NUM, REVIEW_CONTENT) VALUES (REVIEW_SEQ.NEXTVAL, ?, ?, ?)";
        jdbcTemplate.update(sql, dto.getGoodsNum(), dto.getMemberNum(), dto.getReviewContent());
    }

    // 후기 조회
    public List<ReviewDTO> getReviewsByGoodsNum(String goodsNum) {
        sql = " SELECT REVIEW_NUM, GOODS_NUM, M.MEMBER_ID, REVIEW_CONTENT, REVIEW_DATE"
            + " FROM REVIEW R JOIN MEMBERS M "
            + " ON R.MEMBER_NUM = M.MEMBER_Num "
            + " WHERE GOODS_NUM = ? ORDER BY REVIEW_DATE DESC ";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<ReviewDTO>(ReviewDTO.class), goodsNum);
    }
}
