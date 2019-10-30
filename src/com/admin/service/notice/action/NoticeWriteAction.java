package com.admin.service.notice.action;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.admin.service.notice.db.AdminNoticeDAO;
import com.admin.service.notice.db.AdminNoticeDAOImpl;
import com.admin.service.notice.db.AdminNoticeDTO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;



public class NoticeWriteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("AdminNoticeWriteAction_execute()------------------------");
		
		// 한글 처리
		request.setCharacterEncoding("UTF-8");
		
		ServletContext context = request.getServletContext();
		String realPath = context.getRealPath("/upload");
		
		System.out.println("realPath : "+realPath);
		
		
		int maxSize = 10 * 1024 * 1024;
		
		MultipartRequest multi = new MultipartRequest(request,realPath,maxSize,"UTF-8",
				new DefaultFileRenamePolicy());
				// 전달된 정보 객체
				// boardDTO 객체 생성 저장
				AdminNoticeDTO andto = new AdminNoticeDTO(); 
				
				andto.setName(multi.getParameter("name"));
				andto.setPass(multi.getParameter("pass"));
				andto.setSubject(multi.getParameter("subject"));
				andto.setContent(multi.getParameter("content"));
				andto.setCategory(multi.getParameter("category"));
		String image=multi.getFilesystemName("image");
		andto.setImage(image);
		
		System.out.println("image : "+image);
		// BoardDAOImpl 객체 생성
		AdminNoticeDAO andao = new AdminNoticeDAOImpl();
		
		// insertBoard(DTO)
		andao.insertBoard(andto);
		
		// 페이지 이동
		// 글목록 보여주는 페이지로 이동
		ActionForward forward = new ActionForward();
		forward.setPath("./NoticeList.an");
		forward.setRedirect(true);
		
		return forward;
	}

}
