package shoppingmall.repository;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import shoppingmall.domain.PurchaseDTO;
import shoppingmall.domain.PurchaseListDTO;

@Repository
public class PurchaseRepository {

    @Autowired
    private JdbcTemplate jdbcTemplate;
    private String sql;

    // 구매 정보 저장
    public void save(PurchaseDTO dto) {
        sql = "INSERT INTO purchase (purchase_num, purchase_name, purchase_price, delivery_name, delivery_addr"
                + "                     , delivery_post, delivery_phone, message, member_num, purchase_date, PURCHASE_STATUS) " +
              "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, sysdate, '결제 대기중')";
        jdbcTemplate.update(sql,
                dto.getPurchaseNum(),
                dto.getPurchaseName(),
                dto.getPurchasePrice(),
                dto.getDeliveryName(),
                dto.getDeliveryAddr(),
                dto.getDeliveryPost(),
                dto.getDeliveryPhone(),
                dto.getMessage(),
                dto.getMemberNum());
    }

    // 구매 목록 조회
    public List<PurchaseListDTO> SelectAll(String memberNum) {
        sql = " select g.GOODS_NUM, GOODS_NAME, GOODS_PRICE, GOODS_CONTENTS, GOODS_MAIN_IMAGE, GOODS_MAIN_STORE_IMAGE, UPDATE_EMP_NUM, stock_name "
            + "      , p.PURCHASE_NUM, p.PURCHASE_DATE, PURCHASE_PRICE, PURCHASE_STATUS"
            + "      , CONFIRMNUMBER, CARDNUM, APPLDATE "
            + " from goods g join purchase_list pl "
            + " on g.goods_num = pl.goods_num join purchase p "
            + " on pl.purchase_num = p.purchase_num left outer join payment pm "
            + " on pm.purchase_num = p.purchase_num "
            + " where member_num = ?";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(PurchaseListDTO.class), memberNum);
    }

    // 구매 이력 확인 메서드 (memberNum, goodsNum으로 구매여부 확인)ㅇ
    public List<PurchaseListDTO> countByMemberAndGoods(String memberNum, String goodsNum) {
    	sql = " SELECT * FROM ( " +
    		      "SELECT pl.purchase_num, pl.goods_num, REVIEW_CONTENT " + // ← 공백 추가
    		      "FROM purchase p " +
    		      "JOIN purchase_list pl ON p.purchase_num = pl.purchase_num " +
    		      "LEFT OUTER JOIN review r ON pl.goods_num = r.goods_num and pl.purchase_num = r.purchase_num " +
    		      "WHERE p.member_num = ? AND pl.goods_num = ?) " +
    		      "WHERE REVIEW_CONTENT IS NULL";
        List<PurchaseListDTO> list = jdbcTemplate.query(
            sql, 
            new BeanPropertyRowMapper<PurchaseListDTO>(PurchaseListDTO.class), 
            memberNum, goodsNum
        );
        return list; 
    }

}
