package com.ticketing.action;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URLDecoder;
import java.sql.Date;
import java.text.SimpleDateFormat;
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
import com.mall.order.action.CreateBarcode;
import com.mall.order.action.RandomNumberCreator;
import com.mall.order.db.MallOrderDAO;
import com.mall.order.db.MallOrderDAOImpl;
import com.mall.order.db.MallOrderDTO;
import com.member.db.MemberDAO;
import com.member.db.MemberDAOImpl;
import com.member.db.MemberDTO;
import com.ticketing.db.TicketDAO;
import com.ticketing.db.TicketDAOImpl;
import com.ticketing.db.TicketDTO;

public class TicketOrderAddAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		System.out.println("ticketOrderProc.jsp ajax ->TicketOrderAddAction execute()--------------------------------");
		
		// 세션값 처리
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");

		ActionForward forward = new ActionForward();
		if (id == null) {
			forward.setPath("./MemberLogin.me");
			forward.setRedirect(true);
			return forward;
		}
		
		int movie_num=Integer.parseInt(request.getParameter("movie_num"));
		int cinema_num=Integer.parseInt(request.getParameter("cinema_num"));
		String sendseat=request.getParameter("seat");
		String roomNum=request.getParameter("roomNum");
		String person_num=request.getParameter("person_num");
		int realPri=Integer.parseInt(request.getParameter("realPri"));
		String runnging_date=request.getParameter("running_date");
		String runnging_time=request.getParameter("running_time");
		String week=request.getParameter("week");
		String payment=request.getParameter("payment");
		
		System.out.println("전달받은 값 "+ movie_num+" "+cinema_num+" "+sendseat+" "+roomNum+" "+
		person_num+" "+realPri+" "+runnging_date+" "+runnging_time+" "+week+" "+payment );

		//TicketDTO 객체 생성
		TicketDTO tdto = new TicketDTO();

		MemberDAO mdao=new MemberDAOImpl();
		MemberDTO mdto=mdao.getMember(id);
		
		// 한글 인코딩
		request.setCharacterEncoding("UTF-8");
		
		// RequestBody에서 데이터 받아오기
		/*String data = URLDecoder.decode(getBody(request), "UTF-8");	
		
		String[] splitData = data.split(",");
		
		for(int i =0; i<splitData.length; i++){
			System.out.println(splitData[i]+"   ");
		}*/
		
		// tdto에 값 저장하기
		tdto.setId(id);
		tdto.setPass(mdto.getPass());
		tdto.setMovie_num(movie_num);
		tdto.setCinema_num(cinema_num);
		
		String allSeat=sendseat;//ex)D12,D14
		String[] splitSeat=allSeat.split(",");//[0]=D12,[1]=D14
		String row="";
		String col="";
		String seat="";
		for(int i=0; i<splitSeat.length; i++){
			row=splitSeat[i].substring(0, 1);
			col=splitSeat[i].substring(1);
			if(i>=1){
				seat+=","+row+" "+col;
			}else if(i==0){
				seat=row+" "+col;
			}
		}
		tdto.setSeat(seat);
		tdto.setRoom(roomNum);
		tdto.setPerson_num(person_num);
		tdto.setPrice(realPri);
		
		
		String fDate[]=runnging_date.split("-");
		
		Date date= new Date(Integer.parseInt(fDate[0])-1900
				,Integer.parseInt(fDate[1])-1,Integer.parseInt(fDate[2]));
		tdto.setDate(date);
		tdto.setRunnging_time(runnging_time);
		
		tdto.setDay(week);
		tdto.setPayment(payment);
		
		
		
		
		// 받아온 데이터를 특정 문자를 기준으로 추출 >> 순서 : movie_num, cinema_num, seat, roomNum
		// person_num, realPri, running_date, running_time, week, KakaoPay
		/*String[] splitData = data.split(",");
		
		for(int i =0; i<splitData.length; i++){
			System.out.println(splitData[i]+"   ");
		}
		
		// tdto에 값 저장하기
		tdto.setId(id);
		tdto.setPass(mdto.getPass());
		tdto.setMovie_num(Integer.parseInt(splitData[0]));
		tdto.setCinema_num(Integer.parseInt(splitData[1]));
		
		String allSeat=splitData[2];//ex)D12,D14
		String[] splitSeat=allSeat.split(",");//[0]=D12,[1]=D14
		String row="";
		String col="";
		String seat="";
		for(int i=0; i<splitSeat.length; i++){
			row=splitSeat[i].substring(0, 1);
			col=splitSeat[i].substring(1);
			if(i>=1){
				seat+=","+row+" "+col;
			}else if(i==0){
				seat=row+" "+col;
			}
		}
		tdto.setSeat(seat);
		tdto.setRoom(splitData[3]);
		tdto.setPerson_num(splitData[4]);
		tdto.setPrice(Integer.parseInt(splitData[5]));
		
		
		String fDate[]=splitData[6].split("-");
		
		Date date= new Date(Integer.parseInt(fDate[0])-1900
				,Integer.parseInt(fDate[1])-1,Integer.parseInt(fDate[2]));
		tdto.setDate(date);
		tdto.setRunnging_time(splitData[7]);
		
		tdto.setDay(splitData[8]);
		tdto.setPayment(splitData[9]);*/
		
		System.out.println(tdto.toString());

		// 메소드 객체 생성 및 실행
		TicketDAO tdao = new TicketDAOImpl();
		tdao.setTicket(tdto);
		
		// 보내는이 아이디, 비밀번호
		final String user   = "alien213";
		final String password  = "tmddnr21";
		
		//
		String sResult = "OK";
		String imsinum = "결제완료되었습니다------------- 예매해주셔서 감사합니다";
		
		// 받는이 이메일 가져오기
		 String to =mdao.getMember(id).getEmail();
		
		try{
			String st = to;	// 받는 사람 
			String sbj = "예매가 완료 되었습니다"; 
			String sf = user; // 보내는 사람(인증 정보와 동일한 email 주소여야 함!!) 
			String sMsg = "["+imsinum+"] ";
			
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
		
		int percentage = (int) Math.round(realPri* 0.002);	// 포인트 적립
		mdao.addPoint(id, percentage);
		
		// 페이지 이동
		forward.setPath("./TicketOrderDone.ti");
		forward.setRedirect(true);
		return forward;
	}
	
/*	public static String getBody(HttpServletRequest request) throws IOException {
		
		String body = null;
		StringBuilder stringBuilder = new StringBuilder();
		BufferedReader bufferdReader = null;
		
		try {
			InputStream inputStream = request.getInputStream();
			if (inputStream != null) {
				bufferdReader = new BufferedReader(new InputStreamReader(inputStream));
				char[] charBuffer = new char[128];
				int bytesRead = -1;
				while ((bytesRead = bufferdReader.read(charBuffer)) > 0) {
					stringBuilder.append(charBuffer, 0, bytesRead);
				}
			} else {
				stringBuilder.append("");
			}
		} catch (IOException e) {
			throw e;
		} finally {
			if (bufferdReader != null) {
				try {
					bufferdReader.close();
				} catch (IOException ex) {
					throw ex;
				}
			}
		}
		
		body = stringBuilder.toString();
		
		return body;
	}*/
}
