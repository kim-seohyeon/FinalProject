package shoppingmall.service.goods;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import shoppingmall.repository.GoodsRepository;

@Service
public class GoodsDeleteService {

	@Autowired
	GoodsRepository goodsRepository;
	public void execute(String goodsNum) {
		goodsRepository.goodsDelete(goodsNum);
	}
	
}
