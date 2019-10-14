package com.admin.service.event.action;

import java.io.File;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.admin.service.event.db.AdminEventDAO;
import com.admin.service.event.db.AdminEventDAOImpl;

public class EventDelete implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("/*-------------- EventList.jsp -> EventDelete()[관리자 리스트]------------*/");
		
		//이벤트 num 저장
		int num = Integer.parseInt(request.getParameter("num"));
		// 디비 처리객체 DAO
		AdminEventDAO agdao = new AdminEventDAOImpl();
		// 메서드 호출 deleteEvent(num)
		int chk = agdao.deleteEvent(num);
		
		// 페이지 이동
		response.setContentType("text/html; charset=UTF-8");
		if(chk==1){//이벤트 수정 완료
			PrintWriter out=response.getWriter();
			out.print("<script>");
			out.print("alert('이벤트 삭제 완료!');");
			out.print("location.href='./EventList.ae';");
			out.print("</script>");
			out.close();
			
			return null;
		}else{
			PrintWriter out=response.getWriter();
			out.print("<script>");
			out.print("alert('이벤트 삭제 실패!');");
			out.print("history.back();");
			out.print("</script>");
			out.close();
			
			return null;
		}
	}
}
