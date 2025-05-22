package shoppingmall.service.item;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import jakarta.servlet.http.HttpSession;
import shoppingmall.domain.AuthInfoDTO;
import shoppingmall.domain.MemberDTO;
import shoppingmall.domain.WishDTO;
import shoppingmall.repository.MemberRepository;
import shoppingmall.repository.ItemRepository;

@Service
public class GoodsWishItemService {

    @Autowired
    private MemberRepository memberRepository;

    @Autowired
    private ItemRepository itemRepository;

    public boolean execute(HttpSession session, String goodsNum) {
        // 로그인 사용자 정보 가져오기
        AuthInfoDTO auth = (AuthInfoDTO) session.getAttribute("auth");
        if (auth == null) {
            throw new IllegalStateException("로그인이 필요합니다.");
        }

        // 사용자 정보 조회
        MemberDTO mdto = memberRepository.memberSelectOne(auth.getUserId());
        String memberNum = mdto.getMemberNum();

        // 이미 찜한 상품인지 확인
        boolean isWished = itemRepository.isWished(memberNum, goodsNum);

        if (isWished) {
            // 이미 찜했다면 삭제
            itemRepository.wishDelete(memberNum, goodsNum);
            return false;
        } else {
            // 찜하지 않았다면 추가
            WishDTO dto = new WishDTO();
            dto.setMemberNum(memberNum);
            dto.setGoodsNum(goodsNum);
            itemRepository.wishInsert(dto);
            return true;
        }
    }
}
