package com.member.action;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import com.action.Action;
import com.action.ActionForward;

public class MemberNaverLogin implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("MemberNaverLogin______execute()---------");
		
		
		
		// 세션 생성
		HttpSession session = request.getSession();
		
		//
		ActionForward forward = new ActionForward();
		
		/************************************************************/
		/** 네이버 아이디 로그인  
		 *  https://developers.naver.com/docs/login/api/ 
		 * 	callback.jsp 내용
		 * 
		 * **/
		 String clientId = "zbWDmpR7Dt9oKkuZ8yzZ";//애플리케이션 클라이언트 아이디값";
		    String clientSecret = "uAP1zK_EJr";//애플리케이션 클라이언트 시크릿값";
		    String code = request.getParameter("code");
		    String state = request.getParameter("state");
		 	// 후에 서버에 올라갈시 URL 변경, 추가 필요
		    String redirectURI = URLEncoder.encode("http://itwillbs12.cafe24.com/MemberNaverLogin.me", "UTF-8");
		    String apiURL;
		    apiURL = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code&";
		    apiURL += "client_id=" + clientId;
		    apiURL += "&client_secret=" + clientSecret;
		    apiURL += "&redirect_uri=" + redirectURI;
		    apiURL += "&code=" + code;
		    apiURL += "&state=" + state;
		    String access_token = "";
		    String refresh_token = "";
		    //Integer expires_in = 0;
		    System.out.println("apiURL="+apiURL);
		    try {
		      URL url = new URL(apiURL);
		      HttpURLConnection con = (HttpURLConnection)url.openConnection();
		      con.setRequestMethod("GET");
		      int responseCode = con.getResponseCode();
		      BufferedReader br;
		      System.out.print("responseCode="+responseCode);
		      if(responseCode==200) { // 정상 호출
		        br = new BufferedReader(new InputStreamReader(con.getInputStream()));
		      } else {  // 에러 발생
		        br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
		      }
		      String inputLine;
		      StringBuffer res = new StringBuffer();
		      while ((inputLine = br.readLine()) != null) {
		        res.append(inputLine);
		      }
		      br.close();
		      if(responseCode==200) {
		    	  // 화면에 토큰 출력
		    	  //System.out.println("가져온 json형식 토큰 : "+res.toString());
		        //out.println(res.toString());
		    	  //res.toString() -> Object -> JSON으로 바꿔야함
		          JSONParser parsing = new JSONParser();
		          Object obj = parsing.parse(res.toString());
		          JSONObject jsonObj = (JSONObject)obj;
		          access_token = (String)jsonObj.get("access_token");
		          refresh_token = (String)jsonObj.get("refresh_token");
		          //expires_in = (Integer)jsonObj.get("expires_in"); 접근 토큰의 유효 기간(초 단위)
		          System.out.println("access token:"+access_token+"<br>");
		          System.out.println("refresh token:"+refresh_token);
		          
		          //session.setMacInactiveInterval(3600);
		          session.setAttribute("access_token", access_token);
		          session.setAttribute("refresh_token", refresh_token);
		          
		          
		         // response.sendRedirect("./MemberNaverLoginAction.me"); 
		         
		  		
		  		// 네아로 데이터 받은뒤 로그인 액션 페이지로 이동하여 
		        // 회원 데이터 저장 후 로그인 session 정보 저장
		  		forward.setPath("./MemberNaverLoginAction.me");
		  		forward.setRedirect(true);
		  		
		  		return forward;
		          
		    	  
		      }
		    } catch (Exception e) {
		      System.out.println(e);
		    }

			/************************************************************/
			/** 네이버 아이디 로그인  **/
		    
		return null;
	}

}
