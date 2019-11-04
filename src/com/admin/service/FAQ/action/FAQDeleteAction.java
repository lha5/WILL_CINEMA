package com.admin.service.FAQ.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.admin.service.FAQ.db.AdminFAQDAO;
import com.admin.service.FAQ.db.AdminFAQDAOImpl;

public class FAQDeleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		//이벤트 num 저장
	System.out.println("DeleteAction");
	String pass = request.getParameter("pass");
	int num = Integer.parseInt(request.getParameter("num"));
	
	// 디비 처리객체 DAO
	AdminFAQDAO afdao = new AdminFAQDAOImpl();
	// 메서드 호출 deleteEvent(num)
	int chk = afdao.deleteFAQ(num, pass);
				
	// 페이지 이동
	response.setContentType("text/html; charset=UTF-8");
				if(chk==1){//FAQ 삭제 완료 
					PrintWriter out=response.getWriter();
					out.print("<script>");
					out.print("alert('faq 삭제 완료!');");
					out.print(" location.href='./FAQList.af'");
					out.print("</script>");
					out.close();

					return null;
				}else if(chk == -1){
					PrintWriter out = response.getWriter();
					out.println("<script>");
					out.println(" alert('글이 없음'); ");
					out.println(" history.back() ");
					out.println("</script>");
							
					out.close();
							
					return null;
				}
				else{
					PrintWriter out=response.getWriter();
					out.print("<script>");
					out.print("alert('faq 삭제 실패!');");
					out.print("history.back();");
					out.print("</script>");
					out.close();
					
					return null;
				}
			}
	}


