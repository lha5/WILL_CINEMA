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

public class TestSendEmailAction implements Action {
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
	
		
		System.out.println("TestSendEmailAction execute()--------------------------------------------");
	 
		MemberDTO mdto = new MemberDTO();
			
		
		MemberDAO mdao = new MemberDAOImpl();
		
		// 보내는이 아이디, 비밀번호
		final String user   = "alien213";
		final String password  = "tmddnr21";
		
		//
		String sResult = "OK";
		String imsinum = "결제완료되었습니다";
		
		// 받는이 이메일 가져오기
		 String to =mdao.getMember("test100").getEmail();
		
		try{
			String st = to;	// 받는 사람 
			String sbj = "이메일 인증번호입니다."; 
			String sf = user; // 보내는 사람(인증 정보와 동일한 email 주소여야 함!!) 
			String sMsg = "["+imsinum+"] - 결제가 완료되었습니다";
			
		Properties p = new Properties(); // 정보를 담을 객체 
		p.put("mail.smtp.host","smtp.naver.com"); // 네이버 SMTP
		p.put("mail.smtp.port", "465");
		
		// p.put("mail.smtp.starttls.enable", "false"); // 이부분은 true,false든 일단 제외시키니깐 정상작동되네...
		p.put("mail.smtp.auth", "true");
		p.put("mail.smtp.debug", "true");
		p.put("mail.smtp.socketFactory.port", "465");
		p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		p.put("mail.smtp.socketFactory.fallback", "false");// SMTP 서버에 접속하기 위한 정보들 
		System.out.println(5678);//Get the Session object.
			try {
			
				Session mailSession = Session.getInstance(
						p,new javax.mail.Authenticator() {
							protected PasswordAuthentication getPasswordAuthentication() {
								return new PasswordAuthentication(user,password); // 네이버 메일 ID / PWD
								}
							});
				
				mailSession.setDebug(true);
				
				
				// Create a default MimeMessage object.
				Message message = new MimeMessage(mailSession);
				
				// Set From: header field of the header.
				message.setFrom(new InternetAddress(sf));
				// Set To: header field of the header.
				message.addRecipient(Message.RecipientType.TO, new InternetAddress(st));
				// Set Subject: header field
				message.setSubject(sbj);
				// Now set the actual message
				message.setContent(sMsg, "text/html;charset=utf-8"); 
				// 내용과 인코딩 
				// Send message
				Transport.send(message);
				// System.out.println("Sent message successfully....");
				// sResult = "Sent message successfully....";
				} catch (MessagingException e) {
					e.printStackTrace();
					System.out.println("Error: unable to send message...." + e.toString());
					sResult = "ERR";
					}
			}catch (Exception err){
				System.out.println(err.toString());
				sResult = "ERR";
				System.out.println(sResult);
			}finally {// dbhandle.close(dbhandle.con);} 
				
		}
		

		
		
		
		
		return null;
	}
	


	 
}