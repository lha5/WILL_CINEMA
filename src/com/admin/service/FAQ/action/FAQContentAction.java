package com.admin.service.FAQ.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.admin.service.FAQ.db.AdminFAQDAO;
import com.admin.service.FAQ.db.AdminFAQDAOImpl;

public class FAQContentAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		
		// 한글처리
				request.setCharacterEncoding("UTF-8");

				
				String item = request.getParameter("item");
				// DB처리 객체 생성
				// AdminEventDAO 객체 생성
				AdminFAQDAO afdao = new AdminFAQDAOImpl();

				// 카테고리별 리스트 가져오는 메서드 생성 getGoodsList(item);
				List FAQList = afdao.getFAQList(item,0,4);

				// 정보 저장
				request.setAttribute("FAQList", FAQList);
				
				ActionForward forward=new ActionForward();
				forward.setPath("./faq/faqContent.jsp");
				forward.setRedirect(false);
				return forward;
			}
		}
