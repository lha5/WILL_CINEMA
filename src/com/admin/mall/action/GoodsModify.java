package com.admin.mall.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.admin.mall.db.AdminMallDAO;
import com.admin.mall.db.AdminMallDAOImpl;
import com.admin.mall.db.AdminMallDTO;

public class GoodsModify implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("GoodsModify_exeucte()");
		
		//관리자 판별 코드
		
		//num값 저장
		int num = Integer.parseInt(request.getParameter("num"));
		
		//DAO 객체 생성
		//상품 가져오기 getGoods()
		AdminMallDAO amdao = new AdminMallDAOImpl();
		AdminMallDTO amdto = amdao.getGoods(num);
		
		//상품의 정보를 저장
		request.setAttribute("amdto", amdto);
		
		
		//경로 이동
		ActionForward forward = new ActionForward();
		forward.setPath("./adminGoods/goodsModify.jsp");
		forward.setRedirect(false);
		
		return forward;
	}

}
