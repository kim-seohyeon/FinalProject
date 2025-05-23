package shoppingmall.service.item;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import shoppingmall.domain.MemberDTO;
import shoppingmall.repository.ItemRepository;
import shoppingmall.repository.MemberRepository;

@Service
public class CartdeletService {
	
	@Autowired
	ItemRepository itemRepository;
	@Autowired
	MemberRepository memberRepository;
	public void deleteCart(String memberId, String goodsNums[]) {
		MemberDTO  dto = memberRepository.memberSelectOne(memberId);
		for(String goodsNum : goodsNums)
			itemRepository.deleteByMemberNumAndGoodsNum(dto.getMemberNum(), goodsNum);

		
	}
}
