package com.service.QnA.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.action.Action;
import com.action.ActionForward;
import com.service.QnA.db.QnADAOImpl;

public class QnADeleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("QnADeleteAction_execute()--------------------------------");
		
		ActionForward forward = new ActionForward();
		HttpSession session = request.getSession();
		
		// pageNum 저장(get)
		String pageNum = request.getParameter("pageNum");
				
		// pass, num 저장(post)
		String pass = (String) session.getAttribute("id");
		System.out.println(" 삭제할 글의 pass : "+pass);
		int num = Integer.parseInt(request.getParameter("num"));
		
		QnADAOImpl qadaoImpl = new QnADAOImpl();
		int check = qadaoImpl.deleteBoard(num,pass);
		
		// check 0, 1, -1
		response.setContentType("text/html; charset=UTF-8");
		if(check == 0){
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println(" alert('비밀번호 오류'); ");
			out.println(" history.back() ");
			out.println("</script>");
					
			out.close();
					
			return null;
		}else if(check == -1){
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println(" alert('글이 없음'); ");
			out.println(" history.back() ");
			out.println("</script>");
					
			out.close();
					
			return null;
		}
		
		PrintWriter out = response.getWriter();
		out.println("<script>");
		out.println(" alert('삭제 성공'); ");
		out.println(" location.href='./QnAList.sq?pageNum="+pageNum+"' ");
		out.println("</script>");
		
		out.close();
		
		return null;
	}

}
