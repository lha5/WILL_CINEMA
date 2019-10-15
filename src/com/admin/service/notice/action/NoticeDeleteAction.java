package com.admin.service.notice.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.action.Action;
import com.action.ActionForward;
import com.admin.service.notice.db.AdminNoticeDAO;
import com.admin.service.notice.db.AdminNoticeDAOImpl;

public class NoticeDeleteAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("NoticeDeleteAction_execute()-------------------------------");
		
			// 로그인 정보가 있을경우에만 삭제 처리
			// 로그인 정보가 없을경우 (로그인 페이지로 이동)

			HttpSession session = request.getSession();
		
			String id = (String) session.getAttribute("id");
		
			ActionForward forward = new ActionForward();

			if(id == null){
				forward.setPath("./Main.me");
				forward.setRedirect(true);	
				return forward;
			}

			
			// pageNum 저장(get)
			String pageNum = request.getParameter("pageNum");
		
			
			// pass,num저장
			String pass = request.getParameter("pass");
			int num = Integer.parseInt(request.getParameter("num"));

			
			System.out.println("pass : "+pass + ", num :" + num);
			
			// AdminNoticeDAOImpl 객체를 저장
			AdminNoticeDAO andao = new AdminNoticeDAOImpl(); 
			
			// deleteNotice(num,pass)
			int check = andao.deleteNotice(num,pass);
			
			// check 0, -1, 1
			
			
			// 0,-1 자바 스크립트 사용 경고창 메세지 출력??
			
			response.setContentType("text/html; charset=UTF-8");
			if(check == 0){
				PrintWriter out = response.getWriter();
				out.println("<script>");
				out.println(" alert('비밀번호 오류');");
				out.println(" history.back()");
				out.println("</script>");
				out.close();
				
				return null;			
			}else if(check == -1){
				PrintWriter out = response.getWriter();
				out.println("<script>");
				out.println(" alert('글 번호 없음');");
				out.println(" history.back()");
				out.println("</script>");
				out.close();
				
				return null;	
			}
			
			// 1 (삭제 성공)

			// 자바 스크립트 사용 페이지 이동 (./NoticeList.an)
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println(" alert('게시판 글 삭제 성공');");

			out.println(" location.href='./NoticeList.an?pageNum="+pageNum+"'");
			out.println("</script>");
			out.close();
			
			return null;
		}

	}
