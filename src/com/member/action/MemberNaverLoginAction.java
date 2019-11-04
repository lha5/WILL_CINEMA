package com.member.action;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import com.action.Action;
import com.action.ActionForward;
import com.member.db.MemberDAO;
import com.member.db.MemberDAOImpl;
import com.member.db.MemberDTO;

public class MemberNaverLoginAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("MemberNaverLoginAction______execute()---------");
		
		HttpSession session = request.getSession();
		
		//naver접근 토큰을 이용해서 접근가능한 데이터 받아 저장하기
		String token = (String)session.getAttribute("access_token");// 네이버 로그인 접근 토큰;
	    String header = "Bearer " + token; // Bearer 다음에 공백 추가
	    //String name = null;
	    String nickname = null;
	    String email = null;
	    String id = null;
	    String gender = null;
	    String age = null;
	    String birthday = null;
	    
	    
	    // 네아로 참조 페이지
	    //https://developers.naver.com/docs/common/openapiguide/apicall.md#%EB%A1%9C%EA%B7%B8%EC%9D%B8-%EB%B0%A9%EC%8B%9D-%EC%98%A4%ED%94%88-api-%ED%98%B8%EC%B6%9C-%EC%98%88
	    
	    try {
	        String apiURL = "https://openapi.naver.com/v1/nid/me";
	        URL url = new URL(apiURL);
	        HttpURLConnection con = (HttpURLConnection)url.openConnection();
	        con.setRequestMethod("GET");
	        con.setRequestProperty("Authorization", header);
	        int responseCode = con.getResponseCode();
	        BufferedReader br;
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
	        System.out.println(res.toString());
	        //out.print(res.toString());
	     
	       //JSON 파싱-오브젝트화!!
	        JSONParser parsing = new JSONParser();
	        Object obj = parsing.parse(res.toString());
	        System.out.println(obj);
	        //오브젝트 다운캐스팅으로 JSONObject 만들기
	        JSONObject jsonObj = (JSONObject) obj;
	        System.out.println(jsonObj);
	        //내부 JSONObject 생성
	        JSONObject responseObj = (JSONObject) jsonObj.get("response");
	        
	        nickname = (String) responseObj.get("nickname");
	        email = (String) responseObj.get("email");
	        id = (String) responseObj.get("id");
	        gender = (String) responseObj.get("gender");
	        age = (String) responseObj.get("age");
	        birthday = (String) responseObj.get("birthday");
	        
	        
	        System.out.println("닉네임 : "+nickname+", 이메일 : "+email+", 아이디 : "+id);
	        System.out.println("성별 : "+gender+", 나이 : "+age+", 생일 : "+birthday);
	        
	    } catch (Exception e) {
	        System.out.println(e);
	    }
	    
	    
	    //이전에 네아로 로그인한 회원일경우 회원등록 차단 필요
		// DAO 객체를 생성
	    MemberDAO mdao = new MemberDAOImpl();
	    
	    String snsMember_id = "";
	    // 회원 확인 메소드 checkSNSMember(id); 
	    snsMember_id = mdao.checkSNSMember(id);
	    
	    System.out.println(snsMember_id);
	    
	    if(snsMember_id==null || snsMember_id.equals("fail")){
	    	
	    //네이버 로그인 전용 id 생성
	    //Calendar 타입으로 현재 날짜 가져오기
	    //id중간부에 쓸 부분
	    SimpleDateFormat dateformat = new SimpleDateFormat("yyMMdd");
	    Calendar cal = Calendar.getInstance();
	    String dateFormat = dateformat.format(cal.getTime());
	    
	    
	    //네이버 로그인으로 들어온 회원 id 생성
	    int insert_num = mdao.SNSMemberinsertNum();
	    
	    String collect_id = "N"+dateFormat+"-"+insert_num;
	    
	    // 자바빈(DTO) 객체를 생성
	    MemberDTO mdto = new MemberDTO();
	    mdto.setId(collect_id);
	    mdto.setPass(id);
	    mdto.setName(nickname);
	    mdto.setBirthday(birthday);
	    mdto.setEmail(email);
	    mdto.setReg_date(new Timestamp(System.currentTimeMillis()));
	    
	    
	    mdao.insertSNSMember(mdto);
	    
	    snsMember_id = collect_id;
	    }
	    
	    System.out.println(snsMember_id);
	    
	    List info = mdao.forPointLevel(snsMember_id);
		
		session.setAttribute("id", snsMember_id);
		session.setAttribute("info", info);
		
		ActionForward forward = new ActionForward();
		
		// 로그인 안되어 있음 회원가입으로 감
		forward.setPath("./Main.me");
		// 정보값 가져가지 않아서  true
		forward.setRedirect(true);
		
		return forward;
	 }
	
}
