package shoppingmall.service.item;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import shoppingmall.domain.WishDTO;

@Service
public class WishListServiceImpl implements WishListService {

    @Autowired
    JdbcTemplate jdbcTemplate;

    @Override
    public void execute(String userNum, Model model) {
        String sql = """
            SELECT WG.GOODS_NUM AS goodsNum, 
                   WG.WISHGOODS_DATE AS wishDate,
                   M.GOODS_PRICE AS goodsPrice,
                   M.STOCK_NAME AS stockName,
                   M.goods_name as goodsName,
                   M.GOODS_MAIN_STORE_IMAGE AS goodsMainStoreImage
            FROM WISHGOODS WG JOIN GOODS M 
            ON WG.GOODS_NUM = M.GOODS_NUM
            WHERE WG.MEMBER_Num = ?
        """;

        List<WishDTO> wishList = jdbcTemplate.query(
            sql,
            new BeanPropertyRowMapper<>(WishDTO.class),
            userNum
        );

        model.addAttribute("wishList", wishList);
    }
}
