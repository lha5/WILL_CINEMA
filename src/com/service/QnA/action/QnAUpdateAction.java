package com.service.QnA.action;

import java.io.PrintWriter;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.service.QnA.db.QnADAOImpl;
import com.service.QnA.db.QnADTO;

public class QnAUpdateAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("QnAUpdateAction_execute()-------------------------------");
		
		// 한글 처리
		request.setCharacterEncoding("UTF-8");
		
		ServletContext context = request.getServletContext();
		String realPath = context.getRealPath("/upload");
		System.out.println("realPath : "+realPath);
		
		int maxSize = 10 * 1024 * 1024; // 10MB
				
		// 전달정보를 저장(pageNum)
		String pageNum = (String)request.getAttribute("pageNum");
		
		QnADTO qadto = new QnADTO();
		
		qadto.setNum(Integer.parseInt(request.getParameter("num")));
		qadto.setName(request.getParameter("name"));
		qadto.setPass(request.getParameter("pass"));
		qadto.setCategory(request.getParameter("category"));
		qadto.setSubject(request.getParameter("subject"));
		qadto.setContent(request.getParameter("content"));
		qadto.setImage(request.getParameter("image"));

		// 수정 메서드 (updateBoard(DTO))
		QnADAOImpl qadaoImpl = new QnADAOImpl();
		int check = qadaoImpl.updateBoard(qadto);
		
		// check 0.1.-1
		if(check == 0){
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			
			out.println("<script>");
			out.println("alert('비밀번호 오류!');");
			out.println("history.back();");
			out.println("</script>");
					
			out.close();
					
			return null;
		}else if(check == -1){
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
					
			out.println("<script>");
			out.println("alert('글 없음!');");
			out.println("history.back();");
			out.println("</script>");
					
			out.close();
					
			return null;
		}
				
		// check == 1
		// 수정 완료
				
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
				
		out.println("<script>");
		out.println("alert('글 수정완료!');");
		out.println("location.href='./QnAList.sq' ");
		out.println("</script>");
				
		out.close();
		
		return null;
	}

}
