package shoppingmall.service.community;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import shoppingmall.command.CommunityCommand;
import shoppingmall.repository.CommunityRepository;

@Service
public class CommunityAutoNumService {

	@Autowired
	CommunityRepository communityRepository;
	public void execute(Model model) {
		
		String communityNum = communityRepository.communityNumAutoSelect();
		
		CommunityCommand communityCommand = new CommunityCommand();
		communityCommand.setCommunityNum(communityNum);
		
		model.addAttribute("communityCommand", communityCommand);
	}
}
