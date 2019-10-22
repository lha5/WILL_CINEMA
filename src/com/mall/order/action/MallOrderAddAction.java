package com.mall.order.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.action.Action;
import com.action.ActionForward;
import com.mall.order.db.MallOrderDAO;
import com.mall.order.db.MallOrderDAOImpl;
import com.mall.order.db.MallOrderDTO;

public class MallOrderAddAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("MallOrderAddAction execute()-----------------------------------------------------");
		
		// 세션값 처리
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");

		ActionForward forward = new ActionForward();
		if (id == null) {
			forward.setPath("./MemberLogin.me");
			forward.setRedirect(true);
			return forward;
		}
		
		// OrderDTO 객체 생성
		MallOrderDTO modto = new MallOrderDTO();
		
		// 한글 인코딩
		request.setCharacterEncoding("UTF-8");
		
		modto.setOrder_id(id);
		modto.setGoods_name(request.getParameter("goods_name"));
		modto.setOrder_goods_num(Integer.parseInt(request.getParameter("goods_num")));
		modto.setGoods_amount(Integer.parseInt(request.getParameter("goods_amount")));
		modto.setPayment(request.getParameter("payment"));
		
		MallOrderDAO modao = new MallOrderDAOImpl();
		modao.addOrder(modto);
		
		forward.setPath("./MallOrderList.mor");
		forward.setRedirect(true);
		
		return forward;
	}

}
