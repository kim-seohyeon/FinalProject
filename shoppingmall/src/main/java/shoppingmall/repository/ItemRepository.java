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
        
        jdbcTemplate.update(sql
        	,dto.getGoodsNum(), dto.getMemberNum(), dto.getCartQty() // for ON + UPDATE
            ,dto.getGoodsNum(), dto.getMemberNum(), dto.getCartQty()  // for INSERT
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
        	+ " select ? , ?, cart_qty , cart_qty * goods_price "
    		+ " from cart c join goods g "
    		+ " on c.goods_num = g.goods_num "
    		+ " where g.goods_num = ? and member_num = ? ";
        jdbcTemplate.update(sql, goodsNum, purchaseNum , goodsNum, memberNum);
    }

    // 장바구니에서 상품 삭제
    public void cartDelete(String goodsNum, String memberNum) {
        sql = "DELETE FROM cart WHERE goods_num = ? AND member_num = ?";
        jdbcTemplate.update(sql, goodsNum, memberNum);
    }


    public CartListDTO itemSelectOne(String goodsNum, String memberNum) {
        sql = "SELECT c.CART_QTY, g.GOODS_NUM, g.GOODS_NAME, g.GOODS_PRICE, "
                + "g.GOODS_MAIN_STORE_IMAGE, c.MEMBER_NUM "
                + "FROM cart c JOIN goods g ON c.GOODS_NUM = g.GOODS_NUM "
                + "WHERE c.MEMBER_NUM = ? AND c.GOODS_NUM = ?";
        
        try {
            return jdbcTemplate.queryForObject(sql, new BeanPropertyRowMapper<>(CartListDTO.class), memberNum, goodsNum);
        } catch (Exception e) {
            return null;  // 상품이 없다면 null을 반환
        }
    }

    // wish 테이블에 데이터 삽입
    public void wishInsert(WishDTO dto) {
    	sql  = " merge into wishgoods w  "
   			 + " using (select goods_num from goods where goods_num = ?) g "
   			 + " on (w.goods_num = g.goods_num and w.member_num = ? )"
   			 + " when matched then "
   			 + " 	update set WISHGOODS_DATE = sysdate "
   			 + "    delete where goods_num = ? and member_num  = ? "
   			 + " when not matched then "
   			 + " 	insert (member_num, goods_num , WISHGOODS_DATE) "
   			 + "    values (?, g.goods_num , sysdate) ";
    
    	jdbcTemplate.update(sql,dto.getGoodsNum(), dto.getMemberNum()
    			               ,dto.getGoodsNum(), dto.getMemberNum()
    			               ,dto.getMemberNum());
    }

    // 찜 목록 조회 (회원 번호와 상품 번호로 찜 정보 조회)
    public WishDTO wishSelectOne(WishDTO dto) {
        sql = "SELECT member_num, goods_num, WISH_DATE "
        		+ "FROM wish WHERE member_num = ? AND goods_num = ?";
        try {
            // 찜 정보를 가져와서 반환
            return jdbcTemplate.queryForObject(sql, new BeanPropertyRowMapper<WishDTO>(WishDTO.class), dto.getMemberNum(), dto.getGoodsNum());
        } catch (Exception e) {
            // 만약 찜 정보가 없다면 null을 반환
            return null;
        }
    }
    
    public PurchaseDTO purchaseSelectOne(String purchaseNum) {
    	sql = " select  PURCHASE_NUM, PURCHASE_DATE, PURCHASE_PRICE  "
    			+ "     	,DELIVERY_ADDR, DELIVERY_ADDR_DETAIL, DELIVERY_POST"
    			+ "     	,DELIVERY_PHONE, MESSAGE, PURCHASE_STATUS, MEMBER_NUM"
    			+ "     	,DELIVERY_NAME, PURCHASE_NAME"
    			+ " from purchase "
    			+ " where PURCHASE_NUM = ? ";       
    	return jdbcTemplate.queryForObject(sql, new BeanPropertyRowMapper<>(PurchaseDTO.class), purchaseNum);
    }

    public void paymentInsert(PaymentDTO dto) {
        // SQL 쿼리 작성
        sql = "INSERT INTO payment (APPLDATE, APPTIME, CARDNUM, CONFIRMNUMBER, PAYMATHOD " +
                     ", purchase_num, RESULTMASSAGE, tid, TOTALPRICE) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        // JdbcTemplate을 사용하여 데이터 삽입
        jdbcTemplate.update(sql, dto.getApplDate(),  dto.getApplTime(), dto.getCardNum(),dto.getConfirmNumber(),
            dto.getPayMathod(), dto.getPurchaseNum(), dto.getResultMessage(),
            dto.getTid(), dto.getTotalPrice()
        );
    }

}
