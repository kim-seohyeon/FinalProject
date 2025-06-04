package shoppingmall.service.library;

import java.io.File;
import java.net.URL;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import jakarta.servlet.http.HttpSession;
import shoppingmall.domain.AuthInfoDTO;
import shoppingmall.domain.LibraryDTO;
import shoppingmall.mapper.LibraryMapper;

@Service
public class LibraryDeleteService {

	@Autowired
	LibraryMapper libraryMapper;
	public void execute(int libNum, HttpSession session) {
    	AuthInfoDTO auth = (AuthInfoDTO) session.getAttribute("auth");
    	if (auth == null || auth.getGrade() == null || !auth.getGrade().equals("emp")) {
    	    return; // 비직원이거나 로그인하지 않은 경우 등록 중단
    	}
		LibraryDTO dto = libraryMapper.libSelectOne(libNum);
		int i = libraryMapper.libraryDelete(libNum);

		if( i != 0) {
			//저장 경로
			URL resource = getClass().getClassLoader().getResource("static/libUpload");
			String fileDir = resource.getFile();
			//삭제 코드
			File file = new File(fileDir + "/" + dto.getLibImageStoreName());
			if(file.exists()) file.delete();
			
			if(dto.getLibStoreName() != null) {
				for(String fileName : dto.getLibStoreName().split("`")) {
					if(file.exists()) file.delete();
				}
			}
		}

	}
	
}
