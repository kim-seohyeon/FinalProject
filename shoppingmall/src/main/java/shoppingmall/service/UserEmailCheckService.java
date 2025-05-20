package shoppingmall.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import shoppingmall.repository.DuplicationRepository;

@Service
public class UserEmailCheckService {
	@Autowired
	DuplicationRepository dulicationRepository; 
	public String execute(String userEmail) {
		return dulicationRepository.emailCheckSelectOne(userEmail);
	}
}
