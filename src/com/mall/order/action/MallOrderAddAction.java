package com.mall.order.action;

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
		modto.setPrice(Integer.parseInt(request.getParameter("price")));
		modto.setPayment(request.getParameter("payment"));
		
		RandomNumberCreator rnc = new RandomNumberCreator();
		rnc.setCertNumLength(6);
		
		final String code = rnc.excuteGenerate();
		modto.setBarcode(code);
		
		System.out.println("바코드 번호 : " + code);
		
		CreateBarcode cb = new CreateBarcode();
		String barcodeImgPath = cb.saveBarcodeImage(code, "E:/workspace_project/WillCinema/WebContent/upload", 1, 60);
		modto.setBarcode_img(barcodeImgPath);
		
		System.out.println("바코드가 저장되는 경로 : " + barcodeImgPath);
		
		// 메소드 객체 생성 및 실행
		MallOrderDAO modao = new MallOrderDAOImpl();
		modao.addOrder(modto);
		
		// 페이지 이동
		forward.setPath("./MallOrderList.mor");
		forward.setRedirect(true);
		
		return forward;
	}

}
