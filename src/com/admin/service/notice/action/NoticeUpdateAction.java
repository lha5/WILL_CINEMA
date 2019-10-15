package com.admin.service.notice.action;

import java.io.PrintWriter;

import javax.print.attribute.standard.RequestingUserName;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.admin.service.notice.db.AdminNoticeDAO;
import com.admin.service.notice.db.AdminNoticeDAOImpl;
import com.admin.service.notice.db.AdminNoticeDTO;

public class NoticeUpdateAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("NoticeUpdateAction_execute()----------------");
		
			//한글 처리 
			request.setCharacterEncoding("UTF-8");
		
			// 전달정보를 저장 (pageNum)
			String pageNum = request.getParameter("pageNum");
		
			//	*pageNum 없을경우 	-> 다시 목록 페이지, 글 본문 페이지 이동 
		
			// BoardDTo 객체를 사용하여 (수정할 정보를 모두 저장)
			// num,name,pass,subject,content
			AdminNoticeDTO andto = new AdminNoticeDTO();
	
			andto.setNum(Integer.parseInt(request.getParameter("num")));
			andto.setName(request.getParameter("name"));
			andto.setPass(request.getParameter("pass"));
			andto.setSubject(request.getParameter("subject"));
			andto.setContent(request.getParameter("content"));
		
			
			// BoardDAO 객체를 생성
			// 수정 메서드(updateBoard(DTO))
			AdminNoticeDAOImpl andao = new AdminNoticeDAOImpl();
			int check = andao.updateBoard(andto);
			
			// check 0,1,-1
			if(check == 0){
				response.setContentType("text/html charset=UTF-8"); 
				PrintWriter out = response.getWriter();
				out.println("<script>");
				out.println(" alert('비밀번호 오류');");
				out.println(" history.back(); ");
				out.println("</script>");
				
				out.close();
			
			return null;
	
			}else if(check == -1){
				
				response.setContentType("text/html charset=UTF-8"); 
				PrintWriter out = response.getWriter();
				out.println("<script>");
				out.println(" alert('내용 없음 오류');");
				out.println(" history.back(); ");
				out.println("</script>");
				
				out.close();
				return null;
				
			}
				// check == 1
				// 수정 완료
			
			response.setContentType("text/html charset=UTF-8"); 
			PrintWriter out = response.getWriter();
			out.println("<script>");
			//out.println(" alert('글 수정 완료 ');");
			out.println(" location.href='./NoticeList.an?pageNum="+pageNum+"' ");
			out.println("</script>");
			
			out.close();
			return null;
			}

}
