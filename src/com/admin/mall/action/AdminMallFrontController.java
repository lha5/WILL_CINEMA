package com.admin.mall.action;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;

//매점(mall) 관리 페이지
public class AdminMallFrontController extends HttpServlet{

	protected void doProcess(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String requestURI = req.getRequestURI();
		String contextPath=req.getContextPath();
		String command=requestURI.substring(contextPath.length());
		
		ActionForward forward =null;
		Action action=null;
		//가상주소 비교
		if (command.equals("/GoodsList.al")) { // 상품(간식,상품권) 리스트 페이지(관리자)
			//action = new GoodsListAction();
			try {
				forward = action.execute(req, resp);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/GoodsAdd.al")) { // 상품(간식,상품권)추가 페이지
			forward = new ActionForward();
			forward.setPath("./adminGoods/goodsAdd.jsp");
			forward.setRedirect(false);
		} else if (command.equals("/GoodsAddAction.al")) { // 상품(간식,상품권) 추가 페이지
			//action = new GoodsAddAction();
			try {
				forward = action.execute(req, resp);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/GoodsDelete.al")) { // 상품(간식,상품권) 삭제 페이지
			//action = new GoodsDeleteAction();
			try {
				forward = action.execute(req, resp);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if (command.equals("/GoodsModify.al")) { // 상품(간식,상품권) 수정 페이지
			forward = new ActionForward();
			forward.setPath("./adminGoods/goodsModify.jsp");
			forward.setRedirect(false);
		}else if (command.equals("/GoodsModifyAction.al")) { // 상품(간식,상품권) 수정 페이지
			//action = new GoodsModifyAction();
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