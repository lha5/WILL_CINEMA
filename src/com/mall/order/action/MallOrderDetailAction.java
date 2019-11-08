package com.mall.order.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.action.Action;
import com.action.ActionForward;
import com.mall.db.MallDAO;
import com.mall.db.MallDAOImpl;
import com.mall.order.db.MallOrderDAO;
import com.mall.order.db.MallOrderDAOImpl;
import com.mall.order.db.MallOrderDTO;

public class MallOrderDetailAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("MallOrderDetailAction execute()----------------------------------------------------");
		
		// 세션값 처리
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");

		ActionForward forward = new ActionForward();
		if (id == null) {
			forward.setPath("./MemberLogin.me");
			forward.setRedirect(true);
			return forward;
		}
		
		request.setCharacterEncoding("UTF-8");
		// 파라미터로 전달된 값 trans_no<%=odto.getO_trans_no()%> 저장
		String trans_num = request.getParameter("trans_num");
		
		// OrderDAO 객체 생성 및 orderDetail(trade_no) 메소드 사용
		MallOrderDAO modao = new MallOrderDAOImpl();
		MallOrderDTO modto = modao.orderDetail(trans_num);
		
		MallDAO mdao = new MallDAOImpl();
		String imgSrc = mdao.getGoodsImage(modto.getOrder_goods_num());
				
		// 주문 상세 페이지 정보를 저장
		request.setAttribute("modto", modto);
		request.setAttribute("imgSrc", imgSrc);
		
		// 페이지 이동
		forward.setPath("./goodsOrder/order_detail.jsp");
		forward.setRedirect(false);
		
		return forward;
	}

}
