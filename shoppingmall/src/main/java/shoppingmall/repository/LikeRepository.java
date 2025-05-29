package shoppingmall.repository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class LikeRepository {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public int countLikes(String communityNum) {
        String sql = "SELECT COUNT(*) FROM community_like WHERE community_num = ?";
        return jdbcTemplate.queryForObject(sql, Integer.class, communityNum);
    }

    public boolean hasUserLiked(String communityNum, String memberNum) {
        String sql = "SELECT COUNT(*) FROM community_like WHERE community_num = ? AND member_num = ?";
        Integer count = jdbcTemplate.queryForObject(sql, Integer.class, communityNum, memberNum);
        return count != null && count > 0;
    }

    public void insertLike(String communityNum, String memberNum) {
    	String numQuery  = "select nvl(max(like_id),0) + 1 from community_like";
        String sql = "INSERT INTO community_like (like_id, community_num, member_num) VALUES (("+ numQuery +"), ?, ?)";
        jdbcTemplate.update(sql, communityNum, memberNum);
    }

    public void deleteLike(String communityNum, String memberNum) {
        String sql = "DELETE FROM community_like WHERE community_num = ? AND member_num = ?";
        jdbcTemplate.update(sql, communityNum, memberNum);
    }
}