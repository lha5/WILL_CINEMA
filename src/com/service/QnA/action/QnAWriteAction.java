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
		request.setCharacterEncoding("UTF-8");
		
		ServletContext context = request.getServletContext();
		String realPath = context.getRealPath("/upload");
		
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");
		
		ActionForward forward = new ActionForward();
		if(id == null){
			forward.setPath("./MemberLogin.me");
			forward.setRedirect(true);
			return forward;
		}
		
		System.out.println("realPath : "+realPath);
		
		int maxSize = 10 * 1024 * 1024; // 10MB
		
		// QnADTO객체 생성
		QnADTO qadto = new QnADTO();
		
		String name = request.getParameter("name");
		String pass = request.getParameter("pass");
		
		System.out.print("name : "+ name + " pass : "+ pass + " id : "+id);
		
		String secreat = request.getParameter("secreat");
		
		qadto.setName(request.getParameter("name"));
		qadto.setPass(request.getParameter("pass"));
		qadto.setSubject(request.getParameter("subject"));
		qadto.setCategory(request.getParameter("category"));
		qadto.setContent(request.getParameter("content"));
		qadto.setImage(request.getParameter("image"));
		qadto.setId(id);
		
		// QnaDAOImpl객체 생성
		QnADAOImpl qadaoImpl = new QnADAOImpl();
		// insertBoard()
		qadaoImpl.insertBoard(qadto);
		
		forward.setPath("./QnAList.sq");
		forward.setRedirect(true);
		return forward;
		/*return null;*/
	}

}
