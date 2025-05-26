package shoppingmall.service.inquire;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import shoppingmall.repository.InquireRepository;

@Service
public class InquireDeleteService {

	@Autowired
	InquireRepository inquireRepository;
	public void execute(String inquireNum) {
		inquireRepository.inquireDelete(inquireNum);
	}
}
