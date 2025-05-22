package shoppingmall.repository;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import shoppingmall.domain.CartDTO;
import shoppingmall.domain.CartListDTO;
import shoppingmall.domain.PaymentDTO;
import shoppingmall.domain.PurchaseDTO;
import shoppingmall.domain.WishDTO;

@Repository
public class ItemRepository {

    @Autowired
    JdbcTemplate jdbcTemplate;
    String sql;

    // 장바구니에 상품 추가
    public void cartMerge(CartDTO dto) {
        sql = " MERGE INTO cart c "
            + " using (select goods_num from goods where goods_num = ? ) g"
            + " on (c.goods_num = g.goods_num and c.member_num = ? ) "
            + " WHEN MATCHED THEN "
            + "  UPDATE SET c.cart_qty = c.cart_qty + ? "
            + " WHEN NOT MATCHED THEN "
            + "  INSERT ( goods_num, member_num, cart_qty, cart_date) "
            + "  VALUES ( ?, ?, ?, sysdate)";
        
        jdbcTemplate.update(sql,
            dto.getGoodsNum(), dto.getMemberNum(), dto.getCartQty(),
            dto.getGoodsNum(), dto.getMemberNum(), dto.getCartQty()
        );
    }

    // 장바구니 상품 목록 조회
    public List<CartListDTO> cartSelectAll(String memberNum) {
        sql = "SELECT c.CART_QTY, g.GOODS_NUM, g.GOODS_NAME, g.GOODS_PRICE, "
                   + "g.GOODS_MAIN_STORE_IMAGE, c.MEMBER_NUM "
                   + "FROM cart c JOIN goods g ON c.GOODS_NUM = g.GOODS_NUM "
                   + "WHERE c.MEMBER_NUM = ?";
        
        return jdbcTemplate.query(sql, 
                new BeanPropertyRowMapper<>(CartListDTO.class), 
                memberNum);
    }

    // 구매 리스트에 상품 정보 추가
    public void purchaseListInsert(String goodsNum, String purchaseNum, String memberNum) {
        sql = "INSERT INTO purchase_list (goods_num, purchase_num, PURCHASE_QTY, GOODS_UNIT_PRICE) "
            + "SELECT ?, ?, cart_qty, cart_qty * goods_price "
            + "FROM cart c JOIN goods g ON c.goods_num = g.goods_num "
            + "WHERE g.goods_num = ? AND member_num = ?";
        jdbcTemplate.update(sql, goodsNum, purchaseNum, goodsNum, memberNum);
    }

    // 장바구니에서 상품 삭제
    public void cartDelete(String goodsNum, String memberNum) {
        sql = "DELETE FROM cart WHERE goods_num = ? AND member_num = ?";
        jdbcTemplate.update(sql, goodsNum, memberNum);
    }

    // 장바구니에서 특정 상품 1개 조회
    public CartListDTO itemSelectOne(String goodsNum, String memberNum) {
        sql = "SELECT c.CART_QTY, g.GOODS_NUM, g.GOODS_NAME, g.GOODS_PRICE, "
            + "g.GOODS_MAIN_STORE_IMAGE, c.MEMBER_NUM "
            + "FROM cart c JOIN goods g ON c.GOODS_NUM = g.GOODS_NUM "
            + "WHERE c.MEMBER_NUM = ? AND c.GOODS_NUM = ?";
        
        try {
            return jdbcTemplate.queryForObject(sql, new BeanPropertyRowMapper<>(CartListDTO.class), memberNum, goodsNum);
        } catch (Exception e) {
            return null;
        }
    }

    // 찜 등록 (MERGE 방식)
    public void wishInsert(WishDTO dto) {
        sql  = " MERGE INTO wishgoods w "
             + " USING (SELECT goods_num FROM goods WHERE goods_num = ?) g "
             + " ON (w.goods_num = g.goods_num AND w.member_num = ?) "
             + " WHEN MATCHED THEN "
             + "   UPDATE SET wishgoods_date = SYSDATE "
             + "   DELETE WHERE goods_num = ? AND member_num = ? "
             + " WHEN NOT MATCHED THEN "
             + "   INSERT (member_num, goods_num, wishgoods_date) "
             + "   VALUES (?, g.goods_num, SYSDATE)";
    
        jdbcTemplate.update(sql, dto.getGoodsNum(), dto.getMemberNum(),
                                  dto.getGoodsNum(), dto.getMemberNum(),
                                  dto.getMemberNum());
    }

    // 찜 삭제 (찜한 상품 제거)
    public void wishDelete(String memberNum, String goodsNum) {
        sql = "DELETE FROM wishgoods WHERE member_num = ? AND goods_num = ?";
        jdbcTemplate.update(sql, memberNum, goodsNum);
    }

    // 찜 여부 확인 (이미 찜했는지)
    public boolean isWished(String memberNum, String goodsNum) {
        sql = "SELECT COUNT(*) FROM wishgoods WHERE member_num = ? AND goods_num = ?";
        Integer count = jdbcTemplate.queryForObject(sql, Integer.class, memberNum, goodsNum);
        return count != null && count > 0;
    }

    // 찜 단건 조회
    public WishDTO wishSelectOne(WishDTO dto) {
        sql = "SELECT member_num, goods_num, WISHGOODS_DATE "
            + "FROM wishgoods WHERE member_num = ? AND goods_num = ?";
        try {
            return jdbcTemplate.queryForObject(sql, new BeanPropertyRowMapper<>(WishDTO.class), dto.getMemberNum(), dto.getGoodsNum());
        } catch (Exception e) {
            return null;
        }
    }

    // 찜 목록 전체 조회 (회원 기준)
    public List<WishDTO> wishSelectAll(String memberNum) {
        sql = "SELECT g.goods_num, g.goods_name, g.goods_price, g.goods_main_store_image, g.stock_name, w.wishgoods_date "
            + "FROM wishgoods w "
            + "JOIN goods g ON w.goods_num = g.goods_num "
            + "WHERE w.member_num = ? "
            + "ORDER BY w.wishgoods_date DESC";

        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(WishDTO.class), memberNum);
    }

    // 구매 단건 조회
    public PurchaseDTO purchaseSelectOne(String purchaseNum) {
        sql = "SELECT PURCHASE_NUM, PURCHASE_DATE, PURCHASE_PRICE, "
            + "DELIVERY_ADDR, DELIVERY_ADDR_DETAIL, DELIVERY_POST, "
            + "DELIVERY_PHONE, MESSAGE, PURCHASE_STATUS, MEMBER_NUM, "
            + "DELIVERY_NAME, PURCHASE_NAME "
            + "FROM purchase "
            + "WHERE PURCHASE_NUM = ?";
        return jdbcTemplate.queryForObject(sql, new BeanPropertyRowMapper<>(PurchaseDTO.class), purchaseNum);
    }

    // 결제 정보 저장
    public void paymentInsert(PaymentDTO dto) {
        sql = "INSERT INTO payment (APPLDATE, APPTIME, CARDNUM, CONFIRMNUMBER, PAYMATHOD, "
            + "purchase_num, RESULTMASSAGE, tid, TOTALPRICE) "
            + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        jdbcTemplate.update(sql, dto.getApplDate(), dto.getApplTime(), dto.getCardNum(), dto.getConfirmNumber(),
            dto.getPayMathod(), dto.getPurchaseNum(), dto.getResultMessage(),
            dto.getTid(), dto.getTotalPrice()
        );
    }
}
