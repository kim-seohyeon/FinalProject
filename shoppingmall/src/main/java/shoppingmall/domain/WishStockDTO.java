package shoppingmall.domain;

import java.util.Date;

public class WishStockDTO {
    private String memberNum;
    private String stockNum;
    private Date wishStockDate;

    public String getMemberNum() {
        return memberNum;
    }

    public void setMemberNum(String memberNum) {
        this.memberNum = memberNum;
    }

    public String getStockNum() {
        return stockNum;
    }

    public void setStockNum(String stockNum) {
        this.stockNum = stockNum;
    }

    public Date getWishStockDate() {
        return wishStockDate;
    }

    public void setWishStockDate(Date wishStockDate) {
        this.wishStockDate = wishStockDate;
    }
}
