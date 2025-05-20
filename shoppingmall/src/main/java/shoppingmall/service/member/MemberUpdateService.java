package shoppingmall.service.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import jakarta.servlet.http.HttpSession;
import shoppingmall.command.MemberCommand;
import shoppingmall.domain.AuthInfoDTO;
import shoppingmall.domain.MemberDTO;
import shoppingmall.repository.MemberRepository;

@Service
public class MemberUpdateService {

    private final PasswordEncoder passwordEncoder;

    @Autowired
    MemberRepository memberRepository;

    MemberUpdateService(PasswordEncoder passwordEncoder) {
        this.passwordEncoder = passwordEncoder;
    }

    public int execute(HttpSession session,  MemberCommand memberCommand) {
        System.out.println(memberCommand.getMemberNum());
        
        AuthInfoDTO auth = (AuthInfoDTO) session.getAttribute("auth");

        MemberDTO dto = memberRepository.memberSelectOne(auth.getUserId());
        System.out.println(memberCommand.getMemberPw());
        System.out.println(dto.getMemberPw());

        int result = 0;

        // 비밀번호 확인 후 회원 정보 수정
        if (passwordEncoder.matches(memberCommand.getMemberPw(), dto.getMemberPw())) {
            dto.setMemberNum(memberCommand.getMemberNum());
            dto.setMemberName(memberCommand.getMemberName());
            dto.setMemberId(memberCommand.getMemberId());
            dto.setMemberAddr(memberCommand.getMemberAddr());
            dto.setMemberAddrDetail(memberCommand.getMemberAddrDetail());
            dto.setMemberPost(memberCommand.getMemberPost());
            dto.setMemberRegist(memberCommand.getMemberRegist());
            dto.setMemberGender(memberCommand.getMemberGender());
            dto.setMemberPhone1(memberCommand.getMemberPhone1());
            dto.setMemberPhone2(memberCommand.getMemberPhone2());
            dto.setMemberEmail(memberCommand.getMemberEmail());
            dto.setMemberBirth(memberCommand.getMemberBirth());
             
            System.out.println("dto.getMemberId() : " + dto.getMemberId());

            // 데이터베이스 업데이트
            memberRepository.memberUpdate(dto);
            result = 1; // 성공
        }

        return result; // 비밀번호가 일치하지 않으면 0 반환
    }
}