package com.mall.order.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.action.Action;
import com.action.ActionForward;
import com.mall.order.db.MallOrderDAO;
import com.mall.order.db.MallOrderDAOImpl;
import com.mall.order.db.MallOrderDTO;

public class MallOrderListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		System.out.println("MallOrderListAction execute()----------------------------------------------------");
		
		// 세션값 처리
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");

		ActionForward forward = new ActionForward();
		if (id == null) {
			forward.setPath("./MemberLogin.me");
			forward.setRedirect(true);
			return forward;
		}
		
		MallOrderDAO modao = new MallOrderDAOImpl();
		List<MallOrderDTO> orderList = modao.getOrderList(id);
		
		request.setAttribute("orderList", orderList);
		
		forward.setPath("./goodsOrder/order_list.jsp");
		forward.setRedirect(false);
		
		return forward;
	}

}
