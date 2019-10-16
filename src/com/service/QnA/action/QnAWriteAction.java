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
		
		int maxSize = 10 * 1024 * 1024; // 10MB
		
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");
		
		ActionForward forward = new ActionForward();
		if(id == null){
			forward.setPath("./MemberLogin.me");
			forward.setRedirect(true);
			return forward;
		}
		
		System.out.println("realPath : "+realPath);
		
		// QnADTO객체 생성
		QnADTO qadto = new QnADTO();
		
		MultipartRequest multi = new MultipartRequest(request, realPath, maxSize, "UTF-8", new DefaultFileRenamePolicy());
		
		String name = multi.getParameter("name");
		String pass = multi.getParameter("pass");
		
		System.out.print("name : "+ name + " pass : "+ pass + " id : "+id);
		
		qadto.setName(multi.getParameter("name"));
		qadto.setPass(multi.getParameter("pass"));
		qadto.setSubject(multi.getParameter("subject"));
		qadto.setCategory(multi.getParameter("category"));
		qadto.setContent(multi.getParameter("content"));
		String image = multi.getFilesystemName("image");
		qadto.setImage(image);
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
