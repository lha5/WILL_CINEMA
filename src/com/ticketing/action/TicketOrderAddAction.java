package com.ticketing.action;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URLDecoder;
import java.sql.Date;
import java.text.SimpleDateFormat;

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
