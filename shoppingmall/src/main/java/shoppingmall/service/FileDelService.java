package shoppingmall.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import shoppingmall.domain.FileDTO;
import jakarta.servlet.http.HttpSession;

@Service
public class FileDelService {
	
	public int execute(String orgFile, String storeFile, HttpSession session) {
		int i = 0;
		
		FileDTO dto = new FileDTO();
		dto.setOrgFile(orgFile);
		dto.setStoreFile(storeFile);
		Boolean newFile = true; // 세션에 파일 정보가 있는지 확인
		// 세션에 파일 정보가 있는지 세션정보 가져오기
		List<FileDTO> list = (List<FileDTO>) session.getAttribute("fileList");
		// 처음 삭제 시에는 session이 없으므로 list 객체를 생성
		//session이 없는 경우
		if(list == null) {
			list = new ArrayList<FileDTO>();
		}
		// session이 있는 경우
		for(FileDTO fd : list) {
			if(fd.getOrgFile().equals(orgFile)) {
				list.remove(fd); //session에 있는 파일 정보 삭제
				newFile = false;
				break;
			}
		}
		if(newFile) {
			list.add(dto);
			i = 1;
		}
		session.setAttribute("filsList", list);
		return i;
	}

}
