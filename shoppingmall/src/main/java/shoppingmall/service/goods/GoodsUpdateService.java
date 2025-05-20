package shoppingmall.service.goods;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import shoppingmall.command.GoodsCommand;
import shoppingmall.domain.GoodsDTO;
import shoppingmall.repository.GoodsRepository;

@Service
public class GoodsUpdateService {

	@Autowired
	GoodsRepository goodsRepository;
	public void execute(GoodsCommand goodsCommand) {
		
		GoodsDTO dto = goodsRepository.goodsSelectOne(goodsCommand.getGoodsNum());
		dto.setGoodsNum(goodsCommand.getGoodsNum());
		dto.setGoodsName(goodsCommand.getGoodsName());
		dto.setGoodsPrice(goodsCommand.getGoodsPrice());
		dto.setGoodsContents(goodsCommand.getGoodsContents());
		dto.setGoodsMainImage(goodsCommand.getGoodsMainImage());
		dto.setGoodsMainStoreImage(goodsCommand.getGoodsMainStoreImage());
		dto.setGoodsDetailImage(goodsCommand.getGoodsDetailImage());
		dto.setGoodsDetailStoreImage(goodsCommand.getGoodsDetailStoreImage());
		
		goodsRepository.goodsUpdate(dto);

	}
}
