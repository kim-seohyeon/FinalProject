package shoppingmall.service.comment;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import jakarta.servlet.http.HttpSession;
import shoppingmall.domain.CommentDTO;
import shoppingmall.repository.CommentRepository;

@Service 
public class CommentUpdateService {
	
	@Autowired
    CommentRepository commentRepository;

    public void execute(CommentDTO commentDTO, HttpSession session) {
        // 권한 검사 (선택적으로 넣기)
        commentRepository.updateComment(commentDTO);
    }
}


