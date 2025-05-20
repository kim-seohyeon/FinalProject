package shoppingmall.service.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import shoppingmall.command.MemberCommand;
import shoppingmall.domain.MemberDTO;
import shoppingmall.repository.MemberRepository;
import shoppingmall.service.EmailSendService;

@Service
public class UserWriteService {
	@Autowired
	PasswordEncoder passwordEncoder;
	@Autowired
	MemberRepository memberRepository;
	@Autowired
	EmailSendService emailSendService;
	
	public void execute(MemberCommand membercommand) {
		
		MemberDTO dto = new MemberDTO();
		dto.setMemberNum(memberRepository.autoMemberNum());
		dto.setMemberId(membercommand.getMemberId());
		dto.setMemberName(membercommand.getMemberName());
		dto.setMemberEmail(membercommand.getMemberEmail());
		dto.setMemberPw(passwordEncoder.encode(membercommand.getMemberPw()));
		dto.setMemberAddr(membercommand.getMemberAddr());
		dto.setMemberAddrDetail(membercommand.getMemberAddrDetail());
		dto.setMemberPost(membercommand.getMemberPost());
		dto.setMemberBirth(membercommand.getMemberBirth());
		dto.setMemberGender(membercommand.getMemberGender());
		dto.setMemberPhone1(membercommand.getMemberPhone1());
		dto.setMemberPhone2(membercommand.getMemberPhone2());
		dto.setMemberRegist(membercommand.getMemberRegist());
		memberRepository.memberInsert(dto);
		
		String fromEmail = "soongmoostudent@gmail.com";
		String toEmail = dto.getMemberEmail();
		String subject = "가입을 환영합니다.";
		String contents = dto.getMemberName() + "님 hk shoppingmall에 오신걸 환영합니다. <br/>" 
							+ "가입을 완료하시려면 "
							+ "<a href='http://localhost:8080/help/userConfirm?chk="
								+dto.getMemberId()+"'>여기</a>를 클릭하세요";
		
		emailSendService.send(fromEmail, toEmail, subject, contents);
		
	}
}
