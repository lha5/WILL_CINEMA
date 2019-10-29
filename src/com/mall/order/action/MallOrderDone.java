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

public class MallOrderDone implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("MallOrderDone execute()---------------------------------------------------------");
		
		// 세션값 처리
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");

		ActionForward forward = new ActionForward();
		if (id == null) {
			forward.setPath("./MemberLogin.me");
			forward.setRedirect(true);
			return forward;
		}
		
		// 한글 인코딩
		request.setCharacterEncoding("UTF-8");
		
		// 객체 생성 및 메소드 실행
		MallOrderDAO modao = new MallOrderDAOImpl();
		List<MallOrderDTO> doneCheck = modao.getOrderDone(id);
		
		request.setAttribute("doneCheck", doneCheck);
		
		// 페이지 이동
		forward.setPath("./goodsOrder/goodsOrderDone.jsp");
		forward.setRedirect(false);
				
		return forward;
	}

}
