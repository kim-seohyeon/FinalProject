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
	
	public String goodsNumAutoSelect() {
		sql = " select concat('g_', nvl(to_number(substr(max(goods_num), 3)), 10000) + 1) from goods";
		return jdbcTemplate.queryForObject(sql, String.class);
	}
	
	public int goodsInsert(GoodsDTO dto) {
		sql = " insert into goods(GOODS_NUM, GOODS_NAME, GOODS_PRICE, GOODS_CONTENTS"
				+ "					, GOODS_MAIN_IMAGE, GOODS_MAIN_STORE_IMAGE, GOODS_DETAIL_IMAGE, GOODS_DETAIL_STORE_IMAGE)"
				+ " values(?, ?, ?, ?"
				+ "		 , ?, ?, ?,?)";
		
		return jdbcTemplate.update(sql, dto.getGoodsNum(), dto.getGoodsName(), dto.getGoodsPrice(), dto.getGoodsContents()
										, dto.getGoodsMainImage(), dto.getGoodsMainStoreImage(), dto.getGoodsDetailImage(), dto.getGoodsDetailStoreImage());

	}
	
	public List<GoodsDTO> goodsSelectAll() {
		sql = " select GOODS_NUM, GOODS_NAME, GOODS_PRICE, GOODS_CONTENTS"
				+ "  , GOODS_MAIN_IMAGE, GOODS_MAIN_STORE_IMAGE, GOODS_DETAIL_IMAGE, GOODS_DETAIL_STORE_IMAGE"
				+ " from goods";
		
		return jdbcTemplate.query(sql, new BeanPropertyRowMapper<GoodsDTO>(GoodsDTO.class));
	
	}
	
	public GoodsDTO goodsSelectOne(String goodsNum) {
		
		sql = " select GOODS_NUM, GOODS_NAME, GOODS_PRICE, GOODS_CONTENTS"
				+ "  , GOODS_MAIN_IMAGE, GOODS_MAIN_STORE_IMAGE, GOODS_DETAIL_IMAGE, GOODS_DETAIL_STORE_IMAGE"
				+ " from goods where goods_num=?";
		
		return jdbcTemplate.queryForObject(sql, new BeanPropertyRowMapper<GoodsDTO>(GoodsDTO.class), goodsNum);

	}


	public int goodsUpdate(GoodsDTO dto) {
		sql = " update goods"
				+ " set GOODS_NAME = ?, GOODS_PRICE = ?, GOODS_CONTENTS = ?"
				+ "  , GOODS_MAIN_IMAGE = ?, GOODS_MAIN_STORE_IMAGE = ?, GOODS_DETAIL_IMAGE = ?, GOODS_DETAIL_STORE_IMAGE = ?"
				+ " where goods_num = ?";
		
		return jdbcTemplate.update(sql, dto.getGoodsName(), dto.getGoodsPrice(), dto.getGoodsContents()
				, dto.getGoodsMainImage(), dto.getGoodsMainStoreImage(), dto.getGoodsDetailImage(), dto.getGoodsDetailStoreImage()
									  , dto.getGoodsNum());
	}

	public int goodsDelete(String goodsNum) {

		sql = " delete from goods where goods_num = ?";
		return jdbcTemplate.update(sql, goodsNum);
	}

}
