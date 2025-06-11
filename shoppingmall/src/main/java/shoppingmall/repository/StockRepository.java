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
   public List<StockA3> stockSelect() {
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
				+ "WHERE rn = 1 "
				+ "ORDER BY trading_date DESC ";
		return jdbcTemplate.query(sql
				, new BeanPropertyRowMapper<StockA3>(StockA3.class));
	}
	
	public List<StockA3> stockCurrentSelect(){
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
				+ "WHERE rn = 1";
		return jdbcTemplate.query(sql
				, new BeanPropertyRowMapper<StockA3>(StockA3.class));
	}
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
}
//s