package com.ticketing.action;

import java.util.List;
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

import com.action.Action;
import com.action.ActionForward;
import com.member.db.MemberDAO;
import com.member.db.MemberDAOImpl;
import com.member.db.MemberDTO;

public class TestSendEmailAction implements Action{
 @Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
	
	 System.out.println("TestSendEmailAction execute()--------------------------------------------");
	 
	 List<MemberDTO> boardList = null;
	 
	 MemberDTO mdto = new MemberDTO();
	 
	 mdto.setEmail(request.getParameter("email"));
	 	
	 	
	 
	 
		return null;
	}

public static void main(String[] args) {

	 String host  = "smtp.naver.com";
	  final String user   = "alien213";
	  final String password  = "tmddnr21";

	  String to  = " ";

  
	  
	  
  // Get the session object
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
   message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));

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
 }
}