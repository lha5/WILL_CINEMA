package com.admin.service.event.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.action.Action;
import com.action.ActionForward;
import com.admin.service.event.db.AdminEventDAO;
import com.admin.service.event.db.AdminEventDAOImpl;
import com.admin.service.event.db.AdminEventDTO;



public class EventMoreAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("/*--------------- EventMoreAction()[이벤트 리스트 더보기(사용자)]-------------------------*/");
		
		//시작 행
		int startCnt=Integer.parseInt(request.getParameter("startCnt"));
		//가져올 행
		int viewCnt=Integer.parseInt(request.getParameter("viewCnt"));
		//카테고리
		String item=request.getParameter("item");
		
		AdminEventDAO aedao=new AdminEventDAOImpl();
		List<AdminEventDTO> eventList=aedao.getEventList(item, startCnt, viewCnt);
		
		JSONArray resultList= new JSONArray();
		
		for(int i=0; i<eventList.size(); i++){
			JSONObject jsonObj=new JSONObject();
			AdminEventDTO aedto = eventList.get(i);
			jsonObj.put("num", aedto.getNum());
			jsonObj.put("category", aedto.getCategory());
			jsonObj.put("image", aedto.getImage());
			jsonObj.put("f_date", aedto.getF_date().toString());
			jsonObj.put("e_date", aedto.getE_date().toString());
			resultList.add(jsonObj);
		}
		/*response.setContentType("application/json; charset=utf-8");*/		
		response.getWriter().write(resultList.toString());
		
		return null;
	}
}
