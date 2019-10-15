package com.admin.service.event.action;

import java.sql.Date;
import java.text.SimpleDateFormat;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.admin.service.event.db.AdminEventDAO;
import com.admin.service.event.db.AdminEventDAOImpl;
import com.admin.service.event.db.AdminEventDTO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class EventWriteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("/*--------------- eventWirte.jsp[이벤트 작성 ]-> EventWriteAction()[이벤트 처리]-------------------------*/");
		//파일 위치(가상경로)
		ServletContext context=request.getServletContext();
		String realpath=context.getRealPath("/upload");
		System.out.println("저장 경로 : "+realpath);
		//파일 크기
		int maxSize=10*1024*1024;
		
		//MultipartRequest 객체 생성
		MultipartRequest multi = 
				new MultipartRequest(request, realpath, maxSize, "UTF-8"
				,new DefaultFileRenamePolicy());
		
		/*dto에 전달받은 내용 저장*/
		AdminEventDTO aedto=new AdminEventDTO();
		aedto.setCategory(multi.getParameter("category"));
		aedto.setSubject(multi.getParameter("subject"));
		String fDate[]=multi.getParameter("fDate").split("-");
		String eDate[]=multi.getParameter("eDate").split("-");
		
		Date fDate1= new Date(Integer.parseInt(fDate[0])-1900
				,Integer.parseInt(fDate[1])-1,Integer.parseInt(fDate[2]));
		Date eDate1 = new Date(Integer.parseInt(eDate[0])-1900
				,Integer.parseInt(eDate[1])-1,Integer.parseInt(eDate[2]));
		aedto.setF_date(fDate1);
		aedto.setE_date(eDate1);
		
		String image=multi.getFilesystemName("img1")+","+multi.getFilesystemName("img2")+
				","+multi.getFilesystemName("img3")+","+multi.getFilesystemName("img4");
		aedto.setImage(image);
		/*dto에 전달받은 내용 저장*/
		
		AdminEventDAO aedao=new AdminEventDAOImpl();
		aedao.eventInsert(aedto);

		ActionForward forward=new ActionForward();
		forward.setPath("./EventSummary.ae");
		forward.setRedirect(true);
		return forward;
	}

}
