package com.service.QnA.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.action.Action;
import com.action.ActionForward;
import com.service.QnA.db.QnADAO;
import com.service.QnA.db.QnADAOImpl;
import com.service.QnA.db.QnADTO;

public class QnAReWrite implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("QnAReWrite execute()---------------------------------------------------------");
		
		int num = Integer.parseInt(request.getParameter("num"));
		String pageNum = request.getParameter("pageNum");
		
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");
		
		ActionForward forward = new ActionForward();
		if(id == null){
			forward.setPath("./MemberLogin.me");
			forward.setRedirect(true);
			return forward;
		} else if (!id.equals("admin")) {
			forward.setPath("./QnAUserList.sq");
			forward.setRedirect(true);
		}
		
		QnADAO qnadao = new QnADAOImpl();
		QnADTO qnadto = qnadao.getBoard(num);
		
		request.setAttribute("qnadto", qnadto);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("name", session.getAttribute("name"));
		
		forward.setPath("./service/QnABoard/QnARewrite.jsp");
		forward.setRedirect(false);
		return forward;
	}

}
