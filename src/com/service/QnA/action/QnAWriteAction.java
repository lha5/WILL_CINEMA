package com.service.QnA.action;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.action.Action;
import com.action.ActionForward;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.service.QnA.db.QnADAO;
import com.service.QnA.db.QnADAOImpl;
import com.service.QnA.db.QnADTO;

public class QnAWriteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("QnAWriteAction_execute()-----------------");
		
		// 한글처리 
		// request.setCharacterEncoding("UTF-8");
		
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");
		
		ActionForward forward = new ActionForward();
		if (id == null) {
			forward.setPath("./MemberLogin.me");
			forward.setRedirect(true);
			return forward;
		}
		
		ServletContext context = request.getServletContext();
		String realPath = context.getRealPath("/upload");
		System.out.println("realPath : "+realPath);
		
		int maxSize = 10 * 1024 * 1024; // 10MB
		
		
		// QnADTO객체 생성
		QnADTO qadto = new QnADTO();
		
		MultipartRequest multi = new MultipartRequest(request, realPath, maxSize, "UTF-8", new DefaultFileRenamePolicy());
		
		qadto.setName(multi.getParameter("name"));
		qadto.setPass(multi.getParameter("pass"));
		qadto.setSubject(multi.getParameter("subject"));
		qadto.setCategory(multi.getParameter("category"));
		qadto.setContent(multi.getParameter("content"));
		qadto.setImage(multi.getFilesystemName("image"));
		
		// QnaDAOImpl객체 생성
		// insertBoard()
		QnADAO qadaoImpl = new QnADAOImpl();
		qadaoImpl.insertBoard(qadto);
		
		forward.setPath("./QnAUserList.sq");
		forward.setRedirect(true);
		return forward;
	}

}
