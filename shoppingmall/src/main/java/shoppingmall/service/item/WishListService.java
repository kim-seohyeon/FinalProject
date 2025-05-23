package shoppingmall.service.item;

import org.springframework.ui.Model;

public interface WishListService {
    void execute(String userNum, Model model);
}
