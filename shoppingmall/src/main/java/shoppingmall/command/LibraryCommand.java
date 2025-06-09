package shoppingmall.command;

import org.springframework.web.multipart.MultipartFile;

import jakarta.validation.constraints.NotEmpty;
import lombok.Data;

@Data
public class LibraryCommand {

	int libNum;
	@NotEmpty(message = "제목을 입력하세요")
	String libSubject;
	@NotEmpty(message = "작성자를 입력하세요")
	String libWriter;
	String libContent;
	
	MultipartFile [] libFile;
	MultipartFile libImageFile;
	
	int libReadCount;
	
}
