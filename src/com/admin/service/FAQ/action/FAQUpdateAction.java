package com.admin.service.FAQ.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.admin.service.FAQ.db.AdminFAQDAO;
import com.admin.service.FAQ.db.AdminFAQDAOImpl;
import com.admin.service.FAQ.db.AdminFAQDTO;

public class FAQUpdateAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
	
	System.out.println("updateAction ~~~!!!");	
		
	request.setCharacterEncoding("UTF-8");
		
	String pageNum = request.getParameter("pageNum");
	
	AdminFAQDTO afdto = new AdminFAQDTO();
	afdto.setSubject(request.getParameter("subject"));
	afdto.setCategory(request.getParameter("category"));
	afdto.setContent(request.getParameter("content"));
	afdto.setImage(request.getParameter("image"));
		
	AdminFAQDAO afdao = new AdminFAQDAOImpl();
	int check = afdao.updateFAQ(afdto);
	
	if(check == 0){
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.println("<script>");
		out.println(" alert('비밀번호 오류');");
		out.println(" history.back(); ");
		out.println("</script>");
		
		out.close();
		return null;			
	}else if(check == -1){
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.println("<script>");
		out.println(" alert('글 없음오류');");
		out.println(" history.back(); ");
		out.println("</script>");
		
		out.close();
		return null;
	}
	
	
	
	response.setContentType("text/html; charset=UTF-8");
	PrintWriter out = response.getWriter();
	out.println("<script>");
	out.println(" alert('글 수정 완료 ');");
	out.println(" location.href='./FAQList.af?pageNum="+pageNum+"' ");
	out.println("</script>");
	
	out.close();
	return null;

	}

}
