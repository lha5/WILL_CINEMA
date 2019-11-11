package com.mall.order.action;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URLDecoder;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;

import com.action.Action;
import com.action.ActionForward;
import com.mall.order.db.MallOrderDAO;
import com.mall.order.db.MallOrderDAOImpl;
import com.mall.order.db.MallOrderDTO;
import com.member.db.MemberDAO;
import com.member.db.MemberDAOImpl;

import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

public class MallOrderAddAction implements Action {
	
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("MallOrderAddAction execute()-----------------------------------------------------");
		
		/*********************************************************************/
		
		// 세션값 처리
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");

		
		ActionForward forward = new ActionForward();
		if (id == null) {
			forward.setPath("./MemberLogin.me");
			forward.setRedirect(true);
			return forward;
		}
		
		/*********************************************************************/
				
		// OrderDTO 객체 생성
		MallOrderDTO modto = new MallOrderDTO();
		
		// 한글 인코딩
		request.setCharacterEncoding("UTF-8");
		
		// RequestBody에서 데이터 받아오기
		String data = URLDecoder.decode(getBody(request), "UTF-8");
		// System.out.println("넘겨 받은 Request Body 값 : " + data);		
		
		// 받아온 데이터를 특정 문자를 기준으로 추출 >> 순서 : order_goods_num,goods_name,goods_amount,price,payment,tel
		String[] splitData = data.split(",");
		
		// modto에 값 저장하기
		modto.setOrder_id(id);
		modto.setOrder_goods_num(Integer.parseInt(splitData[0]));
		modto.setGoods_name(splitData[1]);
		modto.setGoods_amount(Integer.parseInt(splitData[2]));
		modto.setPrice(Integer.parseInt(splitData[3]));
		modto.setPayment(splitData[4]);
		String to = splitData[5];
	
		RandomNumberCreator rnc = new RandomNumberCreator();
		rnc.setCertNumLength(6);
		
		final String code = rnc.excuteGenerate();
		modto.setBarcode(code);
		
		System.out.println("바코드 번호 : " + code);
		
		//바코드 현재 주석처리
		CreateBarcode cb = new CreateBarcode();
		//경로 수정 필요
		String barcodeImgPath = cb.saveBarcodeImage(code, "./barcode", 1, 60);
		modto.setBarcode_img(barcodeImgPath);
		System.out.println("바코드가 저장되는 경로 : " + barcodeImgPath);
		
		// 메소드 객체 생성 및 실행
		MallOrderDAO modao = new MallOrderDAOImpl();
		modao.addOrder(modto);	// 구매 테이블에 구매 내역 저장
		
		MemberDAO mdao = new MemberDAOImpl();
		int usingPoint = Integer.parseInt(splitData[6]);
		if (usingPoint != 0) {
			mdao.substractPoint(id, usingPoint); // 사용 포인트가 있다면 차감
		}
		int percentage = (int) Math.round(Integer.parseInt(splitData[3]) * 0.002);	// 포인트 적립
		mdao.addPoint(id, percentage);
		
		// 문자 보내기
		// order_goods_num,goods_name,goods_amount,price
		String msg = "구매가 정상처리되었습니다."+"\n";
		msg += "구매하신 상품 : "+modto.getGoods_name()+"\n";
		msg += "구매하신 상품 수량 : "+modto.getGoods_amount()+"\n";
		msg += "구매하신 상품 가격 : "+modto.getPrice()+"\n";
		msg += "구매하신 상품 코드 : "+modto.getBarcode()+"\n";
		msg += "받으신 문자를 판매원에게 보여주시면 알아서 처리해드립니다";
		
		System.out.println("문자로 보낼 내용 : "+msg);
		
		//수신번호를 저장해야 하므로 등록후 등록한 번호만 사용
		/*to = "01093654019";
		SendSMS(msg, to);*/
		
		// 현재 이 Action페이지는 ajax로 들어와 데이터 연결작업만 하기에 
		// 이동 작업은 처리되지 않음
		
		// 페이지 이동
		//forward.setPath("./MallOrderDone.mor");
		//forward.setRedirect(true);
		//return forward;
		return null;
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

	
	//문자 발송 
	//https://www.coolsms.co.kr/
	// 가입후 Developers에 자세히 나와있음 참조 바람
	// 충전한 코인으로 문자 보내기에 코인이 다떨어지면 보내지 못함
	// 가입시 무료로 코인을 주기에 참조
	//class sendSMS{
	
	public static void SendSMS(String msg, String to){
		
		 String api_key = "NCSV3GHKNTFLPQVD";	//후에 자신 걸로 바꿀경우 API Key 입력
		 String api_secret = "KEJHVC6ZMJNTMSLAJZBVPGMVBCMXFNV6";	//API Secret 입력
		 Message coolsms = new Message(api_key, api_secret);

		    // 4 params(to, from, type, text) are mandatory. must be filled
		    HashMap<String, String> params = new HashMap<String, String>();
		    params.put("to", to); // 수신번호
		    params.put("from", "01093654019"); // 발신번호
		    params.put("type", "LMS"); // Message type ( SMS(단문 45자), LMS(장문 1000자), MMS(그림문자), ATA(예약문자) )
		    params.put("text", msg); // 문자내용    
		    params.put("app_version", "JAVA SDK v2.2"); // application name and version
		    
		    try {
		      JSONObject obj = (JSONObject) coolsms.send(params);
		      System.out.println(obj.toString());
		    } catch (CoolsmsException e) {
		      System.out.println(e.getMessage());
		      System.out.println(e.getCode());
		    }

		}
	//}
}
