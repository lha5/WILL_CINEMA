package com.service.QnA.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.service.QnA.db.QnADAOImpl;
import com.service.QnA.db.QnADTO;

public class QnAContentAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("QnAContentAction_execute()-----------------------------");
		
		// 전달 정보를 저장 (num,pageNum)
		int num = Integer.parseInt(request.getParameter("num"));
		String pageNum = request.getParameter("pageNum");
		
		QnADAOImpl qadaoImpl = new QnADAOImpl();
		
		qadaoImpl.updateReadCount(num);
		
		QnADTO qadto = qadaoImpl.getBoard(num);
		
		System.out.print("qadto.getNum() : "+qadto.getNum());
		
		request.setAttribute("qadto", qadto);
		request.setAttribute("pageNum", pageNum);
		
		ActionForward forward = new ActionForward();
		forward.setPath("./board/QnAContent.jsp");
		forward.setRedirect(false);
		
		return forward;
	}

}
