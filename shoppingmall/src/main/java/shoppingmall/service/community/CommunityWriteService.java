package shoppingmall.service.community;

import java.io.File;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpSession;
import shoppingmall.command.CommunityCommand;
import shoppingmall.domain.AuthInfoDTO;
import shoppingmall.domain.CommunityDTO;
import shoppingmall.domain.MemberDTO;
import shoppingmall.repository.CommunityRepository;
import shoppingmall.repository.MemberRepository;

@Service
public class CommunityWriteService {

    @Autowired
    private CommunityRepository communityRepository;

    @Autowired
    private MemberRepository memberRepository;

    @Autowired
    private ServletContext servletContext;  // 실제 경로를 가져오기 위해 필요

    public void execute(CommunityCommand communityCommand, HttpSession session) {
        // 로그인 정보 가져오기
        AuthInfoDTO auth = (AuthInfoDTO) session.getAttribute("auth");
        MemberDTO member = memberRepository.memberSelectOne(auth.getUserId());

        // CommunityDTO 생성 및 값 채우기
        CommunityDTO dto = new CommunityDTO();
        dto.setCommunityNum(communityCommand.getCommunityNum());
        dto.setCommunityWriter(auth.getUserId());
        dto.setCommunitySubject(communityCommand.getCommunitySubject());
        dto.setCommunityContent(communityCommand.getCommunityContent());
        dto.setMemberNum(member.getMemberNum());
        dto.setCommunityDate(new java.sql.Date(System.currentTimeMillis()));  // 현재 날짜로 등록일 설정

        // 업로드된 이미지 처리
        MultipartFile uploadImage = communityCommand.getUploadImage();
        if (uploadImage != null && !uploadImage.isEmpty()) {
            try {
                // 업로드 경로: 실제 서버 경로 (src/main/webapp/resources/communityUpload)
                String uploadPath = servletContext.getRealPath("/upload/community/");
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();  // 폴더가 없으면 생성
                }

                // 파일 이름 생성 (UUID 사용)
                String originalFilename = uploadImage.getOriginalFilename();
                String extension = "";
                if (originalFilename != null && originalFilename.contains(".")) {
                    extension = originalFilename.substring(originalFilename.lastIndexOf("."));
                }
                String uniqueFilename = UUID.randomUUID().toString().replace("-", "") + extension;

                // 파일 객체 생성 및 저장
                File destFile = new File(uploadDir, uniqueFilename);
                uploadImage.transferTo(destFile);

                // DB에 저장할 이미지 파일명 설정
                dto.setImagePath(uniqueFilename);

            } catch (Exception e) {
                e.printStackTrace();
                // 예외 발생 시 로깅 또는 사용자 피드백 처리 필요
            }
        }

        // 커뮤니티 글 DB에 저장
        communityRepository.communityInsert(dto);
    }
}
