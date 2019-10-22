package com.mall.order.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.action.Action;
import com.action.ActionForward;
import com.mall.db.MallDAO;
import com.mall.db.MallDAOImpl;
import com.mall.db.MallDTO;
import com.mall.order.db.MallOrderDTO;
import com.member.db.MemberDAO;
import com.member.db.MemberDAOImpl;
import com.member.db.MemberDTO;

public class MallOrderStarAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("MallOrderStarAction execute()------------------------------------");
		
		request.setCharacterEncoding("UTF-8");
		
		// 세션값 체크
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");
		
		System.out.println("현제 세션 아이디 값 : " + id);
		
		ActionForward forward = new ActionForward();
		if (id == null) {
			forward.setPath("./MemberLogin.me");
			forward.setRedirect(true);
			return forward;
		}
		
		// 정보 저장
		//request값 저장
		int amount = Integer.parseInt(request.getParameter("amount"));
		int goods_num = Integer.parseInt(request.getParameter("goods_num"));
		
		//회원 상세
		MemberDAO memdao = new MemberDAOImpl();
		
		// 현재 관리자의 내용만 가져옴
		MemberDTO memdto = memdao.getMember(id); 
		
		//주문 상품 상세
		MallDAO malldao = new MallDAOImpl();
		MallDTO malldto = malldao.getGoods(goods_num);
		
		
		//request에 저장
		request.setAttribute("memdto", memdto);
		request.setAttribute("malldto", malldto);
		request.setAttribute("amount", amount);
		
		System.out.println("값 저장");
		
		//페이지 이동
		forward.setPath("./goodsOrder/goodsBuy.jsp");
		forward.setRedirect(false);
		
		return forward;
	}
	
}
