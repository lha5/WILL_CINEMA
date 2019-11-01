package com.admin.mall.action;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.admin.mall.db.AdminMallDAO;
import com.admin.mall.db.AdminMallDAOImpl;
import com.admin.mall.db.AdminMallDTO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class GoodsAddAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("GoodsAddAction_exeucte");
		
		// upload 생성
		// * upload 폴더 생성후  서버 Clean 할경우 해당 파일 삭제 될수 있다.
		
		// 관리자 확인 코드 필요
		
		
		
		// 파일 위치(가상경로) 
		ServletContext context = request.getServletContext();
		String realPath = context.getRealPath("/upload/goods");
		
		System.out.println("realPath : "+realPath);
		
		// 파일 크기
		int maxSize = 10 * 1024 * 1024;  //10MB

		// MultipartRequest 객체 생성
		MultipartRequest multi 
			= new MultipartRequest(
				     request,
				     realPath,
				     maxSize,
				     "UTF-8",
				     new DefaultFileRenamePolicy()
				);
		
		//AdminMallDTO 객체 생성 -> 정보저장(form태그 데이터)
		AdminMallDTO amdto = new AdminMallDTO();
		amdto.setName(multi.getParameter("name"));
		amdto.setContent(multi.getParameter("content"));
		amdto.setCategory(multi.getParameter("category"));
		amdto.setPrice(Integer.parseInt(multi.getParameter("price")));
		String image = multi.getFilesystemName("image");
		amdto.setImage(image);
		
		System.out.println("image :"+image);
		//goods_num - DB에서 처리
		
		//AdminMallDAO객체 생성
		//insertGoodsMall(DTO)
		AdminMallDAO amdao = new AdminMallDAOImpl();
		amdao.insertGoodsMall(amdto);
		
		//페이지 이동("./GoodsList.al")
		ActionForward forward = new ActionForward();
		forward.setPath("./GoodsList.al");
		forward.setRedirect(true);
		
		return forward;
	}

}
