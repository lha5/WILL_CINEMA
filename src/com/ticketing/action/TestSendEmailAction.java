package com.ticketing.action;

import java.io.PrintWriter;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.action.Action;
import com.action.ActionForward;
import com.member.db.MemberDAO;
import com.member.db.MemberDAOImpl;
import com.member.db.MemberDTO;

public class TestSendEmailAction implements Action{
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
	
		
		System.out.println("TestSendEmailAction execute()--------------------------------------------");
	 
		MemberDTO mdto = new MemberDTO();
			
		
		MemberDAO mdao = new MemberDAOImpl();
		
		
		String host  = "smtp.naver.com";
		 // 관리자 메일(보내는 사람) 
		 final String user   = "alien213";
		  final String password  = "tmddnr21";

		 
		//해당 메일로 전송(받는사람) 
		 
		
		 String to =mdao.getMember("test100").getEmail();
		 System.out.println("--------------------------------");
		 System.out.println(to);
		 System.out.println("--------------------------------");
		
	  Properties props = new Properties();
	  props.put("mail.smtp.host", host);
	  props.put("mail.smtp.auth", "true");

	  Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
	   protected PasswordAuthentication getPasswordAuthentication() {
	    return new PasswordAuthentication(user, password);
	   }
	  });

	  // Compose the message
	  try {
	   MimeMessage message = new MimeMessage(session);
	   message.setFrom(new InternetAddress(user));
	   message.addRecipient(Message.RecipientType.TO, new InternetAddress());

	   // Subject
	   message.setSubject("테스트입니다");
	   
	   // Text
	   message.setText("테스트 중입니다");

	   // send the message
	   Transport.send(message);
	   System.out.println("message sent successfully...");

	  } catch (MessagingException e) {
	   e.printStackTrace();
	  } 
		
		return null;
	}
	


	 
}