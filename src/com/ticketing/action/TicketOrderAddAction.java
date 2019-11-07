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

		System.out.println("MallOrderAddAction execute()-----------------------------------------------------");
		
		// 세션값 처리
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");

		ActionForward forward = new ActionForward();
		if (id == null) {
			forward.setPath("./MemberLogin.me");
			forward.setRedirect(true);
			return forward;
		}

		//TicketDTO 객체 생성
		TicketDTO tdto = new TicketDTO();

		MemberDAO mdao=new MemberDAOImpl();
		MemberDTO mdto=mdao.getMember(id);
		
		// 한글 인코딩
		request.setCharacterEncoding("UTF-8");
		
		// RequestBody에서 데이터 받아오기
		String data = URLDecoder.decode(getBody(request), "UTF-8");
		// System.out.println("넘겨 받은 Request Body 값 : " + data);		
		
		// 받아온 데이터를 특정 문자를 기준으로 추출 >> 순서 : mdto.getMovie_num, cdto.getCinema_num, seat, roomNum
		// person_num, realPri, running_date, running_time, week, KakaoPay
		String[] splitData = data.split(",");
		
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
		
		tdto.setRoom(splitData[3]);
		tdto.setSeat(seat);
		tdto.setPrice(Integer.parseInt(splitData[4]));
		
		
		String fDate[]=splitData[5].split("-");
		
		Date date= new Date(Integer.parseInt(fDate[0])-1900
				,Integer.parseInt(fDate[1])-1,Integer.parseInt(fDate[2]));
		tdto.setDate(date);
		tdto.setRunnging_time(splitData[6]);
		tdto.setDay(splitData[7]);
		tdto.setPayment(splitData[8]);
		

		// 메소드 객체 생성 및 실행
		TicketDAO tdao = new TicketDAOImpl();
		tdao.setTicket(tdto);
		
		int percentage = (int) Math.round(Integer.parseInt(splitData[4]) * 0.002);	// 포인트 적립
		mdao.addPoint(id, percentage);
		
		// 페이지 이동
		forward.setPath("./TicketOrderDone.ti");
		forward.setRedirect(true);
		return forward;
	}
	
	public static String getBody(HttpServletRequest request) throws IOException {
		
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
	}
}
