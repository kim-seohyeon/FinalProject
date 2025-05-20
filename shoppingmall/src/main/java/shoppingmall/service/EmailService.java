package shoppingmall.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import shoppingmall.command.MailCommand;
import shoppingmall.service.EmailSendService;

@Service
public class EmailService {

	@Autowired
	EmailSendService emailSendService;
	
	public void execute(MailCommand mailCommand) {
		
		String fromEmail = mailCommand.getFromEmail();
		String toEmail = mailCommand.getToEmail();
		String subject = mailCommand.getSubject();
		String contents = mailCommand.getContents();
		
		emailSendService.send(fromEmail, toEmail, subject, contents);
		
	}
}
