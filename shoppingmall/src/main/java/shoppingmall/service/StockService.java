package shoppingmall.service;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;
import shoppingmall.domain.WishStockDTO;

@Service
public class StockService {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public List<WishStockDTO> getWishStocks(String memberNum) {
        String sql = "SELECT * FROM WISHSTOCK WHERE MEMBER_NUM = ?";
        return jdbcTemplate.query(sql, new Object[]{memberNum}, new WishStockRowMapper());
    }

    public void addWishStock(String memberNum, String stockNum) {
        String sql = "INSERT INTO WISHSTOCK (MEMBER_NUM, STOCK_NUM, WISHSTOCK_DATE) VALUES (?, ?, SYSDATE)";
        jdbcTemplate.update(sql, memberNum, stockNum);
    }

    public void removeWishStock(String memberNum, String stockNum) {
        String sql = "DELETE FROM WISHSTOCK WHERE MEMBER_NUM = ? AND STOCK_NUM = ?";
        jdbcTemplate.update(sql, memberNum, stockNum);
    }

    private static class WishStockRowMapper implements RowMapper<WishStockDTO> {
        @Override
        public WishStockDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
            WishStockDTO wishStock = new WishStockDTO();
            wishStock.setMemberNum(rs.getString("MEMBER_NUM"));
            wishStock.setStockNum(rs.getString("STOCK_NUM"));
            wishStock.setWishStockDate(rs.getDate("WISHSTOCK_DATE"));
            return wishStock;
        }
    }
    
    public boolean toggleWishStock(String memberNum, String stockNum) {
        String checkSql = "SELECT COUNT(*) FROM WISHSTOCK WHERE MEMBER_NUM = ? AND STOCK_NUM = ?";
        Integer count = jdbcTemplate.queryForObject(checkSql, Integer.class, memberNum, stockNum);

        if (count != null && count > 0) {
            String deleteSql = "DELETE FROM WISHSTOCK WHERE MEMBER_NUM = ? AND STOCK_NUM = ?";
            jdbcTemplate.update(deleteSql, memberNum, stockNum);
            return false; // 삭제됨
        } else {
            String insertSql = "INSERT INTO WISHSTOCK (MEMBER_NUM, STOCK_NUM, WISHSTOCK_DATE) VALUES (?, ?, SYSDATE)";
            jdbcTemplate.update(insertSql, memberNum, stockNum);
            return true; // 추가됨
        }
    }

}
