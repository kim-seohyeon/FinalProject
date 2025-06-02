package shoppingmall.service.item;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import shoppingmall.repository.ReviewRepository;

@Service
public class ReviewDeleteService {

	@Autowired
	ReviewRepository reviewRepository;
	
	public void execute(String reviewNum) {
		reviewRepository.reviewDelete(reviewNum);

	}

}
