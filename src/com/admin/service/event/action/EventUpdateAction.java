package com.admin.service.event.action;

import java.io.File;
import java.io.PrintWriter;
import java.sql.Date;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.admin.service.event.db.AdminEventDAO;
import com.admin.service.event.db.AdminEventDAOImpl;
import com.admin.service.event.db.AdminEventDTO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class EventUpdateAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("/*--------- eventUpdate.jsp -> EventUpdateAction() ------------------------*/");
		// 한글처리 
		request.setCharacterEncoding("UTF-8");

		// 파일 위치(가상경로)
		ServletContext context = request.getServletContext();
		String realpath = context.getRealPath("/upload");
		System.out.println("저장 경로 : " + realpath);
		// 파일 크기
		int maxSize = 10 * 1024 * 1024;

		// MultipartRequest 객체 생성
		MultipartRequest multi = new MultipartRequest(request, realpath, 
				maxSize, "UTF-8", new DefaultFileRenamePolicy());
		
		//이미 저장된 이미지
		String image2=multi.getParameter("file2");
		
		/*dto에 전달받은 내용 저장*/
		AdminEventDTO aedto = new AdminEventDTO();
		aedto.setNum(Integer.parseInt(multi.getParameter("num")));
		aedto.setCategory(multi.getParameter("category"));
		aedto.setSubject(multi.getParameter("subject"));
		String fDate[] = multi.getParameter("fDate").split("-");
		String eDate[] = multi.getParameter("eDate").split("-");

		Date fDate1 = new Date(Integer.parseInt(fDate[0]) - 1900, Integer.parseInt(fDate[1]) - 1,
				Integer.parseInt(fDate[2]));
		Date eDate1 = new Date(Integer.parseInt(eDate[0]) - 1900, Integer.parseInt(eDate[1]) - 1,
				Integer.parseInt(eDate[2]));
		aedto.setF_date(fDate1);
		aedto.setE_date(eDate1);

		String image = multi.getFilesystemName("img1") + "," + multi.getFilesystemName("img2") + ","
				+ multi.getFilesystemName("img3") + "," + multi.getFilesystemName("img4");
		aedto.setImage(image);
		/*dto에 전달받은 내용 저장*/
		
		//이미지 변경이 없으면 기존 이미지를 사용
		if(!image.equals("null,null,null,null")){
			aedto.setImage(image);
		}else{
			aedto.setImage(image2);
		}

		AdminEventDAO aedao=new AdminEventDAOImpl();
		
		// 상품정보수정 메서드 updateEvent(DTO);
		int chk=aedao.updateEvent(aedto);
		
		response.setContentType("text/html; charset=UTF-8");
		if(chk==1){//이벤트 수정 완료
			if(image2!="null,null,null,null"){//저장된 이미지가 있으면
				
				//이미 있는 이미지를 삭제
				for(int i=0; i<image2.split(",").length; i++){ 
					String file=image2.split(",")[i];
					if(!file.equals("null")){
						File f = new File(realpath,file);
						f.delete();
					}
				}
			}
			PrintWriter out=response.getWriter();
			out.print("<script>");
			out.print("alert('이벤트 수정 완료!');");
			out.print("location.href='./EventList.ae';");
			out.print("</script>");
			out.close();
			
			return null;
		}else{
			PrintWriter out=response.getWriter();
			out.print("<script>");
			out.print("alert('이벤트 수정 실패!');");
			out.print("history.back();");
			out.print("</script>");
			out.close();
			
			return null;
		}
	}
}
