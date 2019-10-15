package com.mall.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.mall.db.MallDAO;
import com.mall.db.MallDAOImpl;

public class GoodsListAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("GoodsListAction_execute()-----------");
		
		
		String item = request.getParameter("item");
		if(item==null || item==""){
			item="all";
		}
		
		//DAO
		MallDAO mdao = new MallDAOImpl();
		
		//상품 가져오기 매서드 getGoodsList();
		List goodsList = mdao.getGoodsList(item);
		
		//리스트 저장
		request.setAttribute("goodsList", goodsList);
		
		//전송
		ActionForward forward = new ActionForward();
		forward.setPath("./costomGoods/costomGoodsList.jsp");
		forward.setRedirect(false);
		
		return forward;
	}
	
}
