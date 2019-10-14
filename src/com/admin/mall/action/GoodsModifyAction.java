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

public class GoodsModifyAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("GoodsModifyAction_execute()---------");
		
		//관리자 판별 코드
		
		// 파일 위치(가상경로) 
				ServletContext context = request.getServletContext();
				String realPath = context.getRealPath("/goodsImageUpload");
				
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
				amdto.setGoods_num(Integer.parseInt(multi.getParameter("goods_num")));
				amdto.setName(multi.getParameter("name"));
				amdto.setContent(multi.getParameter("content"));
				amdto.setCategory(multi.getParameter("category"));
				amdto.setPrice(Integer.parseInt(multi.getParameter("price")));
				String image = multi.getFilesystemName("image");
				//이미지에 아무것도 들어가지 않았을경우 이전 사진을 그대로 사용
				if(image==null){
					image = multi.getParameter("prev_image");
				}
				
				amdto.setImage(image);
				
				System.out.println("image :"+image);
				//goods_num - DB에서 처리
				
				//AdminMallDAO객체 생성
				//modifyGoodsMall(DTO)
				AdminMallDAO amdao = new AdminMallDAOImpl();
				amdao.modifyGoodsMall(amdto);
				
				//페이지 이동("./GoodsList.al")
				ActionForward forward = new ActionForward();
				forward.setPath("./GoodsList.al");
				forward.setRedirect(true);
				
				return forward;	}

}
