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
	GoodsRepository goodsRepository;
	public void execute(Model model) {
		List<GoodsDTO> list = goodsRepository.goodsSelectAll();
	    System.out.println("Goods List Size: " + list.size()); // 리스트 크기 확인
		model.addAttribute("list", list);

	}
	
}
