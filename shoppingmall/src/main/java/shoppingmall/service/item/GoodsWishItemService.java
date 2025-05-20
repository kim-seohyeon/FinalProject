package shoppingmall.service.item;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import jakarta.servlet.http.HttpServletRequest;
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

    public void execute(HttpServletRequest request) {

        // 상품 번호 가져오기
        String goodsNum = request.getParameter("goodsNum");

        if (goodsNum == null || goodsNum.isEmpty()) {
            // 상품 번호가 없으면 메서드 종료 (예외 처리 필요)
            return;
        }

        // 세션에서 회원 정보 가져오기
        HttpSession session = request.getSession();
        AuthInfoDTO auth = (AuthInfoDTO) session.getAttribute("auth");

        if (auth == null) {
            // 인증된 사용자 정보가 없으면 처리 종료 (예외 처리 필요)
            return;
        }

        // 회원 정보 조회
        MemberDTO mdto = memberRepository.memberSelectOne(auth.getUserId());

        if (mdto == null) {
            // 해당 회원 정보를 찾을 수 없으면 처리 종료 (예외 처리 필요)
            return;
        }

        // WishDTO 객체 생성 후 데이터 설정
        WishDTO dto = new WishDTO();
        dto.setMemberNum(mdto.getMemberNum());
        dto.setGoodsNum(goodsNum);

        // wish 테이블에 데이터 삽입
        itemRepository.wishInsert(dto);
    }
}
