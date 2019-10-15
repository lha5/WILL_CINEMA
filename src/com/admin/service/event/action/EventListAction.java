package com.admin.service.event.action;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.admin.service.event.db.AdminEventDAO;
import com.admin.service.event.db.AdminEventDAOImpl;
import com.admin.service.event.db.AdminEventDTO;

public class EventListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("/*--------------- EventListAction()[관리자 리스트]-------------------------*/");
		request.setCharacterEncoding("UTF-8");
		AdminEventDAO aedao =new AdminEventDAOImpl();
		
		//검색어
		String keyward=request.getParameter("keyward");
		//카테고리
		String item=request.getParameter("category");
		
		if(keyward==null){
			keyward="";
		}
		if(item==null){
			item="";
		}
		System.out.println("카테고리"+item+"카테고리");
		System.out.println("키워드"+keyward+"키워드");
		
		//이벤트 글 개수
		/*if(item=="all" || item==""){//카테고리 지정 안했을 경우
			cnt = aedao.getEventCount(keyward);//모든 정보 가져오기
		}else{
			cnt = aedao.getEventCount(item,keyward);
		//}	
*/		
		int cnt = aedao.getEventCount();

		
		
		/********************************************/
		//페이징 처리
		int pageSize = 5;
		
		//현재 페이지가 몇 페이지인지를 가져오기
		String pageNum = request.getParameter("pageNum");
		if(pageNum==null){
			pageNum = "1"; //pageNum의 값이 없을경우 무조건 1페이지
		}
		
		//시작행 구하는 작업
		int currentPage = Integer.parseInt(pageNum);
		int startRow = (currentPage -1)*pageSize +1;//->1 4 7
		int viewCnt=5;
		//끝행 구하는 작업
		int endRow = currentPage*pageSize;//=>3 6 9
		/********************************************/
		
		List<AdminEventDTO> eventList=new ArrayList<AdminEventDTO>();
		
		//request.setAttribute("arr", arr);
		
		if(cnt!=0){
			//DB에서 가져온 정보 저장
			if(keyward=="" && item==""){
				
				eventList=aedao.getAllList(startRow-1 ,viewCnt);
				System.out.println("검색 없이 얻어온 리스트 개수 : " + eventList.size() + " , 시작 : "+ (startRow-1)
					+", 끝 : " + endRow);
			}else if(keyward!=""&&item==""){
				cnt = aedao.getEventCount(keyward);
				eventList=aedao.getSearch(keyward,startRow-1 ,viewCnt);
				System.out.println("카테고리X 리스트 개수 : " + eventList.size() + " , 시작 : "+ (startRow-1)
						+", 끝 : " + endRow);
			}else{
				cnt = aedao.getEventCount(item,keyward);
				System.out.println("검색 시 리스트 개수 "+cnt);
				
				eventList=aedao.getEventList(item,keyward,startRow-1 ,viewCnt);
				System.out.println("검색해서 얻어온 리스트 개수 : " + eventList.size() + " , 시작 : "+ (startRow-1)
					+", 끝 : " + endRow);
			}
		}
		System.out.println("리스트 개수 "+cnt);
		//전체 페이지수 계산
		//한 화면에 보여줄 페이지 계산	
		int pageCount=cnt/pageSize+(cnt%pageSize==0?0:1);
			
		//한화면에 보여줄 페이지 번호 계산
		int pageBlock = 5;
			
		//시작페이지
		int startPage=((currentPage-1)/pageBlock)*pageBlock+1;
			
		//끝페이지
		int endPage = startPage+pageBlock-1;
		if(endPage > pageCount){
			endPage = pageCount;
		}
		
		
		
		//글 개수, 게시판 정보(DB), 페이지 정보(pageNum, pageCount, pageBlock, startPage, endPage)
		request.setAttribute("cnt", cnt);
		request.setAttribute("eventList", eventList);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("pageCount", pageCount);
		request.setAttribute("pageBlock", pageBlock);
		request.setAttribute("startPage", startPage);
		request.setAttribute("endPage", endPage);
		request.setAttribute("item", item);
		request.setAttribute("keyward", keyward);
		
		ActionForward forward=new ActionForward();
		forward.setPath("./service/eventBoard/eventList.jsp");
		forward.setRedirect(false);
		return forward;
	}

}
