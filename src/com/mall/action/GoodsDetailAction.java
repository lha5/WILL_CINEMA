package com.mall.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.mall.db.MallDAO;
import com.mall.db.MallDAOImpl;
import com.mall.db.MallDTO;

public class GoodsDetailAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("GoodsDetailAction_execute()--------");
		
		//num 저장
		int num = Integer.parseInt(request.getParameter("num"));
		
		//DAO
		MallDAO mdao = new MallDAOImpl();
		
		//상품번호의 정보가져오는 매서드 getGoods(num);
		MallDTO mdto = mdao.getGoods(num);
		
		//가져온 정보 저장
		request.setAttribute("mdto", mdto);
		
		//전송
		ActionForward forward = new ActionForward();
		forward.setPath("./costomGoods/costomGoodsDetail.jsp");
		forward.setRedirect(false);
		
		return forward;
	}
	
}
