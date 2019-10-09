package com.service.QnA.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.service.QnA.db.QnADAOImpl;
import com.service.QnA.db.QnADTO;

public class QnADelete implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("QnADelete_execute()------------------------------------");
		
		// num, pageNum
		int num = Integer.parseInt(request.getParameter("num"));
		String pageNum = request.getParameter("pageNum");
		
		QnADAOImpl qadaoImpl = new QnADAOImpl();
		QnADTO qadto = qadaoImpl.getBoard(num);
		
		request.setAttribute("qadto", qadto);
		request.setAttribute("pageNum", pageNum);
		
		ActionForward forward = new ActionForward();
		
		forward.setPath("./board/QnADelete.jsp");
		forward.setRedirect(false);
		
		return forward;
	}

}
