package shoppingmall.service.community;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import shoppingmall.repository.LikeRepository;

@Service
public class CommunityLikeService {

    @Autowired
    private LikeRepository likeRepository;

    public void toggleLike(String communityNum, Integer memberNum) {
        if (likeRepository.hasUserLiked(communityNum, memberNum)) {
            likeRepository.deleteLike(communityNum, memberNum);
        } else {
            likeRepository.insertLike(communityNum, memberNum);
        }
    }

    public int getLikeCount(String communityNum) {
        return likeRepository.countLikes(communityNum);
    }
}