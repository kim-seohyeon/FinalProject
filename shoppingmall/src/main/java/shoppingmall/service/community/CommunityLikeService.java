package shoppingmall.service.community;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import jakarta.servlet.http.HttpSession;
import shoppingmall.domain.AuthInfoDTO;
import shoppingmall.domain.CommunityDTO;
import shoppingmall.domain.MemberDTO;
import shoppingmall.repository.LikeRepository;
import shoppingmall.repository.MemberRepository;

@Service
public class CommunityLikeService {

    @Autowired
    private LikeRepository likeRepository;
    @Autowired
    MemberRepository memberRepository;

    // 좋아요 토글 (누르면 넣고, 이미 있으면 삭제)
    public void toggleLike(String communityNum, HttpSession session) {
        AuthInfoDTO auth = (AuthInfoDTO) session.getAttribute("auth");
        MemberDTO dto = memberRepository.memberSelectOne(auth.getUserId());
        String memberNum = dto.getMemberNum();

        if (likeRepository.hasUserLiked(communityNum, memberNum)) {
            likeRepository.deleteLike(communityNum, memberNum);
        } else {
            likeRepository.insertLike(communityNum, memberNum);
        }
    }

    // 해당 게시글의 좋아요 개수 가져오기
    public int getLikeCount(String communityNum) {
        return likeRepository.countLikes(communityNum);
    }

    // 현재 로그인한 사용자가 이 게시글에 좋아요 눌렀는지 확인
    public boolean hasUserLiked(String communityNum, HttpSession session) {
        AuthInfoDTO auth = (AuthInfoDTO) session.getAttribute("auth");
        if (auth == null) {
            return false;
        }
        MemberDTO dto = memberRepository.memberSelectOne(auth.getUserId());
        String memberNum = dto.getMemberNum();
        return likeRepository.hasUserLiked(communityNum, memberNum);
    }
    public List<CommunityDTO> getLikedPosts(String memberNum) {
        return likeRepository.findLikedPostsByMember(memberNum);
    }

}
