package shoppingmall.repository;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import shoppingmall.domain.StockA3;
import shoppingmall.domain.StockDTO;

@Repository
public class StockRepository {
   @Autowired
   JdbcTemplate jdbcTemplate;
   String sql;
   
   //주식 차트 그래프 출력
   public List<StockA3> stockSelect(String StockName) {
		String	StockName1 = " and symbol = (select case when stock_name = '삼성전자' then 'KR7005930003' "
					   + "                                       else '-' end stock_name "
					   + "                            from stock"
					   + "                            where stock_name = '"+StockName+"')";
		
		sql = "SELECT  "
				+ "    TO_CHAR(trading_date, 'yyyy-MM-dd') AS trading_date, "
				+ "    rn AS max_rn, "
				+ "    symbol, "
				+ "    price, "
				+ "    volume, "
				+ "    cumulative_volume "
				+ "FROM ( "
				+ "    SELECT  "
				+ "        ROW_NUMBER() OVER ( "
				+ "            PARTITION BY TO_CHAR(trading_date, 'yyyy-MM-dd')  "
				+ "            ORDER BY trading_hours DESC  "
				+ "        ) AS rn, "
				+ "        trading_date, "
				+ "        symbol, "
				+ "        price, "
				+ "        volume, "
				+ "        cumulative_volume "
				+ "    FROM stock1 "
				+ "    WHERE TO_NUMBER(trading_hours) <= 153000 "
				+ "      AND ( "
				+ "          TRUNC(trading_date) < TRUNC(SYSDATE) "
				+ "          OR ( "
				+ "              TRUNC(trading_date) = TRUNC(SYSDATE)   "
				+ "              AND TO_NUMBER(TO_CHAR(SYSDATE, 'HH24MI')) >= '1530'   "
				+ "          ) "
				+ "      ) "
				+ ") "
				+ "WHERE rn = 1 " + StockName1
				+ "ORDER BY trading_date DESC ";
		return jdbcTemplate.query(sql
				, new BeanPropertyRowMapper<StockA3>(StockA3.class));
	}
	
   //주식 표 출력
	public List<StockA3> stockCurrentSelect(String StockName){
		String	StockName1 = " and symbol = (select case when stock_name = '삼성전자' then 'KR7005930003' "
					   + "                                       else '-' end stock_name "
					   + "                            from stock"
					   + "                            where stock_name = '"+StockName+"')";
		sql = " SELECT * "
				+ "FROM ( "
				+ "    SELECT s.*,  "
				+ "           ROW_NUMBER() OVER ( "
				+ "               PARTITION BY TO_CHAR(trading_date, 'yyyy-MM-dd'), trading_hours  "
				+ "               ORDER BY TO_CHAR(trading_date, 'yyyy-MM-dd') DESC, trading_hours DESC, ROWID DESC "
				+ "           ) AS rn "
				+ "    FROM stock1 s "
				+ "    WHERE TRUNC(trading_date) = TRUNC(SYSDATE) "
				+ ") "
				+ "WHERE rn = 1 " + StockName1;
		return jdbcTemplate.query(sql
				, new BeanPropertyRowMapper<StockA3>(StockA3.class));
	}

	//현재가
	public List<StockDTO> stockInfo(){
      sql = "select STOCK_NUM , stock.STOCK_NAME,"
            + "        price "
            + "from stock left outer join ( select * from ( "
            + "                        select row_number() over (partition by trunc(trading_date)  order by trunc(trading_date) desc) rn "
            + "                             , case when symbol =  'KR7005930003' then '삼성전자' "
            + "                                    else '-' "
            + "                                end stock_name , price , trading_date, TRADING_HOURS "
            + "                        from stock1 "
            + "                        where trunc(trading_date) = trunc(sysdate) "
            + "                        order by trunc(trading_date) desc, TRADING_HOURS desc "
            + "                        ) "
            + "                        where rn = 1 "
            + "                        ) st "
            + "on stock.stock_name = st.stock_name";
      return jdbcTemplate.query(sql
            , new BeanPropertyRowMapper<StockDTO>(StockDTO.class));
   }
	
	//추천주식
	public List<StockA3> recommandStock(String memberNum){
		System.out.println("recommandStock");
		sql = "  SELECT S1.* , CASE WHEN SYMBOL = 'KR7005930003' THEN '삼성전자' "
				+ "                   ELSE '-' END STOCK_NAME   "
				+ "FROM ( "
				+ "    SELECT s.*, "
				+ "           ROW_NUMBER() OVER ( "
				+ "               PARTITION BY TO_CHAR(trading_date, 'yyyy-MM-dd'), trading_hours "
				+ "               ORDER BY TO_CHAR(trading_date, 'yyyy-MM-dd') DESC, trading_hours DESC, ROWID DESC "
				+ "           ) AS rn "
				+ "    FROM stock1 s "
				+ "    WHERE TRUNC(trading_date) = TRUNC(SYSDATE) "
				+ ")S1 "
				+ "WHERE rn = 1  "
				+ "and SYMBOL = (  "
				+ "SELECT CASE WHEN STOCK_NAME = '삼성전자' THEN 'KR7005930003' "
				+ "            ELSE '-' END STOCK_NAME  "
				+ "FROM GOODS "
				+ "WHERE GOODS_NUM = ( "
				+ "        SELECT GOODS_NUM FROM (     "
				+ "            SELECT PL.GOODS_NUM, CNT  "
				+ "            FROM purchase P JOIN (  "
				+ "                                SELECT * "
				+ "                                FROM ( "
				+ "                                      SELECT purchase_NUM,  goods_num, COUNT(*) OVER (PARTITION BY goods_num) AS cnt "
				+ "                                      FROM purchase_list "
				+ "                                      ) "
				+ "                               ) PL "
				+ "            ON P.purchase_NUM = PL.purchase_NUM AND P.MEMBER_NUM = ? "
				+ "            ORDER BY CNT DESC "
				+ "        ) "
				+ "        WHERE ROWNUM =1) "
				+ ")";
		return jdbcTemplate.query(sql
				, new BeanPropertyRowMapper<StockA3>(StockA3.class), memberNum);
	}
}


