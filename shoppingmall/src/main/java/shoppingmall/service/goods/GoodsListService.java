package shoppingmall.service.goods;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import shoppingmall.domain.GoodsDTO;
import shoppingmall.repository.GoodsRepository;

@Service
public class GoodsListService {

    @Autowired
	public
    GoodsRepository goodsRepository;

    // 전체 상품 가져오는 메서드
    public void execute(Model model) {
        List<GoodsDTO> list = goodsRepository.goodsSelectAll();
        System.out.println("Goods List Size: " + list.size()); // 리스트 크기 확인
        model.addAttribute("list", list);
    }

    // 페이지별 상품 가져오는 메서드
    public void execute(Model model, int page) {
        int limit = 5; // 한 페이지에 보여줄 상품 수
        int offset = (page - 1) * limit;

        List<GoodsDTO> list = goodsRepository.selectGoodsByPage(offset, limit);
        int totalCount = goodsRepository.totalGoodsCount();
        int maxPage = (int) Math.ceil((double) totalCount / limit);

        model.addAttribute("list", list);
        model.addAttribute("maxPage", maxPage);
    }
    public int totalGoodsCount() {
        return goodsRepository.totalGoodsCount();
    }

}
