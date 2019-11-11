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

public class QnAReWriteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		System.out.println("QnAReWriteAction execute()---------------------------------------------------");
		
		String pageNum = request.getParameter("pageNum");
		System.out.println("pageNum" + pageNum);
		int num = Integer.parseInt(request.getParameter("num"));
		System.out.println("num : " + num);
		
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
		
		ServletContext context = request.getServletContext();
		String realPath = context.getRealPath("/upload");
		System.out.println("realPath : "+realPath);
		
		int maxSize = 10 * 1024 * 1024; // 10MB
		MultipartRequest multi = new MultipartRequest(request, realPath, maxSize, "UTF-8", new DefaultFileRenamePolicy());		
		// 값 받기
		QnADTO qnadto = new QnADTO();
		
		qnadto.setNum(num);
		qnadto.setRe_ref(Integer.parseInt(request.getParameter("re_ref")));
		qnadto.setRe_lev(Integer.parseInt(request.getParameter("re_lev")));
		qnadto.setRe_seq(Integer.parseInt(request.getParameter("re_seq")));
		qnadto.setNum(Integer.parseInt(request.getParameter("num")));
		qnadto.setName(multi.getParameter("name"));
		qnadto.setPass(multi.getParameter("pass"));
		qnadto.setCategory(multi.getParameter("category"));
		qnadto.setSubject(multi.getParameter("subject"));
		qnadto.setContent(multi.getParameter("content"));
		qnadto.setImage(multi.getFilesystemName("image"));
		
		QnADAO qnadao = new QnADAOImpl();
		qnadao.reInsertBoard(qnadto);
		
		forward.setPath("./QnAUserList.sq");
		forward.setRedirect(true);
		return forward;
	}

}
