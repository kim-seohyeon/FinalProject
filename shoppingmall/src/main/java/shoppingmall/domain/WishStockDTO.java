package shoppingmall.domain;

import java.util.Date;

import lombok.Data;

@Data
public class WishStockDTO {
    private String memberNum;
    private String stockNum;
    private String stockName; 
    private Date wishStockDate;
}
