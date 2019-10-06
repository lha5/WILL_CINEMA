package com.member.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface Action {
	// 추상 메소드 >> 즉, 메소드의 틀(형식)을 지정
	// 모든 처리 동작은 반드시 해당 추상 메소드를 구현해서 사용
	
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception;
}
