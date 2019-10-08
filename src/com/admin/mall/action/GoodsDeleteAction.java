package com.admin.mall.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.admin.mall.db.AdminMallDAO;
import com.admin.mall.db.AdminMallDAOImpl;
import com.admin.mall.db.AdminMallDTO;

public class GoodsDeleteAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("GoodsDeleteAction_execute()-----------");
		
		
		//관리자 판별 코드
		
		//num값 저장(goods_num)
		int num = Integer.parseInt(request.getParameter("num"));
		
		//DAO
		AdminMallDAO amdao = new AdminMallDAOImpl();
		
		//deleteGoodsMall() 삭제 매서드 
		amdao.deleteGoodsMall(num);
			
		
		//경로 이동
		ActionForward forward = new ActionForward();
		forward.setPath("./GoodsList.al");
		forward.setRedirect(true);
		
		return forward;
	}
	
}
