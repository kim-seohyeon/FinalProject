package shoppingmall.service.item;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

@Service
public class UpdateCartQtyService {
    @Autowired
    JdbcTemplate jdbcTemplate;

    public int execute(String userId, String goodsNum, int cartQty) {
        String sql = "UPDATE cart SET cart_qty = ? WHERE member_num = "
                   + "(SELECT member_num FROM members WHERE member_id = ?) AND goods_num = ?";
        int rows = jdbcTemplate.update(sql, cartQty, userId, goodsNum);

        // 합계금액 구해서 반환
        String priceSql = "SELECT goods_price FROM goods WHERE goods_num = ?";
        Integer price = jdbcTemplate.queryForObject(priceSql, Integer.class, goodsNum);

        return price * cartQty;
    }
}
