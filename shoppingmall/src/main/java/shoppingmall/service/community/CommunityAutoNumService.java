package shoppingmall.service.community;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import shoppingmall.command.CommunityCommand;
import shoppingmall.command.GoodsCommand;
import shoppingmall.repository.GoodsRepository;

@Service
public class CommunityAutoNumService {

	@Autowired
	GoodsRepository communityRepository;
	public void execute(Model model) {
		
		String CommunityNum = communityRepository.goodsNumAutoSelect();
		
		CommunityCommand communityCommand = new CommunityCommand();
		communityCommand.setCommunityNum(CommunityNum);
		
		model.addAttribute("goodsCommand", CommunityNum);
	}
}
