package shoppingmall.service.goods;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import shoppingmall.command.GoodsCommand;
import shoppingmall.repository.GoodsRepository;

@Service
public class GoodsAutoNumService {

	@Autowired
	GoodsRepository goodsRepository;
	public void execute(Model model) {
		
		String goodsNum = goodsRepository.goodsNumAutoSelect();
		
		GoodsCommand goodsCommand = new GoodsCommand();
		goodsCommand.setGoodsNum(goodsNum);
		
		model.addAttribute("goodsCommand", goodsCommand);
	}
}

