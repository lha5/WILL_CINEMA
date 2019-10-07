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

	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String requestURI = request.getRequestURI();
		String contextPath=request.getContextPath();
		String command=requestURI.substring(contextPath.length());
		
		ActionForward forward =null;
		Action action=null;
		//가상주소 비교
		if (command.equals("/GoodsList.al")) { // 상품(간식,상품권) 리스트 페이지(관리자) 구현 O
			//action = new GoodsListAction();
			action = new GoodsListAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/GoodsAdd.al")) { // 상품(간식,상품권)추가 페이지 구현O
			forward = new ActionForward();
			forward.setPath("./adminGoods/goodsAdd.jsp");
			forward.setRedirect(false);
		} else if (command.equals("/GoodsAddAction.al")) { // 상품(간식,상품권) 추가 구현 O
			//action = new GoodsAddAction();
			action = new GoodsAddAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (command.equals("/GoodsDelete.al")) { // 상품(간식,상품권) 삭제 페이지 구현 x
			//action = new GoodsDeleteAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if (command.equals("/GoodsModify.al")) { // 상품(간식,상품권) 수정 페이지 구현 x
			//action = new GoodsModify();
			action = new GoodsModify();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		}else if (command.equals("/GoodsModifyAction.al")) { // 상품(간식,상품권) 수정 페이지 구현 x
			//action = new GoodsModifyAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		
		//가상주소를 가지고 이동
		if(forward !=null){
			if(forward.isRedirect()){
				response.sendRedirect(forward.getPath());
			}else{
				RequestDispatcher dis = request.getRequestDispatcher(forward.getPath());
				dis.forward(request, response);
			}
		}
	}
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request,response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request,response);
	}
}