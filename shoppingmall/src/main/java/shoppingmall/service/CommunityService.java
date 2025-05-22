package shoppingmall.service;

import java.util.List;

import org.springframework.stereotype.Service;

import shoppingmall.domain.CommunityDTO;
import shoppingmall.repository.CommunityRepository;

@Service
public class CommunityService {

    private final CommunityRepository communityRepository;

    // 생성자 주입 (Spring이 자동 주입해줌)
    public CommunityService(CommunityRepository communityRepository) {
        this.communityRepository = communityRepository;
    }

    // 게시글 전체 조회
    public List<CommunityDTO> getAllPosts() {
        return communityRepository.findAll();
    }

    // 새 글 작성
    public void createPost(CommunityDTO post) {
        communityRepository.save(post);
    }

    // 상세 글 조회 (필요하면)
    public CommunityDTO getPostById(String communityNum) {
        return communityRepository.findById(communityNum);
    }

	public static void save(CommunityDTO post) {
		// TODO Auto-generated method stub
		
	}
    }