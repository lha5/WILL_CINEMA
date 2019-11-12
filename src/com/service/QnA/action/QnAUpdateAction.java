package com.service.QnA.action;

import java.io.PrintWriter;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.service.QnA.db.QnADAOImpl;
import com.service.QnA.db.QnADTO;

public class QnAUpdateAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("QnAUpdateAction_execute()-------------------------------");
		
		// 한글 처리
		request.setCharacterEncoding("UTF-8");
		
		ServletContext context = request.getServletContext();
		String realPath = context.getRealPath("/upload");
		System.out.println("realPath : "+realPath);
		
		int maxSize = 10 * 1024 * 1024; // 10MB
				
		// 전달정보를 저장(pageNum)
		String pageNum = (String)request.getAttribute("pageNum");
		
		QnADTO qadto = new QnADTO();
		
		
		MultipartRequest multi = new MultipartRequest(request, realPath, maxSize, "UTF-8", new DefaultFileRenamePolicy());
		
		System.out.println(" id : "+multi.getParameter("id"));
		
		qadto.setNum(Integer.parseInt(request.getParameter("num")));
		qadto.setName(multi.getParameter("name"));
		qadto.setPass(multi.getParameter("pass"));
		qadto.setCategory(multi.getParameter("category"));
		qadto.setSubject(multi.getParameter("subject"));
		qadto.setContent(multi.getParameter("content"));
		qadto.setImage(multi.getFilesystemName("image"));

		// 수정 메서드 (updateBoard(DTO))
		QnADAOImpl qadaoImpl = new QnADAOImpl();
		int check = qadaoImpl.updateBoard(qadto);
		
		// check 0.1.-1
		if(check == 0){
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			
			out.println("<script>");
			out.println("alert('비밀번호 오류!');");
			out.println("history.back();");
			out.println("</script>");
					
			out.close();
					
			return null;
		}else if(check == -1){
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
					
			out.println("<script>");
			out.println("alert('글 없음!');");
			out.println("history.back();");
			out.println("</script>");
					
			out.close();
					
			return null;
		}
				
		// check == 1
		// 수정 완료
				
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
				
		out.println("<script>");
		out.println("alert('문의 내용 수정이 완료되었습니다.');");
		out.println("location.href='./QnAUserList.sq' ");
		out.println("</script>");
				
		out.close();
		
		return null;
	}

}
