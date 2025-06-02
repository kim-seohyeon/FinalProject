package shoppingmall.service.community;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import shoppingmall.domain.CommunityDTO;
import shoppingmall.repository.CommunityRepository;

@Service
public class CommunityService {

    @Autowired
    private CommunityRepository communityRepository;

    public void incrementViewCount(String communityNum) {
        communityRepository.incrementViewCount(communityNum);
    }

    public CommunityDTO getPostById(String communityNum) {
        return communityRepository.communitySelectOne(communityNum);
    }
}

