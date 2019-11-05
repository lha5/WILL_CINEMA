package com.mall.order.action;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.action.Action;
import com.action.ActionForward;
import com.mall.order.db.MallOrderDAO;
import com.mall.order.db.MallOrderDAOImpl;
import com.mall.order.db.MallOrderDTO;
import com.member.db.MemberDAO;
import com.member.db.MemberDAOImpl;

public class MallOrderAddAction implements Action {
	
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
				
		// OrderDTO 객체 생성
		MallOrderDTO modto = new MallOrderDTO();
		
		// 한글 인코딩
		request.setCharacterEncoding("UTF-8");
		
		// RequestBody에서 데이터 받아오기
		String data = URLDecoder.decode(getBody(request), "UTF-8");
		// System.out.println("넘겨 받은 Request Body 값 : " + data);		
		
		// 받아온 데이터를 특정 문자를 기준으로 추출 >> 순서 : order_goods_num,goods_name,goods_amount,price,payment
		String[] splitData = data.split(",");
		
		// modto에 값 저장하기
		modto.setOrder_id(id);
		modto.setOrder_goods_num(Integer.parseInt(splitData[0]));
		modto.setGoods_name(splitData[1]);
		modto.setGoods_amount(Integer.parseInt(splitData[2]));
		modto.setPrice(Integer.parseInt(splitData[3]));
		modto.setPayment(splitData[4]);
	
		RandomNumberCreator rnc = new RandomNumberCreator();
		rnc.setCertNumLength(6);
		
		final String code = rnc.excuteGenerate();
		modto.setBarcode(code);
		
		System.out.println("바코드 번호 : " + code);
		
		//CreateBarcode cb = new CreateBarcode();
		//String barcodeImgPath = cb.saveBarcodeImage(code, "E:/workspace_project/WillCinema/WebContent/upload", 1, 60);
		//modto.setBarcode_img(barcodeImgPath);
		
		//System.out.println("바코드가 저장되는 경로 : " + barcodeImgPath);
		
		// 메소드 객체 생성 및 실행
		MallOrderDAO modao = new MallOrderDAOImpl();
		modao.addOrder(modto);	// 구매 테이블에 구매 내역 저장
		
		MemberDAO mdao = new MemberDAOImpl();
		int percentage = (int) Math.round(Integer.parseInt(splitData[3]) * 0.002);	// 포인트 적립
		mdao.addPoint(id, percentage);
		
		
		// 페이지 이동
		forward.setPath("./MallOrderDone.mor");
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
