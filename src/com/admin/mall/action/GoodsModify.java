package com.admin.mall.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.admin.mall.db.AdminMallDAO;
import com.admin.mall.db.AdminMallDAOImpl;

public class GoodsModify implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("GoodsModify_exeucte()");
		
		//num값 저장
		int num = Integer.parseInt(request.getParameter("num"));
		
		//DAO 객체 생성
		//상품 가져오기 getGoods()
		AdminMallDAO amdao = new AdminMallDAOImpl();
		amdao.getGoods(num);
		
		
		
		//경로 이동
		ActionForward forward = new ActionForward();
		forward.setPath("./adminGoods/goodsModify.jsp");
		forward.setRedirect(false);
		
		return null;
	}

}
