package com.admin.mall.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.admin.mall.db.AdminMallDAO;
import com.admin.mall.db.AdminMallDAOImpl;
import com.admin.mall.db.AdminMallDTO;

public class GoodsListAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//
		
		request.setCharacterEncoding("UTF-8");
		//관리자 확인 코드 필요
		
		//DAO객체 생성
		AdminMallDAO amdao = new AdminMallDAOImpl();
		
		//getGoodsList() 데이터 list에 담아 리턴  
		List goodsList = amdao.getGoodsList(); 
		
		//가져온 list 정보 저장
		request.setAttribute("goodsList", goodsList);
		
		
		
		//페이지 이동
		ActionForward forward = new ActionForward();
		forward.setPath("./adminGoods/goodsList.jsp");
		forward.setRedirect(false);
		
		return forward;
	}
	
}
