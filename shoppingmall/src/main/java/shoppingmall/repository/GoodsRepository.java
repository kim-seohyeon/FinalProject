package shoppingmall.repository;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import shoppingmall.domain.GoodsDTO;

@Repository
public class GoodsRepository {

    @Autowired
    JdbcTemplate jdbcTemplate;
    
    String sql;

    // goods_num 자동 생성: 'g_' + 숫자 부분 최대값 + 1
    public String goodsNumAutoSelect() {
        sql = "SELECT CONCAT('g_', NVL(TO_NUMBER(SUBSTR(MAX(goods_num), 3)), 10000) + 1) FROM goods";
        return jdbcTemplate.queryForObject(sql, String.class);
    }

    // 상품 등록
    public int goodsInsert(GoodsDTO dto) {
        sql = "INSERT INTO goods(GOODS_NUM, stock_name, GOODS_NAME, GOODS_PRICE, GOODS_CONTENTS, "
            + "GOODS_MAIN_IMAGE, GOODS_MAIN_STORE_IMAGE, GOODS_DETAIL_IMAGE, GOODS_DETAIL_STORE_IMAGE) "
            + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        return jdbcTemplate.update(sql, dto.getGoodsNum(), dto.getStockName(), dto.getGoodsName(), dto.getGoodsPrice(),
                dto.getGoodsContents(), dto.getGoodsMainImage(), dto.getGoodsMainStoreImage(),
                dto.getGoodsDetailImage(), dto.getGoodsDetailStoreImage());
    }

    // 모든 상품 조회
    public List<GoodsDTO> goodsSelectAll() {
        sql = "SELECT GOODS_NUM, stock_name, GOODS_NAME, GOODS_PRICE, GOODS_CONTENTS, "
            + "GOODS_MAIN_IMAGE, GOODS_MAIN_STORE_IMAGE, GOODS_DETAIL_IMAGE, GOODS_DETAIL_STORE_IMAGE "
            + "FROM goods";
        
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(GoodsDTO.class));
    }

 // 단일 상품 조회 (수정된 안전한 버전)
    public GoodsDTO goodsSelectOne(String goodsNum) {
        sql = "SELECT GOODS_NUM, stock_name, GOODS_NAME, GOODS_PRICE, GOODS_CONTENTS, "
            + "GOODS_MAIN_IMAGE, GOODS_MAIN_STORE_IMAGE, GOODS_DETAIL_IMAGE, GOODS_DETAIL_STORE_IMAGE "
            + "FROM goods WHERE goods_num = ?";
        
        List<GoodsDTO> results = jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(GoodsDTO.class), goodsNum);

        return results.isEmpty() ? null : results.get(0);
    }


    // 상품 수정
    public int goodsUpdate(GoodsDTO dto) {
        sql = "UPDATE goods SET stock_name = ?, GOODS_NAME = ?, GOODS_PRICE = ?, GOODS_CONTENTS = ?, "
            + "GOODS_MAIN_IMAGE = ?, GOODS_MAIN_STORE_IMAGE = ?, GOODS_DETAIL_IMAGE = ?, GOODS_DETAIL_STORE_IMAGE = ? "
            + "WHERE goods_num = ?";
        
        return jdbcTemplate.update(sql, dto.getStockName(), dto.getGoodsName(), dto.getGoodsPrice(),
                dto.getGoodsContents(), dto.getGoodsMainImage(), dto.getGoodsMainStoreImage(),
                dto.getGoodsDetailImage(), dto.getGoodsDetailStoreImage(), dto.getGoodsNum());
    }

    // 상품 삭제
    public int goodsDelete(String goodsNum) {
        sql = "DELETE FROM goods WHERE goods_num = ?";
        return jdbcTemplate.update(sql, goodsNum);
    }
    
    // 페이징 처리용 메서드: offset 부터 limit 개수만큼 조회
    public List<GoodsDTO> selectGoodsByPage(int offset, int limit) {
        sql = "SELECT GOODS_NUM, stock_name, GOODS_NAME, GOODS_PRICE, GOODS_CONTENTS, "
            + "GOODS_MAIN_IMAGE, GOODS_MAIN_STORE_IMAGE, GOODS_DETAIL_IMAGE, GOODS_DETAIL_STORE_IMAGE "
            + "FROM goods ORDER BY GOODS_NUM DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(GoodsDTO.class), offset, limit);
    }

    // 총 상품 수 조회
    public int totalGoodsCount() {
        sql = "SELECT COUNT(*) FROM goods";
        return jdbcTemplate.queryForObject(sql, Integer.class);
    }
}
