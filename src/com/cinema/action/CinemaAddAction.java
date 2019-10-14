package com.cinema.action;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.cinema.db.CineDAO;
import com.cinema.db.CineDAOImpl;
import com.cinema.db.CineDTO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class CinemaAddAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("CinemaAddAction execute()---------------------------------------------------");
		
		// upload 생성
		// ★ upload 폴더를 생성 후 서버를 clean할 경우 해당 파일이 삭제될 수 있음
		
		// 파일 위치(가상 경로)
		ServletContext context = request.getServletContext();
		String realPath = context.getRealPath("/upload");
		
		System.out.println("실제 저장 경로 : " + realPath);

		// 파일 크기
		int maxSize = 10 * 1024 * 1024;

		// MultipartRequest 객체 생성
		MultipartRequest multi = new MultipartRequest(request, realPath, maxSize, "UTF-8", new DefaultFileRenamePolicy());

		// CineDTO 객체 생성 >> 정보 저장(form 태그에서 넘겨 받은 데이터를 저장)
		CineDTO cdto = new CineDTO();
		
		cdto.setRegion(multi.getParameter("region"));
		cdto.setName(multi.getParameter("name"));
		cdto.setAddr(multi.getParameter("addr"));
		cdto.setTel(multi.getParameter("tel"));
		cdto.setRoom(multi.getParameter("room"));
		String image = 
				multi.getFilesystemName("file1") +
				"," + multi.getFilesystemName("file2") +
				"," + multi.getFilesystemName("file3");
		cdto.setImage(image);

		// CineDAO 객체 생성
		// insertCinema(DTO)
		CineDAO cdao = new CineDAOImpl();
		cdao.insertCinema(cdto);

		// 페이지 이동
		ActionForward forward = new ActionForward();
		forward.setPath("./CinemaDetail.ci");
		forward.setRedirect(true);
		
		return forward;
	}

}
