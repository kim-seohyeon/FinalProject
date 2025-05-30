package shoppingmall.repository;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import shoppingmall.domain.CommunityDTO;

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

    public List<CommunityDTO> findLikedPostsByMember(String memberNum) {
        String sql = "SELECT c.community_num, c.community_subject, c.community_content, c.community_writer, c.community_date, c.image_path, " +
                     "NVL(like_counts.like_count, 0) AS like_count " +
                     "FROM community c " +
                     "JOIN community_like cl ON c.community_num = cl.community_num " +
                     "LEFT JOIN ( " +
                     "    SELECT community_num, COUNT(*) AS like_count " +
                     "    FROM community_like " +
                     "    GROUP BY community_num " +
                     ") like_counts ON c.community_num = like_counts.community_num " +
                     "WHERE cl.member_num = ?";

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

