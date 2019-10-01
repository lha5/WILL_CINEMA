package com.admin.movie.action;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;

//영화 관리 페이지(관리자)
public class AdminMovieFrontController extends HttpServlet{

	protected void doProcess(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String requestURI = req.getRequestURI();
		String contextPath=req.getContextPath();
		String command=requestURI.substring(contextPath.length());
		
		ActionForward forward =null;
		Action action=null;
		//가상주소 비교
		if (command.equals("/MovieList.am")) { // 영화 리스트 페이지(관리자)
			//action = new MovieListAction();
			try {
				forward = action.execute(req, resp);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/MovieAdd.am")) { // 영화 추가 페이지
			forward = new ActionForward();
			forward.setPath("./adminMovie/movieAdd.jsp");
			forward.setRedirect(false);
		} else if (command.equals("/MovieAddAction.am")) { // 영화 추가 페이지
			//action = new MovieAddAction();
			try {
				forward = action.execute(req, resp);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/MovieDelete.am")) { // 영화 삭제 페이지
			//action = new MovieDeleteAction();
			try {
				forward = action.execute(req, resp);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if (command.equals("/MovieModify.am")) { // 영화 수정 페이지
			forward = new ActionForward();
			forward.setPath("./adminMovie/movieModify.jsp");
			forward.setRedirect(false);
		}else if (command.equals("/MovieModifyAction.am")) { // 영화 수정 페이지
			//action = new MovieModifyAction();
			try {
				forward = action.execute(req, resp);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//가상주소를 가지고 이동
		if(forward !=null){
			if(forward.isRedirect()){
				resp.sendRedirect(forward.getPath());
			}else{
				RequestDispatcher dis = req.getRequestDispatcher(forward.getPath());
				dis.forward(req, resp);
			}
		}
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doProcess(req,resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doProcess(req,resp);
	}
}