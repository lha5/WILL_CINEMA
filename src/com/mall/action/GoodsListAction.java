package com.mall.action;

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
		
		//DAO
		MallDAO mdao = new MallDAOImpl();
		
		
		
		
		return null;
	}
	
}
