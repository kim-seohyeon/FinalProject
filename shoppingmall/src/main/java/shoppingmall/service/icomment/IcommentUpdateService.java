package shoppingmall.service.icomment;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import jakarta.servlet.http.HttpSession;
import shoppingmall.command.IcommentCommand;
import shoppingmall.repository.IcommentRepository;

@Service
public class IcommentUpdateService {

	@Autowired
	IcommentRepository icommentRepository;
	
	public void execute(IcommentCommand icommentCommand, HttpSession session) {
		icommentRepository.updateComment(icommentCommand);
	}

}
