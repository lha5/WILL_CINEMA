package com.admin.service.FAQ.action;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.action.Action;
import com.action.ActionForward;
import com.admin.service.FAQ.db.AdminFAQDAO;
import com.admin.service.FAQ.db.AdminFAQDAOImpl;
import com.admin.service.FAQ.db.AdminFAQDTO;
import com.admin.service.event.db.AdminEventDAOImpl;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class FAQWriteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("FAQWrite액션 나옵니다~!!~!");
		
		request.setCharacterEncoding("UTF-8"); //한글
		HttpSession session = request.getSession();
		String id= (String)session.getAttribute("id");
		
		ServletContext context = request.getServletContext();
		String realPath = context.getRealPath("/upload");
		System.out.println("realPath : "+realPath);
		
		int maxSize = 10 * 1024 * 1024; // 10MB
		
		
						
		AdminFAQDTO afdto = new AdminFAQDTO();
		MultipartRequest multi = new MultipartRequest(request, realPath, maxSize, "UTF-8", new DefaultFileRenamePolicy());
		
		afdto.setName(multi.getParameter("name"));
		afdto.setPass(multi.getParameter("pass"));
		afdto.setSubject(multi.getParameter("subject"));
		afdto.setContent(multi.getParameter("content"));
		afdto.setCategory(multi.getParameter("category"));
		String image=multi.getFilesystemName("image");
		afdto.setImage(image);
		//이미지 나오나
		System.out.println("image:"+image);
		
		AdminFAQDAO afdao = new AdminFAQDAOImpl();
		afdao.insertFAQ(afdto);
		
		ActionForward forward = new ActionForward();
		forward.setPath("./FAQList.af");
		forward.setRedirect(true);
		return forward;
		
		
		
	}

}
