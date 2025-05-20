package shoppingmall.service.library;

import java.io.File;
import java.io.IOException;
import java.net.URL;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import shoppingmall.command.LibraryCommand;
import shoppingmall.domain.LibraryDTO;
import shoppingmall.mapper.LibraryMapper;

@Service
public class LibraryInsertService {

	@Autowired
	LibraryMapper libraryMapper;
	
	public void execute(LibraryCommand libraryCommand) {
		
		LibraryDTO dto = new LibraryDTO();
		
		dto.setLibSubject(libraryCommand.getLibSubject());
		dto.setLibWriter(libraryCommand.getLibWriter());
		dto.setLibContent(libraryCommand.getLibContent());
		
		//저장 경로
		URL resource = getClass().getClassLoader().getResource("static/libUpload");
		String fileDir = resource.getFile();
		
		if(!libraryCommand.getLibImageFile().getOriginalFilename().isEmpty()) {
			//파일 업로드 시작
			MultipartFile mf = libraryCommand.getLibImageFile();
			//원본 파일 이름
			String originalName = mf.getOriginalFilename();
			//저장 파일 이름 만들기
			//확장자 찾아오기
			String extension = originalName.substring(originalName.lastIndexOf("."));
			//저장 이름
			String storeName = UUID.randomUUID().toString().replace("-", "");
			//확장자를 붙인 파일 이름
			String storeFileName = storeName + extension;
			//저장 파일 생성
			File file = new File(fileDir + "/" + storeFileName);
			try {
				//원본 파일 이름을 저장파일이름으로 변경해서 저장 
				mf.transferTo(file);
			} catch (Exception e) {
				e.printStackTrace();
			} 
	
			//dto저장
			dto.setLibImageOriginalName(originalName);
			dto.setLibImageStoreName(storeFileName);
		
		}
		if(!libraryCommand.getLibFile()[0].getOriginalFilename().isEmpty()) {
			String totalOriginalName = "";
			String totalStoreName = "";
			for(MultipartFile mf :libraryCommand.getLibFile() ) {
				String originalName = mf.getOriginalFilename();
				String extension = originalName.substring(originalName.lastIndexOf("."));
				String storeName = UUID.randomUUID().toString().replace("-", "");
				String storeFileName = storeName + extension;
				File file = new File(fileDir + "/" + storeFileName);
				try {
					mf.transferTo(file);
				} catch (Exception e) {
					e.printStackTrace();
				}
				totalOriginalName += originalName + "`";
				totalStoreName += storeFileName + "`";
			}
			dto.setLibOriginalName(totalOriginalName);
			dto.setLibStoreName(totalStoreName);
		}

		libraryMapper.libraryInsert(dto);

	}
}
