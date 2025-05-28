package shoppingmall.service.icomment;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import jakarta.servlet.http.HttpSession;
import shoppingmall.domain.AuthInfoDTO;
import shoppingmall.repository.IcommentRepository;

@Service
public class IcommentDeleteService {

	@Autowired
	IcommentRepository icommentRepository;
	public void execute(String icommentId, String iquireNum, HttpSession session) {
		
        AuthInfoDTO auth = (AuthInfoDTO) session.getAttribute("auth");
        icommentRepository.icommentDelete(icommentId);
		
	}

}
