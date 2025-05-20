package shoppingmall.service.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import shoppingmall.command.MemberCommand;
import shoppingmall.domain.MemberDTO;
import shoppingmall.repository.MemberRepository;

@Service
public class MemberWriteService {

	@Autowired
	MemberRepository memberRepository;
	@Autowired
	PasswordEncoder passwordEncoder;
	public void execute(MemberCommand memberCommand) {
		
		//memberPw를 암호화
		String newPw = passwordEncoder.encode(memberCommand.getMemberPw());
		//newPw:암호문
		
		MemberDTO dto = new MemberDTO();
		dto.setMemberNum(memberCommand.getMemberNum());
		dto.setMemberName(memberCommand.getMemberName());
		dto.setMemberId(memberCommand.getMemberId());
		dto.setMemberPw(newPw);
		dto.setMemberAddr(memberCommand.getMemberAddr());
		dto.setMemberAddrDetail(memberCommand.getMemberAddrDetail());
		dto.setMemberPost(memberCommand.getMemberPost());
		dto.setMemberRegist(memberCommand.getMemberRegist());
		dto.setMemberGender(memberCommand.getMemberGender());
		dto.setMemberPhone1(memberCommand.getMemberPhone1());
		dto.setMemberPhone2(memberCommand.getMemberPhone2());
		dto.setMemberEmail(memberCommand.getMemberEmail());
		dto.setMemberBirth(memberCommand.getMemberBirth());
		
		memberRepository.memberInsert(dto);

	}
}
