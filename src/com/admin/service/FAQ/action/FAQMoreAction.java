package com.admin.service.FAQ.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.action.Action;
import com.action.ActionForward;
import com.admin.service.FAQ.db.AdminFAQDAO;
import com.admin.service.FAQ.db.AdminFAQDAOImpl;
import com.admin.service.FAQ.db.AdminFAQDTO;

public class FAQMoreAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		
		//시작 행
		int startCnt=Integer.parseInt(request.getParameter("startCnt"));
		//가져올 행
		int viewCnt=Integer.parseInt(request.getParameter("viewCnt"));
		//카테고리
		String item=request.getParameter("item");
		
		AdminFAQDAO afdao=new AdminFAQDAOImpl();
		List<AdminFAQDTO> FAQList=afdao.getFAQList(item, startCnt, viewCnt);
		
		JSONArray resultList= new JSONArray();
		
		for(int i=0; i<FAQList.size(); i++){
			JSONObject jsonObj=new JSONObject();
			AdminFAQDTO afdto = FAQList.get(i);
			jsonObj.put("num", afdto.getNum());
			jsonObj.put("category", afdto.getCategory());
			jsonObj.put("image", afdto.getImage());
			jsonObj.put("content", afdto.getContent());
			jsonObj.put("subject", afdto.getSubject());
			resultList.add(jsonObj);
		}
		
		
		/*response.setContentType("application/json; charset=utf-8");*/		
		response.getWriter().write(resultList.toString());
		
		
		return null;
	}
}
